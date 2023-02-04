# Basic WhatsApp Database

This is a sample implementation of a WhatsApp database. The database consists of three tables: users, chats, and messages. The relationships between these tables are described in the Entity Relationship Diagram (ERD) below.

## Table Descriptions

Users

The users table stores information about the users of the WhatsApp application. It has the following columns:

    id: a unique identifier for each user
    name: the name of the user

Chats

The chats table stores information about the chats between users. It has the following columns:

    id: a unique identifier for each chat
    user1_id: the id of the first user in the chat
    user2_id: the id of the second user in the chat

Messages

The messages table stores information about the messages sent in chats. It has the following columns:

    id: a unique identifier for each message
    chat_id: the id of the chat that the message was sent in
    sender_id: the id of the user who sent the message
    message: the text of the message
    timestamp: the time the message was sent

## Entity Relationship Diagram (ERD)

ERD diagram
<a href="https://ibb.co/vXDYdds"><img src="https://i.ibb.co/MB96118/diagram.png" alt="diagram" border="0"></a>
View

<a href="https://ibb.co/vLd7PDm"><img src="https://i.ibb.co/44S6TJM/view.png" alt="view" border="0"></a>

A view has been created to show the sender name, receiver name, and messages sent between them, along with time stamps. The SQL code for the view is as follows:

```
SELECT 
    sender.name AS sender_name, 
    receiver.name AS receiver_name, 
    messages.message, 
    messages.timestamp
FROM 
    messages
    JOIN users sender ON messages.sender_id = sender.id
    JOIN chats ON messages.chat_id = chats.id
    JOIN users receiver ON 
    (chats.user1_id = receiver.id AND chats.user2_id = sender.id) 
    OR (chats.user2_id = receiver.id AND chats.user1_id = sender.id) ORDER BY messages.timestamp DESC;


```
This SELECT statement retrieves information from the messages, users, and chats tables. 
It joins the users table twice to retrieve the sender and receiver names and uses an OR clause in the final join to account for the fact that either user1 or user2 in the chats table could be the receiver. 

The results are sorted by timestamp in descending order so that the most recent messages are displayed first.



