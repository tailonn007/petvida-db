-- RECEPCIONISTA
CREATE USER IF NOT EXISTS 'recepcionista'@'%' IDENTIFIED BY 'senha123';

GRANT SELECT, INSERT ON petvida.tutores TO 'recepcionista'@'%';
GRANT SELECT, INSERT ON petvida.animais TO 'recepcionista'@'%';
GRANT SELECT, INSERT ON petvida.consultas TO 'recepcionista'@'%';
GRANT SELECT, INSERT ON petvida.especies TO 'recepcionista'@'%';

GRANT EXECUTE ON PROCEDURE petvida.sp_agendar TO 'recepcionista'@'%';
GRANT EXECUTE ON PROCEDURE petvida.sp_cadastrar TO 'recepcionista'@'%';


-- VETERINARIO
CREATE USER IF NOT EXISTS 'veterinario'@'%' IDENTIFIED BY 'senha123';

GRANT SELECT ON petvida.* TO 'veterinario'@'%';

GRANT UPDATE (diagnostico, status)
ON petvida.consultas
TO 'veterinario'@'%';

GRANT EXECUTE ON PROCEDURE petvida.sp_concluir TO 'veterinario'@'%';


-- GERENTE
CREATE USER IF NOT EXISTS 'gerente'@'%' IDENTIFIED BY 'senha123';

GRANT SELECT, INSERT, UPDATE
ON petvida.*
TO 'gerente'@'%';

GRANT DELETE ON petvida.consultas
TO 'gerente'@'%';

GRANT EXECUTE ON PROCEDURE petvida.sp_agendar TO 'gerente'@'%';
GRANT EXECUTE ON PROCEDURE petvida.sp_cadastrar TO 'gerente'@'%';
GRANT EXECUTE ON PROCEDURE petvida.sp_concluir TO 'gerente'@'%';


-- ADMIN
CREATE USER IF NOT EXISTS 'admin'@'%' IDENTIFIED BY 'senha123';

GRANT ALL PRIVILEGES
ON petvida.*
TO 'admin'@'%'
WITH GRANT OPTION;


-- REVOKE RECEPCIONISTA
REVOKE INSERT ON petvida.tutores FROM 'recepcionista'@'%';
REVOKE INSERT ON petvida.animais FROM 'recepcionista'@'%';
REVOKE INSERT ON petvida.consultas FROM 'recepcionista'@'%';
REVOKE INSERT ON petvida.especies FROM 'recepcionista'@'%';

REVOKE EXECUTE ON PROCEDURE petvida.sp_agendar FROM 'recepcionista'@'%';
REVOKE EXECUTE ON PROCEDURE petvida.sp_cadastrar FROM 'recepcionista'@'%';

FLUSH PRIVILEGES;