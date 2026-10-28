#!/bin/bash

echo "🚀 Iniciando el Laboratorio SRE..."

# 1. Arrancar Colima
echo "🐳 Arrancando Colima..."
colima start --cpu 4 --memory 6

# 2. Esperar a que los nodos estén listos
echo "⏳ Esperando a que Kubernetes esté listo..."
kubectl wait --for=condition=Ready nodes --all --timeout=60s

# 3. Abrir Túneles en segundo plano
echo "🌉 Abriendo túneles (API y Grafana)..."
kubectl port-forward svc/fragile-api-service 5000:80 > /dev/null 2>&1 &
kubectl port-forward -n monitoring svc/monitoring-grafana 3000:80 > /dev/null 2>&1 &

echo "✅ ¡Todo listo!"
echo "--------------------------------------------------"
echo "🔗 API: http://localhost:5000"
echo "📊 Grafana: http://localhost:3000"
echo "--------------------------------------------------"
echo "Recuerda: Para apagar todo, usa 'colima stop'"