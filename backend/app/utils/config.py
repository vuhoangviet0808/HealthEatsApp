import os, secrets

class Config:
    SECRET_KEY: str = os.getenv("SECRET_KEY") or secrets.token_hex(32)
    MONGO_URI: str = os.getenv(
        "MONGO_URI",
        "mongodb://localhost:27017/HealthEatsDatabase"
    )
    APP_NAME: str = "HealthEats APP"



SECRET_KEY = Config.SECRET_KEY
MONGO_URI  = Config.MONGO_URI
