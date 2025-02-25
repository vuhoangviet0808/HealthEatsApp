from flask import Flask
from app.extensions import mongo, bcrypt
from app.utils.config import Config  
from app.routes.user_routes import user_routes


def create_app():
    app = Flask(__name__)
    app.config.from_object(Config)
    mongo.init_app(app)
    bcrypt.init_app(app)
    app.register_blueprint(user_routes, url_prefix="/auth")

    return app
