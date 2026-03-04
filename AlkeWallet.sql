/* =====================================================
   PROYECTO: ALKE WALLET
   MODULO: FUNDAMENTOS DE BASES DE DATOS RELACIONALES
   ===================================================== */

/* =====================================================
   1. CREACION DE BASE DE DATOS
   ===================================================== */

CREATE DATABASE AlkeWallet;
USE AlkeWallet;

/* =====================================================
   2. CREACION DE TABLAS (DDL)
   ===================================================== */

/* ---------- TABLA USUARIO ---------- */

CREATE TABLE usuario (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    correo_electronico VARCHAR(100) NOT NULL UNIQUE,
    contraseña VARCHAR(255) NOT NULL,
    saldo DECIMAL(10,2) NOT NULL DEFAULT 0
);

/* ---------- TABLA MONEDA ---------- */

CREATE TABLE moneda (
    currency_id INT AUTO_INCREMENT PRIMARY KEY,
    currency_name VARCHAR(50) NOT NULL,
    currency_symbol VARCHAR(10) NOT NULL
);

/* ---------- TABLA TRANSACCION ---------- */

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

/* =====================================================
   3. INSERTAR DATOS DE PRUEBA (DML)
   ===================================================== */

INSERT INTO usuario (nombre, correo_electronico, contraseña, saldo)
VALUES 
('Carmen', 'carmen@email.com', '1234', 5000),
('Juan', 'juan@email.com', 'abcd', 3000);

INSERT INTO moneda (currency_name, currency_symbol)
VALUES 
('Peso Chileno', '$'),
('Dolar', 'USD');

INSERT INTO transaccion (sender_user_id, receiver_user_id, currency_id, importe)
VALUES 
(1, 2, 1, 1000);

/* =====================================================
   4. CONSULTAS SOLICITADAS
   ===================================================== */

/* ---- Obtener nombre de la moneda usada por un usuario ---- */

SELECT u.nombre, m.currency_name
FROM transaccion t
INNER JOIN usuario u ON t.sender_user_id = u.user_id
INNER JOIN moneda m ON t.currency_id = m.currency_id
WHERE u.user_id = 1;

/* ---- Obtener todas las transacciones ---- */

SELECT * FROM transaccion;

/* ---- Obtener transacciones de un usuario especifico ---- */

SELECT *
FROM transaccion
WHERE sender_user_id = 1;

/* =====================================================
   5. MODIFICAR DATOS (UPDATE)
   ===================================================== */

UPDATE usuario
SET correo_electronico = 'nuevo@email.com'
WHERE user_id = 1;

/* =====================================================
   6. ELIMINAR DATOS (DELETE)
   ===================================================== */

DELETE FROM transaccion
WHERE transaction_id = 1;

/* =====================================================
   7. TRANSACCIONALIDAD (ACID)
   ===================================================== */

START TRANSACTION;

UPDATE usuario 
SET saldo = saldo - 500
WHERE user_id = 1;

UPDATE usuario 
SET saldo = saldo + 500
WHERE user_id = 2;

COMMIT;

/* Si ocurre un error usar:
ROLLBACK;
*/