-- Active: 1729523059018@@127.0.0.1@5432@university_db

-- Creating Student table
CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    student_name VARCHAR(100),
    age INTEGER,
    email VARCHAR(100),
    frontend_mark INTEGER,
    backend_mark INTEGER,
    status VARCHAR(30)
);

-- Creating Course table
CREATE TABLE courses(
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(200),
    credits INTEGER
);

-- Creating Enrollment table
CREATE TABLE enrollment(
    enrollment_id SERIAL PRIMARY KEY,
    student_id INTEGER REFERENCES students(student_id),
    course_id INTEGER REFERENCES courses(course_id)
);


-- Inserting data into Students table
-- Query 1:
INSERT INTO students (student_name, age, email, frontend_mark, backend_mark, status) 
VALUES
('Sameer', 21, 'sameer@example.com', 48, 60, NULL),
('Zoya', 23, 'zoya@example.com', 52, 58, NULL),
('Nabil', 22, 'nabil@example.com', 37, 46, NULL),
('Rafi', 24, 'rafi@example.com', 41, 40, NULL),
('Sophia', 23, 'sophia@example.com', 50, 52, NULL),
('Hasan', 23, 'hasan@gmail.com', 43, 39, NULL);


-- Query 2:
-- Retrieving the names of all students who are enrolled in the course titled 'Next.js'.
SELECT s.student_name
FROM students s
JOIN enrollment e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id
WHERE c.course_name = 'Next.js';



-- Query 3:
-- Updating the status of the student with the highest total (frontend_mark + backend_mark) to 'Awarded'.
UPDATE students
SET status = 'Awarded'
WHERE student_id = ( SELECT student_id FROM students ORDER BY (frontend_mark + backend_mark) DESC LIMIT 1);

 
-- Query 4:
-- Deleting all courses that have no students enrolled.
DELETE FROM courses
WHERE course_id NOT IN (SELECT course_id FROM enrollment);



-- Query 5:
-- Retrieving the names of students using a limit of 2, starting from the 3rd student.
SELECT student_name
FROM students
ORDER BY student_id
LIMIT 2 OFFSET 2;


-- Query 6:
-- Retrieving the course names and the number of students enrolled in each course.
SELECT c.course_name, COUNT(e.student_id) AS student_count
FROM courses c
LEFT JOIN enrollment e ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name;


-- Query 7:
-- Calculating and display the average age of all students.
SELECT AVG(age) AS average_age FROM students;


-- Query 8:
-- Retrieving the names of students whose email addresses contain 'example.com'.
SELECT student_name
FROM students
WHERE email LIKE '%example.com%';




-- Select all data from Students table
SELECT * FROM students


-- Inserting data into Courses table
INSERT INTO courses (course_name, credits) 
VALUES
('Next.js', 3),
('React.js', 4),
('Databases', 3),
('Prisma', 3);

-- Select all data from Courses table
SELECT * FROM courses



-- Inserting data into Enrollment table
INSERT INTO enrollment (student_id, course_id) 
VALUES
(1,1),
(1,2),
(2,1),
(3,2);

-- Select all data from Courses table
SELECT * FROM enrollment
