from database.db_utils import execute_query

class Program:
    def __init__(self, progID, progName, progLevel, duration, totalCredit, num_of_courses):
        self.progID = progID
        self.progName = progName
        self.progLevel = progLevel
        self.duration = duration
        self.totalCredit = totalCredit
        self.num_of_courses = num_of_courses

    @staticmethod
    def get_all():
        query = "SELECT * FROM Programs"
        rows = execute_query(query, fetchall=True)
        return [Program(**dict(row)) for row in rows]
