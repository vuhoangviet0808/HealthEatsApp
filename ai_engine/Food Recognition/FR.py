import tensorflow as tf
import tensorflow_hub as hub
import numpy as np
import cv2

model_url = "https://tfhub.dev/google/imagenet/mobilenet_v2_100_224/classification/5"
model = tf.keras.Sequential([hub.KerasLayer(model_url)])

# Tiền xử lý ảnh
def preprocess_image(image_path):
    image = cv2.imread(image_path)
    image = cv2.resize(image, (224, 224))  # Resize về kích thước phù hợp với mô hình
    image = np.array(image) / 255.0  # Chuẩn hóa pixel về khoảng [0,1]
    image = np.expand_dims(image, axis=0)  # Thêm chiều batch
    return image

# Dự đoán món ăn
def predict_food(image_path):
    image = preprocess_image(image_path)
    predictions = model.predict(image)
    predicted_class = np.argmax(predictions)
    return predicted_class  # Lấy class ID, cần map với danh sách món ăn

food_id = predict_food("test_image.jpg")
print("Predicted Food ID:", food_id)
