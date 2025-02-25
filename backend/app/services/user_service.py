from app.utils.models import UserModel

class UserService:
    @staticmethod
    def register_user(username, email, password):
        if UserModel.find_by_email(email):
            return {"message": "Email already exist"}, 400
        
        user = UserModel(username, email, password)

        user_data = {'username': username, 'email': email, 'password': password}
        user.insert_user(user_data)

        return {"message": "User registered successfully"}, 201
    
    @staticmethod
    def login_user(email, password):
        user = UserModel.find_by_email(email)
        if user:
            user_model = UserModel.from_dict(user)
            if user_model.check_password(password):
                return {"message":"Login Successfully"}, 200
        return {"message":"Invalid credentials"}, 401
    
    