-- Tabela de auditoria
CREATE TABLE IF NOT EXISTS log_auditoria (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tabela_afetada VARCHAR(50),
    acao VARCHAR(20),
    registro_id INT,
    detalhes TEXT,
    data_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER $$

-- A) AFTER INSERT em consultas
CREATE TRIGGER trg_after_insert_consulta
AFTER INSERT ON consultas
FOR EACH ROW
BEGIN
    INSERT INTO log_auditoria (
        tabela_afetada,
        acao,
        registro_id,
        detalhes
    )
    VALUES (
        'consultas',
        'INSERT',
        NEW.id,
        CONCAT('Consulta criada com status: ', NEW.status)
    );
END$$

-- B) AFTER UPDATE status da consulta
CREATE TRIGGER trg_after_update_consulta_status
AFTER UPDATE ON consultas
FOR EACH ROW
BEGIN
    IF OLD.status <> NEW.status THEN
        INSERT INTO log_auditoria (
            tabela_afetada,
            acao,
            registro_id,
            detalhes
        )
        VALUES (
            'consultas',
            'UPDATE',
            NEW.id,
            CONCAT('Status alterado de ', OLD.status, ' para ', NEW.status)
        );
    END IF;
END$$

-- C) BEFORE DELETE consulta paga
CREATE TRIGGER trg_before_delete_consulta
BEFORE DELETE ON consultas
FOR EACH ROW
BEGIN
    IF OLD.pagamento = 'pago' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Nao e permitido excluir consulta paga';
    END IF;
END$$

-- D) AFTER INSERT em animais
CREATE TRIGGER trg_after_insert_animal
AFTER INSERT ON animais
FOR EACH ROW
BEGIN
    INSERT INTO log_auditoria (
        tabela_afetada,
        acao,
        registro_id,
        detalhes
)
    VALUES (
        'animais',
        'INSERT',
        NEW.id,
        CONCAT('Animal cadastrado: ', NEW.nome)
    );
END$$

-- E) BEFORE UPDATE pagamento
CREATE TRIGGER trg_before_update_pagamento
BEFORE UPDATE ON pagamentos
FOR EACH ROW
BEGIN
    IF OLD.status <> 'pago'
       AND NEW.status = 'pago' THEN
        SET NEW.data_pagamento = CURDATE();
    END IF;
END$$

DELIMITER ;
