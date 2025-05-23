from typing import Dict, Any
from bson import ObjectId
from fastapi import HTTPException
from app.utils.models import UserModel

class UserService:
    @staticmethod
    def _to_public(doc) -> dict:
        return {} if not doc else {
            "id": str(doc["_id"]),
            "username": doc["username"],
            "email": doc["email"],
        }

    @staticmethod
    def _oid(uid: str) -> ObjectId:
        try:
            return ObjectId(uid)
        except Exception:
            raise HTTPException(status_code=400, detail="Invalid user id")

    @classmethod
    async def get_user(cls, user_id: str) -> Dict[str, Any]:
        user = await UserModel.col().find_one({"_id": cls._oid(user_id)})
        if not user:
            raise HTTPException(status_code=404, detail="User not found")
        return cls._to_public(user)

    @classmethod
    async def update_user(cls, user_id: str, payload: Dict[str, Any]) -> Dict[str, Any]:
        allowed = {"username", "email"}
        changes = {k: v for k, v in payload.items() if k in allowed}
        if not changes:
            raise HTTPException(status_code=400, detail="Nothing to update")

        res = await UserModel.col().update_one(
            {"_id": cls._oid(user_id)}, {"$set": changes}
        )
        if res.matched_count == 0:
            raise HTTPException(status_code=404, detail="User not found")

        doc = await UserModel.col().find_one({"_id": cls._oid(user_id)})
        return cls._to_public(doc)
