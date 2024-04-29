-- CREATE DATABASE --

CREATE DATABASE myuniversity;
USE myuniversity;

-- CREATE TABLES --

CREATE TABLE Department (
    dept_name VARCHAR(50) PRIMARY KEY,
    building VARCHAR(50),
    budget DECIMAL(12, 2)
);

CREATE TABLE Course (
    course_ID VARCHAR(10) PRIMARY KEY,
    title VARCHAR(100),
    dept_name VARCHAR(50),
    credits INT,
    syllabus TEXT,
    FOREIGN KEY (dept_name) REFERENCES Department(dept_name)
);

CREATE TABLE Instructor (
    ID VARCHAR(10) PRIMARY KEY,
    name VARCHAR(100),
    dept_name VARCHAR(50),
    salary DECIMAL(12, 2),
    FOREIGN KEY (dept_name) REFERENCES Department(dept_name)
);

CREATE TABLE Section (
    sec_ID VARCHAR(10),
    course_ID VARCHAR(10),
    semester VARCHAR(10),
    year INT,
    building VARCHAR(50),
    room_no VARCHAR(10),
    time_slot_ID VARCHAR(10),
    PRIMARY KEY (sec_ID, course_ID, semester, year),
    FOREIGN KEY (course_ID) REFERENCES Course(course_ID)
);

CREATE TABLE Time_Slot (
    time_slot_ID VARCHAR(10) PRIMARY KEY,
    day VARCHAR(10),
    start_hr TIME,
    end_hr TIME,
    start_min TIME,
    end_min TIME
);

CREATE TABLE Classroom (
    room_no VARCHAR(10),
    building VARCHAR(50),
    capacity INT,
    PRIMARY KEY (room_no, building)
);

CREATE TABLE Student (
    ID VARCHAR(10) PRIMARY KEY,
    name VARCHAR(100),
    dept_name VARCHAR(50),
    tot_credit INT,
    date_of_birth DATE,
    FOREIGN KEY (dept_name) REFERENCES Department(dept_name)
);

CREATE TABLE Advisor (
    s_ID VARCHAR(10),
    I_ID VARCHAR(10),
    PRIMARY KEY (s_ID),
    FOREIGN KEY (s_ID) REFERENCES Student(ID),
    FOREIGN KEY (I_ID) REFERENCES Instructor(ID)
);

CREATE TABLE Takes (
    ID VARCHAR(10),
    course_ID VARCHAR(10),
    sec_ID VARCHAR(10),
    semester VARCHAR(10),
    year INT,
    grade CHAR(2),
    PRIMARY KEY (ID, course_ID, sec_ID, semester, year),
    FOREIGN KEY (ID) REFERENCES Student(ID),
    FOREIGN KEY (course_ID, sec_ID, semester, year) REFERENCES Section(course_ID, sec_ID, semester, year)
);

CREATE TABLE Teaches (
    ID VARCHAR(10),
    course_ID VARCHAR(10),
    sec_ID VARCHAR(10),
    semester VARCHAR(10),
    year INT,
    PRIMARY KEY (ID, course_ID, sec_ID, semester, year),
    FOREIGN KEY (ID) REFERENCES Instructor(ID),
    FOREIGN KEY (course_ID, sec_ID, semester, year) REFERENCES Section(course_ID, sec_ID, semester, year)
);

CREATE TABLE Prerequisite (
    course_ID VARCHAR(10),
    prereq_ID VARCHAR(10),
    PRIMARY KEY (course_ID, prereq_ID),
    FOREIGN KEY (course_ID) REFERENCES Course(course_ID),
    FOREIGN KEY (prereq_ID) REFERENCES Course(course_ID)
);

CREATE TABLE Grading_Components (
    course_ID VARCHAR(10),
    max_points INT,
    weights DECIMAL(5, 2),
    PRIMARY KEY (course_ID),
    FOREIGN KEY (course_ID) REFERENCES Course(course_ID)
);

-- The relationship between Section and Time_Slot is many-to-one, so we add a foreign key to Section.
ALTER TABLE Section
ADD FOREIGN KEY (time_slot_ID) REFERENCES Time_Slot(time_slot_ID);

-- The relationship between Section and Classroom is many-to-one, so we add a foreign key to Section.
ALTER TABLE Section
ADD FOREIGN KEY (building, room_no) REFERENCES Classroom(building, room_no);

-- INSERT --

INSERT INTO Department (dept_name, building, budget) VALUES
('Computer Science', 'CompSci Building', 500000),
('Mathematics', 'Math Building', 300000),
('Physics', 'Physics Building', 250000),
('History', 'History Building', 200000),
('English', 'English Building', 150000),
('Biology', 'Biology Building', 350000),
('Chemistry', 'Chemistry Building', 360000),
('Economics', 'Economics Building', 400000),
('Law', 'Law Building', 600000),
('Psychology', 'Psychology Building', 220000);

INSERT INTO Course (course_ID, title, dept_name, credits, syllabus) VALUES
('CS101', 'Intro to Computer Science', 'Computer Science', 4, 'Introduction to fundamentals of computer science'),
('MATH201', 'Advanced Mathematics', 'Mathematics', 3, 'In-depth study of abstract mathematical theories'),
('PH101', 'General Physics', 'Physics', 3, 'Concepts of motion and energy'),
('HIST301', 'World History', 'History', 3, 'Overview of global historical events'),
('ENG202', 'British Literature', 'English', 2, 'Study of literature from Britain'),
('BIO101', 'Introductory Biology', 'Biology', 3, 'Basics of biological sciences'),
('CHEM100', 'Chemistry Principles', 'Chemistry', 3, 'Fundamental principles of chemistry'),
('ECO200', 'Microeconomics', 'Economics', 3, 'Principles of microeconomic theory'),
('LAW400', 'Corporate Law', 'Law', 4, 'Understanding corporate law and regulations'),
('PSY101', 'Intro to Psychology', 'Psychology', 3, 'Basics of psychological theories');


INSERT INTO Instructor (ID, name, dept_name, salary) VALUES
('I1001', 'Alice Johnson', 'Computer Science', 90000),
('I1002', 'Bob Smith', 'Mathematics', 85000),
('I1003', 'Carol White', 'Physics', 80000),
('I1004', 'Dave Brown', 'History', 78000),
('I1005', 'Eve Davis', 'English', 75000),
('I1006', 'Frank Miller', 'Biology', 87000),
('I1007', 'Grace Wilson', 'Chemistry', 89000),
('I1008', 'Henry Moore', 'Economics', 92000),
('I1009', 'Isabel Taylor', 'Law', 95000),
('I1010', 'Jack Lee', 'Psychology', 77000);

INSERT INTO Student (ID, name, dept_name, tot_credit, date_of_birth) VALUES
('S1001', 'John Doe', 'Computer Science', 45, '2000-01-01'),
('S1002', 'Jane Smith', 'Mathematics', 30, '2000-02-02'),
('S1003', 'Mike Brown', 'Physics', 60, '2001-03-03'),
('S1004', 'Lucy Green', 'History', 50, '2001-04-04'),
('S1005', 'Ethan Hunt', 'English', 40, '2002-05-05'),
('S1006', 'Emma Wilson', 'Biology', 55, '2002-06-06'),
('S1007', 'Olivia Jones', 'Chemistry', 65, '2003-07-07'),
('S1008', 'Noah Lee', 'Economics', 75, '2003-08-08'),
('S1009', 'Sophia Martinez', 'Law', 85, '2004-09-09'),
('S1010', 'Liam Taylor', 'Psychology', 95, '2004-10-10');

INSERT INTO Section (course_ID, sec_id, semester, year, building, room_no, time_slot_id) VALUES
('CS101', '01', 'Fall', 2023, 'CompSci Building', 101, 'A'),
('MATH201', '01', 'Spring', 2024, 'Math Building', 202, 'B'),
('PH101', '02', 'Fall', 2023, 'Physics Building', 301, 'C'),
('HIST301', '02', 'Spring', 2024, 'History Building', 401, 'D'),
('ENG202', '01', 'Fall', 2023, 'English Building', 102, 'E'),
('BIO101', '01', 'Spring', 2024, 'Biology Building', 202, 'F'),
('CHEM100', '02', 'Fall', 2023, 'Chemistry Building', 301, 'G'),
('ECO200', '02', 'Spring', 2024, 'Economics Building', 402, 'H'),
('LAW400', '01', 'Fall', 2023, 'Law Building', 101, 'I'),
('PSY101', '01', 'Spring', 2024, 'Psychology Building', 202, 'J');


INSERT INTO Time_Slot (time_slot_ID, day, start_hr, end_hr, start_min, end_min) VALUES
('A', 'Monday', '09:00', '10:30', '00:00', '30:00'),
('B', 'Tuesday', '10:00', '11:30', '00:00', '30:00'),
('C', 'Wednesday', '11:00', '12:30', '00:00', '30:00'),
('D', 'Thursday', '12:00', '13:30', '00:00', '30:00'),
('E', 'Friday', '13:00', '14:30', '00:00', '30:00'),
('F', 'Monday', '14:00', '15:30', '00:00', '30:00'),
('G', 'Tuesday', '15:00', '16:30', '00:00', '30:00'),
('H', 'Wednesday', '16:00', '17:30', '00:00', '30:00'),
('I', 'Thursday', '17:00', '18:30', '00:00', '30:00'),
('J', 'Friday', '18:00', '19:30', '00:00', '30:00');

INSERT INTO Classroom (room_no, building, capacity) VALUES
('101', 'CompSci Building', 30),
('202', 'Math Building', 20),
('301', 'Physics Building', 25),
('401', 'History Building', 15),
('102', 'English Building', 40),
('202', 'Biology Building', 35),
('301', 'Chemistry Building', 50),
('402', 'Economics Building', 45),
('101', 'Law Building', 60),
('202', 'Psychology Building', 25);

INSERT INTO Advisor (s_ID, I_ID) VALUES
('S1001', 'I1001'),
('S1002', 'I1002'),
('S1003', 'I1003'),
('S1004', 'I1004'),
('S1005', 'I1005'),
('S1006', 'I1006'),
('S1007', 'I1007'),
('S1008', 'I1008'),
('S1009', 'I1009'),
('S1010', 'I1010');

INSERT INTO Takes (ID, course_ID, sec_ID, semester, year, grade) VALUES
('S1001', 'CS101', '01', 'Fall', 2023, 'A'),
('S1002', 'MATH201', '01', 'Spring', 2024, 'B'),
('S1003', 'PH101', '02', 'Fall', 2023, 'C'),
('S1004', 'HIST301', '02', 'Spring', 2024, 'D'),
('S1005', 'ENG202', '01', 'Fall', 2023, 'B'),
('S1006', 'BIO101', '01', 'Spring', 2024, 'A'),
('S1007', 'CHEM100', '02', 'Fall', 2023, 'B'),
('S1008', 'ECO200', '02', 'Spring', 2024, 'A'),
('S1009', 'LAW400', '01', 'Fall', 2023, 'C'),
('S1010', 'PSY101', '01', 'Spring', 2024, 'A');


INSERT INTO Teaches (ID, course_ID, sec_ID, semester, year) VALUES
('I1001', 'CS101', '01', 'Fall', 2023),
('I1002', 'MATH201', '01', 'Spring', 2024),
('I1003', 'PH101', '02', 'Fall', 2023),
('I1004', 'HIST301', '02', 'Spring', 2024),
('I1005', 'ENG202', '01', 'Fall', 2023),
('I1006', 'BIO101', '01', 'Spring', 2024),
('I1007', 'CHEM100', '02', 'Fall', 2023),
('I1008', 'ECO200', '02', 'Spring', 2024),
('I1009', 'LAW400', '01', 'Fall', 2023),
('I1010', 'PSY101', '01', 'Spring', 2024);


INSERT INTO Prerequisite (course_ID, prereq_ID) VALUES
('CS301', 'CS101'),
('MATH201', 'MATH101'),
('PH301', 'PH101'),
('HIST400', 'HIST200'),
('ENG300', 'ENG100'),
('BIO200', 'BIO101'),
('CHEM300', 'CHEM100'),
('ECO300', 'ECO100'),
('LAW500', 'LAW300'),
('PSY300', 'PSY101');

INSERT INTO Grading_Components (course_ID, max_points, weights) VALUES
('CS101', 100, 0.20),
('MATH201', 100, 0.25),
('PH101', 100, 0.15),
('HIST301', 100, 0.10),
('ENG202', 100, 0.30),
('BIO101', 100, 0.25),
('CHEM100', 100, 0.20),
('ECO200', 100, 0.15),
('LAW400', 100, 0.30),
('PSY101', 100, 0.20);

-- QUERY --


-- Query 1: Detailed Course Enrollment Information
-- This query provides detailed information about students enrolled in a specific course, including the course ID, section ID, semester, year, student ID, and their grade. It joins the `Takes` table with the `Student` and `Course` tables to enrich the output with more descriptive data.


SELECT 
    t.course_ID, 
    t.sec_ID, 
    t.semester, 
    t.year, 
    t.ID AS Student_ID, 
    s.name AS Student_Name,
    c.title AS Course_Title,
    t.grade
FROM Takes t
JOIN Student s ON t.ID = s.ID
JOIN Course c ON t.course_ID = c.course_ID
WHERE t.course_ID = 'CS101'; 



-- Query 2: Course Prerequisites
-- This query lists all courses along with their prerequisites. It is particularly useful for academic planning and for systems that need to check if a student has met the prerequisites for enrollment.


SELECT 
    c.course_ID AS Course_ID,
    c.title AS Course_Title,
    p.prereq_ID AS Prerequisite_ID,
    pc.title AS Prerequisite_Title
FROM Course c
JOIN Prerequisite p ON c.course_ID = p.course_ID
JOIN Course pc ON p.prereq_ID = pc.course_ID;


-- Query 3: Faculty Teaching Load
-- This query calculates the number of sections each instructor is teaching for a given semester and year. It helps in understanding the workload distribution among faculty members.


SELECT 
    t.ID AS Instructor_ID,
    i.name AS Instructor_Name,
    COUNT(*) AS Number_of_Sections_Taught,
    t.semester,
    t.year
FROM Teaches t
JOIN Instructor i ON t.ID = i.ID
WHERE t.semester = 'Fall' AND t.year = 2023
GROUP BY t.ID, i.name, t.semester, t.year;


-- This query assumes there is an Instructor table with a name column. It provides details on how many sections each instructor is teaching during the Fall 2023 semester.