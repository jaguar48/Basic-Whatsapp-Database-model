CREATE DATABASE Whatsapdb

CREATE TABLE users (
    id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    phone_number VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE chats (
    id INT PRIMARY KEY,
    user1_id INT NOT NULL,
    user2_id INT NOT NULL,
    FOREIGN KEY (user1_id) REFERENCES users(id),
    FOREIGN KEY (user2_id) REFERENCES users(id),
    UNIQUE (user1_id, user2_id)
);

CREATE TABLE messages (
    id INT PRIMARY KEY,
    chat_id INT NOT NULL,
    sender_id INT NOT NULL,
    message TEXT NOT NULL,
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (chat_id) REFERENCES chats(id),
    FOREIGN KEY (sender_id) REFERENCES users(id)
);


INSERT INTO users (id, name, phone_number)
VALUES 
    (1, 'User 1', '+1 123 456 7890'),
    (2, 'User 2', '+1 987 654 3210'),
    (3, 'User 3', '+1 111 222 3333');

INSERT INTO chats (id, user1_id, user2_id)
VALUES
    (1, 1, 2),
    (2, 2, 3);

INSERT INTO messages (id, chat_id, sender_id, message)
VALUES
    (1, 1, 1, 'Hello User 2'),
    (2, 1, 2, 'Hi User 1'),
    (3, 2, 2, 'Hello User 3'),
    (4, 2, 3, 'Hi User 2');



SELECT 
    sender.name AS sender_name, 
    receiver.name AS receiver_name, 
    messages.message, 
    messages.timestamp,
	sender.phone_number As phone
FROM 
    messages
    JOIN users sender ON messages.sender_id = sender.id
    JOIN chats ON messages.chat_id = chats.id
    JOIN users receiver ON 
        (chats.user1_id = receiver.id AND chats.user2_id = sender.id) 
        OR (chats.user2_id = receiver.id AND chats.user1_id = sender.id)
ORDER BY messages.timestamp DESC;
