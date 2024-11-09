CREATE TABLE IF NOT EXISTS users
(
    id         BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name       VARCHAR(64) NOT NULL,
    surname    VARCHAR(64) NOT NULL,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS contacts
(
    id            BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    contact_type  VARCHAR(64)  NOT NULL,
    contact_value VARCHAR(255) NOT NULL,

    UNIQUE (contact_type, contact_value)
);

CREATE TABLE IF NOT EXISTS messages
(
    id      BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    user_id BIGINT        NOT NULL,
    text    VARCHAR(4096) NOT NULL,

    CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES users (id)
);

CREATE TABLE IF NOT EXISTS messages_contacts
(
    id         BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    message_id BIGINT NOT NULL,
    contact_id BIGINT NOT NULL,

    CONSTRAINT fk_message_id FOREIGN KEY (message_id) REFERENCES messages (id),
    CONSTRAINT fk_contact_id FOREIGN KEY (contact_id) REFERENCES contacts (id),
    UNIQUE (message_id, contact_id)
);
CREATE INDEX idx_message_contact ON messages_contacts (message_id, contact_id);