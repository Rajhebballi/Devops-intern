# FROM python:3.11-slim

# WORKDIR /app
# COPY requirements.txt .
# RUN pip install --no-cache-dir -r requirements.txt
# RUN apt-get update && apt-get install -y \
#     build-essential \
#     libpq-dev \
#     && rm -rf /var/lib/apt/lists/*
# COPY . .
# RUN python manage.py collectstatic --noinput
# EXPOSE 8000
# CMD ["gunicorn", "main:app", "--bind", "0.0.0.0:8000"]
FROM python:3.11-slim

# 1. Install system dependencies FIRST
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# 2. Set working directory
WORKDIR /app

# 3. Copy only requirements to leverage cache
COPY requirements.txt .

# 4. Install python packages
RUN pip install --no-cache-dir -r requirements.txt

# 5. Copy the rest of the code
COPY . .

# 6. Run command
CMD ["gunicorn", "myproject.wsgi:application", "--bind", "0.0.0.0:8000"]