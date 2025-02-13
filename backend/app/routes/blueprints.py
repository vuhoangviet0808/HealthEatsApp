from flask import Blueprint, request, jsonify
from app import mongo, bcrypt
from app.routes.user_routes import user_bp

auth_bp = Blueprint('auth', __name__)
auth_bp.register_blueprint(user_bp, url_prefix="/user")

