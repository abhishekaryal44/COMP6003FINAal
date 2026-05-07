from database.db_utils import execute_query

class Student:
    def __init__(self, studentID, studName, age, email, address, contactNum, marksPercentage, attendancePercentage):
        self.studentID = studentID
        self.studName = studName
        self.age = age
        self.email = email
        self.address = address
        self.contactNum = contactNum
        self.marksPercentage = marksPercentage
        self.attendancePercentage = attendancePercentage
        self.enrolled_courses = []

    @staticmethod
    def get_by_id(studentID):
        query = "SELECT * FROM Students WHERE studentID = ?"
        row = execute_query(query, (studentID,), fetchone=True)
        if not row:
            return None
        
        student = Student(**dict(row))
        
        # Fetch enrolled courses
        enroll_query = """
            SELECT c.courseCode, c.courseName 
            FROM Courses c
            JOIN Enrollments e ON c.courseCode = e.courseCode
            WHERE e.studentID = ?
        """
        enroll_rows = execute_query(enroll_query, (studentID,), fetchall=True)
        student.enrolled_courses = [dict(r) for r in enroll_rows]
        
        return student

    @staticmethod
    def create(studentID, studName, age, email, address, contactNum, marks, attendance):
        query = """
            INSERT INTO Students (studentID, studName, age, email, address, contactNum, marksPercentage, attendancePercentage)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?)
        """
        execute_query(query, (studentID, studName, age, email, address, contactNum, marks, attendance), commit=True)
