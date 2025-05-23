from bson import ObjectId
from app.utils.extensions import mongo, bcrypt
from pydantic import BaseModel
from typing import List

class UserModel:
    @classmethod
    def col(cls):
        return mongo.db["users"]

    @classmethod
    def find_by_email(cls, email):
        return cls.col().find_one({"email": email})

    @classmethod
    def insert_user(cls, doc: dict):
        return cls.col().insert_one(doc)

    def __init__(self, username, email, pw_hash, _id=None):
        self.id = str(_id) if _id else None
        self.username = username
        self.email = email
        self.password_hash = pw_hash

    @classmethod
    def from_dict(cls, d):
        return cls(d["username"], d["email"], d["password_hash"], d["_id"])

    def check_password(self, raw_pw):
        return bcrypt.check_password_hash(self.password_hash, raw_pw)


class DetectItem(BaseModel):
    name: str
    conf: float
    kcal: int
    protein: int

class ChatImageResp(BaseModel):
    items: List[DetectItem]
    text: str

class ChatTextReq(BaseModel):
    chat_id: str
    text: str

class ChatTextResp(BaseModel):
    text: str
    role: str = "bot"