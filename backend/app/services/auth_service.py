from fastapi import HTTPException
from pydantic import EmailStr
from app.utils.extensions import mongo, bcrypt
from app.utils.config import SECRET_KEY
import jwt, datetime

class AuthService:
    @staticmethod
    async def register(email: EmailStr, username: str, password: str):
        # kiểm tra trùng email
        if await mongo.db.users.find_one({"email": email}):
            raise HTTPException(status_code=400, detail="Email exists")

        hashed = bcrypt.hash(password)
        await mongo.db.users.insert_one(
            {"email": email, "username": username, "password": hashed}
        )
        return {"msg": "registered"}

    
    @staticmethod
    async def login(email: str, password: str) -> dict:
        user = await mongo.db.users.find_one({"email": email})
        # hashed = user["password"]
        if not user or not bcrypt.verify(password, user["password"]):
            raise HTTPException(status_code=401, detail="Invalid credentials")

        payload = {
            "sub": str(user["_id"]),
            "exp": datetime.datetime.utcnow() + datetime.timedelta(days=7)
        }
        token = jwt.encode(payload, SECRET_KEY, algorithm="HS256")

        return {
            "user": {
                "id": str(user["_id"]),
                "username": user["username"],
                "email": user["email"],
            },
            "access_token": token,
            "token_type": "bearer",
            "expires_in": 7 * 24 * 3600,  
        }