from flask import Blueprint

user_bp = Blueprint('user', __name__, url_prefix='/user')
post_bp = Blueprint('post', __name__, url_prefix='/post')

