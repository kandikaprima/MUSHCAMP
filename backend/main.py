from flask import Flask, request, session, jsonify
import pyrebase
import cv2
import numpy as np
import tensorflow as tf
from werkzeug.utils import secure_filename
from tensorflow.keras.layers import DepthwiseConv2D

app = Flask(__name__)
config = {
  'apiKey': "",
  'authDomain': "",
  'projectId': "",
  'storageBucket': "",
  'messagingSenderId': "",
  'appId': "",
  'databaseURL':''
}

# Custom Dropout layer
def fixed_dropout(rate, **kwargs):
    return tf.keras.layers.Dropout(rate=rate, **kwargs)

# Custom DepthwiseConv2D to ignore 'groups' argument
class CustomDepthwiseConv2D(DepthwiseConv2D):
    def __init__(self, **kwargs):
        kwargs.pop('groups', None)
        super().__init__(**kwargs)

custom_objects = {
    'FixedDropout': fixed_dropout,
    'DepthwiseConv2D': CustomDepthwiseConv2D
}

# Load the model with custom objects
model = tf.keras.models.load_model('current_model.h5', custom_objects=custom_objects)

firebase = pyrebase.initialize_app(config)
auth = firebase.auth()
db = firebase.database()
storage = firebase.storage()

@app.route('/predict', methods=['POST', 'GET'])
def predict():
        if 'image' not in request.files:
            return jsonify({'error': 'No image uploaded'}), 400
        image = request.files['image']
        img = cv2.imdecode(np.frombuffer(image.read(), np.uint8), cv2.IMREAD_COLOR)
        img = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)
        img = cv2.resize(img, (150, 150))
        img = img.astype(np.float32) / 255.0
        img = np.expand_dims(img, axis=0)
        pred = model.predict(img)  # type: ignore
        ml_class = ['Agaricus', 'Amanita', 'Boletus', 'Cortinarius', 'Entoloma', 'Hygrocybe', 'Lactarius', 'Russula', 'Suillus']
        if (pred.max() > 0.6):
            hasil = np.argmax(pred)
            predicted = db.child('mushroom').child(ml_class[hasil]).get().val()
            return jsonify({'predicted_label': ml_class[hasil],'detail' : predicted})
        else:
            return jsonify({'error': 'tidak terdeteksi'})

@app.route('/data', methods=['POST'])
def get_data():
    data_id = request.form.get('select')
    if not data_id:
        return jsonify({'error': 'Missing data ID parameter'}), 400
    if data_id == '1':
        data = db.child('mushroom').child('Agaricus').get().val()
    elif data_id == '2':
        data = db.child('mushroom').child('Amanita').get().val()
    elif data_id == '3':
        data = db.child('mushroom').child('Boletus').get().val()
    elif data_id == '4':
        data = db.child('mushroom').child('Cortinarius').get().val()
    elif data_id == '5':
        data = db.child('mushroom').child('Entoloma').get().val()
    elif data_id == '6':
        data = db.child('mushroom').child('Hygrocybe').get().val()
    elif data_id == '7':
        data = db.child('mushroom').child('Lactarius').get().val()
    elif data_id == '8':
        data = db.child('mushroom').child('Russula').get().val()
    elif data_id == '9':
        data = db.child('mushroom').child('Suillus').get().val()
    else:
        return jsonify({'error': 'Invalid data ID'}), 400
    return jsonify(data)

if __name__ == '__main__':
    app.run(host='0.0.0.0', debug = True, port=8080)