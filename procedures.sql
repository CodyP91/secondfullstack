CREATE PROCEDURE create_client (IN username_input VARCHAR(255), IN email_input VARCHAR(255), IN password_input VARCHAR(255), IN bio_input TEXT, IN image_url_input VARCHAR(1000))
BEGIN
    INSERT INTO client (username, email, password, bio, image_url) 
    VALUES (username_input, email_input, password_input, bio_input, image_url_input);
    
    SELECT LAST_INSERT_ID() AS 'client_id';
END;

CREATE PROCEDURE create_token (IN username_input VARCHAR(255), IN password_input VARCHAR(255), IN token_input VARCHAR(255))
BEGIN
    INSERT INTO login (client_id, token)
    SELECT id, token_input 
    FROM client 
    WHERE username = username_input AND password = password_input;
END;

CREATE PROCEDURE get_client_by_token (IN token_input VARCHAR(255))
BEGIN
    SELECT c.id, c.username, c.email, c.image_url, c.bio 
    FROM client c 
    JOIN login l ON c.id = l.client_id 
    WHERE l.token = token_input;
END;

CREATE PROCEDURE delete_token (IN token_input VARCHAR(255))
BEGIN
    DELETE FROM login WHERE token = token_input;
END;
