from app import create_app
from app.routes.blueprints import blueprint
app = create_app()
app.register_blueprint(blueprint)
if __name__ == '__main__':
    
    app.run(debug=True)