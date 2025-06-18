FROM python:3.10-slim

# Install dependencies
WORKDIR /app
COPY requirements.txt .
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt
ADD https://drive.usercontent.google.com/download?id=1GoBYoWTeOTFGz2nhJgcLCPH6zRiIB8-n&export=download&confirm=t&uuid=7b56516b-a31e-4d82-a2b7-f7e195267d86 model_EfficientNetB7.h5

# Copy source code and model
COPY . ./
RUN ls

# Expose port & run app using Gunicorn
EXPOSE 8080
CMD ["gunicorn", "-b", "0.0.0.0:8080", "app:app"]
