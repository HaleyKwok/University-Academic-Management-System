
-- Query 2: Detailed Course Enrollment Information
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



-- Query 3: Course Prerequisites
-- This query lists all courses along with their prerequisites. It is particularly useful for academic planning and for systems that need to check if a student has met the prerequisites for enrollment.


SELECT 
    c.course_ID AS Course_ID,
    c.title AS Course_Title,
    p.prereq_ID AS Prerequisite_ID,
    pc.title AS Prerequisite_Title
FROM Course c
JOIN Prerequisite p ON c.course_ID = p.course_ID
JOIN Course pc ON p.prereq_ID = pc.course_ID;


-- Query 4: Faculty Teaching Load
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