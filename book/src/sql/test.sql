CREATE SCHEMA AUTHORIZATION user1;

INSERT INTO fruits (id, name, quantity, price) VALUES (1, 'apple', 100, 1.25);
INSERT INTO fruits (id, name, quantity, price) VALUES (2, 'banana', 200, 0.75);

UPDATE fruits 
SET quantity = quantity + 50 
WHERE name = 'apple';

DELETE FROM fruits 
WHERE quantity < 100;

COMMIT WORK;

