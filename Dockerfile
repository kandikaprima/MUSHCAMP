FROM python:3.10-slim

# Install dependencies
WORKDIR /app
COPY requirements.txt .
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt
ADD https://drive.usercontent.google.com/download?id=1GoBYoWTeOTFGz2nhJgcLCPH6zRiIB8-n&export=download&authuser=0&confirm=t&uuid=191ef568-1e83-44cd-9885-a5e8b5a8ff90&at=AN8xHookrDkzuFt1B6MZ6-dQVY4F%3A1750000002917 app

# Copy source code and model
COPY . .

# Expose port & run app using Gunicorn
EXPOSE 8080
CMD ["gunicorn", "-b", "0.0.0.0:8080", "app:app"]
