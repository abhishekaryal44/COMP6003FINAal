from flask import Blueprint, render_template
from models.program import Program

program_bp = Blueprint('program_bp', __name__)

@program_bp.route('/programs')
def programs():
    all_programs = Program.get_all()
    return render_template('programs.html', programs=all_programs)
