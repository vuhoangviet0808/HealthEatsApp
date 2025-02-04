from flask import request

def before_request_func():
    print(f"Request: {request.method} {request.path}")

def register_middlewares(app):
    app.before_request(before_request_func)
