from flask import Blueprint, request, jsonify
from app import mongo, bcrypt
from app.routes.user_routes import user_routes

def auth_blueprints(app):
    app.register_blueprint(user_routes, url_prefix='/auth')

