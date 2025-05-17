from typing import Tuple, Dict, Any, List
from bson import ObjectId
from app.utils.models import UserModel

class UserService:
    @staticmethod
    def _to_public(doc) -> dict:
        if not doc:
            return {}
        return {
            "id": str(doc["_id"]),
            "username": doc["username"],
            "email": doc["email"],
        }

    @staticmethod
    def _oid(uid: str) -> ObjectId | None:
        try:
            return ObjectId(uid)
        except Exception:
            return None
        

    @staticmethod
    def get_user(user_id: str) -> Tuple[Dict[str, Any], int]:
        oid = UserService._oid(user_id)
        if not oid:
            return {"message": "Invalid user id"}, 400

        user = UserModel.col().find_one({"_id": oid})
        if not user:
            return {"message": "User not found"}, 404
        return UserService._to_public(user), 200

    @staticmethod
    def update_user(user_id: str, payload: Dict[str, Any]):
        oid = UserService._oid(user_id)
        if not oid:
            return {"message": "Invalid user id"}, 400

        allowed = {"username", "email"}
        changes = {k: v for k, v in payload.items() if k in allowed}
        if not changes:
            return {"message": "Nothing to update"}, 400

        res = UserModel.col().update_one({"_id": oid}, {"$set": changes})
        if res.matched_count == 0:
            return {"message": "User not found"}, 404

        doc = UserModel.col().find_one({"_id": oid})
        return UserService._to_public(doc), 200


        
    