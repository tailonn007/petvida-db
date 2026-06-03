DROP DATABASE IF EXISTS petvida;
CREATE DATABASE petvida;
USE petvida;

CREATE TABLE especialidades (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE veterinarios (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    crmv VARCHAR(20) UNIQUE NOT NULL,
    especialidade_id INT NOT NULL,
    telefone VARCHAR(20) NOT NULL,
    FOREIGN KEY (especialidade_id) REFERENCES especialidades(id)
);

CREATE TABLE tutores (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) UNIQUE NOT NULL,
    email VARCHAR(100) NOT NULL,
    telefone VARCHAR(20) NOT NULL
);

CREATE TABLE especies (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE animais (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    especie_id INT NOT NULL,
    raca VARCHAR(100) NOT NULL,
    data_nascimento DATE NOT NULL,
    tutor_id INT NOT NULL,
    FOREIGN KEY (especie_id) REFERENCES especies(id),
    FOREIGN KEY (tutor_id) REFERENCES tutores(id)
);

CREATE TABLE consultas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    animal_id INT NOT NULL,
    veterinario_id INT NOT NULL,
    data_hora DATETIME NOT NULL,
    diagnostico TEXT NOT NULL,
    valor DECIMAL(10,2) NOT NULL,
    status ENUM('agendada', 'em_atendimento', 'concluida', 'cancelada') NOT NULL,
    FOREIGN KEY (animal_id) REFERENCES animais(id),
    FOREIGN KEY (veterinario_id) REFERENCES veterinarios(id)
);

CREATE TABLE pagamentos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    consulta_id INT UNIQUE NOT NULL,
    valor_pago DECIMAL(10,2) NOT NULL,
    forma_pagamento ENUM('pix', 'cartao', 'dinheiro', 'convenio') NOT NULL,
    data_pagamento DATE NOT NULL,
    status_pagamento ENUM('pago', 'pendente', 'cancelado') NOT NULL,
    FOREIGN KEY (consulta_id) REFERENCES consultas(id)
);

CREATE INDEX idx_consultas_data ON consultas(data_hora);