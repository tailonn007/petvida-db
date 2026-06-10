USE petvida;

DELIMITER $$

-- 1) Idade do animal
DROP FUNCTION IF EXISTS fn_idade_animal $$
CREATE FUNCTION fn_idade_animal(
    p_data_nascimento DATE
)
RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN

    DECLARE anos INT;
    DECLARE meses INT;

    SET anos = TIMESTAMPDIFF(
        YEAR,
        p_data_nascimento,
        CURDATE()
    );

    SET meses = TIMESTAMPDIFF(
        MONTH,
        DATE_ADD(
            p_data_nascimento,
            INTERVAL anos YEAR
        ),
        CURDATE()
    );

    RETURN CONCAT(
        anos,
        ' anos e ',
        meses,
        ' meses'
    );

END $$

-- 2) Total gasto pelo tutor
DROP FUNCTION IF EXISTS fn_total_gasto_tutor $$
CREATE FUNCTION fn_total_gasto_tutor(
    p_tutor_id INT
)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN

    DECLARE total DECIMAL(10,2);

    SELECT IFNULL(SUM(c.valor),0)
    INTO total
    FROM consultas c
    INNER JOIN animais a
        ON c.animal_id = a.id
    WHERE a.tutor_id = p_tutor_id
      AND c.status <> 'cancelada';

    RETURN total;

END $$

-- 3) Quantidade de consultas do animal
DROP FUNCTION IF EXISTS fn_qtd_consultas_animal $$
CREATE FUNCTION fn_qtd_consultas_animal(
    p_animal_id INT
)
RETURNS INT
DETERMINISTIC
BEGIN

    DECLARE qtd INT;

    SELECT COUNT(*)
    INTO qtd
    FROM consultas
    WHERE animal_id = p_animal_id;

    RETURN qtd;

END $$

-- 4) Status com emoji
DROP FUNCTION IF EXISTS fn_status_emoji $$
CREATE FUNCTION fn_status_emoji(
    p_status VARCHAR(30)
)
RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN

    RETURN CASE

        WHEN p_status = 'agendada'
            THEN '📅 Agendada'

        WHEN p_status = 'concluida'
            THEN '✅ Concluída'

        WHEN p_status = 'cancelada'
            THEN '❌ Cancelada'

        WHEN p_status = 'em_atendimento'
            THEN '🏥 Em Atendimento'

        ELSE 'Status desconhecido'

    END;

END $$

-- 5) Classificação por valor
DROP FUNCTION IF EXISTS fn_classificar_valor $$
CREATE FUNCTION fn_classificar_valor(
    p_valor DECIMAL(10,2)
)
RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN

    RETURN CASE

        WHEN p_valor < 100
            THEN 'Consulta Simples'

        WHEN p_valor BETWEEN 100 AND 300
            THEN 'Consulta Padrão'

        ELSE 'Procedimento Especial'

    END;

END $$

DELIMITER ;