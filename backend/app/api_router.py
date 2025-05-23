from fastapi import APIRouter
from app.routers.auth_routes import router as auth_router
from app.routers.user_routes import router as user_router
from app.routers.chat_image  import router as chat_img_router
from app.routers.chat_text   import router as chat_txt_router

api_router = APIRouter()
api_router.include_router(auth_router)
api_router.include_router(user_router)
api_router.include_router(chat_img_router)
api_router.include_router(chat_txt_router)
