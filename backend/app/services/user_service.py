from typing import Tuple, Dict, Any, List
from bson import ObjectId
from app.utils.models import UserModel

class UserService:
    @staticmethod
    def _to_public_dict(data: Dict[str, Any]) -> Dict[str, Any]:
        if not data:
            return {}
        
        public = {
            "id": str(data.get("_id")),
            "username": data.get("username"),
            "email": data.get("email"),
        }

        return public
    

    @staticmethod
    def _validate_object_id(user_id: str) -> ObjectId | None:
        try:
            return ObjectId(user_id)
        except Exception:
            return None
        

    #--------CRUD-------#
    @staticmethod
    def get_user(user_id: str) -> Tuple[Dict[str, Any], int]:
        oid = UserService._validate_object_id(user_id)
        if not oid:
            return {"message": "Invalid user id"}, 400
        
        user = UserModel.collection.find_one({"_id": oid})
        if not user:
            return {"message": "User not found"}, 404
        
        return UserService._to_public_dict(user), 200
    
    @staticmethod
    def update_user(user_id: str, payload: Dict[str, Any]) -> Tuple[Dict[str, Any], int]:
        oid = UserService._validate_object_id(user_id)
        if not oid:
            return {"message": "Invalid user id"}, 400
        
        allowed_fields = {"username", "email"}
        update_data = {k: v for k, v in payload.items() if k in allowed_fields}

        if not update_data:
            return {"message": "Nothing to update"}, 400
        
        result = UserModel.collection.update_one({"_id": oid}, {"$set": update_data})
        if result.matched_count == 0:
            return {"message": "User not found"}, 404
        
        user = UserModel.collection.find_one({"_id": oid})
        return UserService._to_public_dict(user), 200
    
    @staticmethod
    def delete_user(user_id: str) -> Tuple[Dict[str, Any], int]:
        oid = UserService._validate_object_id(user_id)
        if not oid:
            return {"message": "Invalid user id"}, 400
        
        result = UserModel.collection.delete_one({"_id": oid})
        if result.deleted_count == 0:
            return {"message": "User not found"}, 404
        
        return {"message": "User deleted successfully"}, 200
    
    def list_users(limit: int = 20, skip: int = 0) -> Tuple[List[Dict[str, Any]], int]:
        """
        Liệt kê người dùng (phục vụ admin / debug).
        """
        cursor = (
            UserModel.collection
            .find({}, {"password_hash": 0})
            .skip(skip)
            .limit(limit)
        )
        users = [UserService._to_public_dict(u) for u in cursor]
        return users, 200


        
    