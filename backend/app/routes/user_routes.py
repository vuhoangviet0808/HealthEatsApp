from flask import jsonify
from app.routes import user_bp
from app.services.user_service import get_all_users

@user_bp.route("/", methods=["GET"])
def get_users():
    users = get_all_users()
    return jsonify({"users": users})
