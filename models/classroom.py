from database.db_utils import execute_query

class Classroom:
    def __init__(self, classID, roomNum, buildingNum, seat_capacity, campus):
        self.classID = classID
        self.roomNum = roomNum
        self.buildingNum = buildingNum
        self.seat_capacity = seat_capacity
        self.campus = campus

    @staticmethod
    def get_all():
        query = "SELECT * FROM Classrooms"
        rows = execute_query(query, fetchall=True)
        return [Classroom(**dict(row)) for row in rows]
