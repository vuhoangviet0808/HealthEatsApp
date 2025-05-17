# app/utils/models.py
from bson import ObjectId
from app.utils.extensions import mongo, bcrypt

def _col(name):
    """Lazy lấy collection – chắc chắn mongo.db đã có sau init_app()."""
    return mongo.db[name]

class UserModel:
    @staticmethod
    def find_by_email(email):
        return _col("users").find_one({"email": email})

    @staticmethod
    def insert_user(doc):
        return _col("users").insert_one(doc)

    @staticmethod
    def from_dict(d):
        return UserModel(d["username"], d["email"], d["password_hash"], d["_id"])

    def __init__(self, username, email, pw_hash, _id=None):
        self.id = str(_id) if _id else None
        self.username = username
        self.email    = email
        self.pw_hash  = pw_hash

    # … check_password, v.v.
