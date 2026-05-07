from flask import Blueprint, render_template, request
from models.student import Student

student_bp = Blueprint('student_bp', __name__)

@student_bp.route('/students', methods=['GET', 'POST'])
def search_student():
    student = None
    student_id = None
    
    if request.method == 'POST':
        student_id = request.form.get('student_id')
        if student_id:
            student = Student.get_by_id(student_id)
            
    return render_template('students.html', student=student, student_id=student_id)

@student_bp.route('/students/add', methods=['GET', 'POST'])
def add_student():
    if request.method == 'POST':
        try:
            Student.create(
                request.form.get('studentID'),
                request.form.get('studName'),
                int(request.form.get('age')),
                request.form.get('email'),
                request.form.get('address'),
                request.form.get('contactNum'),
                float(request.form.get('marks')),
                float(request.form.get('attendance'))
            )
            return render_template('add_student.html', success=True)
        except Exception as e:
            return render_template('add_student.html', error=str(e))
            
    return render_template('add_student.html')
