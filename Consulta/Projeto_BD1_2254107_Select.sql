DROP TABLE IF EXISTS MEDICAMENTOS_CONTROLADOS;
DROP TABLE IF EXISTS OPERACOES_CIRURGICAS;
DROP TABLE IF EXISTS APLICA;
DROP TABLE IF EXISTS MEDICAMENTOS;
DROP TABLE IF EXISTS TEM_CONTATO_COM;
DROP TABLE IF EXISTS CIRURGIOES;
DROP TABLE IF EXISTS ENFERMEIROS;
DROP TABLE IF EXISTS FICA_EM;
DROP TABLE IF EXISTS EQUIPAMENTOS;
DROP TABLE IF EXISTS VISITA;
DROP TABLE IF EXISTS FAMILIARES;
DROP TABLE IF EXISTS PACIENTES;
DROP TABLE IF EXISTS QUARTOS;
DROP TABLE IF EXISTS AMBULANCIAS;


CREATE TABLE MEDICAMENTOS (
    nome VARCHAR(100),
    lote INTEGER,
    efeito_colateral VARCHAR(100),
    PRIMARY KEY (nome)
);

CREATE TABLE MEDICAMENTOS_CONTROLADOS (
    nome VARCHAR(100),
    receita_medica VARCHAR(100),
    tarja VARCHAR(100),
    entorpecente VARCHAR(100),
    FOREIGN KEY (nome) REFERENCES MEDICAMENTOS (nome) ON DELETE CASCADE,
    PRIMARY KEY (nome)
);

CREATE TABLE ENFERMEIROS (
    coren CHAR(6),
    nome VARCHAR(100),
    especialidade VARCHAR(100),
    PRIMARY KEY (coren)
);

CREATE TABLE CIRURGIOES (
    crm CHAR(7),
    nome VARCHAR(100),
    especialidade VARCHAR(100),
    PRIMARY KEY (crm)
);

CREATE TABLE OPERACOES_CIRURGICAS (
    objetivo VARCHAR(100),
    tempo_horas INTEGER,
    complexidade VARCHAR(100),
    crm_cirurgiao CHAR(7),
    FOREIGN KEY (crm_cirurgiao) REFERENCES CIRURGIOES (crm),
    PRIMARY KEY (objetivo)
);

CREATE TABLE AMBULANCIAS (
    chassi CHAR(17),
    placa CHAR(7),
    equipe VARCHAR(100),
    PRIMARY KEY (chassi)
);

CREATE TABLE EQUIPAMENTOS (
    funcao VARCHAR(150),
    tipo VARCHAR(100),
    manipulador VARCHAR(150),
    PRIMARY KEY (funcao)
);

CREATE TABLE QUARTOS (
    numero INTEGER,
    ala VARCHAR(100),
    capacidade INTEGER,
    PRIMARY KEY (numero)
);

CREATE TABLE PACIENTES (
    rg VARCHAR(10),
    nome VARCHAR(100),
    idade INTEGER,
    chassi_ambulancia CHAR(17),
    numero_quarto INTEGER,
    FOREIGN KEY (numero_quarto) REFERENCES QUARTOS(numero),
    FOREIGN KEY (chassi_ambulancia) REFERENCES AMBULANCIAS(chassi),
    PRIMARY KEY (rg)
);

CREATE TABLE FAMILIARES (
    cpf CHAR(11),
    nome VARCHAR(100),
    idade INTEGER,
    PRIMARY KEY (cpf)
);

CREATE TABLE APLICA (
    nome_medicamento VARCHAR(100),
    coren_enfermeiro CHAR(6),
    FOREIGN KEY (nome_medicamento) REFERENCES MEDICAMENTOS(nome),
    FOREIGN KEY (coren_enfermeiro) REFERENCES ENFERMEIROS(coren),
    PRIMARY KEY (nome_medicamento, coren_enfermeiro)
);

CREATE TABLE TEM_CONTATO_COM (
    coren_enfermeiro CHAR(6),
    crm_cirurgiao CHAR(7),
    rg_paciente VARCHAR(10),
    FOREIGN KEY (coren_enfermeiro) REFERENCES ENFERMEIROS(coren),
    FOREIGN KEY (crm_cirurgiao) REFERENCES CIRURGIOES(crm),
    FOREIGN KEY (rg_paciente) REFERENCES PACIENTES(rg),
    PRIMARY KEY (coren_enfermeiro, crm_cirurgiao, rg_paciente)
);

CREATE TABLE FICA_EM (
    funcao_equipamento VARCHAR(150),
    numero_quarto INTEGER,
    FOREIGN KEY (funcao_equipamento) REFERENCES EQUIPAMENTOS(funcao),
    FOREIGN KEY (numero_quarto) REFERENCES QUARTOS(numero),
    PRIMARY KEY (funcao_equipamento, numero_quarto)
);

CREATE TABLE VISITA (
    rg_paciente VARCHAR(10),
    cpf_familiar CHAR(11),
    FOREIGN KEY (rg_paciente) REFERENCES PACIENTES(rg),
    FOREIGN KEY (cpf_familiar) REFERENCES FAMILIARES(cpf),
    PRIMARY KEY (rg_paciente, cpf_familiar)
);

INSERT INTO MEDICAMENTOS(nome, lote, efeito_colateral)
VALUES	('Amytril', 1, 'Sonol??ncia'),
		('Diclofenaco', 2, 'Dor de est??mago'),
        ('Valsed', 3, 'Tontura'),
        ('Patz Sublingual', 4, 'Ins??nia exacerbada'),
        ('Imovane', 5, 'Ansiedade'),
        ('Venvanse', 6, 'Diminui????o do apetite'),
        ('Biomag', 7, 'Formigamento'),
        ('Restiva', 8, 'Disartria'),
        ('Zolfest D', 9, 'Disturbios cognitivos'),
        ('Sibus', 10, 'Boca seca');

INSERT INTO MEDICAMENTOS_CONTROLADOS(nome, receita_medica, tarja, entorpecente)
VALUES  ('Amytril', 'Receita 1', 'Tarja vermelha', 'Entorpecente 1'),
        ('Diclofenaco', 'Receita 2', 'Tarja vermelha', 'Entorpecente 2'),
        ('Valsed', 'Receita 3', 'Tarja vermelha', 'Entorpecente 3'),
        ('Patz Sublingual', 'Receita 4', 'Tarja vermelha', 'Entorpecente 4'),
        ('Imovane', 'Receita 5', 'Tarja vermelha', 'Entorpecente 5'),
        ('Venvanse', 'Receita 6', 'Tarja preta', 'Entorpecente 6'),
        ('Biomag', 'Receita 7', 'Tarja preta', 'Entorpecente 7'),
        ('Restiva', 'Receita 8', 'Tarja preta', 'Entorpecente 8'),
        ('Zolfest D', 'Receita 9', 'Tarja preta', 'Entorpecente 9'),
        ('Sibus', 'Receita 10', 'Tarja preta', 'Entorpecente 10');

INSERT INTO ENFERMEIROS(coren, nome, especialidade)
VALUES  ('123456', 'Jo??o', 'Enfermagem em Nefrologia'),
        ('234567', 'Maria', 'Enfermagem em Cardiologia e Hemodin??mica'),
        ('345678', 'Pedro', 'Enfermagem em Pediatria'),
        ('456789', 'Paulo', 'Enfermagem em Urg??ncia e Emerg??ncia'),
        ('678901', 'Jos??', 'Enfermagem em Sa??de Mental'),
        ('789012', 'Iris', 'Enfermagem em Centro Cir??rgico'),
        ('890123', 'Joaquim', 'Enfermagem em UTI'),
        ('901234', 'Leonardo', 'Enfermagem Forense'),
        ('012345', 'Simone', 'Enfermagem em Ginecologia'),
        ('234234', 'Ester', 'Enfermagem em Neurocirurgia');

INSERT INTO CIRURGIOES(crm, nome, especialidade)
VALUES  ('1234567', 'Elias', 'Cirurgia no Aparelho Digestivo'),
        ('2345678', 'Josias', 'Cirurgia Pl??stica'),
        ('3456789', 'Livia', 'Cirurgia Vascular'),
        ('4567890', 'Pietro', 'Cirurgia Pediatrica'),
        ('5678901', 'Stefany', 'Cirurgia Neurol??gica'),
        ('6789012', 'Melissa', 'Cirurgia Proctol??gica'),
        ('7890123', 'Amanda', 'Cirurgia Orrinolaringol??gica'),
        ('8901234', 'Mario', 'Cirurgia Ortop??dica'),
        ('9012345', 'Claudio', 'Cirurgia Ginecol??gica'),
        ('0123456', 'Rafaela', 'Cirurgia Cabe??a e Pesco??o');

INSERT INTO OPERACOES_CIRURGICAS(objetivo, tempo_horas, complexidade, crm_cirurgiao)
VALUES	('Repara????o no sistema digestivo', '5', 'M??dia Complexidade', '1234567'),
		('Reconstru????o da orelha', '2', 'Baixa Complexidade', '2345678'),
		('Tratamento de doen??a arterial', '9', 'Alta Complexidade', '3456789'),
		('H??rnia umbilical', '1', 'Baixa Complexidade', '4567890'),
		('Ressec????o de tumor cerebral', '5', 'Alta Complexidade', '5678901'),
		('Tratamento de doen??a do intestino grosso', '2', 'M??dia Complexidade', '6789012'),
		('Corre????o do do septo e das conchas nasais', '3', 'Baixa Complexidade', '7890123'),
		('Artroscopia de joelho', '0.5', 'Baixa Complexidade', '8901234'),
		('Retirada de p??lipo endometrial', '1', 'Baixa Complexidade', '9012345'),
		('Traqueostomia', '2', 'M??dia Complexidade', '0123456');

INSERT INTO AMBULANCIAS(chassi, placa, equipe)
VALUES  ('12345678901234567', 'ABC1234', 'Motorista, Equipe de Emerg??ncia e Enfermeiros'),
        ('23456789012345678', 'DEF5678', 'Motorista, Equipe de Enfermagem em Ambul??ncia e Urg??ncia'),
        ('34567890123456789', 'GHI9012', 'Motorista, Equipe de Urg??ncia e Emfermagem Socorrista'),
        ('45678901234567890', 'JKL3456', 'Motorista, Equipe de Enfermagem Socorrista e Paramedicos'),
        ('56789012345678901', 'MNO6789', 'Motorista, Equipe de Paramedicos e Emerg??ncia'),
        ('67890123456789012', 'PQR0123', 'Motorista, Equipe Geral e Enfermagem em Ambul??ncia'),
        ('78901234567890123', 'STU4567', 'Motorista, Equipe de Auxiliar de Enfermagem e Geral'),
        ('89012345678901234', 'VWX7890', 'Motorista, Equipe de Enfermagem em Ambul??ncia e Geral'),
        ('90123456789012345', 'EYZ0134', 'Motorista, Equipe de Paramedicos e Enfermeiros'),
        ('01234567890123456', 'ABD5678', 'Motorista, Equipe de Enfermeiros e Geral');

INSERT INTO EQUIPAMENTOS(funcao, tipo, manipulador)
VALUES  ('Coletar, amplificar e desenhar um sinal card??aco', 'Eletrocardi??grafo', 'Profissional de Enfermagem, Auxiliar de Enfermagem ou Tecnico em Enfermagem'),
        ('Mensura quantidade de oxig??nio no sangue', 'Ox??metro', 'M??dico'),
        ('Mensura a press??o arterial', 'Esfigmoman??metro', 'M??dico'),
        ('Mensura a temperatura do corpo', 'Term??metro', 'Profissional de Enfermagem, Auxiliar de Enfermagem ou Tecnico em Enfermagem'),
        ('Dispara carga el??trica sobre o paciente com arritmia card??aca ou em parada cardiorrespirat??ria', 'Desfibrilador', 'Profissional de Enfermagem, Auxiliar de Enfermagem, Tecnico em Enfermagem ou m??dico'),
        ('Realiza leitura dos sinais vitais do paciente', 'Monitor multiparam??trico', 'Comumente manipulado por profissionais da sa??de de setores de emerg??ncia, pronto-socorro, UTI, ambul??ncias, centros cir??rgicos e ambulat??rios'),
        ('Garantir ventila????o artificial promovendo suporte ventilat??rio tempor??rio ??queles que n??o conseguem respirar normalmente', 'Ventilador pulmonar', 'Profissional de Enfermagem, Auxiliar de Enfermagem, Tecnico em Enfermagem ou m??dico'),
        ('Carrinhos m??veis e rotativos, servindo de prateleiras para armazenar demais equipamentos hospitalares', 'Estativa', 'Normalmente manipulado por Auxiliar de Enfermagem'),
        ('Contribui para administra????o eficiente de medicamentos e alimenta????o', 'Cateteres e sondas', 'Profissional de Enfermagem ou Tecnico em Enfermagem'),
        ('Controla infus??o de subst??ncias l??quidas', 'Bomba de infus??o', 'Normalmente manipulado por profissionais da  de enfermagem ou tecnico em enfermagem');

INSERT INTO QUARTOS(numero, ala, capacidade)
VALUES  ('100', 'A', '5'),
        ('101', 'A', '3'),
        ('200', 'B', '8'),
        ('201', 'B', '5'),
        ('300', 'C', '10'),
        ('301', 'C', '5'),
        ('400', 'D', '3'),
        ('401', 'D', '10'),
        ('500', 'E', '8'),
        ('501', 'E', '5');

INSERT INTO PACIENTES(rg, nome, idade, chassi_ambulancia, numero_quarto)
VALUES  ('1539383530', 'Rodrigo da Silva', '20', '12345678901234567', '100'),
        ('4537492151', 'Maria Saraiva', '25', '23456789012345678', '101'),
        ('8374921517', 'Tiago Alves Silva', '30', '34567890123456789', '200'),
        ('1019031575', 'Julia Tavares', '35', '45678901234567890', '201'),
        ('3691948460', 'Olivia Santana', '47', '56789012345678901', '300'),
        ('4437630572', 'Teresa Oliveira', '50', '67890123456789012', '301'),
        ('3055539998', 'Geraldo Souza', '79', '78901234567890123', '400'),
        ('4332095629', 'Renato Pereira', '34', '89012345678901234', '401'),
        ('4883715821', 'Samanta Rodrigues', '22', '90123456789012345', '500'),
        ('4712097125', 'Marcos Santos', '19', '01234567890123456', '501');

INSERT INTO FAMILIARES(cpf, nome, idade)
VALUES  ('75057949063', 'Miguel da Silva', '53'),
        ('83749215147', 'Arthur Saraiva', '27'),
        ('92185778080', 'Heitor Alves Silva', '37'),
        ('91441075011', 'Alice Tavares', '26'),
        ('09879008030', 'Helena Santana', '33'),
        ('69316242029', 'Theo Oliveira', '45'),
        ('99238338019', 'Davi Souza', '55'),
        ('28021556013', 'Laura Pereira', '27'),
        ('03253045056', 'Cecilia Rodrigues', '23'),
        ('91238017020', 'Benicio Santos', '68');

INSERT INTO APLICA (nome_medicamento, coren_enfermeiro)
VALUES  ('Amytril', '123456'),
        ('Diclofenaco', '234567'),
        ('Valsed', '345678'),
        ('Patz Sublingual', '456789'),
        ('Imovane', '678901'),
        ('Venvanse', '789012'),
        ('Biomag', '890123'),
        ('Restiva', '901234'),
        ('Zolfest D', '012345'),
        ('Sibus', '234234');

INSERT INTO TEM_CONTATO_COM(coren_enfermeiro, crm_cirurgiao, rg_paciente)
VALUES  ('123456', '1234567', '1539383530'),
        ('234567', '2345678', '4537492151'),
        ('345678', '3456789', '8374921517'),
        ('456789', '4567890', '1019031575'),
        ('678901', '5678901', '3691948460'),
        ('789012', '6789012', '4437630572'),
        ('890123', '7890123', '3055539998'),
        ('901234', '8901234', '4332095629'),
        ('012345', '9012345', '4883715821'),
        ('234234', '0123456', '4712097125');

INSERT INTO FICA_EM(funcao_equipamento, numero_quarto)
VALUES  ('Coletar, amplificar e desenhar um sinal card??aco', '100'),
        ('Mensura quantidade de oxig??nio no sangue', '101'),
        ('Mensura a press??o arterial', '200'),
        ('Mensura a temperatura do corpo', '201'),
        ('Dispara carga el??trica sobre o paciente com arritmia card??aca ou em parada cardiorrespirat??ria', '300'),
        ('Realiza leitura dos sinais vitais do paciente', '301'),
        ('Garantir ventila????o artificial promovendo suporte ventilat??rio tempor??rio ??queles que n??o conseguem respirar normalmente', '400'),
        ('Carrinhos m??veis e rotativos, servindo de prateleiras para armazenar demais equipamentos hospitalares', '401'),
        ('Contribui para administra????o eficiente de medicamentos e alimenta????o', '500'),
        ('Controla infus??o de subst??ncias l??quidas', '501');

INSERT INTO VISITA(rg_paciente, cpf_familiar)
VALUES  ('1539383530', '75057949063'),
        ('4537492151', '83749215147'),
        ('8374921517', '92185778080'),
        ('1019031575', '91441075011'),
        ('3691948460', '09879008030'),
        ('4437630572', '69316242029'),
        ('3055539998', '99238338019'),
        ('4332095629', '28021556013'),
        ('4883715821', '03253045056'),
        ('4712097125', '91238017020');


-- nome cirurgi??es que n??o realizaram cirurgias de m??dia complexidade
SELECT C.nome
FROM CIRURGIOES C
WHERE C.crm NOT IN (
    SELECT OC.crm_cirurgiao
    FROM OPERACOES_CIRURGICAS OC
    WHERE OC.complexidade = 'M??dia Complexidade');

-- nome de cirurgi??es que realizaram cirurgia de alta complexidade
SELECT C.nome, C.crm
FROM CIRURGIOES C
WHERE C.crm IN (
    SELECT OC.crm_cirurgiao
    FROM OPERACOES_CIRURGICAS OC
    WHERE OC.complexidade = 'Alta Complexidade');

-- crm e nome de cirurgioes que realizaram operacoes cirurgicas que possuem tempo de dura????o (horas) maior que o tempo m??dio (horas)
SELECT C.crm, C.nome
FROM CIRURGIOES C
WHERE C.crm IN (
	SELECT OC.crm_cirurgiao
	FROM OPERACOES_CIRURGICAS OC
	WHERE OC.tempo_horas > (
		SELECT AVG(OC.tempo_horas)
		FROM OPERACOES_CIRURGICAS OC));

-- nome e efeito colateral de medicamentos que possuem tarja vermelha
SELECT M.nome, M.efeito_colateral
FROM MEDICAMENTOS M
WHERE M.nome IN (
    SELECT MC.nome
    FROM MEDICAMENTOS_CONTROLADOS MC
    WHERE MC.tarja LIKE '%vermelha');

-- chassi da ambulancia com paciente com idade superior a 30 anos
SELECT A.chassi
FROM AMBULANCIAS A
WHERE A.chassi IN (
    SELECT P.chassi_ambulancia
    FROM PACIENTES P
    WHERE P.idade > 30);

-- numero do quarto do paciente com rg com final '5'
SELECT Q.numero
FROM QUARTOS Q
WHERE Q.numero IN (
    SELECT P.numero_quarto
    FROM PACIENTES P
    WHERE P.rg LIKE '%5');

-- coren e nome de enfermeiros que aplicaram medicamentos de tarja preta
SELECT E.coren, E.nome
FROM ENFERMEIROS E
WHERE E.coren IN (
    SELECT AC.coren_enfermeiro
    FROM APLICA AC
    WHERE AC.nome_medicamento IN (
        SELECT MC.nome
        FROM MEDICAMENTOS_CONTROLADOS MC
        WHERE MC.tarja LIKE '%preta'));

-- tipo de equipamento que fica em quarto com numero de quarto com final '0'
SELECT E.tipo
FROM EQUIPAMENTOS E
WHERE E.funcao IN (
    SELECT F.funcao_equipamento
    FROM FICA_EM F
    WHERE F.numero_quarto LIKE '%0');

-- nome e idade do paciente que esta em um quarto com numero de quarto com final '0' e que possui idade inferior a 30 anos
SELECT P.nome, P.idade
FROM PACIENTES P
WHERE P.nome IN (
    SELECT P.nome
    FROM PACIENTES P
    WHERE P.numero_quarto <> '100'
    AND P.idade < 30);

-- numero do quarto que possui equipamento que mensura algo
SELECT Q.numero
FROM QUARTOS Q
WHERE Q.numero IN (
    SELECT F.numero_quarto
    FROM FICA_EM F
    WHERE F.funcao_equipamento LIKE 'Mensura%');