USE petvida;

CREATE OR REPLACE VIEW vw_consultas_completas AS
SELECT
c.data_hora,
c.status,
c.diagnostico,
c.valor,
a.nome AS animal,
e.nome AS especie,
t.nome AS tutor,
t.telefone,
v.nome AS veterinario,
v.especialidade,
p.forma_pagamento,
p.status AS status_pagamento
FROM consultas c
INNER JOIN animais a ON c.animal_id = a.id
INNER JOIN especies e ON a.especie_id = e.id
INNER JOIN tutores t ON a.tutor_id = t.id
INNER JOIN veterinarios v ON c.veterinario_id = v.id
LEFT JOIN pagamentos p ON p.consulta_id = c.id;


CREATE OR REPLACE VIEW vw_agenda_hoje AS
SELECT *
FROM vw_consultas_completas
WHERE DATE(data_hora) = CURDATE()
ORDER BY data_hora;


CREATE OR REPLACE VIEW vw_faturamento_mensal AS
SELECT
YEAR(c.data_hora) AS ano,
MONTH(c.data_hora) AS mes,
v.nome AS veterinario,
COUNT(c.id) AS total_consultas,
SUM(c.valor) AS faturamento_total
FROM consultas c
INNER JOIN veterinarios v ON c.veterinario_id = v.id
GROUP BY YEAR(c.data_hora), MONTH(c.data_hora), v.nome
ORDER BY ano, mes, veterinario;


CREATE OR REPLACE VIEW vw_animais_detalhados AS
SELECT
a.id,
a.nome AS animal,
a.raca,
a.data_nascimento,
e.nome AS especie,
t.nome AS tutor,
t.telefone,
COUNT(c.id) AS total_consultas
FROM animais a
INNER JOIN especies e ON a.especie_id = e.id
INNER JOIN tutores t ON a.tutor_id = t.id
LEFT JOIN consultas c ON c.animal_id = a.id
GROUP BY a.id, a.nome, a.raca, a.data_nascimento, e.nome, t.nome, t.telefone
ORDER BY a.nome;


CREATE OR REPLACE VIEW vw_inadimplentes AS
SELECT *
FROM vw_consultas_completas
WHERE status = 'Concluída'
AND (
status_pagamento IS NULL
OR status_pagamento = 'Pendente'
);