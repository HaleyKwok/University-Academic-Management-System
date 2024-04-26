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