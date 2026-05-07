from flask import Blueprint, render_template, request
from models.course import Course
from models.program import Program

course_bp = Blueprint('course_bp', __name__)

@course_bp.route('/courses', methods=['GET', 'POST'])
def search_courses():
    all_programs = Program.get_all()
    courses = []
    selected_program = None
    selected_semester = None
    
    if request.method == 'POST':
        selected_program = request.form.get('program_id')
        selected_semester = request.form.get('semester')
        
        if selected_program and selected_semester:
            courses = Course.search(selected_program, int(selected_semester))
            
    return render_template('courses.html', 
                           programs=all_programs, 
                           courses=courses, 
                           selected_program=selected_program,
                           selected_semester=selected_semester)
