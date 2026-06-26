USE petvida;

DROP VIEW IF EXISTS vw_inadimplentes;
DROP VIEW IF EXISTS vw_animais_detalhados;
DROP VIEW IF EXISTS vw_faturamento_mensal;
DROP VIEW IF EXISTS vw_agenda_hoje;
DROP VIEW IF EXISTS vw_consultas_completas;

CREATE VIEW vw_consultas_completas AS
SELECT
    c.data_hora,
    'Concluída' AS status,
    c.diagnostico,
    c.valor,
    a.nome AS animal,
    a.especie AS especie,
    t.nome AS tutor,
    t.telefone,
    v.nome AS veterinario,
    v.especialidade,
    p.forma_pagamento,
    p.status AS status_pagamento
FROM consultas c
INNER JOIN animais a ON c.animal_id = a.id
INNER JOIN tutores t ON a.tutor_id = t.id
INNER JOIN veterinarios v ON c.veterinario_id = v.id
LEFT JOIN pagamentos p ON p.consulta_id = c.id;

CREATE VIEW vw_agenda_hoje AS
SELECT *
FROM vw_consultas_completas
WHERE DATE(data_hora) = CURDATE();

CREATE VIEW vw_faturamento_mensal AS
SELECT
    YEAR(data_hora) AS ano,
    MONTH(data_hora) AS mes,
    veterinario,
    COUNT(*) AS total_consultas,
    SUM(valor) AS faturamento_total
FROM vw_consultas_completas
GROUP BY YEAR(data_hora), MONTH(data_hora), veterinario;

CREATE VIEW vw_animais_detalhados AS
SELECT
    a.id,
    a.nome AS animal,
    a.especie,
    a.raca,
    a.data_nascimento,
    t.nome AS tutor,
    t.telefone,
    COUNT(c.id) AS total_consultas
FROM animais a
INNER JOIN tutores t ON a.tutor_id = t.id
LEFT JOIN consultas c ON c.animal_id = a.id
GROUP BY a.id, a.nome, a.especie, a.raca, a.data_nascimento, t.nome, t.telefone;

CREATE VIEW vw_inadimplentes AS
SELECT *
FROM vw_consultas_completas
WHERE status_pagamento IS NULL
   OR status_pagamento = 'Pendente';
   
   
   SELECT * FROM vw_consultas_completas;

SELECT * FROM vw_agenda_hoje;

SELECT * FROM vw_faturamento_mensal;

SELECT * FROM vw_animais_detalhados;

SELECT * FROM vw_inadimplentes;