from flask import Flask, render_template
from routes.program_routes import program_bp
from routes.course_routes import course_bp
from routes.student_routes import student_bp
from routes.classroom_routes import classroom_bp

def create_app():
    app = Flask(__name__)
    app.config['SECRET_KEY'] = 'dev-secret-key-12345'

    # Register Blueprints
    app.register_blueprint(program_bp)
    app.register_blueprint(course_bp)
    app.register_blueprint(student_bp)
    app.register_blueprint(classroom_bp)

    @app.route('/')
    def index():
        return render_template('index.html')

    return app

if __name__ == '__main__':
    app = create_app()
    print("DIMS Application starting at http://127.0.0.1:5000")
    app.run(debug=True)