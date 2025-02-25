from flask import jsonify, request, Blueprint
from app.routes import user_bp
from app.services.user_service import UserService

user_routes = Blueprint("user_routes", __name__)


@user_bp.route("/register", methods=["POST"])
def register():
    data = request.json
    username = data.get("username")
    email = data.get("email")
    password = data.get("password")

    if not username or not email or not password:
        return jsonify({"message": "Missing information"}), 400
    return jsonify(UserService.register_user(username, email, password))

@user_routes.route("/login", methods=["POST"])
def login():
    data = request.get_json()
    email = data.get("email")
    password = data.get("password")

    return jsonify(UserService.login_user(email, password))