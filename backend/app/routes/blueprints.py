from flask import Blueprint, request, jsonify
from app import mongo, bcrypt
from app.routes.user_routes import user_routes

blueprint = Blueprint("api", __name__, url_prefix="/auth")
blueprint.register_blueprint(user_routes)

