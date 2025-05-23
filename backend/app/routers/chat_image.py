from fastapi import APIRouter, UploadFile, File
import cv2, numpy as np
from app.services.food_recognition import detect_food
from app.utils.models import ChatImageResp, DetectItem

router = APIRouter(tags=["chat"])

@router.post("/chat/image", response_model=ChatImageResp)
async def chat_image(file: UploadFile = File(...)):
    img_np = np.frombuffer(await file.read(), np.uint8)
    bgr    = cv2.imdecode(img_np, cv2.IMREAD_COLOR)

    items = detect_food(bgr)
    if not items:
        return ChatImageResp(items=[], text="No food detected 😢")

    lines = [f"- {i['name']} ({i['kcal']} kcal, {i['protein']} g protein)"
             for i in items]
    return ChatImageResp(
        items=[DetectItem(**i) for i in items],
        text="I see:\n" + "\n".join(lines),
    )
