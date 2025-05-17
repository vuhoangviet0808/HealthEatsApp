from flask import jsonify, request, Blueprint
from app.services.auth_service import AuthService

auth_bp = Blueprint("auth_bp", __name__, url_prefix="/auth")


@auth_bp.route("/register", methods=["POST"])
def register():
    data = request.get_json() or {}
    username, email, password = (data.get(k) for k in ("username", "email", "password"))

    if not username or not email or not password:
        return jsonify({"message": "Missing information"}), 400
    response, status_code = AuthService.register(username, email, password)
    return jsonify(response), status_code

@auth_bp.route("/login", methods=["POST"])
def login():
    data = request.get_json() or {}
    resp, code = AuthService.login(data.get("email"), data.get("password"))
    # print("111111")
    return jsonify(resp), code

