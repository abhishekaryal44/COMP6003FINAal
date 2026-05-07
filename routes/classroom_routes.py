from flask import Blueprint, render_template
from models.classroom import Classroom

classroom_bp = Blueprint('classroom_bp', __name__)

@classroom_bp.route('/classrooms')
def classrooms():
    all_classrooms = Classroom.get_all()
    # The template expects a 'classrooms' variable, checking the name in template (often 'classrooms.html')
    # Wait, the template name was `classroom.html` according to list_dir, let's use `classroom.html`
    return render_template('classroom.html', classrooms=all_classrooms)
