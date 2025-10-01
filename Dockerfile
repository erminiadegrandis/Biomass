# Usa una base Python leggera
FROM python:3.11-slim

# Evita scrittura di bytecode e buffering
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Imposta la directory di lavoro
WORKDIR /app

# Installa dipendenze di sistema utili (se serve compilare librerie Python)
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    git \
    && rm -rf /var/lib/apt/lists/*

# Copia i file di requirements e installa le dipendenze
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copia tutto il progetto
COPY . .

# (Opzionale) Installa il pacchetto come modulo
RUN pip install -e .

# Espone Jupyter se lo usi
EXPOSE 8888

# Comando di default (puoi cambiare con train o predict)
CMD ["python", "-m", "biomass.modeling.train"]
