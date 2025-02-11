from flask import Flask
from flask_pymongo import PyMongo
from flak_bycrypt import Bcrypt
from app.config import Config
from app.routes.blueprints import auth_bp


mongo = Pymongo()
bcrypt = Bcrypt()
def create_app():
    app = Flask(__name__)
    app.config.from_object(Config)
    mongo.init_app(app)
    bcrypt.init_app(app)
    app.register_blueprint(auth_bp, url_prefix="/auth")

    return app
