-- ============================================================
-- COMP6003 – Department Information Management System (DIMS)
-- Database Schema: schema.sql
-- University of Notre Dame Australia
-- ============================================================
-- HOW TO USE:
--   Option 1: Open SQLite Studio → New Database → Run this file
--   Option 2: Run in terminal:  sqlite3 dims.db < schema.sql
-- ============================================================
 
 
-- ────────────────────────────────────────────────────────────
-- DROP EXISTING TABLES (safe reset order — children first)
-- ────────────────────────────────────────────────────────────
DROP TABLE IF EXISTS Enrollments;
DROP TABLE IF EXISTS Courses;
DROP TABLE IF EXISTS Students;
DROP TABLE IF EXISTS Classrooms;
DROP TABLE IF EXISTS Programs;
 
 
-- ────────────────────────────────────────────────────────────
-- TABLE 1: Programs
-- Stores undergraduate and postgraduate academic programs
-- ────────────────────────────────────────────────────────────
CREATE TABLE Programs (
    progID          TEXT        PRIMARY KEY,        -- e.g. 'UG-CS', 'PG-CS'
    progName        TEXT        NOT NULL,           -- Full program name
    progLevel       TEXT        NOT NULL            -- 'Undergraduate' or 'Master'
                    CHECK(progLevel IN ('Undergraduate', 'Master')),
    duration        INTEGER     NOT NULL,           -- Duration in years (e.g. 3 or 2)
    totalCredit     INTEGER     NOT NULL,           -- Total credit points required
    num_of_courses  INTEGER     NOT NULL            -- Total number of courses in program
);
 
 
-- ────────────────────────────────────────────────────────────
-- TABLE 2: Classrooms
-- Stores classroom/room information for each campus
-- ────────────────────────────────────────────────────────────
CREATE TABLE Classrooms (
    classID         INTEGER     PRIMARY KEY AUTOINCREMENT,
    roomNum         TEXT        NOT NULL,           -- Room number e.g. 'T101'
    buildingNum     TEXT        NOT NULL,           -- Building identifier e.g. 'B3'
    seat_capacity   INTEGER     NOT NULL,           -- Number of seats in room
    campus          TEXT        NOT NULL            -- 'Fremantle' or 'Sydney'
                    CHECK(campus IN ('Fremantle', 'Sydney'))
);
 
 
-- ────────────────────────────────────────────────────────────
-- TABLE 3: Courses
-- Stores course details; linked to a Program and Classroom
-- ────────────────────────────────────────────────────────────
CREATE TABLE Courses (
    courseCode          TEXT        PRIMARY KEY,    -- e.g. 'COMP1001'
    courseName          TEXT        NOT NULL,       -- Full course name
    num_of_assessments  INTEGER     NOT NULL,       -- Number of assessments in course
    semester            INTEGER     NOT NULL        -- Semester number (1, 2, etc.)
                        CHECK(semester >= 1),
    progID              TEXT        NOT NULL,       -- FK → Programs
    classID             INTEGER     NOT NULL,       -- FK → Classrooms
 
    FOREIGN KEY (progID)  REFERENCES Programs(progID),
    FOREIGN KEY (classID) REFERENCES Classrooms(classID)
);
 
 
-- ────────────────────────────────────────────────────────────
-- TABLE 4: Students
-- Stores student personal and academic performance records
-- ────────────────────────────────────────────────────────────
CREATE TABLE Students (
    studentID           TEXT        PRIMARY KEY,    -- Unique student ID e.g. 'S3012345'
    studName            TEXT        NOT NULL,       -- Full name
    age                 INTEGER     NOT NULL,
    email               TEXT        NOT NULL UNIQUE,
    address             TEXT,
    contactNum          TEXT,
    marksPercentage     REAL        DEFAULT 0.0     -- Overall marks % (0.0 – 100.0)
                        CHECK(marksPercentage >= 0 AND marksPercentage <= 100),
    attendancePercentage REAL       DEFAULT 0.0     -- Attendance % (0.0 – 100.0)
                        CHECK(attendancePercentage >= 0 AND attendancePercentage <= 100)
);
 
 
-- ────────────────────────────────────────────────────────────
-- TABLE 5: Enrollments
-- Junction table — links Students to Courses (many-to-many)
-- ────────────────────────────────────────────────────────────
CREATE TABLE Enrollments (
    enrollID        INTEGER     PRIMARY KEY AUTOINCREMENT,
    studentID       TEXT        NOT NULL,           -- FK → Students
    courseCode      TEXT        NOT NULL,           -- FK → Courses
    date_of_enroll  TEXT        NOT NULL,           -- ISO date string 'YYYY-MM-DD'
 
    FOREIGN KEY (studentID)  REFERENCES Students(studentID),
    FOREIGN KEY (courseCode) REFERENCES Courses(courseCode),
 
    -- Prevent duplicate enrollments for same student + course
    UNIQUE(studentID, courseCode)
);
 
 
-- ============================================================
-- SAMPLE SEED DATA
-- ============================================================
 
 
-- ── Programs ─────────────────────────────────────────────────
INSERT INTO Programs VALUES ('UG-CS',  'Bachelor of Computer Science',    'Undergraduate', 3, 240, 24);
INSERT INTO Programs VALUES ('UG-IT',  'Bachelor of Information Technology','Undergraduate',3, 240, 24);
INSERT INTO Programs VALUES ('PG-CS',  'Master of Computer Science',       'Master',        2, 160, 16);
INSERT INTO Programs VALUES ('PG-MIT', 'Master of Information Technology', 'Master',        2, 160, 16);
 
 
-- ── Classrooms ───────────────────────────────────────────────
INSERT INTO Classrooms (roomNum, buildingNum, seat_capacity, campus) VALUES ('T101', 'B1', 40, 'Sydney');
INSERT INTO Classrooms (roomNum, buildingNum, seat_capacity, campus) VALUES ('T102', 'B1', 35, 'Sydney');
INSERT INTO Classrooms (roomNum, buildingNum, seat_capacity, campus) VALUES ('T201', 'B2', 50, 'Sydney');
INSERT INTO Classrooms (roomNum, buildingNum, seat_capacity, campus) VALUES ('F101', 'B3', 40, 'Fremantle');
INSERT INTO Classrooms (roomNum, buildingNum, seat_capacity, campus) VALUES ('F201', 'B3', 30, 'Fremantle');
INSERT INTO Classrooms (roomNum, buildingNum, seat_capacity, campus) VALUES ('F301', 'B4', 45, 'Fremantle');
 
 
-- ── Courses ──────────────────────────────────────────────────
-- UG-CS Semester 1
INSERT INTO Courses VALUES ('COMP1001', 'Introduction to Programming',       3, 1, 'UG-CS',  1);
INSERT INTO Courses VALUES ('COMP1002', 'Foundations of Computer Science',   2, 1, 'UG-CS',  2);
INSERT INTO Courses VALUES ('MATH1001', 'Discrete Mathematics',              3, 1, 'UG-CS',  3);
-- UG-CS Semester 2
INSERT INTO Courses VALUES ('COMP1003', 'Data Structures and Algorithms',    3, 2, 'UG-CS',  1);
INSERT INTO Courses VALUES ('COMP1004', 'Database Systems',                  3, 2, 'UG-CS',  4);
INSERT INTO Courses VALUES ('COMP1005', 'Web Development Fundamentals',      2, 2, 'UG-CS',  2);
-- UG-CS Year 2
INSERT INTO Courses VALUES ('COMP2001', 'Object-Oriented Programming',       3, 3, 'UG-CS',  3);
INSERT INTO Courses VALUES ('COMP2002', 'Software Engineering',              3, 3, 'UG-CS',  1);
INSERT INTO Courses VALUES ('COMP2003', 'Operating Systems',                 2, 4, 'UG-CS',  2);
INSERT INTO Courses VALUES ('COMP2004', 'Computer Networks',                 3, 4, 'UG-CS',  4);
-- PG-CS Semester 1
INSERT INTO Courses VALUES ('COMP6001', 'Advanced Algorithms',               3, 1, 'PG-CS',  5);
INSERT INTO Courses VALUES ('COMP6002', 'Machine Learning Fundamentals',     3, 1, 'PG-CS',  6);
INSERT INTO Courses VALUES ('COMP6003', 'Software Design and Development',   3, 1, 'PG-CS',  5);
-- PG-CS Semester 2
INSERT INTO Courses VALUES ('COMP6004', 'Cloud Computing',                   3, 2, 'PG-CS',  6);
INSERT INTO Courses VALUES ('COMP6005', 'Cybersecurity Principles',          2, 2, 'PG-CS',  5);
 
 
-- ── Students ─────────────────────────────────────────────────
INSERT INTO Students VALUES ('S3010001', 'Alice Johnson',   22, 'alice.johnson@nd.edu.au',   '12 King St, Sydney NSW 2000',       '0412345678', 78.5, 92.0);
INSERT INTO Students VALUES ('S3010002', 'Bob Smith',       23, 'bob.smith@nd.edu.au',        '34 Queen St, Sydney NSW 2000',      '0423456789', 65.0, 85.5);
INSERT INTO Students VALUES ('S3010003', 'Clara Wang',      21, 'clara.wang@nd.edu.au',       '56 Park Ave, Sydney NSW 2010',      '0434567890', 88.0, 95.0);
INSERT INTO Students VALUES ('S3010004', 'David Lee',       24, 'david.lee@nd.edu.au',        '78 George St, Sydney NSW 2000',     '0445678901', 72.3, 80.0);
INSERT INTO Students VALUES ('S3010005', 'Eva Brown',       22, 'eva.brown@nd.edu.au',        '90 Pitt St, Sydney NSW 2000',       '0456789012', 55.0, 76.5);
INSERT INTO Students VALUES ('S3010006', 'Frank Miller',    25, 'frank.miller@nd.edu.au',     '10 Market St, Fremantle WA 6160',   '0467890123', 91.5, 98.0);
INSERT INTO Students VALUES ('S3010007', 'Grace Nguyen',    23, 'grace.nguyen@nd.edu.au',     '22 High St, Fremantle WA 6160',     '0478901234', 60.0, 83.0);
INSERT INTO Students VALUES ('S3010008', 'Henry Patel',     26, 'henry.patel@nd.edu.au',      '44 Beach Rd, Fremantle WA 6160',    '0489012345', 83.7, 90.5);
 
 
-- ── Enrollments ──────────────────────────────────────────────
-- Alice enrolled in UG-CS Year 1 courses
INSERT INTO Enrollments (studentID, courseCode, date_of_enroll) VALUES ('S3010001', 'COMP1001', '2025-02-01');
INSERT INTO Enrollments (studentID, courseCode, date_of_enroll) VALUES ('S3010001', 'COMP1002', '2025-02-01');
INSERT INTO Enrollments (studentID, courseCode, date_of_enroll) VALUES ('S3010001', 'MATH1001', '2025-02-01');
 
-- Bob enrolled in UG-CS
INSERT INTO Enrollments (studentID, courseCode, date_of_enroll) VALUES ('S3010002', 'COMP1001', '2025-02-01');
INSERT INTO Enrollments (studentID, courseCode, date_of_enroll) VALUES ('S3010002', 'COMP1003', '2025-07-15');
INSERT INTO Enrollments (studentID, courseCode, date_of_enroll) VALUES ('S3010002', 'COMP1004', '2025-07-15');
 
-- Clara enrolled in UG-CS Year 2
INSERT INTO Enrollments (studentID, courseCode, date_of_enroll) VALUES ('S3010003', 'COMP2001', '2025-02-01');
INSERT INTO Enrollments (studentID, courseCode, date_of_enroll) VALUES ('S3010003', 'COMP2002', '2025-02-01');
INSERT INTO Enrollments (studentID, courseCode, date_of_enroll) VALUES ('S3010003', 'COMP2003', '2025-07-15');
 
-- Frank enrolled in PG-CS
INSERT INTO Enrollments (studentID, courseCode, date_of_enroll) VALUES ('S3010006', 'COMP6001', '2025-02-01');
INSERT INTO Enrollments (studentID, courseCode, date_of_enroll) VALUES ('S3010006', 'COMP6002', '2025-02-01');
INSERT INTO Enrollments (studentID, courseCode, date_of_enroll) VALUES ('S3010006', 'COMP6003', '2025-02-01');
 
-- Henry enrolled in PG-CS
INSERT INTO Enrollments (studentID, courseCode, date_of_enroll) VALUES ('S3010008', 'COMP6003', '2026-02-01');
INSERT INTO Enrollments (studentID, courseCode, date_of_enroll) VALUES ('S3010008', 'COMP6004', '2026-02-01');
INSERT INTO Enrollments (studentID, courseCode, date_of_enroll) VALUES ('S3010008', 'COMP6005', '2026-02-01');
 
 
-- ============================================================
-- VERIFICATION QUERIES (run these to confirm setup is correct)
-- ============================================================
-- SELECT * FROM Programs;
-- SELECT * FROM Classrooms;
-- SELECT * FROM Courses;
-- SELECT * FROM Students;
-- SELECT * FROM Enrollments;
 
-- Find all courses for a program in a specific semester:
-- SELECT courseCode, courseName, num_of_assessments, classID
-- FROM Courses WHERE progID = 'UG-CS' AND semester = 1;
 
-- Find student info + enrolled courses:
-- SELECT s.studentID, s.studName, s.email, s.marksPercentage,
--        s.attendancePercentage, c.courseCode, c.courseName
-- FROM Students s
-- JOIN Enrollments e ON s.studentID = e.studentID
-- JOIN Courses c     ON e.courseCode = c.courseCode
-- WHERE s.studentID = 'S3010001';
 