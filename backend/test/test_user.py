from bson import ObjectId
from app.utils.extensions import mongo

def test_get_profile(client):
    uid = ObjectId()
    mongo.db.users.insert_one({
        "_id": uid,
        "username": "dave",
        "email": "dave@mail.com",
        "password_hash": "x"
    })
    res = client.get(f"/users/{uid}")
    assert res.status_code == 200
    assert res.get_json()["username"] == "dave"
