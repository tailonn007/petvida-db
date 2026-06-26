USE petvida;

DELIMITER $$

DROP PROCEDURE IF EXISTS sp_agendar_consulta $$
CREATE PROCEDURE sp_agendar_consulta(
    IN p_animal_id INT,
    IN p_vet_id INT,
    IN p_data_hora DATETIME,
    IN p_valor DECIMAL(10,2)
)
BEGIN
    IF NOT EXISTS (SELECT 1 FROM animais WHERE id = p_animal_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Animal nao encontrado';
    END IF;

    IF NOT EXISTS (SELECT 1 FROM veterinarios WHERE id = p_vet_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Veterinario nao encontrado';
    END IF;

    IF EXISTS (
        SELECT 1 FROM consultas
        WHERE veterinario_id = p_vet_id
        AND data_hora = p_data_hora
        AND status <> 'cancelada'
    ) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Horario indisponivel';
    END IF;

    START TRANSACTION;

    INSERT INTO consultas (animal_id, veterinario_id, data_hora, valor, status)
    VALUES (p_animal_id, p_vet_id, p_data_hora, p_valor, 'agendada');

    INSERT INTO pagamentos (consulta_id, valor, status)
    VALUES (LAST_INSERT_ID(), p_valor, 'pendente');

    COMMIT;
END $$


DROP PROCEDURE IF EXISTS sp_concluir_consulta $$
CREATE PROCEDURE sp_concluir_consulta(
    IN p_consulta_id INT,
    IN p_diagnostico TEXT
)
BEGIN
    IF NOT EXISTS (SELECT 1 FROM consultas WHERE id = p_consulta_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Consulta nao encontrada';
    END IF;

    UPDATE consultas
    SET status = 'concluida',
        diagnostico = p_diagnostico
    WHERE id = p_consulta_id;
END $$


DROP PROCEDURE IF EXISTS sp_registrar_pagamento $$
CREATE PROCEDURE sp_registrar_pagamento(
    IN p_consulta_id INT,
    IN p_forma VARCHAR(30)
)
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pagamentos WHERE consulta_id = p_consulta_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Pagamento nao encontrado';
    END IF;

    IF EXISTS (
        SELECT 1 FROM pagamentos
        WHERE consulta_id = p_consulta_id
        AND status = 'pago'
    ) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Pagamento ja esta pago';
    END IF;

    UPDATE pagamentos
    SET status = 'pago',
        forma_pagamento = p_forma
    WHERE consulta_id = p_consulta_id;
END $$


DROP PROCEDURE IF EXISTS sp_cancelar_consulta $$
CREATE PROCEDURE sp_cancelar_consulta(
    IN p_consulta_id INT
)
BEGIN
    IF NOT EXISTS (SELECT 1 FROM consultas WHERE id = p_consulta_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Consulta nao encontrada';
    END IF;

    START TRANSACTION;

    UPDATE consultas
    SET status = 'cancelada'
    WHERE id = p_consulta_id;

    UPDATE pagamentos
    SET status = 'cancelado'
    WHERE consulta_id = p_consulta_id;

    COMMIT;
END $$


DELIMITER $$

DROP PROCEDURE IF EXISTS sp_cadastrar_animal $$

CREATE PROCEDURE sp_cadastrar_animal(
    IN p_nome VARCHAR(100),
    IN p_especie VARCHAR(50),
    IN p_raca VARCHAR(80),
    IN p_nascimento DATE,
    IN p_tutor_id INT
)
BEGIN
    IF NOT EXISTS (SELECT 1 FROM tutores WHERE id = p_tutor_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Tutor nao encontrado';
    END IF;

    INSERT INTO animais (nome, especie, raca, data_nascimento, tutor_id)
    VALUES (p_nome, p_especie, p_raca, p_nascimento, p_tutor_id);

    SELECT LAST_INSERT_ID() AS animal_criado_id;
END $$

DELIMITER ;