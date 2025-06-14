CREATE TABLE user_profiles (
    id SERIAL PRIMARY KEY,
    chat_id BIGINT NOT NULL UNIQUE,
    name TEXT,
    gender TEXT,
    native_lang TEXT NOT NULL,
    target_lang TEXT NOT NULL,
    interests TEXT[]
);

CREATE TABLE user_progress (
    id SERIAL PRIMARY KEY,
    chat_id BIGINT NOT NULL,
    target_lang TEXT NOT NULL,
    topic_id INTEGER NOT NULL,
    progress INTEGER DEFAULT 0
);

CREATE TABLE topics (
    id SERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    description TEXT,
    use_case TEXT,
    difficulty TEXT CHECK (difficulty IN ('easy', 'medium', 'hard')),
    level INTEGER
);

CREATE TABLE learning_plans (
    id SERIAL PRIMARY KEY,
    lang TEXT NOT NULL,
    topic_id INTEGER NOT NULL REFERENCES topics(id),
    next_topic_id INTEGER REFERENCES topics(id)
);

CREATE TABLE exercises (
    id SERIAL PRIMARY KEY,
    chat_id BIGINT NOT NULL,
    topic_id INTEGER NOT NULL REFERENCES topics(id),
    title TEXT,
    type TEXT CHECK (type IN ('listen_and_repeat', 'choose', 'tell', 'chat', 'fill', 'correct', 'translate_to', 'translate_from')),
    exercise_text TEXT,
    correct_answer TEXT,
    difficulty TEXT,
    accuracy REAL,
    time TIMESTAMP,
    completed BOOLEAN DEFAULT FALSE
); 