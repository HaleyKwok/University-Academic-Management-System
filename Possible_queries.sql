-- Find the most enrolled courses:
-- Plain English: List the top 5 courses by number of students enrolled.

SELECT CourseID, COUNT(StudentID) AS EnrolledStudents
FROM CourseEnrollments
GROUP BY CourseID
ORDER BY EnrolledStudents DESC
LIMIT 5;

-- Identify professors without a full course load:
-- Plain English: List all professors who are teaching fewer than 3 courses this semester.

SELECT Professors.ProfessorID, Professors.Name, COUNT(CourseID) AS CoursesTaught
FROM Professors
LEFT JOIN Courses ON Professors.ProfessorID = Courses.ProfessorID
GROUP BY Professors.ProfessorID
HAVING CoursesTaught < 3;

-- Classroom utilization report:
-- Plain English: Show the percentage utilization of each classroom.

SELECT Classrooms.RoomID, (COUNT(ClassID) / Classrooms.Capacity) * 100 AS UtilizationPercentage
FROM Classrooms
LEFT JOIN Classes ON Classrooms.RoomID = Classes.RoomID
GROUP BY Classrooms.RoomID;