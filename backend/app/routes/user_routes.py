from flask import jsonify, request, Blueprint
from app.services.user_service import UserService

user_bp = Blueprint("user_routes", __name__, url_prefix="/users")


@user_bp.get("/<user_id>")
def get_profile(user_id):
    resp, code = UserService.get_user(user_id)
    return jsonify(resp), code

@user_bp.put("/<user_id>")
def update_profile(user_id):
    data = request.get_json() or {}
    resp, code = UserService.update_user(user_id, data)
    return jsonify(resp), code