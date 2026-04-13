from flask import Flask, jsonify
import os
import socket
import time

app = Flask(__name__)
START_TIME = time.time()

@app.route("/")
def home():
    return jsonify({
        "message": "SRE demo app running",
        "hostname": socket.gethostname(),
        "environment": os.getenv("APP_ENV", "dev")
    })

@app.route("/healthz")
def healthz():
    return jsonify({"status": "healthy"}), 200

@app.route("/readyz")
def readyz():
    return jsonify({"status": "ready"}), 200

@app.route("/info")
def info():
    return jsonify({
        "uptime_seconds": round(time.time() - START_TIME, 2),
        "hostname": socket.gethostname(),
        "environment": os.getenv("APP_ENV", "dev")
    }), 200

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
