"""
Tra cứu nhanh giá trị dinh dưỡng (kcal, protein) cho từng món.
MVP: đọc dict cứng hoặc JSON nội bộ. Sau này có thể đổi sang DB.
"""
from __future__ import annotations
from pathlib import Path
import json
from functools import lru_cache

# Nếu muốn tách file JSON dinh dưỡng, đặt tại cùng thư mục
_DB_PATH = Path(__file__).with_name("nutrition_db.json")

# Fallback mặc định khi chưa có file JSON
_DEFAULT_DATA: dict[str, dict[str, int]] = {
    "salad":  {"kcal": 150, "protein": 4},
    "egg":    {"kcal": 80,  "protein": 6},
    "burger": {"kcal": 300, "protein": 18},
}


@lru_cache
def _load_db() -> dict[str, dict[str, int]]:
    """
    Đọc JSON một lần (cache) – nếu chưa có file thì dùng dữ liệu mặc định.
    """
    if _DB_PATH.exists():
        try:
            with open(_DB_PATH, "r", encoding="utf-8") as f:
                return json.load(f)
        except Exception as e:
            print("Nutrition DB load error:", e)

    return _DEFAULT_DATA


def lookup(food_name: str) -> dict[str, int]:
    """
    Trả về dict {"kcal": int, "protein": int}.
    Nếu không tìm thấy → trả {"kcal": 0, "protein": 0}.
    """
    db = _load_db()
    return db.get(food_name.lower(), {"kcal": 0, "protein": 0})
