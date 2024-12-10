CREATE DATABASE ecommecer;
USE ecommecer;


CREATE TABLE cliente (
    idcliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    cpf CHAR(11) NOT NULL,
    endereco TEXT,
    constraint UNIQUE_CPF_CLIENTE unique (cpf)
);


CREATE TABLE produtos (
    idprodutos INT AUTO_INCREMENT PRIMARY KEY,
    nome varchar(20),
    categoria VARCHAR(100) NOT NULL,
    descricao TEXT,
    valor DECIMAL(10, 2) NOT NULL
);

-- Tabela Cliente Pessoa Física (PF)
CREATE TABLE cliente_pf (
    idcliente INT PRIMARY KEY,
    cpf VARCHAR(14) NOT NULL UNIQUE,
    FOREIGN KEY (idcliente) REFERENCES cliente(idcliente)
);

-- Tabela Cliente Pessoa Jurídica (PJ)
CREATE TABLE cliente_pj (
    idcliente INT PRIMARY KEY,
    cnpj VARCHAR(20) NOT NULL UNIQUE,
    razao_social VARCHAR(255) NOT NULL,
    FOREIGN KEY (idcliente) REFERENCES cliente(idcliente)
);



CREATE TABLE estoque (
    idestoque INT AUTO_INCREMENT PRIMARY KEY,
    local VARCHAR(255) NOT NULL
);

-- Tabela Pedido
CREATE TABLE pedido (
    idpedido INT AUTO_INCREMENT PRIMARY KEY,
    status_pedido VARCHAR(50) NOT NULL,
    descricao TEXT,
    frete DECIMAL(10, 2) NOT NULL,
    idcliente INT NOT NULL,
    FOREIGN KEY (idcliente) REFERENCES cliente(idcliente)
);

CREATE TABLE entrega (
    identrega INT AUTO_INCREMENT PRIMARY KEY,
    idpedido INT NOT NULL,
    status_entrega VARCHAR(50) NOT NULL,
    codigo_rastreamento VARCHAR(50),
    FOREIGN KEY (idpedido) REFERENCES pedido(idpedido)
);

CREATE TABLE pagamento (
    idpagamento INT AUTO_INCREMENT PRIMARY KEY,
    idpedido INT NOT NULL,
    forma_pagamento VARCHAR(50) NOT NULL,
    valor_pagamento DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (idpedido) REFERENCES pedido(idpedido)
);

CREATE TABLE terceiro_vendedor (
    idterceiro_vendedor INT AUTO_INCREMENT PRIMARY KEY,
    razao_social VARCHAR(255) NOT NULL,
    local VARCHAR(255),
    nome VARCHAR(255)
);

CREATE TABLE fornecedor (
    idfornecedor INT AUTO_INCREMENT PRIMARY KEY,
    razao_social VARCHAR(255) NOT NULL,
    cnpj VARCHAR(20) NOT NULL UNIQUE
);

CREATE TABLE fornecedor_produtos (
    idfornecedor INT,
    idprodutos INT,
    PRIMARY KEY (idfornecedor, idprodutos),
    FOREIGN KEY (idfornecedor) REFERENCES fornecedor(idfornecedor),
    FOREIGN KEY (idprodutos) REFERENCES produtos(idprodutos)
);

CREATE TABLE produtos_terceiro_vendedor (
    idprodutos INT,
    idterceiro_vendedor INT,
    PRIMARY KEY (idprodutos, idterceiro_vendedor),
    FOREIGN KEY (idprodutos) REFERENCES produtos(idprodutos),
    FOREIGN KEY (idterceiro_vendedor) REFERENCES terceiro_vendedor(idterceiro_vendedor)
);

CREATE TABLE produtos_estoque (
    idprodutos INT,
    idestoque INT,
    PRIMARY KEY (idprodutos, idestoque),
    FOREIGN KEY (idprodutos) REFERENCES produtos(idprodutos),
    FOREIGN KEY (idestoque) REFERENCES estoque(idestoque)
);

CREATE TABLE produtos_pedido (
    idprodutos INT,
    idpedido INT,
    PRIMARY KEY (idprodutos, idpedido),
    FOREIGN KEY (idprodutos) REFERENCES produtos(idprodutos),
    FOREIGN KEY (idpedido) REFERENCES pedido(idpedido)
);
