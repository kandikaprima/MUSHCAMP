from flask import Flask, request, jsonify
import tensorflow as tf
import numpy as np
from PIL import Image
import io

app = Flask(__name__)
model = tf.keras.models.load_model('model_EfficientNetB7.h5')

@app.route("/", methods=['POST', 'GET'])
def home():
    return jsonify("Service berjalan")

@app.route("/predict", methods=['POST', 'GET'])
def predict():
    file = request.files.get("file")
    if not file:
        return jsonify({"error": "No file provided"}), 400

    try:
        image = Image.open(file.stream).resize((300, 300))
        img_array = np.array(image) / 255.0
        prediction = model.predict(np.expand_dims(img_array, axis=0))
        return jsonify({"prediction": prediction.tolist()})
    except Exception as e:
        return jsonify({"error": str(e)}), 500

if __name__ == "__main__":
    app.run(debug=False, port=5000)
