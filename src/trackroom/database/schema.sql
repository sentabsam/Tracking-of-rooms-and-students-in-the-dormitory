PRAGMA foreign_keys = ON;

--Удаление старых таблиц(зависимые)
DROP TABLE IF EXISTS Request;
DROP TABLE IF EXISTS User_room;
DROP TABLE IF EXISTS User;

--Удаление старых таблиц(независимые)
DROP TABLE IF EXISTS Room;
DROP TABLE IF EXISTS User_role;

--Роли пользователей
CREATE TABLE User_role(
    user_role_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL UNIQUE
);

--Комнаты
CREATE TABLE Room(
    room_id INTEGER PRIMARY KEY AUTOINCREMENT,
    number INTEGER NOT NULL UNIQUE,
    capacity INTEGER NOT NULL CHECK(capacity > 0),
    gender TEXT NOT NULL,
    floor INTEGER NOT NULL,
    status BOOLEAN NOT NULL DEFAULT TRUE
);

--Пользователь
CREATE TABLE User(
    user_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    surname TEXT NOT NULL,
    patronymic TEXT,
    gender TEXT NOT NULL,
    user_role INTEGER NOT NULL,
    password_hash TEXT NOT NULL,
    inhabited BOOLEAN NOT NULL,

    FOREIGN KEY (user_role) REFERENCES User_role(user_role_id)
);

--Заявки
CREATE TABLE Request(
    request_id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    description TEXT,

    FOREIGN KEY (user_id) REFERENCES User(user_id)
);

--Комната пользователя
CREATE TABLE User_room(
    user_room_id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    room_id INTEGER NOT NULL,

    FOREIGN KEY (user_id) REFERENCES User(user_id),
    FOREIGN KEY (room_id) REFERENCES Room(room_id)
);

INSERT INTO User_role(name)
VALUES ('client'), ('admin');

INSERT INTO User(name, surname, patronymic, gender, user_role, password_hash, inhabited)
VALUES ('Alexander', 'Markov', 'Leonidovich', 'male', 2, '123456', 1),
('Elon', 'Musk', Null, 'male', 1, 'abc123', 0),
('Vladimir', 'Putin', 'Vladimirovich', 'male', 1, '333333', 1);

INSERT INTO Request(user_id, description)
VALUES (2, 'Zaselite v vashu klassnuyu obshagu please'), (3, 'Выселяюсь');

INSERT INTO Room(number, capacity, gender, floor, status)
VALUES (1, 3, 'male', 2, 1), (2, 2, 'female', 2, 1);

INSERT INTO User_room(user_id, room_id)
VALUES (1, 1), (3, 1);

