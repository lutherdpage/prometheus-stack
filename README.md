# 📡 Prometheus Monitoring Stack (Prometheus + Grafana + Alertmanager + Node Exporter)

This project sets up a full monitoring and alerting stack using **Docker Compose**, including:

* **Prometheus** – Time-series monitoring
* **Grafana** – Dashboards & visualization
* **Alertmanager** – Alert delivery
* **Node Exporter** – Host machine metrics
* **cAdvisor** – *Optional* container metrics (not supported on Docker Desktop for Windows)

---

## 🚀 Features

* Containerized monitoring stack using **Docker Compose**
* Pre-configured **Prometheus scraping** for Node Exporter
* Working **Grafana dashboards**
* Alerting enabled with **Alertmanager**
* Easy to extend with additional exporters

---

## 🛠️ Stack Components

| Service                 | Description                                                 | Port        |
| ----------------------- | ----------------------------------------------------------- | ----------- |
| **Prometheus**          | Metrics scraping & storage                                  | 9095 → 9090 |
| **Grafana**             | Dashboard visualization                                     | 3030 → 3000 |
| **Alertmanager**        | Alert routing                                               | 9093        |
| **Node Exporter**       | Host OS metrics                                             | 9100        |
| **cAdvisor** (optional) | Container metrics (not supported on Windows Docker Desktop) | 8080        |

---

## 📂 Project Structure

```
prometheus-stack/
│── docker-compose.yml
│
├── prometheus/
│   ├── prometheus.yml
│   └── alert.rules.yml
│
├── grafana/
│
└── alertmanager/
    └── alertmanager.yml
```

---

## ▶️ Getting Started

### **1. Clone the Repository**

```bash
git clone https://github.com/lutherdpage/prometheus-stack.git
cd prometheus-stack
```

### **2. Start the Stack**

```bash
docker compose up -d
```

### **3. Access the Services**

| Service       | URL                                                            |
| ------------- | -------------------------------------------------------------- |
| Prometheus    | [http://localhost:9095](http://localhost:9095)                 |
| Grafana       | [http://localhost:3030](http://localhost:3030)                 |
| Alertmanager  | [http://localhost:9093](http://localhost:9093)                 |
| Node Exporter | [http://localhost:9100/metrics](http://localhost:9100/metrics) |

⚠ **cAdvisor will *not* work on Windows Docker Desktop**
It requires Linux cgroups which are unavailable on Windows.

---

## 🔔 Alerts

Prometheus is configured with example alert rules located in:

```
prometheus/alert.rules.yml
```

To reload Prometheus config without restarting the container:

```bash
docker compose exec prometheus kill -HUP 1
```

---

## 🧪 Verify Prometheus Scraping

Visit:

```
http://localhost:9095/targets
```

You should see:

* Prometheus
* Node Exporter

Both **UP**.

---

