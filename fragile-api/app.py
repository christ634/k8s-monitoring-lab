from flask import Flask, jsonify
from prometheus_client import Counter, generate_latest
import random

app = Flask(__name__)

# Métrica SRE: Contador de peticiones
REQUEST_COUNT = Counter('api_requests_total', 'Total de peticiones', ['method', 'endpoint', 'http_status'])

@app.route('/metrics')
def metrics():
    return generate_latest()

@app.route('/')
def hello():
    REQUEST_COUNT.labels(method='GET', endpoint='/', http_status='200').inc()
    return jsonify(message="SRE Lab - Fragile API v1")

@app.route('/error')
def error():
    REQUEST_COUNT.labels(method='GET', endpoint='/error', http_status='500').inc()
    return jsonify(error="Inyectando fallo"), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)