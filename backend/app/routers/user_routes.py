from fastapi import APIRouter
from pydantic import BaseModel, EmailStr
from app.services.user_service import UserService

router = APIRouter(prefix="/users", tags=["users"])

class UpdateUserIn(BaseModel):
    username: str | None = None
    email: EmailStr | None = None

@router.get("/{user_id}")
async def get_user(user_id: str):
    return await UserService.get_user(user_id)

@router.patch("/{user_id}")
async def update_user(user_id: str, body: UpdateUserIn):
    return await UserService.update_user(
        user_id, body.model_dump(exclude_none=True)
    )
