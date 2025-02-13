from flask import jsonify, request
from app.routes import user_bp
from app.services.user_service import UserService

@user_bp.route("/register", methods=["POST"])
def register():
    data = request.json
    username = data.get("username")
    email = data.get("email")
    password = data.get("password")

    if not username or not email or not password:
        return jsonify({"message": "Missing information"}), 400
    return jsonify(UserService.register_user(username, email, password))