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
    tempo INTEGER,
    complexidade VARCHAR(100),
    crm_cirurgiao CHAR(7),
    FOREIGN KEY (crm_cirurgiao) REFERENCES CIRURGIOES (crm),
    PRIMARY KEY (objetivo)
);

CREATE TABLE AMBULANCIAS (
    chassi CHAR(17),
    placa CHAR(6),
    equipe VARCHAR(100),
    PRIMARY KEY (chassi)
);

CREATE TABLE EQUIPAMENTOS (
    funcao VARCHAR(100),
    tipo VARCHAR(100),
    manipulador VARCHAR(100),
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
    funcao_equipamento VARCHAR(100),
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
