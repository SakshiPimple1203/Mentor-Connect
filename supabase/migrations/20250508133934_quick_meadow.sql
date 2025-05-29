-- Database schema for Mentor Connect

-- Users table
CREATE TABLE IF NOT EXISTS users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    email TEXT UNIQUE NOT NULL,
    password TEXT NOT NULL,
    role TEXT NOT NULL,  -- 'admin', 'mentor', or 'mentee'
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Mentor profiles
CREATE TABLE IF NOT EXISTS mentor_profiles (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    department TEXT,
    bio TEXT,
    expertise TEXT,
    mobile_no TEXT,
    profile_picture TEXT,
    FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
);

-- Mentee profiles
CREATE TABLE IF NOT EXISTS mentee_profiles (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    department TEXT,
    semester TEXT,
    roll_no TEXT,
    mobile_no TEXT,
    address TEXT,
    profile_picture TEXT,
    FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
);

-- Connections between mentors and mentees
CREATE TABLE IF NOT EXISTS connections (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    mentor_id INTEGER NOT NULL,
    mentee_id INTEGER NOT NULL,
    status TEXT NOT NULL,  -- 'PENDING', 'ACCEPTED', 'REJECTED', 'TERMINATED'
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP,
    FOREIGN KEY (mentor_id) REFERENCES users (id) ON DELETE CASCADE,
    FOREIGN KEY (mentee_id) REFERENCES users (id) ON DELETE CASCADE
);

-- Academic records for mentees
CREATE TABLE IF NOT EXISTS academic_records (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    mentee_id INTEGER NOT NULL,
    semester INTEGER NOT NULL,
    course_code TEXT NOT NULL,
    course_title TEXT NOT NULL,
    credits INTEGER,
    grade TEXT,
    FOREIGN KEY (mentee_id) REFERENCES users (id) ON DELETE CASCADE
);

-- Posts by users
CREATE TABLE IF NOT EXISTS posts (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    title TEXT NOT NULL,
    content TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
);

-- Comments on posts
CREATE TABLE IF NOT EXISTS comments (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    post_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    content TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (post_id) REFERENCES posts (id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
);

-- Meetings between mentors and mentees
CREATE TABLE IF NOT EXISTS meetings (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    mentor_id INTEGER NOT NULL,
    mentee_id INTEGER NOT NULL,
    title TEXT NOT NULL,
    meeting_time TIMESTAMP NOT NULL,
    duration INTEGER,  -- in minutes
    agenda TEXT,
    status TEXT,  -- 'SCHEDULED', 'COMPLETED', 'CANCELLED'
    notes TEXT,
    FOREIGN KEY (mentor_id) REFERENCES users (id) ON DELETE CASCADE,
    FOREIGN KEY (mentee_id) REFERENCES users (id) ON DELETE CASCADE
);

-- Activities log
CREATE TABLE IF NOT EXISTS activities (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    related_user_id INTEGER,
    activity_type TEXT NOT NULL,
    description TEXT,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
    FOREIGN KEY (related_user_id) REFERENCES users (id) ON DELETE SET NULL
);