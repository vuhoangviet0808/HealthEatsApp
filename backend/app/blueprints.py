from app.routes import user_bp, post_bp

def register_blueprints(app):
    app.register_blueprint(user_bp)
    app.register_blueprint(post_bp)
