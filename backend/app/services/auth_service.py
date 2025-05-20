from app.utils.models import UserModel
from app.utils.extensions import bcrypt

class AuthService:
    @staticmethod
    def register(username, email, raw_pw):
        if UserModel.find_by_email(email):
            return {"message": "Email already exists"}, 409

        pw_hash = bcrypt.generate_password_hash(raw_pw).decode()
        UserModel.insert_user({
            "username": username,
            "email": email,
            "password_hash": pw_hash
        })
        return {"message": "User registered successfully"}, 201

    @staticmethod
    def login(email, raw_pw):
        doc = UserModel.find_by_email(email)
        if not doc:
            return {"message": "Invalid credentials"}, 401

        if bcrypt.check_password_hash(doc["password_hash"], raw_pw):
            return {"message": "Login successfully",
                    "user_id": str(doc["_id"]),
                    "username": doc["username"],
                    "email": doc["email"]}, 200
        return {"message": "Invalid credentials"}, 401
