CREATE TABLE tutor (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);

CREATE TABLE especie (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL
);

CREATE TABLE animal (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    especie_id INT,
    raca VARCHAR(100),
    nascimento DATE,
    tutor_id INT,
    FOREIGN KEY (especie_id) REFERENCES especie(id),
    FOREIGN KEY (tutor_id) REFERENCES tutor(id)
);

CREATE TABLE veterinario (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);

CREATE TABLE consulta (
    id INT AUTO_INCREMENT PRIMARY KEY,
    animal_id INT,
    vet_id INT,
    data_hora DATETIME,
    status ENUM('agendada', 'concluida', 'cancelada') DEFAULT 'agendada',
    diagnostico TEXT,
    FOREIGN KEY (animal_id) REFERENCES animal(id),
    FOREIGN KEY (vet_id) REFERENCES veterinario(id)
);

CREATE TABLE pagamento (
    id INT AUTO_INCREMENT PRIMARY KEY,
    consulta_id INT,
    valor DECIMAL(10,2) NOT NULL,
    status ENUM('pendente', 'pago', 'cancelado') DEFAULT 'pendente',
    forma_pagamento VARCHAR(50),
    FOREIGN KEY (consulta_id) REFERENCES consulta(id)
);
