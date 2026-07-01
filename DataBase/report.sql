USE petvida;

-- =====================================================
-- 1) Ranking de tutores que mais gastam
-- =====================================================

SELECT
    ROW_NUMBER() OVER (
        ORDER BY SUM(c.valor) DESC
    ) AS posicao,

    t.nome,

    COUNT(c.id) AS qtd_consultas,

    SUM(c.valor) AS total_gasto

FROM tutores t

INNER JOIN animais a
ON t.id = a.tutor_id

INNER JOIN consultas c
ON a.id = c.animal_id

WHERE c.status <> 'cancelada'

GROUP BY t.id, t.nome

ORDER BY total_gasto DESC;


-- =====================================================
-- 2) Faturamento mensal
-- =====================================================

SELECT

YEAR(c.data_hora) AS ano,

MONTH(c.data_hora) AS mes,

COUNT(*) AS total_consultas,

SUM(c.valor) AS faturamento_bruto,

SUM(
CASE
WHEN p.status='pago'
THEN c.valor
ELSE 0
END
) AS recebido,

SUM(
CASE
WHEN p.status='pendente'
THEN c.valor
ELSE 0
END
) AS pendente

FROM consultas c

LEFT JOIN pagamentos p
ON c.id=p.consulta_id

GROUP BY
YEAR(c.data_hora),
MONTH(c.data_hora)

ORDER BY
ano,
mes;


-- =====================================================
-- 3) Animais sem consulta há mais de 6 meses
-- =====================================================

SELECT

a.nome,

MAX(c.data_hora) AS ultima_consulta

FROM animais a

LEFT JOIN consultas c
ON a.id=c.animal_id

GROUP BY
a.id,
a.nome

HAVING

ultima_consulta IS NULL

OR

DATEDIFF(
CURDATE(),
ultima_consulta
)>180;


-- =====================================================
-- 4) Dashboard financeiro
-- =====================================================

SELECT

COUNT(*) AS total_consultas,

SUM(valor) AS faturamento_bruto,

SUM(
CASE
WHEN p.status='pago'
THEN valor
ELSE 0
END
) AS recebido,

SUM(
CASE
WHEN p.status='pendente'
THEN valor
ELSE 0
END
) AS pendente,

ROUND(

SUM(
CASE
WHEN p.status='pendente'
THEN 1
ELSE 0
END
)

/

COUNT(*)

*100

,2)

AS percentual_inadimplencia

FROM consultas c

LEFT JOIN pagamentos p
ON c.id=p.consulta_id;


-- =====================================================
-- 5) Veterinário do mês
-- =====================================================

SELECT

v.nome,

COUNT(*) AS consultas,

SUM(c.valor) AS faturamento

FROM veterinarios v

INNER JOIN consultas c
ON v.id=c.veterinario_id

WHERE

MONTH(c.data_hora)=MONTH(CURDATE())

AND

YEAR(c.data_hora)=YEAR(CURDATE())

GROUP BY

v.id,
v.nome

ORDER BY faturamento DESC

LIMIT 1;


-- =====================================================
-- 6) Distribuição por espécie
-- =====================================================

SELECT

e.nome,

COUNT(a.id) AS quantidade,

ROUND(

COUNT(a.id)

/

(SELECT COUNT(*) FROM animais)

*100

,2)

AS percentual

FROM especies e

LEFT JOIN animais a

ON e.id=a.especie_id

GROUP BY

e.id,
e.nome;