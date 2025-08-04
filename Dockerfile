FROM python:3.10-slim

# Install dependencies
WORKDIR /app
COPY requirements.txt .
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt
ADD https://drive.usercontent.google.com/download?id=1H3OU6ZUs1Uoe91hc1srkLAbTlUlIroea&export=download&authuser=0&confirm=t&uuid=4a85723f-577e-4180-a9c3-bc3b53608b0e&at=AN8xHooURdMiP60GB7V3vsXnmYhF:1754330294472 model_vgg16.h5

# Copy source code and model
COPY . ./
RUN ls

# Expose port & run app using Gunicorn
EXPOSE 8080
CMD ["gunicorn", "-b", "0.0.0.0:8080", "app:app"]

