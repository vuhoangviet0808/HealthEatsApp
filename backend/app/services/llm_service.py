from typing import List, Dict, Any
DEFAULT_BOT_REPLY = (
    "🤖 Xin chào! Đây là phản hồi mặc định (stub) – "
    "khi bạn tích hợp LLM thật hãy thay thế hàm chat_llm."
)


async def chat_llm(
    prompt: str,
    history: List[Dict[str, Any]] | None = None,
) -> str:
    return DEFAULT_BOT_REPLY
