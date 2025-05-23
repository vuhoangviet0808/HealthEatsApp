from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from app.utils.config import Config
from app.api_router import api_router

def create_app() -> FastAPI:
    app = FastAPI(title=Config.APP_NAME)

    # CORS đơn giản
    app.add_middleware(
        CORSMiddleware,
        allow_origins=["*"],
        allow_methods=["*"],
        allow_headers=["*"],
    )

    # Đăng ký router
    app.include_router(api_router)

    @app.get("/")
    def ping():
        return {"status": "ok"}

    return app

app = create_app()
