from flask import Blueprint, request, jsonify
from app import mongo, bcrypt
from .user_routes import user_bp
from .auth_routes import auth_bp

all_blueprints: list[Blueprint] = [auth_bp, user_bp]

