from database.db_utils import execute_query

class Course:
    def __init__(self, courseCode, courseName, num_of_assessments, semester, progID, classID):
        self.courseCode = courseCode
        self.courseName = courseName
        self.num_of_assessments = num_of_assessments
        self.semester = semester
        self.progID = progID
        self.classID = classID

    @staticmethod
    def search(progID, semester):
        query = "SELECT * FROM Courses WHERE progID = ? AND semester = ?"
        rows = execute_query(query, (progID, semester), fetchall=True)
        return [Course(**dict(row)) for row in rows]
