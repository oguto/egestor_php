-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: db
-- Tempo de geração: 12-Abr-2021 às 23:03
-- Versão do servidor: 5.7.33
-- versão do PHP: 7.4.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
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
-- Estrutura da tabela `aauth_groups`
--

CREATE TABLE `aauth_groups` (
  `id` int(11) UNSIGNED NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `definition` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `aauth_groups`
--

INSERT INTO `aauth_groups` (`id`, `name`, `definition`) VALUES
(1, 'Admin', 'Super Admin Group'),
(2, 'Public', 'Public Access Group'),
(3, 'Default', 'Default Access Group');

-- --------------------------------------------------------

--
-- Estrutura da tabela `aauth_group_to_group`
--

CREATE TABLE `aauth_group_to_group` (
  `group_id` int(11) UNSIGNED NOT NULL,
  `subgroup_id` int(11) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `aauth_login_attempts`
--

CREATE TABLE `aauth_login_attempts` (
  `id` int(11) NOT NULL,
  `ip_address` varchar(39) DEFAULT '0',
  `timestamp` datetime DEFAULT NULL,
  `login_attempts` tinyint(2) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `aauth_login_attempts`
--

INSERT INTO `aauth_login_attempts` (`id`, `ip_address`, `timestamp`, `login_attempts`) VALUES
(1, '172.18.0.1', '2021-04-02 21:54:06', 12),
(18, '172.18.0.1', '2021-04-03 23:45:07', 2),
(20, '172.18.0.1', '2021-04-08 03:39:05', 1),
(32, '172.18.0.1', '2021-04-10 19:08:37', 1),
(33, '172.18.0.1', '2021-04-10 19:50:54', 2),
(50, '172.18.0.1', '2021-04-12 15:45:57', 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `aauth_perms`
--

CREATE TABLE `aauth_perms` (
  `id` int(11) UNSIGNED NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `definition` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `aauth_perm_to_group`
--

CREATE TABLE `aauth_perm_to_group` (
  `perm_id` int(11) UNSIGNED NOT NULL,
  `group_id` int(11) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `aauth_perm_to_user`
--

CREATE TABLE `aauth_perm_to_user` (
  `perm_id` int(11) UNSIGNED NOT NULL,
  `user_id` int(11) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `aauth_pms`
--

CREATE TABLE `aauth_pms` (
  `id` int(11) UNSIGNED NOT NULL,
  `sender_id` int(11) UNSIGNED NOT NULL,
  `receiver_id` int(11) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `message` text,
  `date_sent` datetime DEFAULT NULL,
  `date_read` datetime DEFAULT NULL,
  `pm_deleted_sender` int(1) DEFAULT NULL,
  `pm_deleted_receiver` int(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `aauth_users`
--

CREATE TABLE `aauth_users` (
  `id` int(11) UNSIGNED NOT NULL,
  `email` varchar(100) NOT NULL,
  `pass` varchar(64) NOT NULL,
  `username` varchar(100) DEFAULT NULL,
  `banned` tinyint(1) DEFAULT '0',
  `last_login` datetime DEFAULT NULL,
  `last_activity` datetime DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `forgot_exp` text,
  `remember_time` datetime DEFAULT NULL,
  `remember_exp` text,
  `verification_code` text,
  `totp_secret` varchar(16) DEFAULT NULL,
  `ip_address` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `aauth_users`
--

INSERT INTO `aauth_users` (`id`, `email`, `pass`, `username`, `banned`, `last_login`, `last_activity`, `date_created`, `forgot_exp`, `remember_time`, `remember_exp`, `verification_code`, `totp_secret`, `ip_address`) VALUES
(1, 'admin@example.com', 'dd5073c93fb477a167fd69072e95455834acd93df8fed41a2c468c45b394bfe3', 'Admin', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0'),
(3, 'guto.nelos@gmail.com', '4e4cdff9436d4b9797eeb35d6965e73bd0bd9d5dc939ab2c190a179cf8df960d', 'Gustavo', 0, '2021-04-12 20:58:34', '2021-04-12 20:58:34', '2021-04-02 21:58:48', NULL, NULL, NULL, NULL, NULL, '172.18.0.1'),
(4, 'user@example.com', '993292c80ab00a8e79dd3e951850f99587e60063714194b882c90bdda3b63492', 'gt', 0, '2021-04-12 04:16:11', '2021-04-12 04:16:11', '2021-04-12 04:08:52', NULL, NULL, NULL, NULL, NULL, '172.18.0.1');

-- --------------------------------------------------------

--
-- Estrutura da tabela `aauth_user_to_group`
--

CREATE TABLE `aauth_user_to_group` (
  `user_id` int(11) UNSIGNED NOT NULL,
  `group_id` int(11) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `aauth_user_to_group`
--

INSERT INTO `aauth_user_to_group` (`user_id`, `group_id`) VALUES
(1, 1),
(1, 3),
(2, 3),
(3, 3),
(4, 3);

-- --------------------------------------------------------

--
-- Estrutura da tabela `aauth_user_variables`
--

CREATE TABLE `aauth_user_variables` (
  `id` int(11) UNSIGNED NOT NULL,
  `user_id` int(11) UNSIGNED NOT NULL,
  `data_key` varchar(100) NOT NULL,
  `value` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `ATIVIDADES`
--

CREATE TABLE `ATIVIDADES` (
  `id` int(11) NOT NULL,
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
(4, 'qefe', '2021-03-19 00:00:00', NULL),
(5, 'Gustavo visualizou o arquivo 26128865.jpg.', '2021-04-10 03:55:55', NULL),
(6, 'Gustavo editou o arquivo .', '2021-04-10 05:51:17', NULL),
(7, 'Gustavo editou o arquivo teste.', '2021-04-10 05:51:40', NULL),
(8, 'Gustavo visualizou o arquivo teste.', '2021-04-10 05:53:41', NULL),
(9, 'Gustavo visualizou o arquivo AngularJS_na_pratica_PT-BR.pdf.', '2021-04-10 05:54:15', NULL),
(10, 'Gustavo visualizou o arquivo <b>Nº 69</b>.', '2021-04-10 05:55:08', NULL),
(11, 'Gustavo visualizou o arquivo Nº 70.', '2021-04-10 05:55:41', NULL),
(12, 'Gustavo criou o arquivo null.', '2021-04-10 05:58:41', NULL),
(13, 'Gustavo criou o arquivo undefined.', '2021-04-10 06:00:19', NULL),
(14, 'Gustavo criou o arquivo 87.', '2021-04-10 06:01:42', NULL),
(15, 'Gustavo criou o arquivo 88.', '2021-04-10 06:02:47', NULL),
(16, 'Gustavo criou o arquivo Nº89.', '2021-04-10 06:04:08', NULL),
(17, 'Gustavo criou o arquivo Nº90.', '2021-04-10 06:04:08', NULL),
(18, 'Gustavo criou o arquivo Nº91.', '2021-04-10 06:04:08', NULL),
(19, 'Gustavo criou o arquivo Nº92.', '2021-04-10 06:04:08', NULL),
(20, 'Gustavo criou o arquivo Nº93.', '2021-04-10 06:04:08', NULL),
(21, 'Gustavo visualizou o arquivo Nº 90.', '2021-04-10 06:05:25', NULL),
(22, 'Gustavo visualizou o arquivo Nº 91.', '2021-04-10 06:05:30', NULL),
(23, 'Gustavo visualizou o arquivo Nº 86.', '2021-04-10 06:05:36', NULL),
(24, 'Gustavo visualizou o arquivo Nº 70.', '2021-04-10 06:07:39', NULL),
(25, 'Gustavo visualizou o arquivo Nº 77.', '2021-04-11 04:30:59', NULL),
(26, 'Gustavo visualizou o arquivo Nº 70.', '2021-04-11 04:54:18', NULL),
(27, 'Gustavo visualizou o arquivo Nº 87.', '2021-04-11 04:54:27', NULL),
(28, 'Gustavo visualizou o arquivo Nº 70.', '2021-04-11 04:54:46', NULL),
(29, 'Gustavo visualizou o arquivo Nº 92.', '2021-04-11 04:55:06', NULL),
(30, 'Gustavo visualizou o arquivo Nº 70.', '2021-04-11 10:21:22', NULL),
(31, 'Gustavo visualizou o arquivo Nº 70.', '2021-04-11 10:21:38', NULL),
(32, 'Gustavo visualizou o arquivo Nº 75.', '2021-04-11 10:21:46', NULL),
(33, 'Gustavo enviou o arquivo Nº94.', '2021-04-11 10:37:12', NULL),
(34, 'Gustavo enviou o arquivo Nº95.', '2021-04-11 10:37:12', NULL),
(35, 'Gustavo editou o arquivo Nº 95.', '2021-04-11 10:37:52', NULL),
(36, 'Gustavo enviou o arquivo Nº1.', '2021-04-12 03:42:02', NULL),
(37, 'Gustavo enviou o arquivo Nº2.', '2021-04-12 03:43:31', NULL),
(38, 'Gustavo editou o arquivo Nº 2.', '2021-04-12 03:46:12', NULL),
(39, 'gt enviou o arquivo Nº3.', '2021-04-12 04:10:25', NULL),
(40, 'gt visualizou o arquivo Nº 3.', '2021-04-12 04:25:49', NULL),
(41, 'gt visualizou o arquivo Nº 2.', '2021-04-12 04:25:52', NULL),
(42, 'gt editou o arquivo Nº 2.', '2021-04-12 04:25:59', NULL),
(43, 'gt editou o arquivo Nº 3.', '2021-04-12 04:26:13', NULL),
(44, 'gt visualizou o arquivo Nº 2.', '2021-04-12 04:26:54', NULL),
(45, 'Gustavo visualizou o arquivo Nº 3.', '2021-04-12 07:00:46', NULL),
(46, 'Gustavo visualizou o arquivo Nº 2.', '2021-04-12 07:01:00', NULL),
(47, 'Gustavo visualizou o arquivo Nº 3.', '2021-04-12 07:01:04', NULL),
(48, 'Gustavo visualizou o arquivo Nº 3.', '2021-04-12 07:02:37', NULL),
(49, 'Gustavo visualizou o arquivo Nº 3.', '2021-04-12 07:03:43', NULL),
(50, 'Gustavo editou o arquivo Nº 3.', '2021-04-12 07:04:43', NULL),
(51, 'Gustavo editou o arquivo Nº 3.', '2021-04-12 07:04:56', NULL),
(52, 'Gustavo visualizou o arquivo Nº 3.', '2021-04-12 07:05:00', NULL),
(53, 'Gustavo visualizou o arquivo Nº 3.', '2021-04-12 07:07:56', NULL),
(54, 'Gustavo visualizou o arquivo Nº 3.', '2021-04-12 07:10:11', NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `ci_sessions`
--

CREATE TABLE `ci_sessions` (
  `id` varchar(40) NOT NULL,
  `ip_address` varchar(45) NOT NULL,
  `timestamp` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `data` blob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `ci_sessions`
--

INSERT INTO `ci_sessions` (`id`, `ip_address`, `timestamp`, `data`) VALUES
('180e246eac7016e1a20acd7e9d089b3a3db71b14', '172.18.0.1', 1618256111, 0x5f5f63695f6c6173745f726567656e65726174657c693a313631383235363131313b),
('2a53b60daac6eb94d49ba1ac65bf7be0ba0b064a', '172.18.0.1', 1618255469, 0x5f5f63695f6c6173745f726567656e65726174657c693a313631383235353436393b),
('2d15bc0232cbb95d6390c7eda07aabe4d6a2ca25', '172.18.0.1', 1618256109, 0x5f5f63695f6c6173745f726567656e65726174657c693a313631383235353935323b69647c733a313a2233223b757365726e616d657c733a373a224775737461766f223b656d61696c7c733a32303a226775746f2e6e656c6f7340676d61696c2e636f6d223b6c6f67676564696e7c623a313b),
('36d598160233129e3112836ee50a3a8010ba4a73', '172.18.0.1', 1618261104, 0x5f5f63695f6c6173745f726567656e65726174657c693a313631383236313130343b),
('51337f65725c15d45feb397cada3cfbdb062df0b', '172.18.0.1', 1618256111, 0x5f5f63695f6c6173745f726567656e65726174657c693a313631383235363131313b),
('52e67b9dc5ad8e1d511abebbf151926b7248332a', '172.18.0.1', 1618260800, 0x5f5f63695f6c6173745f726567656e65726174657c693a313631383236303830303b),
('55878de697cc57812e30baff273cf458b9155391', '172.18.0.1', 1618254007, 0x5f5f63695f6c6173745f726567656e65726174657c693a313631383235343030373b69647c733a313a2233223b757365726e616d657c733a373a224775737461766f223b656d61696c7c733a32303a226775746f2e6e656c6f7340676d61696c2e636f6d223b6c6f67676564696e7c623a313b),
('5928b004a3c3ae24fd824e8a37ab400560f3012e', '172.18.0.1', 1618262584, 0x5f5f63695f6c6173745f726567656e65726174657c693a313631383236323538343b69647c733a313a2233223b757365726e616d657c733a373a224775737461766f223b656d61696c7c733a32303a226775746f2e6e656c6f7340676d61696c2e636f6d223b6c6f67676564696e7c623a313b),
('594c5786b29831c22c8b1c925cc85b9834155301', '172.18.0.1', 1618260482, 0x5f5f63695f6c6173745f726567656e65726174657c693a313631383236303438323b),
('5b47cb75f1e00f0cae8fa56528a1599cbee78e74', '172.18.0.1', 1618255948, 0x5f5f63695f6c6173745f726567656e65726174657c693a313631383235353739323b69647c733a313a2233223b757365726e616d657c733a373a224775737461766f223b656d61696c7c733a32303a226775746f2e6e656c6f7340676d61696c2e636f6d223b6c6f67676564696e7c623a313b),
('7de4f76a62fd89bb977472296fc5b012a17bc4d7', '172.18.0.1', 1618259187, 0x5f5f63695f6c6173745f726567656e65726174657c693a313631383235393032363b),
('7f0423146b20525bdeb7cabf5c7cf6832b03f0ac', '172.18.0.1', 1618255953, 0x5f5f63695f6c6173745f726567656e65726174657c693a313631383235353935323b),
('875af464d5c437b1908daf1bfa4e7769c2627414', '172.18.0.1', 1618255191, 0x5f5f63695f6c6173745f726567656e65726174657c693a313631383235353139313b),
('8b27a87c6bd08a12728b0488cf132b6c6baf9556', '172.18.0.1', 1618254694, 0x5f5f63695f6c6173745f726567656e65726174657c693a313631383235343639343b69647c733a313a2233223b757365726e616d657c733a373a224775737461766f223b656d61696c7c733a32303a226775746f2e6e656c6f7340676d61696c2e636f6d223b6c6f67676564696e7c623a313b),
('8d9793c5dab7e6d2de3036a65a54690ead72fc5b', '172.18.0.1', 1618255469, 0x5f5f63695f6c6173745f726567656e65726174657c693a313631383235353436393b),
('93e23b8b1c61b8654175a60e8c9c823d10d2c180', '172.18.0.1', 1618256111, 0x5f5f63695f6c6173745f726567656e65726174657c693a313631383235363131313b),
('97e0afa5ab4c1f5a5191eb4095bab9e6191cac17', '172.18.0.1', 1618255191, 0x5f5f63695f6c6173745f726567656e65726174657c693a313631383235353139313b),
('9923aa30e7afb97b69bfbcbd6ff622866891a5de', '172.18.0.1', 1618256111, 0x5f5f63695f6c6173745f726567656e65726174657c693a313631383235363131313b),
('a678f62b81a13d6e6f7808e9886f4521eea94cbb', '172.18.0.1', 1618255469, 0x5f5f63695f6c6173745f726567656e65726174657c693a313631383235353436393b),
('ac42a6ae8a6b0701b4c0a2d35dbd8abdf60d9d91', '172.18.0.1', 1618259728, 0x5f5f63695f6c6173745f726567656e65726174657c693a313631383235393732383b),
('b1a9c2f8e87087216c57792bbe4ba277d4cfbcc4', '172.18.0.1', 1618255191, 0x5f5f63695f6c6173745f726567656e65726174657c693a313631383235353139313b),
('b92c2e4ef5d90af88db9b6b67556eb3bbd4fd3d9', '172.18.0.1', 1618255792, 0x5f5f63695f6c6173745f726567656e65726174657c693a313631383235353739323b69647c733a313a2233223b757365726e616d657c733a373a224775737461766f223b656d61696c7c733a32303a226775746f2e6e656c6f7340676d61696c2e636f6d223b6c6f67676564696e7c623a313b),
('bc0beedc9ec2f7a6d67e681268d4377aaaeaf50c', '172.18.0.1', 1618255053, 0x5f5f63695f6c6173745f726567656e65726174657c693a313631383235353035333b69647c733a313a2233223b757365726e616d657c733a373a224775737461766f223b656d61696c7c733a32303a226775746f2e6e656c6f7340676d61696c2e636f6d223b6c6f67676564696e7c623a313b),
('c72666320ef552cf28d804bf4dd53857b9939721', '172.18.0.1', 1618256414, 0x5f5f63695f6c6173745f726567656e65726174657c693a313631383235363431343b69647c733a313a2233223b757365726e616d657c733a373a224775737461766f223b656d61696c7c733a32303a226775746f2e6e656c6f7340676d61696c2e636f6d223b6c6f67676564696e7c623a313b),
('c83541b1e5d8f4176be0e29ac89b4682a1f67d81', '172.18.0.1', 1618254392, 0x5f5f63695f6c6173745f726567656e65726174657c693a313631383235343339323b69647c733a313a2233223b757365726e616d657c733a373a224775737461766f223b656d61696c7c733a32303a226775746f2e6e656c6f7340676d61696c2e636f6d223b6c6f67676564696e7c623a313b),
('caf3128864deb83a062c264008a66285b5b514b3', '172.18.0.1', 1618259389, 0x5f5f63695f6c6173745f726567656e65726174657c693a313631383235393139303b),
('cd8c03dd714e50f39dfca1d56a463d59e7643ff7', '172.18.0.1', 1618255463, 0x5f5f63695f6c6173745f726567656e65726174657c693a313631383235353139313b69647c733a313a2233223b757365726e616d657c733a373a224775737461766f223b656d61696c7c733a32303a226775746f2e6e656c6f7340676d61696c2e636f6d223b6c6f67676564696e7c623a313b),
('ec4895ab74fd5f24891080b723f0de2e994c2741', '172.18.0.1', 1618266117, 0x5f5f63695f6c6173745f726567656e65726174657c693a313631383236363131373b69647c733a313a2233223b757365726e616d657c733a373a224775737461766f223b656d61696c7c733a32303a226775746f2e6e656c6f7340676d61696c2e636f6d223b6c6f67676564696e7c623a313b),
('ed1c422dcae7d043a7ff8ceb6588b291be06b98b', '172.18.0.1', 1618255187, 0x5f5f63695f6c6173745f726567656e65726174657c693a313631383235353035333b69647c733a313a2233223b757365726e616d657c733a373a224775737461766f223b656d61696c7c733a32303a226775746f2e6e656c6f7340676d61696c2e636f6d223b6c6f67676564696e7c623a313b),
('f0733a3c8fe2f060b41a85af146d9c81812bfc45', '172.18.0.1', 1618266117, 0x5f5f63695f6c6173745f726567656e65726174657c693a313631383236363131373b69647c733a313a2233223b757365726e616d657c733a373a224775737461766f223b656d61696c7c733a32303a226775746f2e6e656c6f7340676d61696c2e636f6d223b6c6f67676564696e7c623a313b),
('f7211fc03e1ad5af6f3999def9c2f0455a3f336e', '172.18.0.1', 1618259026, 0x5f5f63695f6c6173745f726567656e65726174657c693a313631383235393032363b),
('fef321002b09195a3d3a8c594a9716847b158b27', '172.18.0.1', 1618255469, 0x5f5f63695f6c6173745f726567656e65726174657c693a313631383235353436393b);

-- --------------------------------------------------------

--
-- Estrutura da tabela `DOCUMENTOS`
--

CREATE TABLE `DOCUMENTOS` (
  `id` int(11) NOT NULL,
  `nome` varchar(255) NOT NULL,
  `id_pasta` int(11) DEFAULT NULL,
  `data_inicial` date DEFAULT NULL,
  `data_final` date DEFAULT NULL,
  `palavras_chaves` text,
  `url` text,
  `thumbnail` longtext,
  `exclusao` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `DOCUMENTOS`
--

INSERT INTO `DOCUMENTOS` (`id`, `nome`, `id_pasta`, `data_inicial`, `data_final`, `palavras_chaves`, `url`, `thumbnail`, `exclusao`) VALUES
(1, '', NULL, '2021-04-12', '2021-04-12', NULL, '/upload/2039996b8859a5e1cf1a1a659a4a2672.jpg', 'data:image/jpeg;base64,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', NULL),
(2, 'teste', NULL, '2021-04-12', '2021-04-13', NULL, '/upload/6b96f1486a504ca7692fbf36620762b2.jpg', 'data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDABsSFBcUERsXFhceHBsgKEIrKCUlKFE6PTBCYFVlZF9VXVtqeJmBanGQc1tdhbWGkJ6jq62rZ4C8ybqmx5moq6T/2wBDARweHigjKE4rK06kbl1upKSkpKSkpKSkpKSkpKSkpKSkpKSkpKSkpKSkpKSkpKSkpKSkpKSkpKSkpKSkpKSkpKT/wAARCAAtAC0DASIAAhEBAxEB/8QAGQAAAwEBAQAAAAAAAAAAAAAAAQIDBAAF/8QAKhAAAQQBAgQGAgMAAAAAAAAAAQACAxEhBBITIkFRMVJhcYGRFDJDobH/xAAYAQEAAwEAAAAAAAAAAAAAAAACAAEDBP/EABsRAQEBAAMBAQAAAAAAAAAAAAEAEQISQSFh/9oADAMBAAIRAxEAPwC5iB/mkPyUpga4/u8n3KoVwIDXOPQIXRrZzp4u5+ylOmh7H7KR+peXlsbAQOpRi1G5/DeNrunqpUrH8eEdP7KBgh8oVcIEJQ1rg7gHDwOVi1GqBJjaeUHJ7ozz8LRM8zmgD6XlySXGdt0j5LfuW1jnAnGDZuko3maNxGLSxu4sdh3wiyQNla1xvabNIDacgy3szaSQPLrYbHui2SIxlzXjb1N+ChOydsh4EjQDkgrW5/KLXxyxtfJJVcoF9FHUkONNINYwpVyMvIpNGTwiezt3+KYJX3eOjcGEN2uBDhhdG0x89GryiZ3Y3Ddi7tXezdEc1kI47LuPH9mL6lBAqsEHwcCszrc47DgY3d/b0T6eUOlia5t5wSVpZpIzJIDdA4HZOyEXW//Z', NULL),
(3, 'v', 1, '2021-04-12', '2021-04-15', NULL, '/upload/8c478a26afdae3a035252b52c9d7c0b2.jpg', 'data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDABsSFBcUERsXFhceHBsgKEIrKCUlKFE6PTBCYFVlZF9VXVtqeJmBanGQc1tdhbWGkJ6jq62rZ4C8ybqmx5moq6T/2wBDARweHigjKE4rK06kbl1upKSkpKSkpKSkpKSkpKSkpKSkpKSkpKSkpKSkpKSkpKSkpKSkpKSkpKSkpKSkpKSkpKT/wAARCAAtAC0DASIAAhEBAxEB/8QAGAABAAMBAAAAAAAAAAAAAAAABAEDBQL/xAAlEAACAgEEAgEFAQAAAAAAAAABAgMRAAQSITFBUXEFEyIjMoH/xAAXAQADAQAAAAAAAAAAAAAAAAAAAgMB/8QAGhEBAQEBAAMAAAAAAAAAAAAAAAERAiFBUf/aAAwDAQACEQMRAD8AXI80j1wE8geciLbG+z/QbvIUCSMxozELwTkXbnaKHWTtxSTXSa46dHBTcBZu64rDxfUF1klOBG/z3iIljkcFjV9D3lf1HToULoAJF5BHeZKLytemSxzXvjIhd1Wj385RotR96NeOa5Ocyb1kICkj5qsbS4vl1Cp+uIBVHrK1a129Xh40ZV/P+vJOVjUbdQoY/rJ5PrJLeI14dPsfeZCQegfGFlhd3Z/wIs8nsYlyzR/jyMzdRqGjiZVpbPArzg2T2Poi0Z23xeaMm5qMZ+eMzIQyIAeDj4HOznKSpWONQ9hipu8BIrEX65rNPWoP685mzsQpxcw+7NI05kOmsSMteMJUm8s53Ee8arCHRF1Xk5UeUBPbULxYbr45Cu53DrFRkAUG6y+OBAg4w02nQvYJX3tNXhOmXl//2Q==', '2021-04-12');

-- --------------------------------------------------------

--
-- Estrutura da tabela `GRUPO`
--

CREATE TABLE `GRUPO` (
  `id` int(11) NOT NULL,
  `nome` varchar(255) NOT NULL,
  `exclusao` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `GRUPO`
--

INSERT INTO `GRUPO` (`id`, `nome`, `exclusao`) VALUES
(1, 'Grupo', '2021-03-18'),
(2, 'Todos', '2021-03-26'),
(3, 'Gerentes', NULL),
(4, 'Administradores', NULL),
(5, 'Conselheiros', NULL),
(6, 'Conselho Fiscal', NULL),
(7, 'Controle Interno', NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `GRUPO_DOCUMENTO`
--

CREATE TABLE `GRUPO_DOCUMENTO` (
  `id` int(11) NOT NULL,
  `id_grupo` int(11) NOT NULL,
  `id_documento` int(11) NOT NULL,
  `exclusao` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `GRUPO_DOCUMENTO`
--

INSERT INTO `GRUPO_DOCUMENTO` (`id`, `id_grupo`, `id_documento`, `exclusao`) VALUES
(8, 4, 29, NULL),
(9, 5, 29, NULL),
(10, 6, 29, NULL),
(11, 7, 29, NULL),
(20, 4, 4, NULL),
(21, 5, 4, NULL),
(22, 6, 4, NULL),
(23, 7, 4, NULL),
(24, 4, 5, NULL),
(25, 5, 5, NULL),
(26, 6, 5, NULL),
(27, 7, 5, NULL),
(28, 5, 6, NULL),
(29, 6, 6, NULL),
(30, 7, 6, NULL),
(31, 3, 9, NULL),
(32, 4, 9, NULL),
(33, 5, 9, NULL),
(34, 6, 9, NULL),
(35, 7, 9, NULL),
(36, 5, 7, NULL),
(37, 3, 8, NULL),
(38, 3, 10, NULL),
(39, 5, 10, NULL),
(40, 7, 10, NULL),
(41, 3, 11, NULL),
(42, 5, 11, NULL),
(43, 7, 11, NULL),
(44, 3, 12, NULL),
(45, 5, 12, NULL),
(46, 7, 12, NULL),
(52, 4, 2, NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `GRUPO_PASTA`
--

CREATE TABLE `GRUPO_PASTA` (
  `id` int(11) NOT NULL,
  `id_grupo` int(11) NOT NULL,
  `id_pasta` int(11) NOT NULL,
  `exclusao` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `GRUPO_USUARIO`
--

CREATE TABLE `GRUPO_USUARIO` (
  `id` int(11) NOT NULL,
  `id_grupo` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `exclusao` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `GRUPO_USUARIO`
--

INSERT INTO `GRUPO_USUARIO` (`id`, `id_grupo`, `id_usuario`, `exclusao`) VALUES
(12, 3, 2, NULL),
(13, 4, 2, NULL),
(14, 5, 2, NULL),
(15, 6, 2, NULL),
(16, 7, 2, NULL),
(17, 1, 3, NULL),
(19, 4, 4, NULL),
(20, 5, 4, NULL),
(21, 6, 4, NULL),
(22, 4, 7, NULL),
(23, 5, 7, NULL),
(24, 6, 7, NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `PASTAS`
--

CREATE TABLE `PASTAS` (
  `id` int(11) NOT NULL,
  `nome` varchar(255) NOT NULL,
  `exclusao` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `PASTAS`
--

INSERT INTO `PASTAS` (`id`, `nome`, `exclusao`) VALUES
(1, 'Ofícios', NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `PERMISSOES`
--

CREATE TABLE `PERMISSOES` (
  `id` int(11) NOT NULL,
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
  `id` int(11) NOT NULL,
  `nome` varchar(255) NOT NULL,
  `senha` text NOT NULL,
  `telefone` varchar(45) NOT NULL,
  `email` varchar(255) NOT NULL,
  `id_permissao` int(11) NOT NULL,
  `id_aauth` int(11) DEFAULT NULL,
  `codigo` varchar(255) DEFAULT NULL,
  `exclusao` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `USUARIOS`
--

INSERT INTO `USUARIOS` (`id`, `nome`, `senha`, `telefone`, `email`, `id_permissao`, `id_aauth`, `codigo`, `exclusao`) VALUES
(2, 'd', '123', 'd', 'd', 1, NULL, NULL, '0000-00-00'),
(3, 'Guto', '123', 'd', '123', 2, NULL, '3141611', '0000-00-00'),
(4, 'dd', '12345', 'd', 'guto@guto.com', 2, NULL, NULL, '0000-00-00'),
(5, 'sssssss', 'Guto@123', 'Guto@123', 'guto.nelos@gmail.com', 2, 2, NULL, '2021-04-02'),
(6, 'Gustavo', '12345', '71981309973', 'guto.nelos@gmail.com', 1, 3, NULL, '0000-00-00'),
(7, 'gt', '12345', '123', 'user@example.com', 2, 4, NULL, '0000-00-00');

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `aauth_groups`
--
ALTER TABLE `aauth_groups`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `aauth_group_to_group`
--
ALTER TABLE `aauth_group_to_group`
  ADD PRIMARY KEY (`group_id`,`subgroup_id`);

--
-- Índices para tabela `aauth_login_attempts`
--
ALTER TABLE `aauth_login_attempts`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `aauth_perms`
--
ALTER TABLE `aauth_perms`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `aauth_perm_to_group`
--
ALTER TABLE `aauth_perm_to_group`
  ADD PRIMARY KEY (`perm_id`,`group_id`);

--
-- Índices para tabela `aauth_perm_to_user`
--
ALTER TABLE `aauth_perm_to_user`
  ADD PRIMARY KEY (`perm_id`,`user_id`);

--
-- Índices para tabela `aauth_pms`
--
ALTER TABLE `aauth_pms`
  ADD PRIMARY KEY (`id`),
  ADD KEY `full_index` (`id`,`sender_id`,`receiver_id`,`date_read`);

--
-- Índices para tabela `aauth_users`
--
ALTER TABLE `aauth_users`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `aauth_user_to_group`
--
ALTER TABLE `aauth_user_to_group`
  ADD PRIMARY KEY (`user_id`,`group_id`);

--
-- Índices para tabela `aauth_user_variables`
--
ALTER TABLE `aauth_user_variables`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id_index` (`user_id`);

--
-- Índices para tabela `ATIVIDADES`
--
ALTER TABLE `ATIVIDADES`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `ci_sessions`
--
ALTER TABLE `ci_sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ci_sessions_timestamp` (`timestamp`);

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
-- AUTO_INCREMENT de tabela `aauth_groups`
--
ALTER TABLE `aauth_groups`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de tabela `aauth_login_attempts`
--
ALTER TABLE `aauth_login_attempts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=60;

--
-- AUTO_INCREMENT de tabela `aauth_perms`
--
ALTER TABLE `aauth_perms`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `aauth_pms`
--
ALTER TABLE `aauth_pms`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `aauth_users`
--
ALTER TABLE `aauth_users`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de tabela `aauth_user_variables`
--
ALTER TABLE `aauth_user_variables`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `ATIVIDADES`
--
ALTER TABLE `ATIVIDADES`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=55;

--
-- AUTO_INCREMENT de tabela `DOCUMENTOS`
--
ALTER TABLE `DOCUMENTOS`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de tabela `GRUPO`
--
ALTER TABLE `GRUPO`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de tabela `GRUPO_DOCUMENTO`
--
ALTER TABLE `GRUPO_DOCUMENTO`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=55;

--
-- AUTO_INCREMENT de tabela `GRUPO_USUARIO`
--
ALTER TABLE `GRUPO_USUARIO`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT de tabela `PASTAS`
--
ALTER TABLE `PASTAS`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `PERMISSOES`
--
ALTER TABLE `PERMISSOES`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `USUARIOS`
--
ALTER TABLE `USUARIOS`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

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
