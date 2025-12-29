# ===============================
# Base Image
# ===============================
FROM python:3.10-slim

# ===============================
# Set Environment
# ===============================
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# ===============================
# Install system dependencies
# ===============================
RUN apt-get update && apt-get install -y \
    build-essential \
    libgl1 \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

# ===============================
# Working Directory
# ===============================
WORKDIR /app

# ===============================
# Copy requirements & install
# ===============================
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# ===============================
# Copy all project files
# ===============================
COPY . .

# ===============================
# Expose Port (sesuai ENV)
# ===============================
EXPOSE 8000

# ===============================
# Run FastAPI
# ===============================
CMD ["uvicorn", "app_api:app", "--host", "0.0.0.0", "--port", "8000"]
