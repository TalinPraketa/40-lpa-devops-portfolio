const express = require("express");
const { Kafka } = require("kafkajs");

const app = express();

app.use(express.json());

const kafka = new Kafka({
  clientId: process.env.KAFKA_CLIENT_ID || "event-producer",
  brokers: (process.env.KAFKA_BROKERS || "localhost:9092").split(",")
});

const producer = kafka.producer();

const KAFKA_TOPIC = process.env.KAFKA_TOPIC || "events";

let kafkaConnected = false;

async function startKafka() {
  await producer.connect();
  kafkaConnected = true;
  console.log("Event Producer connected to Kafka");
}

app.get("/health", (req, res) => {
  res.status(200).json({
    status: kafkaConnected ? "UP" : "DEGRADED",
    service: "event-producer",
    kafka: kafkaConnected ? "CONNECTED" : "DISCONNECTED"
  });
});

app.post("/events", async (req, res) => {
  const event = {
    event_id: Date.now(),
    event_type: req.body.event_type,
    payload: req.body
  };

  try {
    await producer.send({
      topic: KAFKA_TOPIC,
      messages: [
        {
          key: String(event.event_id),
          value: JSON.stringify(event)
        }
      ]
    });

    console.log("Event published to Kafka:", event);

    res.status(202).json({
      message: "Event accepted and published",
      event
    });
  } catch (error) {
    console.error("Failed to publish event to Kafka:", error);

    res.status(503).json({
      message: "Event could not be published",
      error: "Kafka unavailable"
    });
  }
});

const PORT = process.env.PORT || 8080;

async function start() {
  try {
    await startKafka();

    app.listen(PORT, () => {
      console.log(`Event Producer listening on port ${PORT}`);
    });
  } catch (error) {
    console.error("Failed to start Event Producer:", error);
    process.exit(1);
  }
}

async function shutdown(signal) {
  console.log(`${signal} received. Shutting down gracefully...`);

  try {
    await producer.disconnect();
  } catch (error) {
    console.error("Kafka disconnect failed:", error);
  }

  process.exit(0);
}

process.on("SIGTERM", () => shutdown("SIGTERM"));
process.on("SIGINT", () => shutdown("SIGINT"));

start();
