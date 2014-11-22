/* SQLEditor (Postgres)*/

CREATE TABLE activity_type
(
id TEXT NOT NULL UNIQUE,
name TEXT,
description TEXT,
PRIMARY KEY (id)
);

CREATE TABLE login
(
/*Primary Key for the user*/
id SERIAL,
login TEXT UNIQUE,
fullname TEXT,
password TEXT,
tzname TEXT,
PRIMARY KEY (id)
);

CREATE TABLE loginrole
(
id SERIAL NOT NULL,
login_id INTEGER,
role_id INTEGER UNIQUE,
PRIMARY KEY (id)
);

CREATE TABLE role
(
id SERIAL NOT NULL,
name TEXT,
description TEXT,
PRIMARY KEY (id)
);

CREATE TABLE session
(
id SERIAL NOT NULL,
login_id INTEGER,
ab_session_id BIGINT UNIQUE,
tzname TEXT,
PRIMARY KEY (id)
);

CREATE TABLE topic
(
id SERIAL NOT NULL,
name TEXT,
description TEXT,
PRIMARY KEY (id)
);

CREATE TABLE activity
(
id SERIAL NOT NULL,
session_id INTEGER,
topic_name TEXT,
type_id TEXT,
allow BOOLEAN,
PRIMARY KEY (id)
);

CREATE TABLE topicrole
(
id SERIAL NOT NULL,
topic_id INTEGER NOT NULL,
role_id INTEGER NOT NULL,
type_id TEXT NOT NULL,
allow BOOLEAN,
PRIMARY KEY (id)
);

ALTER TABLE loginrole ADD CONSTRAINT loginrole_login_id_role_id UNIQUE (login_id,role_id);

ALTER TABLE loginrole ADD FOREIGN KEY (login_id) REFERENCES login (id);

ALTER TABLE role ADD FOREIGN KEY (id) REFERENCES loginrole (role_id);

ALTER TABLE session ADD CONSTRAINT session_ab_session_id UNIQUE (ab_session_id);

ALTER TABLE session ADD FOREIGN KEY (login_id) REFERENCES login (id);

ALTER TABLE activity ADD FOREIGN KEY (session_id) REFERENCES session (id);

ALTER TABLE activity ADD FOREIGN KEY (type_id) REFERENCES activity_type (id);

ALTER TABLE topicrole ADD CONSTRAINT topicrole_topic_id_role_id_type_id UNIQUE (topic_id,role_id,allow);

ALTER TABLE topicrole ADD FOREIGN KEY (topic_id) REFERENCES topic (id);

ALTER TABLE topicrole ADD FOREIGN KEY (role_id) REFERENCES role (id);

ALTER TABLE topicrole ADD FOREIGN KEY (type_id) REFERENCES activity_type (id);
