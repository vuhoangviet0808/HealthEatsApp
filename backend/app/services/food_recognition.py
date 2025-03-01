from flask import Flask, request, jsonify
import tensorflow as tf
import numpy as np
import cv2
import os

app = Flask(__name__)

model_url = "https://tfhub.dev/google/imagenet/mobilenet_v2_100_224/classification/5"
model = tf.keras.Sequential([tf.keras.layers.InputLayer(input_shape=(224, 224, 3)),
                             hub.KerasLayer(model_url)])

def preprocess_image(image_path):
    image = cv2.imread(image_path)
    image = cv2.resize(image, (224, 224))
    image = np.array(image) / 255.0
    image = np.expand_dims(image, axis=0)
    return image

# API nhận diện món ăn từ ảnh
@app.route('/predict-food', methods=['POST'])
def predict_food():
    if 'file' not in request.files:
        return jsonify({'error': 'No file uploaded'}), 400
    
    file = request.files['file']
    filepath = os.path.join('uploads', file.filename)
    file.save(filepath)

    image = preprocess_image(filepath)
    predictions = model.predict(image)
    predicted_class = np.argmax(predictions)
    
    food_classes = ["Pizza", "Burger", "Salad", "Sushi", "Pasta"]  # Cần map với dataset
    food_name = food_classes[predicted_class % len(food_classes)]  # Giả sử có danh sách 5 món

    return jsonify({'food_name': food_name})
