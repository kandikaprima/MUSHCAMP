from flask import Flask, request, jsonify
import tensorflow as tf
import numpy as np
from PIL import Image
import io

# Inisialisasi Flask
app = Flask(__name__)

# Load model
model = tf.keras.models.load_model("model/saved_model.h5")

@app.route("/", methods=["GET"])
def home():
    return "Model API is running!"

@app.route("/predict", methods=["POST"])
def predict():
    if "file" not in request.files:
        return jsonify({"error": "No file part"}), 400

    file = request.files["file"]
    if file.filename == "":
        return jsonify({"error": "No selected file"}), 400

    try:
        image = Image.open(file.stream).resize((300, 300))
        img_array = np.array(image) / 255.0
        prediction = model.predict(np.expand_dims(img_array, axis=0))
        return jsonify({"prediction": prediction.tolist()})
    except Exception as e:
        return jsonify({"error": str(e)}), 500

# Jalankan lokal (opsional)
if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)