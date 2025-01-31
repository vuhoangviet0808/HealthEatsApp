from flask import Flask
from flask_cors import CORS
from pymongo import MongoClient
from app.routes import api_bp
from app.config import Config

def create_app():
    app = Flask(__name__)
    CORS(app)
    app.config.from_object(Config)

    # Kết nối MongoDB
    mongo_client = MongoClient(app.config["MONGO_URI"])
    app.db = mongo_client.get_database()  # Gán database vào app.db

    app.register_blueprint(api_bp, url_prefix='/api')
    return app
