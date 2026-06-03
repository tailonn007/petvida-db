USE petvida;

SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE pagamentos;
TRUNCATE TABLE consultas;
TRUNCATE TABLE animais;
TRUNCATE TABLE tutores;
TRUNCATE TABLE veterinarios;
TRUNCATE TABLE especialidades;
TRUNCATE TABLE especies;
SET FOREIGN_KEY_CHECKS = 1;

INSERT INTO especies(nome) VALUES ('Cachorro'), ('Gato'), ('Pássaro'), ('Peixe'), ('Réptil');

INSERT INTO especialidades(nome) VALUES ('Clínico Geral'), ('Cirurgia'), ('Dermatologia');

INSERT INTO veterinarios(nome, crmv, especialidade_id, telefone) VALUES
('João Pedro', 'CRMV101', 1, '71999990001'),
('Amanda Lima', 'CRMV102', 2, '71999990002'),
('Carlos Henrique', 'CRMV103', 3, '71999990003');

INSERT INTO tutores(nome, cpf, email, telefone) VALUES
('Marcos Andrande', '111.111.111-11', 'marcos@gmail.com', '71911110001'),
('Fernanda Souza', '222.222.222-22', 'fernanda@gmail.com', '71911110002'),
('Ricardo Lima', '333.333.333-33', 'ricardo@gmail.com', '71911110003'),
('Juliana Rocha', '444.444.444-44', 'juliana@gmail.com', '71911110004'),
('Pedro Henrique', '555.555.555-55', 'pedro@gmail.com', '71911110005'),
('Camila Alves', '666.666.666-66', 'camila@gmail.com', '71911110006'),
('Thiago Santos', '777.777.777-77', 'thiago@gmail.com', '71911110007'),
('Larissa Costa', '888.888.888-88', 'larissa@gmail.com', '71911110008');

INSERT INTO animais(nome, especie_id, raca, data_nascimento, tutor_id) VALUES
('Hulk',1,'Labrador','2020-02-10',1),
('Marley',2,'Persa','2021-04-11',2),
('Puma',1,'Pitbull','2019-06-12',3),
('Kacey',2,'Siamês','2022-01-20',4),
('Bolt',1,'Poodle','2020-07-30',5),
('Stark',2,'Angorá','2021-09-15',6),
('Silver',3,'Calopsita','2023-03-10',7),
('Gold',4,'Betta','2022-05-18',8),
('Spike Lee',5,'Iguana','2021-08-01',1),
('Thanos',1,'Bulldog','2020-12-19',2),
('Tom',2,'Maine Coon','2019-11-05',3),
('Jerry',3,'Papagaio','2018-04-08',4),
('Bruce Wayne',1,'Doberman','2021-02-14',5),
('Kiara',2,'Bengal','2022-06-17',6),
('Raposo',4,'Kinguio','2023-01-09',7);

INSERT INTO consultas(animal_id, veterinario_id, data_hora, diagnostico, valor, status) VALUES
(1, 1, '2026-05-15 14:00:00', 'Check-up anual.', 150.00, 'concluida'),
(2, 2, '2026-05-16 09:30:00', 'Castração bem sucedida.', 450.00, 'concluida'),
(3, 3, '2026-05-20 16:15:00', 'Alergia alimentar tratada.', 180.00, 'concluida'),
(4, 1, CONCAT(CURDATE(), ' 09:00:00'), 'Retorno de rotina.', 120.00, 'agendada'),
(5, 3, CONCAT(CURDATE(), ' 14:30:00'), 'Suspeita de dermatite.', 180.00, 'agendada'),
(6, 1, '2026-05-25 10:00:00', 'Tratamento de otite.', 130.00, 'concluida');

INSERT INTO pagamentos(consulta_id, valor_pago, forma_pagamento, data_pagamento, status_pagamento) VALUES
(1, 150.00, 'pix', '2026-05-15', 'pago'),
(2, 450.00, 'cartao', '2026-05-16', 'pago'),
(3, 180.00, 'dinheiro', '2026-05-20', 'pago'),
(6, 0.00, 'cartao', '2026-05-25', 'pendente');