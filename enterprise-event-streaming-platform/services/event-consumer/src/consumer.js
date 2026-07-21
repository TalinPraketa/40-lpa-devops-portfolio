const { Kafka } = require("kafkajs");

const kafka = new Kafka({
  clientId: "event-consumer",
  brokers: [process.env.KAFKA_BROKERS || "localhost:9092"]
});

const consumer = kafka.consumer({
  groupId: process.env.KAFKA_GROUP_ID || "event-consumer-group"
});

async function start() {
  await consumer.connect();

  await consumer.subscribe({
    topic: process.env.KAFKA_TOPIC || "events",
    fromBeginning: true
  });

  console.log("Event Consumer connected to Kafka");

  await consumer.run({
    eachMessage: async ({ topic, partition, message }) => {
      const value = message.value.toString();

      console.log("Event received:", {
        topic,
        partition,
        offset: message.offset,
        value
      });
    }
  });
}

start().catch((error) => {
  console.error("Consumer failed:", error);
  process.exit(1);
});
