CREATE DATABASE college;
USE college;

-- 1. Departments
CREATE TABLE departments (
  dept_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL UNIQUE,
  chair_instructor_id INT,  -- optional: who is the chair of the dept
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 2. Instructors
CREATE TABLE instructors (
  instructor_id INT AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  email VARCHAR(100) NOT NULL UNIQUE,
  hire_date DATE NOT NULL,
  dept_id INT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

-- 3. Students
CREATE TABLE students (
  student_id INT AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  email VARCHAR(100) NOT NULL UNIQUE,
  admission_date DATE NOT NULL,
  dept_id INT NOT NULL,   -- student belongs to a department (major)
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

-- 4. StudentProfile — One-to-One with Students
CREATE TABLE student_profiles (
  student_id INT PRIMARY KEY,  -- primary key = foreign key
  date_of_birth DATE NULL,
  address VARCHAR(255),
  phone VARCHAR(20),
  emergency_contact VARCHAR(100),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (student_id) REFERENCES students(student_id)
);

-- 5. Courses
CREATE TABLE courses (
  course_id INT AUTO_INCREMENT PRIMARY KEY,
  dept_id INT NOT NULL,
  course_code VARCHAR(20) NOT NULL,  -- e.g. "CSS101"
  title VARCHAR(200) NOT NULL,
  credits INT NOT NULL CHECK (credits > 0),
  UNIQUE(dept_id, course_code),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

-- 6. CourseOffering — a specific term offering of a course
CREATE TABLE course_offerings (
  offering_id INT AUTO_INCREMENT PRIMARY KEY,
  course_id INT NOT NULL,
  term VARCHAR(20) NOT NULL,  -- e.g. "1st Semester"
  year INT NOT NULL,
  capacity INT NOT NULL CHECK (capacity >= 0),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UNIQUE(course_id, term, year),
  FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

-- 7. Enrollment — Many-to-Many between Students & CourseOffering
CREATE TABLE enrollments (
  enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
  student_id INT NOT NULL,
  offering_id INT NOT NULL,
  enrollment_date DATE NOT NULL,
  grade CHAR(2),   -- e.g. 'A', 'B+', etc.
  UNIQUE(student_id, offering_id),  -- prevents duplicate enroll
  FOREIGN KEY (student_id) REFERENCES students(student_id),
  FOREIGN KEY (offering_id) REFERENCES course_offerings(offering_id)
);

-- 9. Prerequisites — Many-to-Many between Courses and their prereqs
CREATE TABLE course_prerequisites (
  course_id INT NOT NULL,
  prereq_course_id INT NOT NULL,
  PRIMARY KEY (course_id, prereq_course_id),
  FOREIGN KEY (course_id) REFERENCES courses(course_id),
  FOREIGN KEY (prereq_course_id) REFERENCES courses(course_id),
  CHECK (course_id <> prereq_course_id)  -- no course can be its own prerequisite
);
