import json
from app.utils.extensions import bcrypt, mongo

def _hash(pw:str)->str:
    return bcrypt.generate_password_hash(pw).decode()

def test_login_success(client):
    mongo.db.users.insert_one({
        "username": "bob",
        "email": "bob@mail.com",
        "password_hash": _hash("123")
    })
    res = client.post("/auth/login",
                      json={"email": "bob@mail.com", "password": "123"})
    assert res.status_code == 200
    assert res.get_json()["message"] == "Login successfully"

def test_login_wrong_password(client):
    mongo.db.users.insert_one({
        "username": "carol",
        "email": "carol@mail.com",
        "password_hash": _hash("correct")
    })
    res = client.post("/auth/login",
                      json={"email": "carol@mail.com", "password": "wrong"})
    assert res.status_code == 401
