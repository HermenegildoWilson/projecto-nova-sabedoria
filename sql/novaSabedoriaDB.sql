create database novaSabedoriaDB
default character set utf8
default collate utf8_general_ci;

use novaSabedoriaDB;

CREATE TABLE Funcao (
    idFuncao integer(4) PRIMARY KEY auto_increment not null,
    nomeFuncao VARCHAR(40) not null unique,
    descricao VARCHAR(255)
)default charset utf8;

CREATE TABLE Plano (
    idPlano integer(4) PRIMARY KEY auto_increment not null ,
    nome VARCHAR(30)  not null unique,
    tipoPlano enum('Flex', 'Fixo') not null,
    descricao VARCHAR(255)
)default charset utf8;

CREATE TABLE Turma (
    idTurma integer(4) PRIMARY KEY auto_increment not null ,
    nomeTurma VARCHAR(30) not null unique,
    horario time,
    vagas INTEGER(4) not null,
    sala INTEGER(4) not null,
    periodo enum('Manhã', 'Tarde') not null
)default charset utf8;

CREATE TABLE Encarregado (
    idEncarregado INTEGER(4) PRIMARY KEY auto_increment not null,
    nome VARCHAR(40) not null,
    sobreNome VARCHAR(40) not null,
    contacto VARCHAR(40) not null,
    endereco VARCHAR(40) default 'Uíge',
    email VARCHAR(80) unique
)default charset utf8;

CREATE TABLE Aluno (
    idAluno INTEGER(4) PRIMARY KEY auto_increment not null,
    nome VARCHAR(40) not null,
    sobreNome VARCHAR(40) not null,
    dataNascimento DATE not null,
    sexo enum('Masculino', 'Feminino'),
    fotoUrl VARCHAR(255) unique,
    encarregadoId INTEGER(4) not null,
    
    foreign key(encarregadoId) references Encarregado(idEncarregado)
)default charset utf8;

CREATE TABLE Departamento(
    idDepartamento INTEGER (4) PRIMARY KEY auto_increment not null,
    nome VARCHAR(30) not null unique,
    descricao VARCHAR(255)
)default charset utf8;

CREATE TABLE Funcionario (
    idFuncionario INTEGER(4) PRIMARY KEY auto_increment not null,
    nome VARCHAR(40) not null,
    sobreNome VARCHAR(40) not null,
    dataNascimento DATE not null,
    contacto VARCHAR(40) not null,
    email VARCHAR(40) not null unique,
    bi varchar(40) not null unique,
    endereco VARCHAR(40) default 'Uíge',
    dataCadastro timestamp default current_timestamp,
    departamentoId INTEGER(4) not null,
    funcaoId INTEGER(4),
    
    foreign key(departamentoId) references Departamento(idDepartamento),
    foreign key(funcaoId) references Funcao(idFuncao)
)default charset utf8;

CREATE TABLE Salario (
    idSalario INTEGER(4) PRIMARY KEY auto_increment not null,
    mesCorrespondente INTEGER(4) not null,
    anoLectivo year not null,
    dataPagmento timestamp default current_timestamp,
    estado enum('Pago', 'Atrasado'),
    salarioBruto decimal(10,2) not null,
    
    funcionarioPagoId INTEGER(4) not null,
    
    foreign key(funcionarioPagoId) references Funcionario(idFuncionario),
    unique(mesCorrespondente, anoLectivo)
)default charset utf8;

CREATE TABLE Mensalidade (
    idMensalidade INTEGER(4) PRIMARY KEY auto_increment not null,
    mesCorrespondente INTEGER(4) not null,
    anoLectivo year not null,
    dataPagamento timestamp default current_timestamp,
    valorMensal decimal(10,2) not null,
    estado enum('Pago', 'Atrasado', 'Aberto'),
    dataVencimento DATE,
    
    alunoId INTEGER(4),
    
    foreign key(alunoId) references Aluno(idAluno),
    unique(mesCorrespondente, anoLectivo)
)default charset utf8;

CREATE TABLE Disciplina (
    idDisciplina INTEGER(4) PRIMARY KEY auto_increment not null,
    nome VARCHAR(40) not null unique,
    preco decimal(8,2) not null,
    descricao VARCHAR(255),
    planoId INTEGER(4) not null,
    
    foreign key(planoId) references Plano(idPlano)
)default charset utf8;

CREATE TABLE Lecionar (
    id INTEGER(4) PRIMARY KEY auto_increment not null,
    
    funcionarioId INTEGER(4) not null,
    disciplinaId INTEGER(4) not null,
    
    foreign key(disciplinaId) references Disciplina(idDisciplina),
    foreign key(funcionarioId) references Funcionario(idFuncionario)
)default charset utf8;

CREATE TABLE Matricula (
    idMatricula INTEGER(4) PRIMARY KEY auto_increment not null,
    valorMatricula decimal(8,2) not null,
    anoLectivo year not null,
    dataMatricula timestamp default current_timestamp,
    
    turmaId INTEGER(4) not null,
    alunoId INTEGER(4) not null,
    disciplinaId INTEGER(4) not null,
    planoId INTEGER(4) not null,
    funcionarioResponsavelId INTEGER(4) not null,
    
	foreign key(turmaId) references Turma(idTurma),
    foreign key(planoId) references Plano(idPlano),
    foreign key(alunoId) references Aluno(idAluno),
    foreign key(disciplinaId) references Disciplina(idDisciplina),
    foreign key(funcionarioResponsavelId) references Funcionario (idFuncionario),
    
    unique(alunoId, disciplinaId)
)default charset utf8;

CREATE TABLE Nota (
    idNota INTEGER(4) PRIMARY KEY auto_increment not null,
    anoLectivo year not null,
    valorNota decimal(4,2),
    tipoNota enum ('Primeira Prova', 'Segunda Prova', 'Terceira Prova', 'Exame'),
    trimestre enum('I Trimestre', 'II Trimestre', 'III Trimestre'),
    dataLancamento timestamp default current_timestamp,
    
    alunoId INTEGER(4) not null,
    disciplinaId INTEGER(4) not null,
    planoId INTEGER(4) not null,
    
    foreign key(planoId) references Plano(idPlano),
    foreign key(alunoId) references Aluno(idAluno),
    foreign key(disciplinaId) references Disciplina(idDisciplina),
    
    unique(trimestre, tipoNota)
) default charset utf8;

CREATE TABLE HistoricoPlano (
    idHistorico INTEGER(4) PRIMARY KEY auto_increment not null,
    dataInicio DATE not null,
    dataFim DATE not null,
    
    notaId INTEGER(4) not null,
    foreign key(notaId) references Nota(idNota)
)default charset utf8;

CREATE TABLE OutrasReceitas (
    idOutrasReceita INTEGER(4) PRIMARY KEY auto_increment not null,
    dataPagamento timestamp default current_timestamp,
    valor decimal(8,2) not null,
    descricao VARCHAR(255)
)default charset utf8;

CREATE TABLE Receita (
    idReceita  INTEGER(4) PRIMARY KEY auto_increment not null,
    tipoReceita enum('Mensalidade', 'Matricula', 'OutrasReceitas') not null,
    descricaoReceita VARCHAR(40),
    
    matriculaId integer(4),
    mensalidadeId integer(4),
    outrasReceitasId integer(4),
    funcionarioResponsavelId integer(4),
    
    foreign key(matriculaId) references Matricula(idMatricula),
    foreign key(mensalidadeId) references Mensalidade(idMensalidade),
    foreign key(outrasReceitasId) references OutrasReceitas(idOutrasReceita),
	foreign key(funcionarioResponsavelId) references Funcionario(idFuncionario)

)default charset utf8;

CREATE TABLE OutrasDispesas (
    idOutrasDispesa INTEGER(4) PRIMARY KEY auto_increment not null,
    dataPagamento timestamp default current_timestamp,
    valor decimal(8,2) not null,
    descricao VARCHAR(255)
)default charset utf8;

CREATE TABLE Dispesa (
    idDispesa INTEGER PRIMARY KEY,
    descricao VARCHAR(40),
    tipoDispesa VARCHAR(40),
    salarioId INTEGER(4),
    
    outrasDispesaId INTEGER(4),
    funcionarioResponsavelId INTEGER(4),
    
    foreign key(salarioId) references Salario(idSalario),
    foreign key(outrasDispesaId) references OutrasDispesas(idOutrasDispesa),
    foreign key(funcionarioResponsavelId) references Funcionario(idFuncionario)
)default charset utf8;

CREATE TABLE ContaFuncionario(
    idUsuario INTEGER(4) PRIMARY KEY auto_increment not null,
    nomeUsuario VARCHAR(30),
    senhaUsuario VARCHAR(30),
    estadoConta enum('ativo','inativo'),
    ultimoAcesso DATE,
    
    tipoUsuario INTEGER(4),
    funcionarioId INTEGER(4),

    foreign key(funcionarioId) references Funcionario(idFuncionario),
    foreign key(tipoUsuario) references Funcao(idFuncao)

)default charset utf8;

CREATE TABLE ContaAluno (
    idAluno INTEGER(4) PRIMARY KEY auto_increment not null,
    nomeAluno VARCHAR(30),
    senhaAluno VARCHAR(30),
    estadoConta enum('ativo','inativo'),
    ultimoAcesso DATE,
    
    tipoUsuario INTEGER(4),
	alunoId INTEGER(4),

    foreign key(tipoUsuario) references Funcao(idFuncao),
	foreign key(alunoId) references Aluno(idAluno)

)default charset utf8;

CREATE TABLE notificacao (
  idNotificacao  INTEGER(4) PRIMARY KEY auto_increment not null,
  titulo VARCHAR(100),
  mensagem TEXT,
  dataEnvio date default current_timestamp,
  lida BOOLEAN DEFAULT FALSE,
  destinatario INTEGER(4),
  
  funcaoId integer(4),
  foreign key(funcaoId) references Funcao(idFuncao)

)default charset utf8;
