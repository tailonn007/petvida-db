DELIMITER $$

DROP TRIGGER IF EXISTS trg_after_insert_consulta$$

CREATE TRIGGER trg_after_insert_consulta
AFTER INSERT ON consultas
FOR EACH ROW
BEGIN
    INSERT INTO log_auditoria (tabela_afetada, acao, registro_id, detalhes)
    VALUES (
        'consultas',
        'INSERT',
        NEW.id,
        CONCAT('Consulta criada para o animal ID: ', NEW.animal_id, ' com o Vet ID: ', NEW.veterinario_id)
    );
END$$


DROP TRIGGER IF EXISTS trg_after_update_consulta$$

CREATE TRIGGER trg_after_update_consulta
AFTER UPDATE ON consultas
FOR EACH ROW
BEGIN
    INSERT INTO log_auditoria (tabela_afetada, acao, registro_id, detalhes)
    VALUES (
        'consultas',
        'UPDATE',
        NEW.id,
        CONCAT('Consulta modificada. Valor antigo: R$', OLD.valor, ' -> Novo valor: R$', NEW.valor)
    );
END$$


DROP TRIGGER IF EXISTS trg_before_delete_consulta$$

CREATE TRIGGER trg_before_delete_consulta
BEFORE DELETE ON consultas
FOR EACH ROW
BEGIN
    -- Declaramos uma variável para checar se o pagamento existe
    DECLARE v_pago_count INT;
    
    SELECT COUNT(*) INTO v_pago_count 
    FROM pagamentos 
    WHERE consulta_id = OLD.id;
    
    -- Se houver pagamento para esta consulta, barra a exclusão com erro customizado
    IF v_pago_count > 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Erro: Não é possível deletar uma consulta que possui registro de pagamento.';
    END IF;
END$$


DROP TRIGGER IF EXISTS trg_after_insert_animal$$

CREATE TRIGGER trg_after_insert_animal
AFTER INSERT ON animais
FOR EACH ROW
BEGIN
    INSERT INTO log_auditoria (tabela_afetada, acao, registro_id, detalhes)
    VALUES (
        'animais',
        'INSERT',
        NEW.id,
        CONCAT('Animal cadastrado: ', NEW.nome)
    );
END$$

DROP TRIGGER IF EXISTS trg_before_update_pagamento$$

CREATE TRIGGER trg_before_update_pagamento
BEFORE UPDATE ON pagamentos
FOR EACH ROW
BEGIN
    -- Se o status antigo já era 'pago' e tentarem mudar para qualquer outra coisa:
    IF OLD.status = 'pago' AND NEW.status <> 'pago' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Erro: Um pagamento com status PAGO não pode ser alterado.';
    END IF;
END$$

DELIMITER ;