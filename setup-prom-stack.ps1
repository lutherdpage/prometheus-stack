# setup-prom-stack.ps1
# Free Prometheus + Grafana + Alertmanager Stack using Docker

Write-Host "Setting up Prometheus, Grafana, and Alertmanager Stack..."

# Create required folders
New-Item -ItemType Directory -Force -Path "./prometheus"
New-Item -ItemType Directory -Force -Path "./grafana"
New-Item -ItemType Directory -Force -Path "./alertmanager"

# Create docker-compose.yml
@"
version: '3'
services:
  prometheus:
    image: prom/prometheus:latest
    container_name: prometheus
    ports:
      - "9090:9090"
    volumes:
      - ./prometheus/prometheus.yml:/etc/prometheus/prometheus.yml

  grafana:
    image: grafana/grafana:latest
    container_name: grafana
    ports:
      - "3000:3000"
    volumes:
      - ./grafana:/var/lib/grafana
    depends_on:
      - prometheus

  alertmanager:
    image: prom/alertmanager:latest
    container_name: alertmanager
    ports:
      - "9093:9093"
    volumes:
      - ./alertmanager/alertmanager.yml:/etc/alertmanager/alertmanager.yml
"@ | Out-File -Encoding UTF8 docker-compose.yml

# Create sample Prometheus config
@"
global:
  scrape_interval: 15s

scrape_configs:
  - job_name: 'prometheus'
    static_configs:
      - targets: ['prometheus:9090']
"@ | Out-File -Encoding UTF8 ./prometheus/prometheus.yml

# Create sample Alertmanager config
@"
global:
  resolve_timeout: 5m
route:
  receiver: 'default'
receivers:
  - name: 'default'
"@ | Out-File -Encoding UTF8 ./alertmanager/alertmanager.yml

Write-Host "✅ Setup complete. To start, run:"
Write-Host "docker-compose up -d"