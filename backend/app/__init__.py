from flask import Flask
from app.utils.extensions import bcrypt, mongo, cors
from app.routes.auth_routes import auth_bp
from app.routes.user_routes import user_bp
from app.utils.config import Config

def create_app():
    app = Flask(__name__)
    app.config.from_object(Config)

    # Init extensions
    bcrypt.init_app(app)
    cors.init_app(app)
    mongo.init_app(app)

    # Register blueprints
    app.register_blueprint(auth_bp)
    app.register_blueprint(user_bp)
    return app
