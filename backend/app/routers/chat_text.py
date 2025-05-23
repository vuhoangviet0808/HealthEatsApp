from fastapi import APIRouter
import redis.asyncio as redis
from app.services.llm_service import chat_llm
from app.utils.models import ChatTextReq, ChatTextResp
from app.core.config import settings

router = APIRouter(tags=["chat"])
rdb = redis.from_url(settings.REDIS_URL, decode_responses=True)

@router.post("/chat/text", response_model=ChatTextResp)
async def chat_text(req: ChatTextReq):
    history = await rdb.lrange(f"hist:{req.chat_id}", 0, -1)
    history = [eval(i) for i in history]

    bot = await chat_llm(req.text, history)

    await rdb.rpush(f"hist:{req.chat_id}", {"role":"user","content":req.text})
    await rdb.rpush(f"hist:{req.chat_id}", {"role":"bot","content":bot})

    return {"text": bot}
