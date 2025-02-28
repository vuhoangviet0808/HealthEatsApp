from flask import jsonify, request, Blueprint
from app.services.user_service import UserService

user_routes = Blueprint("user_routes", __name__)


@user_routes.route("/register", methods=["POST"])
def register():
    data = request.json
    username = data.get("username")
    email = data.get("email")
    password = data.get("password")

    if not username or not email or not password:
        return jsonify({"message": "Missing information"}), 400
    response, status_code = UserService.register_user(username, email, password)
    return jsonify(response), status_code

@user_routes.route("/login", methods=["POST"])
def login():
    data = request.get_json()
    email = data.get("email")
    password = data.get("password")
    response, status_code = UserService.login_user(email, password)
    print("111111")
    return jsonify(response), status_code