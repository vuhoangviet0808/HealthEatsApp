from fastapi import APIRouter
from pydantic import BaseModel, EmailStr
from app.services.auth_service import AuthService

router = APIRouter(prefix="/auth", tags=["auth"])

class RegisterIn(BaseModel):
    email: EmailStr
    username: str
    password: str

class LoginIn(BaseModel):
    email: EmailStr
    password: str

@router.post("/register")
async def register(body: RegisterIn):
    return await AuthService.register(body.email, body.username, body.password)

@router.post("/login")
async def login(body: LoginIn):
    return await AuthService.login(body.email, body.password)
