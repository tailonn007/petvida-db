USE petvida;

INSERT INTO especies (nome) VALUES
('Cachorro'),
('Gato'),
('Pássaro'),
('Peixe'),
('Réptil');

INSERT INTO veterinarios (nome, crmv, especialidade, telefone) VALUES
('Mariana Souza', 'CRMV1001', 'Clínico Geral', '71999990001'),
('Carlos Lima', 'CRMV1002', 'Cirurgia', '71999990002'),
('Fernanda Alves', 'CRMV1003', 'Dermatologia', '71999990003');

INSERT INTO tutores (nome, cpf, email, telefone) VALUES
('João Silva', '111.111.111-11', 'joao@email.com', '71911110001'),
('Maria Oliveira', '222.222.222-22', 'maria@email.com', '71911110002'),
('Pedro Santos', '333.333.333-33', 'pedro@email.com', '71911110003'),
('Ana Costa', '444.444.444-44', 'ana@email.com', '71911110004'),
('Lucas Pereira', '555.555.555-55', 'lucas@email.com', '71911110005'),
('Juliana Rocha', '666.666.666-66', 'juliana@email.com', '71911110006'),
('Rafael Mendes', '777.777.777-77', 'rafael@email.com', '71911110007'),
('Beatriz Lima', '888.888.888-88', 'beatriz@email.com', '71911110008');

INSERT INTO animais (nome, especie_id, raca, data_nascimento, tutor_id) VALUES
('Thor', 1, 'Labrador', '2020-05-10', 1),
('Mel', 2, 'Siamês', '2021-03-15', 2),
('Rex', 1, 'Pastor Alemão', '2019-07-20', 3),
('Nina', 2, 'Persa', '2022-01-08', 4),
('Bolt', 1, 'Poodle', '2020-11-12', 5),
('Luna', 2, 'Maine Coon', '2021-09-25', 6),
('Pipoca', 3, 'Calopsita', '2023-02-01', 7),
('Goldie', 4, 'Goldfish', '2022-06-14', 8),
('Spike', 5, 'Iguana', '2021-04-18', 1),
('Belinha', 1, 'Bulldog', '2020-12-30', 2),
('Tom', 2, 'Angorá', '2018-08-05', 3),
('Fred', 3, 'Papagaio', '2019-10-10', 4),
('Bruce', 1, 'Rottweiler', '2021-07-07', 5),
('Kiara', 2, 'Bengal', '2022-05-19', 6),
('Dory', 4, 'Betta', '2023-03-22', 7);

INSERT INTO consultas (animal_id, veterinario_id, data_hora, diagnostico, valor, status) VALUES
(1,1,'2026-05-01 09:00:00','Consulta de rotina',120.00,'concluida'),
(2,2,'2026-05-01 10:00:00','Vacinação',150.00,'concluida'),
(3,3,'2026-05-02 11:00:00','Problema de pele',180.00,'concluida'),
(4,1,'2026-05-02 14:00:00','Febre',130.00,'concluida'),
(5,2,'2026-05-03 09:30:00','Cirurgia simples',500.00,'concluida'),
(6,3,'2026-05-03 15:00:00','Alergia',170.00,'concluida'),
(7,1,'2026-05-04 08:00:00','Asa machucada',110.00,'concluida'),
(8,2,'2026-05-04 13:00:00','Infecção',140.00,'concluida'),
(9,3,'2026-05-05 16:00:00','Troca de pele',200.00,'concluida'),
(10,1,'2026-05-05 17:00:00','Consulta de rotina',120.00,'concluida'),
(11,2,'2026-05-06 09:00:00','Exame clínico',160.00,'agendada'),
(12,3,'2026-05-06 10:00:00','Problema respiratório',190.00,'em_atendimento'),
(13,1,'2026-05-07 11:00:00','Vacinação',150.00,'concluida'),
(14,2,'2026-05-07 14:00:00','Consulta dermatológica',210.00,'cancelada'),
(15,3,'2026-05-08 15:00:00','Exame geral',130.00,'agendada'),
(1,1,'2026-05-08 16:00:00','Retorno',90.00,'concluida'),
(2,2,'2026-05-09 09:00:00','Cirurgia',650.00,'agendada'),
(3,3,'2026-05-09 10:00:00','Acompanhamento',140.00,'concluida'),
(4,1,'2026-05-10 11:00:00','Consulta de rotina',120.00,'concluida'),
(5,2,'2026-05-10 12:00:00','Exames laboratoriais',250.00,'pendente');

INSERT INTO pagamentos (consulta_id, valor_pago, forma_pagamento, data_pagamento, status) VALUES
(1,120.00,'pix','2026-05-01','pago'),
(2,150.00,'cartao','2026-05-01','pago'),
(3,180.00,'dinheiro','2026-05-02','pago'),
(4,130.00,'pix','2026-05-02','pago'),
(5,500.00,'cartao','2026-05-03','pago'),
(6,170.00,'pix','2026-05-03','pago'),
(7,110.00,'dinheiro','2026-05-04','pago'),
(8,140.00,'pix','2026-05-04','pago'),
(9,200.00,'cartao','2026-05-05','pago'),
(10,120.00,'dinheiro','2026-05-05','pago'),
(11,160.00,'pix','2026-05-06','pendente'),
(12,190.00,'cartao','2026-05-06','pago'),
(13,150.00,'pix','2026-05-07','pago'),
(14,210.00,'convenio','2026-05-07','cancelado'),
(15,130.00,'dinheiro','2026-05-08','pendente'),
(16,90.00,'pix','2026-05-08','pago'),
(17,650.00,'cartao','2026-05-09','pendente'),
(18,140.00,'pix','2026-05-09','pago'),
(19,120.00,'dinheiro','2026-05-10','pago'),
(20,250.00,'convenio','2026-05-10','pendente');