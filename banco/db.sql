CREATE DATABASE db_lava_rapido;
USE db_lava_rapido;

/*************************
Tabela Datas
*************************/
CREATE TABLE tbl_datas(
id_data INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
datas date not null
);

INSERT INTO tbl_datas(datas)VALUES
('2024-02-10');

/*************************
Tabela Horas
*************************/
CREATE TABLE tbl_horas(
id_horario INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
horas time not null
);

INSERT INTO tbl_horas(horas)VALUES
('18:00:00');

/*************************
Tabela Datas Horas
*************************/
CREATE TABLE tbl_datas_horarios(
id_data_horario INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
id_horario int not null,
id_data int not null,
constraint FK_HORARIO_DATA
foreign key (id_horario) references tbl_horas (id_horario),
constraint FK_DATA_HORARIO
foreign key (id_data) references tbl_datas (id_data)
);

INSERT INTO tbl_datas_horarios(id_horario, id_data)VALUES
(1,1);


/*************************
Tabela Endereços
*************************/
CREATE TABLE tbl_enderecos(
id_endereco INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
rua varchar(45),
cep float,
numero float,
complemento varchar(100),
bairro varchar(150),
estado varchar(80),
cidade varchar(80)
);

INSERT INTO tbl_enderecos(rua, cep, numero, complemento, bairro, estado, cidade)VALUES
('Rua Belval',
'64782358',
'39',
'Do lado do mercado do Zé',
'Vila Barros',
'São Paulo',
'Carapicuíba');

select * from tbl_enderecos;



UPDATE tbl_enderecos SET rua = 'Rua São Mateus', estado = 'São paulo' 
WHERE (id_endereco = 2);

   select cast(last_insert_id()as DECIMAL) as id from tbl_funcionarios limit 1;


/*************************
Tabela Clientes
*************************/
CREATE TABLE tbl_clientes(
id_cliente INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
nome varchar(100),
foto varchar(250), 
email varchar(150),
senha varchar(100),
telefone varchar(18),
id_endereco int not null,
constraint FK_ENDERECO_CLIENTE
foreign key (id_endereco) references tbl_enderecos (id_endereco)
);

INSERT INTO tbl_clientes(nome, foto, email, senha, telefone, id_endereco)VALUES
('Gustavo',
'https://www.nube.com.br/media/noticias/2008/06/17/1049/perfil-profissional-sucesso-carreira-caracteristicas_400x600.jpg',
'gustavo@gmail.com',
'gustavo123',
'11986353648',
1);

select * from tbl_clientes;


/*************************
Tabela Funcionarios
*************************/
CREATE TABLE tbl_funcionarios(
id_funcionario INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
nome varchar(100),
email varchar(150),
senha varchar(100),
cargo varchar(30),
telefone varchar(18),
id_endereco int not null,
constraint FK_ENDERECO_FUNCIONARIO
foreign key (id_endereco) references tbl_enderecos (id_endereco)
);

INSERT INTO tbl_funcionarios(nome, email, senha, cargo, telefone, id_endereco)VALUES
('Murilo',
'murilo@gmail.com',
'murilo123',
'Funcionário',
'11637864582',
1);

select * from tbl_funcionarios;
UPDATE `db_lava_rapido`.`tbl_funcionarios` SET `nome` = 'Pietra de Paula', `email` = 'pietra@gmail.com', `senha` = 'pietra123', `cargo` = 'Funcionária', `telefone` = '11637869999' WHERE (`id_funcionario` = '3');
INSERT INTO `db_lava_rapido`.`tbl_funcionarios` (`id_funcionario`, `nome`, `email`, `senha`, `cargo`, `telefone`, `id_endereco`) VALUES ('4', 'Vinicius', 'vini@vini', 'vini123', 'lavador', '11999999999', '1');




/*************************
Tabela Serviços
*************************/
CREATE TABLE tbl_servicos(
id_servico INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
tipo_servico varchar(50),
descricao text,
preco double
);

INSERT INTO tbl_servicos(tipo_servico, descricao, preco)VALUES
('Lavagem Completa',
'Lavagem por fora e por dentro do veículo',
'250');

select * from tbl_servicos;


/*************************
Tabela Veiculos
*************************/
CREATE TABLE tbl_veiculos(
id_veiculo INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
modelo varchar(30),
marca varchar(80),
ano year,
placa varchar(10),
cor varchar(50)
);

INSERT INTO tbl_veiculos(modelo, marca, ano, placa, cor)VALUES
('SUV',
'BMW',
'2019',
'ZYAR-523',
'Branco');

select * from tbl_veiculos;

/*******************************
Tabela Clientes Veiculos
*******************************/
CREATE TABLE tbl_clientes_veiculos(
id_cliente_veiculo INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
id_cliente int not null,
id_veiculo int not null,
constraint FK_CLIENTE_VEICULO
foreign key (id_cliente) references tbl_clientes (id_cliente),
constraint FK_VEICULO_CLIENTE
foreign key (id_veiculo) references tbl_veiculos (id_veiculo)
);
INSERT INTO tbl_clientes_veiculos(id_cliente, id_veiculo)VALUES
(1,1);

select * from tbl_clientes_veiculos;

/*************************
Tabela Agendamentos
*************************/
CREATE TABLE tbl_agendamentos(
id_agendamento INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
id_data_horario int not null,
id_cliente_veiculo int not null,
constraint FK_DATA_HORARIO_AGENDAMENTO
foreign key (id_data_horario) references tbl_datas_horarios (id_data_horario),
constraint FK_CLIENTE_VEICULO_AGENDAMENTO
foreign key (id_cliente_veiculo) references tbl_clientes_veiculos (id_cliente_veiculo)
);

select * from tbl_agendamentos;

INSERT INTO tbl_agendamentos(id_data_horario, id_cliente_veiculo)VALUES
(1,1);

/****************************************
Tabela Serviços Agendados
****************************************/
CREATE TABLE tbl_servicos_agendamentos(
id_servico_agendamento INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
detalhes_adicionais text,
id_agendamento int not null,
id_servico int not null,
constraint FK_AGENDAMENTO_SERVICO
foreign key (id_agendamento) references tbl_agendamentos (id_agendamento),
constraint FK_SERVICO_AGENDAMENTO
foreign key (id_servico) references tbl_servicos (id_servico)
);

INSERT INTO tbl_servicos_agendamentos(detalhes_adicionais, id_agendamento, id_servico)VALUES
(null,
1,1);

select * from tbl_servicos_agendamentos;


/****************************************
Tabela Agendamentos Funcionarios
****************************************/
CREATE TABLE tbl_agendamentos_funcionarios(
id_agendamento_funcionario INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
id_agendamento int not null,
id_funcionario int not null,
constraint FK_AGENDAMENTO_FUNCIONARIO
foreign key (id_agendamento) references tbl_agendamentos (id_agendamento),
constraint FK_FUNCIONARIO_AGENDAMENTO
foreign key (id_funcionario) references tbl_funcionarios (id_funcionario)
);

INSERT INTO tbl_agendamentos_funcionarios(id_agendamento, id_funcionario)VALUES
(1,1);


/*************************
Tabela Forma de Pagamentos
*************************/
CREATE TABLE tbl_formas_pagamentos(
id_forma_pagamento INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
forma_pagamento varchar(20)
);

INSERT INTO tbl_formas_pagamentos(forma_pagamento)VALUES
('Crédito');

select * from tbl_formas_pagamentos;


/*************************
Tabela Pagamentos
*************************/
CREATE TABLE tbl_pagamentos(
id_pagamento INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
valor_pago float,
data_pagamento date,
horario_pagamento time,
id_servico_agendamento int not null,
id_forma_pagamento int not null,
constraint FK_FORMA_PAGAMENTO_PAGAMENTO
foreign key (id_forma_pagamento) references tbl_formas_pagamentos (id_forma_pagamento),
constraint FK_SERVICO_AGENDAMENTO_PAGAMENTO
foreign key (id_servico_agendamento) references tbl_servicos_agendamentos (id_servico_agendamento)
);

INSERT INTO tbl_pagamentos(valor_pago, data_pagamento, horario_pagamento, id_servico_agendamento, id_forma_pagamento)VALUES
('100',
'2024-02-10',
'17:40:00',
1,
1);


/*************************
Tabela Recibos
*************************/
CREATE TABLE tbl_recibos(
id_recibo INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
data_emissao date,
id_pagamento int not null,
constraint FK_RECIBO_PAGAMENTO
foreign key (id_pagamento) references tbl_pagamentos (id_pagamento)
);

INSERT INTO tbl_recibos(data_emissao, id_pagamento)VALUES
('2024-02-10',
1);















/***********************************************************************
CONSULTAS 
*****************************************************************/




-- Consultar informações do cliente, seu veículo, os serviços agendados, a data e o horário do agendamento com base no email do cliente --
SELECT
    tbl_clientes.nome,
    tbl_veiculos.modelo,
    tbl_veiculos.marca,
    tbl_veiculos.ano,
    tbl_veiculos.placa,
    tbl_veiculos.cor,
    tbl_servicos.tipo_servico,
    tbl_servicos.descricao,
    tbl_datas.datas,
    tbl_horas.horas
FROM
    tbl_clientes
JOIN
    tbl_clientes_veiculos ON tbl_clientes.id_cliente = tbl_clientes_veiculos.id_cliente
JOIN
    tbl_veiculos ON tbl_clientes_veiculos.id_veiculo = tbl_veiculos.id_veiculo
JOIN
    tbl_agendamentos ON tbl_clientes.id_cliente = tbl_agendamentos.id_cliente_veiculo
JOIN
    tbl_datas_horarios ON tbl_agendamentos.id_data_horario = tbl_datas_horarios.id_data_horario
JOIN
    tbl_datas ON tbl_datas_horarios.id_data = tbl_datas.id_data
JOIN
    tbl_horas ON tbl_datas_horarios.id_horario = tbl_horas.id_horario
JOIN
    tbl_servicos_agendamentos ON tbl_agendamentos.id_agendamento = tbl_servicos_agendamentos.id_agendamento
JOIN
    tbl_servicos ON tbl_servicos_agendamentos.id_servico = tbl_servicos.id_servico
WHERE
     tbl_clientes.email = 'gustavo@gmail.com';
     
     
     
-- Consultar agendamentos associados a um funcionário pelo nome do funcionário
CREATE VIEW vw_agendamentos_por_funcionario AS
SELECT
    tbl_funcionarios.nome AS nome_funcionario,
    tbl_clientes.nome AS nome_cliente,
    tbl_clientes.email AS email_cliente,
    tbl_clientes.telefone AS telefone_cliente,
    tbl_veiculos.modelo,
    tbl_veiculos.marca,
    tbl_veiculos.ano,
    tbl_veiculos.placa,
    tbl_veiculos.cor,
    tbl_servicos.tipo_servico,
    tbl_servicos.descricao,
    tbl_datas.datas as dia,
    tbl_horas.horas as hora
FROM
    tbl_funcionarios
JOIN
    tbl_agendamentos_funcionarios ON tbl_funcionarios.id_funcionario = tbl_agendamentos_funcionarios.id_funcionario
JOIN
    tbl_agendamentos ON tbl_agendamentos_funcionarios.id_agendamento = tbl_agendamentos.id_agendamento
JOIN
    tbl_datas_horarios ON tbl_agendamentos.id_data_horario = tbl_datas_horarios.id_data_horario
JOIN
    tbl_datas ON tbl_datas_horarios.id_data = tbl_datas.id_data
JOIN
    tbl_horas ON tbl_datas_horarios.id_horario = tbl_horas.id_horario
JOIN
    tbl_clientes_veiculos ON tbl_agendamentos.id_cliente_veiculo = tbl_clientes_veiculos.id_cliente_veiculo
JOIN
    tbl_clientes ON tbl_clientes_veiculos.id_cliente = tbl_clientes.id_cliente
JOIN
    tbl_veiculos ON tbl_clientes_veiculos.id_veiculo = tbl_veiculos.id_veiculo
JOIN
    tbl_servicos_agendamentos ON tbl_agendamentos.id_agendamento = tbl_servicos_agendamentos.id_agendamento
JOIN
    tbl_servicos ON tbl_servicos_agendamentos.id_servico = tbl_servicos.id_servico;

    
SELECT * FROM vw_agendamentos_por_funcionario
WHERE nome_funcionario like  '%mu%';

drop view vw_agendamentos_por_funcionario;


-- filtra todos os agendamentos de uma data especifica
SELECT
    tbl_clientes.nome,
    tbl_clientes.email,
    tbl_clientes.telefone,
    tbl_veiculos.modelo,
    tbl_veiculos.marca,
    tbl_veiculos.ano,
    tbl_veiculos.placa,
    tbl_veiculos.cor,
    tbl_datas.datas,
    tbl_horas.horas
FROM
    tbl_clientes
JOIN
    tbl_clientes_veiculos ON tbl_clientes.id_cliente = tbl_clientes_veiculos.id_cliente
JOIN
    tbl_veiculos ON tbl_clientes_veiculos.id_veiculo = tbl_veiculos.id_veiculo
JOIN
    tbl_agendamentos ON tbl_clientes.id_cliente = tbl_agendamentos.id_cliente_veiculo
JOIN
    tbl_datas_horarios ON tbl_agendamentos.id_data_horario = tbl_datas_horarios.id_data_horario
JOIN
    tbl_datas ON tbl_datas_horarios.id_data = tbl_datas.id_data
JOIN
    tbl_horas ON tbl_datas_horarios.id_horario = tbl_horas.id_horario
WHERE
    tbl_datas.datas = '2024-02-10';
    
    -- Consultar todas as informações do veículo do cliente com email
SELECT
tbl_clientes.email,
    tbl_clientes.telefone,
    tbl_veiculos.modelo,
    tbl_veiculos.marca,
    tbl_veiculos.ano,
    tbl_veiculos.placa,
    tbl_veiculos.cor
FROM
    tbl_clientes
JOIN
    tbl_clientes_veiculos ON tbl_clientes.id_cliente = tbl_clientes_veiculos.id_cliente
JOIN
    tbl_veiculos ON tbl_clientes_veiculos.id_veiculo = tbl_veiculos.id_veiculo
WHERE
    tbl_clientes.email = 'gustavo@gmail.com';
    
    
    
    -- Consultar todas as informações de endereço do cliente
SELECT
    tc.nome,
    tc.email,
    tc.telefone,
    te.rua,
    te.cep,
    te.numero,
    te.complemento,
    te.bairro,
    te.estado,
    te.cidade
FROM 
    tbl_clientes as tc JOIN 
    tbl_enderecos as te ON tc.id_endereco = te.id_endereco 
WHERE 
    tc.id_cliente = '1';
    
  DELIMITER //

CREATE PROCEDURE inserir_funcionario_com_endereco (
    IN p_nome VARCHAR(100),
    IN p_email VARCHAR(150),
    IN p_senha VARCHAR(100),
    IN p_cargo VARCHAR(30),
    IN p_telefone VARCHAR(18),
    IN p_rua VARCHAR(45),
    IN p_cep FLOAT,
    IN p_numero FLOAT,
    IN p_complemento VARCHAR(100),
    IN p_bairro VARCHAR(150),
    IN p_estado VARCHAR(80),
    IN p_cidade VARCHAR(80)
)
BEGIN
    DECLARE v_id_endereco INT;

    -- Inserir o endereço
    INSERT INTO tbl_enderecos (rua, cep, numero, complemento, bairro, estado, cidade)
    VALUES (p_rua, p_cep, p_numero, p_complemento, p_bairro, p_estado, p_cidade);

    -- Obter o ID do endereço inserido
    SET v_id_endereco = LAST_INSERT_ID();

    -- Inserir o funcionário
    INSERT INTO tbl_funcionarios (nome, email, senha, cargo, telefone, id_endereco)
    VALUES (p_nome, p_email, p_senha, p_cargo, p_telefone, v_id_endereco);
END//

DELIMITER ;
	
CALL inserir_funcionario_com_endereco('Julia', 'julia@gmail', '1234', 'Lavador', '11980807794', 'rua sao mateus', '06332020', 
'260', 'torre 1 apto 154', 'vila ester', 'sao paulo', 'carapicuiba');


select tf.id_funcionario, tf.nome, te.id_endereco, te.rua, te.cep, te.numero, te.complemento, te.bairro, te.estado, te.cidade 
from tbl_funcionarios as tf 
join tbl_enderecos as te ON tf.id_endereco = te.id_endereco 
where tf.id_funcionario = 1;

DELIMITER //

CREATE PROCEDURE p_atualizar_funcionario_com_endereco (
	IN p_id_funcionario int,
    IN p_nome VARCHAR(100),
    IN p_email VARCHAR(150),
    IN p_senha VARCHAR(100),
    IN p_cargo VARCHAR(30),
    IN p_telefone VARCHAR(18),
    IN p_rua VARCHAR(45),
    IN p_cep FLOAT,
    IN p_numero FLOAT,
    IN p_complemento VARCHAR(100),
    IN p_bairro VARCHAR(150),
    IN p_estado VARCHAR(80),
    IN p_cidade VARCHAR(80)
)
BEGIN

SELECT id_endereco INTO v_id_endereco
    FROM tbl_funcionarios
    WHERE id_funcionario = p_id_funcionario;
  
    UPDATE tbl_enderecos
    SET
        rua = p_rua,
        cep = p_cep,
        numero = p_numero,
        complemento = p_complemento,
        bairro = p_bairro,
        estado = p_estado,
        cidade = p_cidade
    WHERE id_endereco = v_id_endereco;

    -- Atualizar o funcionário
    UPDATE tbl_funcionarios
    SET
        nome = p_nome,
        email = p_email,
        senha = p_senha,
        cargo = p_cargo,
        telefone = p_telefone,
        id_endereco = p_id_endereco
    WHERE id = 3;
END //

DELIMITER ;

CALL atualizar_funcionario_com_endereco(
    'João Atualizado',  
    'joao.atualizado@example.com',
    'nova_senha123',  
    'Desenvolvedor Senior', 
    '11999999998',  
    'Rua das Flores Atualizada',  
    12345.678, 
    123,  
    'Apto 45', 
    'Bairro Centro',
    'SP',  
    'São Paulo' 
); 



DELIMITER //

CREATE PROCEDURE deletar_funcionario_com_endereco (
    IN p_id_funcionario INT
)
BEGIN
    DECLARE v_id_endereco INT;

    -- Obter o ID do endereço associado ao funcionário
    SELECT id_endereco INTO v_id_endereco
    FROM tbl_funcionarios
    WHERE id_funcionario = p_id_funcionario;

    -- Deletar o funcionário
    DELETE FROM tbl_funcionarios
    WHERE id_funcionario = p_id_funcionario;

    -- Deletar o endereço, se não for associado a outros funcionários
    DELETE FROM tbl_enderecos
    WHERE id_endereco = v_id_endereco
    AND NOT EXISTS (SELECT 1 FROM tbl_funcionarios WHERE id_endereco = v_id_endereco);
END //

DELIMITER ;


DROP PROCEDURE IF EXISTS deletar_funcionario_com_endereco;

CALL deletar_funcionario_com_endereco(1);
