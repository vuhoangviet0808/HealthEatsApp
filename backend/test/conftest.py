import pytest, mongomock
from app import create_app
from app.utils.extensions import mongo

@pytest.fixture(scope="session")
def app():
    app = create_app()
    # app.config["MONGO_URI"] = "mongodb://localhost:27017/test_db"
    mock_client = mongomock.MongoClient()
    mongo.cx = mock_client        
    mongo.db = mock_client.db
    app.extensions["pymongo"] = mongo
    yield app                                
    mock_client.close()

@pytest.fixture
def client(app):
    return app.test_client()
