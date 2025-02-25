from app.extensions import mongo, bcrypt
class UserModel:
    def __init__(self, username, email, password):
        self.username = username
        self.email = email
        self.password_hash = bcrypt.generate_password_hash(password).decode('utf-8')

    def check_password(self, password):
        return bcrypt.check_password_hash(self.password_hash, password)
    

    @staticmethod
    def find_by_email(email):
        return mongo.db.users.find_one({"email": email})
    
    @staticmethod
    def insert_user(user_data):
        return mongo.db.users.insert_one(user_data)
    
    @staticmethod
    def from_dict(data):
        return UserModel(data["username"], data["email"], data["password"])
    