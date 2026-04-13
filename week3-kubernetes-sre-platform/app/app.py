from flask import Flask, jsonify, request
from prometheus_flask_exporter import PrometheusMetrics
import os
import socket
import time

app = Flask(__name__)

# Prometheus Metrics Setup
metrics = PrometheusMetrics(app)

# Custom metric example (optional but good for interviews)
metrics.info('app_info', 'Application info', version='1.0.0')

START_TIME = time.time()

# Home endpoint
@app.route("/")
def home():
    return jsonify({
        "message": "SRE demo app running",
        "hostname": socket.gethostname(),
        "environment": os.getenv("APP_ENV", "dev"),
        "method": request.method
    })

# Liveness probe
@app.route("/healthz")
def healthz():
    return jsonify({
        "status": "healthy"
    }), 200

# Readiness probe
@app.route("/readyz")
def readyz():
    return jsonify({
        "status": "ready"
    }), 200

# Info endpoint
@app.route("/info")
def info():
    return jsonify({
        "uptime_seconds": round(time.time() - START_TIME, 2),
        "hostname": socket.gethostname(),
        "environment": os.getenv("APP_ENV", "dev")
    }), 200

# Metrics endpoint (automatically handled by PrometheusMetrics)
# Available at /metrics

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
