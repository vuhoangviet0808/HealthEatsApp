from flask import Flask
from app.extensions import mongo, bcrypt
from app.utils.config import Config  
from app.routes.blueprints import auth_blueprints
from flask_cors import CORS


def create_app():
    app = Flask(__name__)
    app.config.from_object(Config)
    mongo.init_app(app)
    bcrypt.init_app(app)
    CORS(app)
    auth_blueprints(app)

    return app
