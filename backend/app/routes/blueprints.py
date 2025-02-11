from flask import Blueprint, request, jsonify
from app import mongo, bcrypt
from app.utils.config import Config

auth_bp = Blueprint("auth", __name__)
@auth_bp.route("/register", methods=["POST"])
def register():
    data = request.json
    username = data.get("username")
    email = data.get("email")
    password = data.get("password")

    if not username or not password or not email:
        return jsonify({"message": "Missing information"}), 400
    
    existing_user = mongo.db.users.find_one({"email": email})
    if existing_user:
        return jsonify({"message": "Username already exist"}), 400
    

    hashed_password = bcrypt.generate_password_hash(password).decode("utf-8")
    mongo.db.users.insert_one({"username": username, "password": hashed_password})

    return jsonify({"message": "Register successfully"}), 201
