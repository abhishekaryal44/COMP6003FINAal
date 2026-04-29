🎓 Department Information Management System
COMP6003 – Software Design and Development | Semester 1, 2026
University of Notre Dame Australia — Fremantle & Sydney Campus

📋 Project Overview
The Department Information Management System (DIMS) is a web-based application built for the newly established Department of Computer Science at the University of Notre Dame Australia. The system allows students, faculty, and administrators to efficiently search and retrieve academic information including programs, courses, student records, and classroom schedules.
The application is built using Python Flask as the backend framework, SQLite as the database, and HTML/CSS for the frontend interface. The system follows Object-Oriented Programming (OOP) principles to ensure modularity, maintainability, and scalability.

👥 Group Information
FieldDetailsGroup NameGroup [X]AssessmentAssessment 2 — COMP6003CourseSoftware Design and DevelopmentCampusSydney CampusSubmission08 May 2026
Group Members
NameStudent IDRole[Member 1 Name][ID]Project Leader[Member 2 Name][ID]Developer[Member 3 Name][ID]Developer[Member 4 Name][ID]Developer

Project Leader: [Name] is responsible for managing the main branch, reviewing Pull Requests, and ensuring repository integrity.


🚀 Features

📚 Program Information — View all available undergraduate and postgraduate programs with duration, total credits, and number of courses
🔍 Course Search — Search courses by Program ID and Semester; view course code, name, assessments, and classroom
👤 Student Search — Look up student details by Student ID including marks %, attendance %, and enrolled courses
🏫 Classroom Information — View all classrooms with room number, building, seating capacity, and campus


🛠️ Technologies Used
TechnologyPurposePython 3.xCore programming languageFlaskWeb framework / backend routingSQLiteRelational databaseSQLite StudioDatabase design & management GUIHTML / CSSFrontend templates (Jinja2)PyCharmIDE for developmentGitLocal version controlGitHubRemote repository & collaborationunittestPython unit testing framework

📁 Project Structure
COMP6003_GroupX/
│
├── app.py                    # Main Flask application entry point
├── models/
│   ├── __init__.py
│   ├── program.py            # Program OOP class
│   ├── course.py             # Course OOP class
│   ├── student.py            # Student OOP class
│   └── classroom.py          # Classroom OOP class
│
├── routes/
│   ├── __init__.py
│   ├── program_routes.py     # Flask routes for program info
│   ├── course_routes.py      # Flask routes for course search
│   ├── student_routes.py     # Flask routes for student search
│   └── classroom_routes.py   # Flask routes for classroom info
│
├── database/
│   ├── schema.sql            # SQLite database schema
│   ├── seed_data.sql         # Sample data for all tables
│   └── dims.db               # SQLite database file
│
├── templates/
│   ├── base.html             # Base layout template
│   ├── index.html            # Home page
│   ├── programs.html         # Program listing page
│   ├── courses.html          # Course search page
│   ├── students.html         # Student search page
│   └── classrooms.html       # Classroom listing page
│
├── static/
│   ├── css/
│   │   └── style.css         # Main stylesheet
│   └── images/               # Any static images
│
├── tests/
│   ├── test_program.py       # Unit tests for Program module
│   ├── test_course.py        # Unit tests for Course module
│   ├── test_student.py       # Unit tests for Student module
│   └── test_classroom.py     # Unit tests for Classroom module
│
├── evidence/                 # Screenshots of development & Git activity
├── requirements.txt          # Python dependencies
└── README.md                 # This file

⚙️ Installation & Setup
Prerequisites
Make sure you have the following installed:

Python 3.8 or higher
pip (Python package manager)
Git

Step 1 — Clone the Repository
bashgit clone https://github.com/[your-username]/COMP6003_GroupX.git
cd COMP6003_GroupX
Step 2 — Create a Virtual Environment (Recommended)
bash# Windows
python -m venv venv
venv\Scripts\activate

# macOS / Linux
python3 -m venv venv
source venv/bin/activate
Step 3 — Install Dependencies
bashpip install -r requirements.txt
Step 4 — Set Up the Database
bash# This will create the SQLite database and populate it with sample data
python database/init_db.py
Alternatively, open database/schema.sql in SQLite Studio to create and view the tables manually.
Step 5 — Run the Application
bashpython app.py
Then open your browser and navigate to:
http://127.0.0.1:5000

🧪 Running Unit Tests
All unit tests are inside the tests/ folder. Run them using:
bash# Run all tests
python -m unittest discover tests/

# Run a specific test file
python -m unittest tests/test_student.py

🗃️ Database Overview
The SQLite database (dims.db) contains the following tables:
TablePrimary KeyDescriptionProgramsprogIDAcademic programs (UG and PG)StudentsstudentIDStudent personal and academic recordsCoursescourseCodeCourse details linked to programsClassroomsclassIDRoom information across campusesEnrollmentsenrollIDLinks students to their enrolled courses

See database/schema.sql for the full schema with all column definitions and relationships.


🌿 Git Branching Strategy
The project uses a feature-branch workflow:
Branch NamePurposemainStable production-ready code onlyfeature-flask-homeHome page and base Flask setupfeature-program-searchProgram listing functionalityfeature-course-searchCourse search by program & semesterfeature-student-searchStudent lookup by IDfeature-classroom-infoClassroom display pagefeature-database-setupSQLite schema and seed datafeature-unit-testsUnit test implementation

⚠️ No team member pushes directly to main. All changes go through Pull Requests reviewed and approved by the Project Leader.


🤖 AI Usage Declaration

As required by the COMP6003 assessment guidelines, we declare the following regarding AI tool usage during this project:


AI Tool Used: [e.g., Claude / ChatGPT / GitHub Copilot — or "No AI tools were used"]
Purpose: [e.g., "Used to help understand Flask routing concepts and generate initial boilerplate code"]
Review Process: All AI-generated code suggestions were carefully reviewed by each team member, tested manually, modified to fit our specific project requirements, and integrated only after group discussion and approval. No AI-generated code was submitted without understanding and adaptation.


📌 Notes for Lecturer

The GitHub repository will be made accessible to the lecturer by end of Week 10
All evidence screenshots are stored in the evidence/ folder
Each Python file includes author comments at the top (e.g., # Jane Smith, Student ID: 3012345)
Sprint documentation is included in the project report


📄 License
This project was developed for academic purposes as part of COMP6003 at the University of Notre Dame Australia. Not for commercial use.