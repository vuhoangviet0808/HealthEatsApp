from fastapi import APIRouter, File, UploadFile
import cv2, numpy as np

from services.food_recognition import detect_food
from app.models_ai import ChatImageResp, DetectItem

router = APIRouter(prefix="/chat")

@router.post("/image", response_model=ChatImageResp)
async def chat_image(file: UploadFile = File(...)):
    img_np = np.frombuffer(await file.read(), np.uint8)
    bgr    = cv2.imdecode(img_np, cv2.IMREAD_COLOR)

    items = detect_food(bgr)
    if not items:
        return ChatImageResp(items=[], text="No food detected 😢")

    lines = [f"- {i['name']} ({i['kcal']} kcal, {i['protein']} g protein)"
             for i in items]
    reply = "I see:\n" + "\n".join(lines)
    return ChatImageResp(
        items=[DetectItem(**i) for i in items],
        text=reply,
    )