def get_all_users(mongo):
    users_collection = mongo.db.users  
    users = users_collection.find()  
    return list(users)