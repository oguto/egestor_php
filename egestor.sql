-- phpMyAdmin SQL Dump
-- version 4.9.5deb2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Tempo de geração: 19-Mar-2021 às 20:02
-- Versão do servidor: 8.0.23-0ubuntu0.20.04.1
-- versão do PHP: 7.1.33-24+ubuntu20.04.1+deb.sury.org+1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `egestor`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `ATIVIDADES`
--

CREATE TABLE `ATIVIDADES` (
  `id` int NOT NULL,
  `acesso` varchar(255) NOT NULL,
  `data` datetime NOT NULL,
  `exclusao` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `ATIVIDADES`
--

INSERT INTO `ATIVIDADES` (`id`, `acesso`, `data`, `exclusao`) VALUES
(1, 'teste', '2021-03-18 00:00:00', NULL),
(2, 'teste 3', '2021-03-18 00:00:00', NULL),
(3, 'teste 4', '2021-03-26 00:00:00', NULL),
(4, 'qefe', '2021-03-19 00:00:00', NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `DOCUMENTOS`
--

CREATE TABLE `DOCUMENTOS` (
  `id` int NOT NULL,
  `nome` varchar(255) NOT NULL,
  `id_pasta` int DEFAULT NULL,
  `data_inicial` date DEFAULT NULL,
  `data_final` date DEFAULT NULL,
  `palavras_chaves` text,
  `url` text,
  `exclusao` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `DOCUMENTOS`
--

INSERT INTO `DOCUMENTOS` (`id`, `nome`, `id_pasta`, `data_inicial`, `data_final`, `palavras_chaves`, `url`, `exclusao`) VALUES
(1, 's', NULL, '2021-03-19', '2021-03-19', 'ss', NULL, NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `GRUPO`
--

CREATE TABLE `GRUPO` (
  `id` int NOT NULL,
  `nome` varchar(255) NOT NULL,
  `exclusao` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `GRUPO`
--

INSERT INTO `GRUPO` (`id`, `nome`, `exclusao`) VALUES
(1, 'Grupo', '2021-03-18'),
(2, 'vaf', NULL),
(3, 'teee', NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `GRUPO_DOCUMENTO`
--

CREATE TABLE `GRUPO_DOCUMENTO` (
  `id` int NOT NULL,
  `id_grupo` int NOT NULL,
  `id_documento` int NOT NULL,
  `exclusao` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `GRUPO_USUARIO`
--

CREATE TABLE `GRUPO_USUARIO` (
  `id` int NOT NULL,
  `id_grupo` int NOT NULL,
  `id_usuario` int NOT NULL,
  `exclusao` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `PASTAS`
--

CREATE TABLE `PASTAS` (
  `id` int NOT NULL,
  `nome` varchar(255) NOT NULL,
  `exclusao` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `PASTAS`
--

INSERT INTO `PASTAS` (`id`, `nome`, `exclusao`) VALUES
(1, 'r', '2021-03-18'),
(2, 'x', NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `PERMISSOES`
--

CREATE TABLE `PERMISSOES` (
  `id` int NOT NULL,
  `nome` varchar(255) NOT NULL,
  `exclusao` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `PERMISSOES`
--

INSERT INTO `PERMISSOES` (`id`, `nome`, `exclusao`) VALUES
(1, 'Admin', NULL),
(2, 'Usuário', NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `USUARIOS`
--

CREATE TABLE `USUARIOS` (
  `id` int NOT NULL,
  `nome` varchar(255) NOT NULL,
  `senha` text NOT NULL,
  `telefone` varchar(45) NOT NULL,
  `email` varchar(255) NOT NULL,
  `id_permissao` int NOT NULL,
  `exclusao` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `USUARIOS`
--

INSERT INTO `USUARIOS` (`id`, `nome`, `senha`, `telefone`, `email`, `id_permissao`, `exclusao`) VALUES
(2, 'd', '123', 'd', 'd', 1, '0000-00-00'),
(3, 'Guto', '123', '123', '123', 2, '0000-00-00'),
(4, 'dd', 'd', 'd', 'd', 2, '0000-00-00');

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `ATIVIDADES`
--
ALTER TABLE `ATIVIDADES`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `DOCUMENTOS`
--
ALTER TABLE `DOCUMENTOS`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_DOCUMENTOS_1_idx` (`id_pasta`);

--
-- Índices para tabela `GRUPO`
--
ALTER TABLE `GRUPO`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `GRUPO_DOCUMENTO`
--
ALTER TABLE `GRUPO_DOCUMENTO`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_GRUPO_USUARIO_2_idx` (`id_grupo`),
  ADD KEY `fk_GRUPO_USUARIO_10_idx` (`id_documento`);

--
-- Índices para tabela `GRUPO_USUARIO`
--
ALTER TABLE `GRUPO_USUARIO`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_GRUPO_USUARIO_1_idx` (`id_usuario`),
  ADD KEY `fk_GRUPO_USUARIO_2_idx` (`id_grupo`);

--
-- Índices para tabela `PASTAS`
--
ALTER TABLE `PASTAS`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `PERMISSOES`
--
ALTER TABLE `PERMISSOES`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `USUARIOS`
--
ALTER TABLE `USUARIOS`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_USUARIOS_1_idx` (`id_permissao`);

--
-- AUTO_INCREMENT de tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `ATIVIDADES`
--
ALTER TABLE `ATIVIDADES`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de tabela `DOCUMENTOS`
--
ALTER TABLE `DOCUMENTOS`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `GRUPO`
--
ALTER TABLE `GRUPO`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de tabela `GRUPO_DOCUMENTO`
--
ALTER TABLE `GRUPO_DOCUMENTO`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `GRUPO_USUARIO`
--
ALTER TABLE `GRUPO_USUARIO`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `PASTAS`
--
ALTER TABLE `PASTAS`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `PERMISSOES`
--
ALTER TABLE `PERMISSOES`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `USUARIOS`
--
ALTER TABLE `USUARIOS`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Restrições para despejos de tabelas
--

--
-- Limitadores para a tabela `DOCUMENTOS`
--
ALTER TABLE `DOCUMENTOS`
  ADD CONSTRAINT `fk_DOCUMENTOS_1` FOREIGN KEY (`id_pasta`) REFERENCES `PASTAS` (`id`);

--
-- Limitadores para a tabela `GRUPO_DOCUMENTO`
--
ALTER TABLE `GRUPO_DOCUMENTO`
  ADD CONSTRAINT `fk_GRUPO_USUARIO_10` FOREIGN KEY (`id_documento`) REFERENCES `DOCUMENTOS` (`id`),
  ADD CONSTRAINT `fk_GRUPO_USUARIO_20` FOREIGN KEY (`id_grupo`) REFERENCES `GRUPO` (`id`);

--
-- Limitadores para a tabela `GRUPO_USUARIO`
--
ALTER TABLE `GRUPO_USUARIO`
  ADD CONSTRAINT `fk_GRUPO_USUARIO_1` FOREIGN KEY (`id_usuario`) REFERENCES `USUARIOS` (`id`),
  ADD CONSTRAINT `fk_GRUPO_USUARIO_2` FOREIGN KEY (`id_grupo`) REFERENCES `GRUPO` (`id`);

--
-- Limitadores para a tabela `USUARIOS`
--
ALTER TABLE `USUARIOS`
  ADD CONSTRAINT `fk_USUARIOS_1` FOREIGN KEY (`id_permissao`) REFERENCES `PERMISSOES` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
