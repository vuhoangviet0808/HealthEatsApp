from passlib.context import CryptContext
from motor.motor_asyncio import AsyncIOMotorClient
from app.utils.config import MONGO_URI

# ---------- bcrypt adapter ----------
_pwd = CryptContext(schemes=["bcrypt"], deprecated="auto")

class _Bcrypt:
    def hash(self, password: str) -> str:
        return _pwd.hash(password)

    def verify(self, password: str, hashed: str) -> bool:
        return _pwd.verify(password, hashed)

bcrypt = _Bcrypt()         


# ---------- mongo ----------
client = AsyncIOMotorClient(MONGO_URI)
mongo  = client.get_default_database()     # => mongo.db.<collection>
