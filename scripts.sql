CREATE TYPE coworking.workspace_status AS ENUM ('Available', 'Unavailable');

-- Crear la tabla 'rooms' en el esquema 'coworking'
CREATE TABLE coworking.rooms (
    room_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    rows INTEGER NOT NULL,
    columns INTEGER NOT NULL
);


-- Crear la tabla 'workspaces' en el esquema 'coworking'
CREATE TABLE coworking.workspaces (
    workspace_id SERIAL PRIMARY KEY,
    room_id INTEGER NOT NULL,
    row INTEGER NOT NULL,
    colum INTEGER NOT NULL,
    status coworking.workspace_status DEFAULT 'Available',
    UNIQUE (room_id, row, colum),
    FOREIGN KEY (room_id) REFERENCES coworking.rooms (room_id)
);


-- Crear la tabla 'sessions' en el esquema 'coworking'
CREATE TABLE coworking.sessions (
    session_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    start_time TIMESTAMP NOT NULL,
    end_time TIMESTAMP NOT NULL
);


-- Crear la tabla 'users' en el esquema 'coworking'
CREATE TABLE coworking.users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(40) UNIQUE NOT NULL,
    email VARCHAR(60) UNIQUE NOT NULL
);


-- Crear la tabla 'reservations' en el esquema 'coworking'
CREATE TABLE coworking.reservations (
    reservation_id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    workspace_id INTEGER NOT NULL,
    session_id INTEGER NOT NULL,
    UNIQUE (workspace_id, session_id),
    FOREIGN KEY (user_id) REFERENCES coworking.users (user_id),
    FOREIGN KEY (workspace_id) REFERENCES coworking.workspaces (workspace_id),
    FOREIGN KEY (session_id) REFERENCES coworking.sessions (session_id)
);
