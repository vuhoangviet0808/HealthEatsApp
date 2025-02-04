from flask import Flask
from flask_pymongo import PyMongo
from app.config import Config
from app.blueprints import register_blueprints
from app.middleware import register_middlewares

def create_app():
    app = Flask(__name__)
    app.config.from_object(Config)
    mongo = PyMongo(app)
    register_middlewares(app)
    register_blueprints(app)

    return app, mongo
