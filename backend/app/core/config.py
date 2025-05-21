"""
Cấu hình trung tâm của backend.
Đọc biến môi trường 
"""

from __future__ import annotations
from pathlib import Path
from functools import lru_cache
from pydantic import BaseSettings, Field

class Settings(BaseSettings):
    APP_NAME: str = "HealthEats APP"
    DEBUG: bool = False


    OPEN_API_KEY: str | None = Field(default=None, env="OPENAI_API_KEY")

    BASE_DIR: Path = Path(__file__).resolve.parents[2]
    YOLO_WEIGHTS: Path = BASE_DIR/"app"/"models_ai" / "food_detection" / "best.pt"
    YOLO_CONF_THRES: float = 0.4
    REDIS_URL: str = "redis://localhost:6379/0"

    class Config:
        env_file = ".env"
        env_file_encoding = "utf-8"


@lru_cache
def get_settings() -> Settings:
    return Settings()


settings = get_settings()