FROM python:3.10-slim

# Install dependencies
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
ADD https://drive.google.com/file/d/1GoBYoWTeOTFGz2nhJgcLCPH6zRiIB8-n/view?usp=sharing /app

# Copy source code and model
COPY . .

# Expose port & run app using Gunicorn
EXPOSE 8080
CMD ["gunicorn", "-b", "0.0.0.0:8080", "app:app"]