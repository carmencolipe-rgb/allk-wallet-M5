CREATE TABLE usuario (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    correo_electronico VARCHAR(100) NOT NULL UNIQUE,
    contraseña VARCHAR(255) NOT NULL,
    saldo DECIMAL(10,2) NOT NULL DEFAULT 0
);SHOW TABLES;
CREATE TABLE moneda (
    currency_id INT AUTO_INCREMENT PRIMARY KEY,
    currency_name VARCHAR(50) NOT NULL,
    currency_symbol VARCHAR(10) NOT NULL
);
SHOW TABLES;
CREATE TABLE transaccion (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    sender_user_id INT NOT NULL,
    receiver_user_id INT NOT NULL,
    currency_id INT NOT NULL,
    importe DECIMAL(10,2) NOT NULL,
    transaction_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (sender_user_id) REFERENCES usuario(user_id),
    FOREIGN KEY (receiver_user_id) REFERENCES usuario(user_id),
    FOREIGN KEY (currency_id) REFERENCES moneda(currency_id)
);
SHOW TABLES;
INSERT INTO usuario (nombre, correo_electronico, contraseña, saldo)
VALUES 
('Carmen', 'carmen@email.com', '1234', 5000),
('Juan', 'juan@email.com', 'abcd', 3000);
SELECT * FROM usuario;
INSERT INTO moneda (currency_name, currency_symbol)
VALUES 
('Peso Chileno', '$'),
('Dolar', 'USD');
SELECT * FROM moneda;
INSERT INTO transaccion (sender_user_id, receiver_user_id, currency_id, importe)
VALUES 
(1, 2, 1, 1000);
SELECT * FROM transaccion;
SELECT u.nombre, m.currency_name, t.importe, t.transaction_date
FROM transaccion t
INNER JOIN usuario u ON t.sender_user_id = u.user_id
INNER JOIN moneda m ON t.currency_id = m.currency_id;
SELECT *
FROM transaccion
WHERE sender_user_id = 1;
UPDATE usuario
SET correo_electronico = 'nuevo@email.com'
WHERE user_id = 1;
SELECT * FROM usuario;
DELETE FROM transaccion
WHERE transaction_id = 1;
SELECT * FROM transaccion;
START TRANSACTION;

UPDATE usuario SET saldo = saldo - 500 WHERE user_id = 1;
UPDATE usuario SET saldo = saldo + 500 WHERE user_id = 2;

COMMIT;
SELECT * FROM usuario;