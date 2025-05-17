import pytest, mongomock
from app import create_app
from app.utils.extensions import mongo

@pytest.fixture(scope="session")
def app():
    app = create_app()
    app.config["MONGO_URI"] = "mongodb://localhost:27017/test_db"
    mongo.cx = mongomock.MongoClient()       
    mongo.db = mongo.cx.get_database("test_db")
    app.extensions["pymongo"] = mongo
    yield app                                
    mongo.cx.close()

@pytest.fixture
def client(app):
    return app.test_client()
