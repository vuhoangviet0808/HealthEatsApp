from flask import Flask
from flask_bcrypt import Bcrypt
from flask_pymongo import PyMongo
from app.utils.config import Config  

mongo = PyMongo()
bcrypt = Bcrypt()

def create_app():
    app = Flask(__name__)
    app.config.from_object(Config)

    # Initialize extensions
    mongo.init_app(app)
    bcrypt.init_app(app)

    # Register Blueprints
    from app.routes.blueprints import auth_bp
    app.register_blueprint(auth_bp, url_prefix="/auth")

    return app
