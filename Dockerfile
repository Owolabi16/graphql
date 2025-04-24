FROM python:3.9-slim AS base

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# Default configuration
ENV PORT=8000
ENV APP_VERSION=1.0.0

# Main application target
FROM base AS app
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "app:app"]

# Migration target
FROM base AS migration
CMD ["python", "migration.py"]
