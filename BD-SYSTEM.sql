-- drop database bd_sistema_info;
create database if not exists bd_sistema_info;
use bd_sistema_info;

create table usuario (
   id_usuario int primary key auto_increment,
   nome varchar(60) not null,
   CPF char (11) not null unique,
   email varchar(100) not null unique,
   senha varchar(50) not null unique,
   tipo_usuario enum('aluno','professor','funcionario','cliente') not null
);

create table agenda (
   id_agenda int primary key auto_increment,
   data_ag date not null,
   horario time not null,
   descricao varchar(150),
   idusuario int not null
);

create table marcacao_calendario (
   id_marcacao_calendario int primary key  auto_increment,
   data_mc date not null,
   descricao varchar(150),
   isusuario int not null
);

create table turma (
   id_turma int primary key auto_increment,
   nometurma varchar(50),
   ano char(4),
   semestre varchar(2)
);

create table disciplina (
   id_disciplina int primary key auto_increment,
   nome_disciplina varchar(50) not null,
   idturma varchar(10)
);

create table avisos (
   id_avisos int primary key auto_increment,
   conteudo_av varchar(100) not null,
   data_av date not null,
   iddisciplina varchar(45) not null
);

create table aula (
   id_aula int primary key auto_increment,
   titulo varchar(100) not null,
   data_aula date not null,
   descricao varchar(100) not null,
   iddisciplina varchar(45) not null
);

create table nota (
   id_nota int primary key auto_increment,
   idusuario_nota int not null,
   id_trabalho int not null,
   pontuacao float
);


create table trabalho (
   id_trabalho int primary key auto_increment,
   id_t_nota int not null,
   titulo varchar(45)not null,
   data_entrega date not null,
   descricao varchar(150),
   iddisciplina int not null,
   constraint fk_tn_nota foreign key (id_t_nota) references nota(id_nota)
);

create table forum (
   id_forum int primary key auto_increment,
   id_disciplina int not null,
   titulo varchar(45),
   data_f date
);

create table postagem_forum (
   id_postagem int primary key auto_increment,
   data_pf date not null,
   conteudo varchar(150),
   codigo_postagem varchar(50) not null
);

create table suporte (
   id_suporte int primary key auto_increment,
   data_sup date not null,
   titulo_sup varchar(50) not null,
   descricao_sup varchar(150) not null,
   codigo_suporte varchar(50) not null,
   solucao varchar(150)
);

create table solicitacao_suporte (
   id_s_suporte int primary key auto_increment,
   id_ss_suporte int not null,
   data_s_sup date not null,
   descricao varchar(150),
   idusuario int not null,
   codigo_suporte varchar(50) not null,
   solucao varchar(150),
   constraint fk_ss_suporte foreign key (id_ss_suporte) references suporte(id_suporte)
);

create table avaliacao (
id_avaliacao int primary key auto_increment,
id_av_nota int not null,
data_av date not null,
titulo_ava varchar(50) not null,
descricao varchar(150)not null,
codigo_avaliacao varchar(50) not null unique,
constraint fk_av_nota foreign key (id_av_nota) references nota(id_nota)
);

-- FKS

create table usuario_agenda (
id_ua_agenda int,
id_ua_usuario int,
constraint fk_ua_agenda foreign key (id_ua_agenda) references agenda(id_agenda),
constraint fk_ua_usuario foreign key (id_ua_usuario) references usuario(id_usuario)
);

create table usuario_suporte (
id_us_suporte int,
id_us_usuario int,
constraint fk_us_suporte foreign key (id_us_suporte) references suporte(id_suporte),
constraint fk_us_usuario foreign key (id_us_usuario) references usuario(id_usuario)
);

create table usuario_turma (
id_ut_turma int,
id_ut_usuario int,
constraint fk_ut_turma foreign key (id_ut_turma) references turma(id_turma),
constraint fk_ut_usuario foreign key (id_ut_usuario) references usuario(id_usuario)
);

create table usuario_nota (
id_un_nota int,
id_un_usuario int,
constraint fk_un_turma foreign key (id_un_nota) references nota(id_nota),
constraint fk_un_usuario foreign key (id_un_usuario) references usuario(id_usuario)
);

create table agenda_calendario (
id_ac_cal int,
id_ac_agenda int,
constraint fk_ac_cal foreign key (id_ac_cal) references marcacao_calendario(id_marcacao_calendario),
constraint fk_ac_agenda foreign key (id_ac_agenda) references agenda(id_agenda)
);

create table turma_disciplina (
id_td_disciplina int,
id_td_turma int,
constraint fk_td_diciplina foreign key (id_td_disciplina) references disciplina(id_disciplina),
constraint fk_td_turma foreign key (id_td_turma) references turma(id_turma)
);

create table avisos_disciplina (
id_ad_disciplina int,
id_ad_avisos int,
constraint fk_ad_disciplina foreign key (id_ad_disciplina) references disciplina(id_disciplina),
constraint fk_ad_avisos foreign key (id_ad_avisos) references avisos(id_avisos)
);

create table forum_disciplina (
id_fd_disciplina int,
id_fd_forum int,
constraint fk_fd_disciplina foreign key (id_fd_disciplina) references disciplina(id_disciplina),
constraint fk_fd_forum foreign key (id_fd_forum) references forum(id_forum)
);

create table aula_disciplina (
id_aud_disciplina int,
id_aud_aula int,
constraint fk_aud_disciplina foreign key (id_aud_disciplina) references disciplina(id_disciplina),
constraint fk_aud_forum foreign key (id_aud_aula) references aula(id_aula)
);

create table avaliacao_disciplina (
id_avd_disciplina int,
id_avd_av int,
constraint fk_avd_disciplina foreign key (id_avd_disciplina) references disciplina(id_disciplina),
constraint fk_avd_forum foreign key (id_avd_av) references avaliacao(id_avaliacao)
);

create table trabalho_disciplina (
id_trd_disciplina int,
id_trd_av int,
constraint fk_trd_disciplina foreign key (id_trd_disciplina) references disciplina(id_disciplina),
constraint fk_trd_forum foreign key (id_trd_av) references trabalho(id_trabalho)
);

create table forum_post_forum (
id_fpf_forum int,
id_fpf_pforum int,
constraint fk_fpf_forum foreign key (id_fpf_forum) references forum(id_forum),
constraint fk_fpf_pforum foreign key (id_fpf_pforum) references postagem_forum(id_postagem)
);
