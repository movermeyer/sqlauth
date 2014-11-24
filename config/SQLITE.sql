/* SQLEditor (SQLite)*/

CREATE TABLE activity_type
(
id TEXT NOT NULL PRIMARY KEY  UNIQUE,
name TEXT,
description TEXT
);

CREATE TABLE login
(
/*Primary Key for the user*/
id INTEGER PRIMARY KEY  AUTOINCREMENT,
login TEXT UNIQUE,
fullname TEXT,
password TEXT,
tzname TEXT
);

CREATE TABLE loginrole
(
id INTEGER NOT NULL PRIMARY KEY  AUTOINCREMENT,
login_id INTEGER REFERENCES login (id),
role_id INTEGER UNIQUE
);

CREATE TABLE role
(
id INTEGER NOT NULL PRIMARY KEY  AUTOINCREMENT  REFERENCES loginrole (role_id),
name TEXT,
description TEXT
);

CREATE TABLE session
(
id INTEGER NOT NULL PRIMARY KEY  AUTOINCREMENT,
login_id INTEGER REFERENCES login (id),
ab_session_id BIGINT UNIQUE,
tzname TEXT
);

CREATE TABLE topic
(
id INTEGER NOT NULL PRIMARY KEY  AUTOINCREMENT,
name TEXT,
description TEXT
);

CREATE TABLE activity
(
id INTEGER NOT NULL PRIMARY KEY  AUTOINCREMENT,
session_id INTEGER REFERENCES session (id),
topic_name TEXT,
type_id TEXT REFERENCES activity_type (id),
allow BOOLEAN
);

CREATE TABLE topicrole
(
id INTEGER NOT NULL PRIMARY KEY  AUTOINCREMENT,
topic_id INTEGER NOT NULL REFERENCES topic (id),
role_id INTEGER NOT NULL REFERENCES role (id),
type_id TEXT NOT NULL REFERENCES activity_type (id),
allow BOOLEAN
);

CREATE UNIQUE INDEX loginrole_login_id_role_id ON loginrole (login_id,role_id);

CREATE UNIQUE INDEX session_ab_session_id ON session (ab_session_id);

CREATE UNIQUE INDEX topicrole_topic_id_role_id_type_id ON topicrole (topic_id,role_id,allow);