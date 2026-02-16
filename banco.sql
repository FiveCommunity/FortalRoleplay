-- --------------------------------------------------------
-- Servidor:                     127.0.0.1
-- Versão do servidor:           12.1.2-MariaDB - MariaDB Server
-- OS do Servidor:               Win64
-- HeidiSQL Versão:              12.15.0.7171
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Copiando estrutura do banco de dados para blacknetwork
DROP DATABASE IF EXISTS `blacknetwork`;
CREATE DATABASE IF NOT EXISTS `blacknetwork` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `blacknetwork`;

-- Copiando estrutura para tabela blacknetwork.accounts
DROP TABLE IF EXISTS `accounts`;
CREATE TABLE IF NOT EXISTS `accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `whitelist` tinyint(1) NOT NULL DEFAULT 0,
  `chars` int(10) NOT NULL DEFAULT 1,
  `premium` int(20) NOT NULL DEFAULT 0,
  `priority` int(3) NOT NULL DEFAULT 0,
  `discord` varchar(50) NOT NULL DEFAULT '0',
  `steam` varchar(50) NOT NULL DEFAULT '0',
  `pincode` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.admin_chat
DROP TABLE IF EXISTS `admin_chat`;
CREATE TABLE IF NOT EXISTS `admin_chat` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.admin_notify
DROP TABLE IF EXISTS `admin_notify`;
CREATE TABLE IF NOT EXISTS `admin_notify` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.admin_salary
DROP TABLE IF EXISTS `admin_salary`;
CREATE TABLE IF NOT EXISTS `admin_salary` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `group` varchar(255) NOT NULL,
  `amount` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.bank
DROP TABLE IF EXISTS `bank`;
CREATE TABLE IF NOT EXISTS `bank` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(20) NOT NULL DEFAULT 0,
  `value` int(20) NOT NULL DEFAULT 0,
  `mode` varchar(50) DEFAULT 'Private',
  `owner` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.banneds
DROP TABLE IF EXISTS `banneds`;
CREATE TABLE IF NOT EXISTS `banneds` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `steam` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.black_conce
DROP TABLE IF EXISTS `black_conce`;
CREATE TABLE IF NOT EXISTS `black_conce` (
  `name` varchar(200) NOT NULL,
  `spawn` varchar(200) NOT NULL,
  `price` int(20) NOT NULL DEFAULT 0,
  `class` int(20) NOT NULL DEFAULT 0,
  `stock` int(20) NOT NULL DEFAULT 0,
  `maxStock` int(20) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.black_dominations
DROP TABLE IF EXISTS `black_dominations`;
CREATE TABLE IF NOT EXISTS `black_dominations` (
  `orgName` varchar(50) DEFAULT NULL,
  `dominationsAmount` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.black_elogios
DROP TABLE IF EXISTS `black_elogios`;
CREATE TABLE IF NOT EXISTS `black_elogios` (
  `user_id` int(11) DEFAULT NULL,
  `data` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.black_esc
DROP TABLE IF EXISTS `black_esc`;
CREATE TABLE IF NOT EXISTS `black_esc` (
  `user_id` int(11) NOT NULL,
  `playTime` int(11) DEFAULT 0,
  `level` int(11) DEFAULT 0,
  `itensResgatados` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '{}',
  `imageUrl` longtext DEFAULT '',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.black_invites
DROP TABLE IF EXISTS `black_invites`;
CREATE TABLE IF NOT EXISTS `black_invites` (
  `orgName` varchar(50) DEFAULT NULL,
  `invitesAmount` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.black_rankedkd
DROP TABLE IF EXISTS `black_rankedkd`;
CREATE TABLE IF NOT EXISTS `black_rankedkd` (
  `user_id` int(11) NOT NULL,
  `abates` int(11) DEFAULT 0,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.black_relationship
DROP TABLE IF EXISTS `black_relationship`;
CREATE TABLE IF NOT EXISTS `black_relationship` (
  `user_id` int(11) DEFAULT NULL,
  `relationship` int(11) DEFAULT NULL,
  `nuser_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.black_skins
DROP TABLE IF EXISTS `black_skins`;
CREATE TABLE IF NOT EXISTS `black_skins` (
  `component` varchar(50) NOT NULL DEFAULT '',
  `stock` int(11) DEFAULT 0,
  PRIMARY KEY (`component`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.black_skins_users
DROP TABLE IF EXISTS `black_skins_users`;
CREATE TABLE IF NOT EXISTS `black_skins_users` (
  `user_id` int(11) NOT NULL DEFAULT 0,
  `skins` text DEFAULT '[]',
  `equipadas` text DEFAULT '[]',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.black-admin-notifications
DROP TABLE IF EXISTS `black-admin-notifications`;
CREATE TABLE IF NOT EXISTS `black-admin-notifications` (
  `id` varchar(50) DEFAULT NULL,
  `message` varchar(300) NOT NULL,
  `date` varchar(50) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.black-admin-salaries
DROP TABLE IF EXISTS `black-admin-salaries`;
CREATE TABLE IF NOT EXISTS `black-admin-salaries` (
  `name` varchar(50) NOT NULL,
  `group` varchar(50) NOT NULL,
  `amount` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.black-admin-tempban
DROP TABLE IF EXISTS `black-admin-tempban`;
CREATE TABLE IF NOT EXISTS `black-admin-tempban` (
  `user_id` int(11) NOT NULL,
  `time` varchar(50) NOT NULL DEFAULT '',
  `timestamp` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.black-garages
DROP TABLE IF EXISTS `black-garages`;
CREATE TABLE IF NOT EXISTS `black-garages` (
  `name` varchar(50) NOT NULL DEFAULT '',
  `perm` varchar(50) NOT NULL DEFAULT '',
  `coords` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `vehicles` text DEFAULT NULL,
  `payment` varchar(50) DEFAULT NULL,
  CONSTRAINT `chk_data` CHECK (json_valid(`coords`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.bs_fines
DROP TABLE IF EXISTS `bs_fines`;
CREATE TABLE IF NOT EXISTS `bs_fines` (
  `user_id` int(11) DEFAULT NULL,
  `service` varchar(50) DEFAULT NULL,
  `reason` varchar(50) DEFAULT NULL,
  `fine` int(11) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.bs_graphics
DROP TABLE IF EXISTS `bs_graphics`;
CREATE TABLE IF NOT EXISTS `bs_graphics` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `value` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.bs_imposts
DROP TABLE IF EXISTS `bs_imposts`;
CREATE TABLE IF NOT EXISTS `bs_imposts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `reason` varchar(50) DEFAULT NULL,
  `value` int(11) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `car` varchar(50) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.bs_investments
DROP TABLE IF EXISTS `bs_investments`;
CREATE TABLE IF NOT EXISTS `bs_investments` (
  `user_id` int(11) DEFAULT NULL,
  `investments` int(11) DEFAULT NULL,
  `investmentsInitial` int(11) DEFAULT NULL,
  `date` int(100) DEFAULT NULL,
  `lastInitial` varchar(100) DEFAULT NULL,
  `datePreview` varchar(100) DEFAULT NULL,
  `profit` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.bs_invoices
DROP TABLE IF EXISTS `bs_invoices`;
CREATE TABLE IF NOT EXISTS `bs_invoices` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `reason` varchar(50) DEFAULT NULL,
  `value` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `nuser_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.bs_monthlyincome
DROP TABLE IF EXISTS `bs_monthlyincome`;
CREATE TABLE IF NOT EXISTS `bs_monthlyincome` (
  `user_id` int(11) DEFAULT NULL,
  `value` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.bs_transations
DROP TABLE IF EXISTS `bs_transations`;
CREATE TABLE IF NOT EXISTS `bs_transations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `reason` varchar(50) DEFAULT NULL,
  `hours` int(11) DEFAULT NULL,
  `typeReason` varchar(50) DEFAULT NULL,
  `value` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.bsgroupmanager-announces
DROP TABLE IF EXISTS `bsgroupmanager-announces`;
CREATE TABLE IF NOT EXISTS `bsgroupmanager-announces` (
  `orgName` varchar(50) NOT NULL,
  `user_id` varchar(50) NOT NULL DEFAULT '',
  `title` varchar(500) NOT NULL,
  `description` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.bsgroupmanager-blacklist
DROP TABLE IF EXISTS `bsgroupmanager-blacklist`;
CREATE TABLE IF NOT EXISTS `bsgroupmanager-blacklist` (
  `user_id` varchar(50) DEFAULT NULL,
  `removed_in` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.bsgroupmanager-chests
DROP TABLE IF EXISTS `bsgroupmanager-chests`;
CREATE TABLE IF NOT EXISTS `bsgroupmanager-chests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `weight` int(11) DEFAULT 0,
  `perm` varchar(50) DEFAULT NULL,
  `logs` int(1) DEFAULT 0,
  `coords` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.bsgroupmanager-farms
DROP TABLE IF EXISTS `bsgroupmanager-farms`;
CREATE TABLE IF NOT EXISTS `bsgroupmanager-farms` (
  `orgName` varchar(50) NOT NULL,
  `taskId` text DEFAULT NULL,
  `title` varchar(100) NOT NULL DEFAULT '',
  `item` varchar(50) NOT NULL,
  `amount` int(11) NOT NULL DEFAULT 0,
  `gift` varchar(50) NOT NULL,
  `date` varchar(50) NOT NULL,
  `users_finished` text CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT '{}'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.bsgroupmanager-logs
DROP TABLE IF EXISTS `bsgroupmanager-logs`;
CREATE TABLE IF NOT EXISTS `bsgroupmanager-logs` (
  `orgName` varchar(50) NOT NULL,
  `type` varchar(50) DEFAULT NULL,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `name` varchar(50) NOT NULL,
  `action` varchar(50) NOT NULL,
  `item` varchar(50) NOT NULL,
  `value` int(11) NOT NULL DEFAULT 0,
  `date` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.bsgroupmanager-members
DROP TABLE IF EXISTS `bsgroupmanager-members`;
CREATE TABLE IF NOT EXISTS `bsgroupmanager-members` (
  `user_id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL DEFAULT '',
  `group` varchar(50) NOT NULL DEFAULT '',
  `orgName` varchar(50) NOT NULL DEFAULT '',
  `image` text NOT NULL,
  `lastLogin` varchar(50) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.bsgroupmanager-orgs
DROP TABLE IF EXISTS `bsgroupmanager-orgs`;
CREATE TABLE IF NOT EXISTS `bsgroupmanager-orgs` (
  `orgName` varchar(50) NOT NULL,
  `bank` int(11) NOT NULL,
  `founder` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.bspolice_historic
DROP TABLE IF EXISTS `bspolice_historic`;
CREATE TABLE IF NOT EXISTS `bspolice_historic` (
  `user_id` int(11) NOT NULL,
  `police_id` int(11) NOT NULL,
  `type` enum('Prisão','Multa') NOT NULL,
  `description` varchar(255) DEFAULT 'Sem descrição',
  `value` int(11) DEFAULT 0,
  `createdAt` varchar(50) DEFAULT NULL,
  KEY `police_id` (`police_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `bspolice_historic_ibfk_1` FOREIGN KEY (`police_id`) REFERENCES `characters` (`id`),
  CONSTRAINT `bspolice_historic_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `characters` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.bspolice_members
DROP TABLE IF EXISTS `bspolice_members`;
CREATE TABLE IF NOT EXISTS `bspolice_members` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `patent` varchar(50) DEFAULT NULL,
  `ago` varchar(50) DEFAULT NULL,
  `arrests` int(11) DEFAULT 0,
  `fines` int(11) DEFAULT 0,
  `reportCards` int(11) DEFAULT 0,
  `seizedVehicles` int(11) DEFAULT 0,
  `totalWorkTime` float DEFAULT 0,
  `totalInFines` int(11) DEFAULT 0,
  `createdAt` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.bspolice_report_card
DROP TABLE IF EXISTS `bspolice_report_card`;
CREATE TABLE IF NOT EXISTS `bspolice_report_card` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `applicant_id` int(11) NOT NULL,
  `suspect_id` int(11) NOT NULL,
  `police_id` int(11) NOT NULL,
  `description` varchar(255) DEFAULT 'Sem descrição',
  `createdAt` varchar(50) DEFAULT NULL,
  `status` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `applicant_id` (`applicant_id`),
  KEY `suspect_id` (`suspect_id`),
  KEY `police_id` (`police_id`),
  CONSTRAINT `bspolice_report_card_ibfk_1` FOREIGN KEY (`applicant_id`) REFERENCES `characters` (`id`),
  CONSTRAINT `bspolice_report_card_ibfk_2` FOREIGN KEY (`suspect_id`) REFERENCES `characters` (`id`),
  CONSTRAINT `bspolice_report_card_ibfk_3` FOREIGN KEY (`police_id`) REFERENCES `characters` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.bspolice_statistics
DROP TABLE IF EXISTS `bspolice_statistics`;
CREATE TABLE IF NOT EXISTS `bspolice_statistics` (
  `type` varchar(50) DEFAULT NULL,
  `value` int(50) DEFAULT NULL,
  `createdAt` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.bspolice_wanted_people
DROP TABLE IF EXISTS `bspolice_wanted_people`;
CREATE TABLE IF NOT EXISTS `bspolice_wanted_people` (
  `id` char(36) NOT NULL DEFAULT uuid(),
  `user_id` int(11) NOT NULL,
  `description` varchar(255) DEFAULT 'Sem descrição',
  `wantedAt` varchar(50) DEFAULT NULL,
  `lastSeeAt` varchar(50) DEFAULT NULL,
  `At` varchar(255) DEFAULT NULL,
  KEY `user_id` (`user_id`),
  CONSTRAINT `bspolice_wanted_people_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `characters` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.bspolice_wanted_vehicle
DROP TABLE IF EXISTS `bspolice_wanted_vehicle`;
CREATE TABLE IF NOT EXISTS `bspolice_wanted_vehicle` (
  `id` char(36) NOT NULL DEFAULT uuid(),
  `model` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT 'Sem descrição',
  `wantedAt` varchar(50) DEFAULT NULL,
  `lastSeeAt` varchar(50) DEFAULT NULL,
  `At` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.bspolice_warns
DROP TABLE IF EXISTS `bspolice_warns`;
CREATE TABLE IF NOT EXISTS `bspolice_warns` (
  `id` char(36) NOT NULL DEFAULT uuid(),
  `title` varchar(255) DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `createdAt` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.centralcart_scheduler
DROP TABLE IF EXISTS `centralcart_scheduler`;
CREATE TABLE IF NOT EXISTS `centralcart_scheduler` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(255) NOT NULL,
  `command` varchar(255) NOT NULL,
  `params` text DEFAULT NULL,
  `execute_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.characters
DROP TABLE IF EXISTS `characters`;
CREATE TABLE IF NOT EXISTS `characters` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `discord` varchar(50) DEFAULT NULL,
  `phone` varchar(10) DEFAULT NULL,
  `serial` varchar(6) DEFAULT NULL,
  `name` varchar(50) DEFAULT 'Individuo',
  `name2` varchar(50) DEFAULT 'Indigente',
  `locate` varchar(10) NOT NULL DEFAULT 'Sul',
  `sex` varchar(1) NOT NULL DEFAULT 'M',
  `state` tinytext DEFAULT 'Solteiro',
  `blood` int(1) NOT NULL DEFAULT 1,
  `fines` int(20) NOT NULL DEFAULT 0,
  `garage` int(3) NOT NULL DEFAULT 3,
  `prison` int(11) NOT NULL DEFAULT 0,
  `port` int(1) NOT NULL DEFAULT 0,
  `deleted` int(1) NOT NULL DEFAULT 0,
  `gems` int(20) NOT NULL DEFAULT 0,
  `paypal` int(11) DEFAULT 0,
  `bank` int(11) DEFAULT 5000,
  `age` int(11) NOT NULL DEFAULT 20,
  `steam` varchar(50) DEFAULT NULL,
  `pincode` varchar(50) DEFAULT NULL,
  `photo` longtext DEFAULT NULL,
  `reset` bit(1) NOT NULL DEFAULT b'0',
  `vipDate` longtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.chests
DROP TABLE IF EXISTS `chests`;
CREATE TABLE IF NOT EXISTS `chests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `weight` int(10) NOT NULL DEFAULT 0,
  `perm` varchar(50) NOT NULL,
  `logs` int(1) NOT NULL DEFAULT 0,
  `level` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.dealership
DROP TABLE IF EXISTS `dealership`;
CREATE TABLE IF NOT EXISTS `dealership` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `spawn` varchar(100) DEFAULT NULL,
  `stock` int(11) DEFAULT 25,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.dominations
DROP TABLE IF EXISTS `dominations`;
CREATE TABLE IF NOT EXISTS `dominations` (
  `id` int(11) NOT NULL,
  `group` varchar(50) NOT NULL,
  `colororg` varchar(50) NOT NULL,
  `x` float(8,4) NOT NULL,
  `y` float(8,4) NOT NULL,
  `z` float(8,4) NOT NULL,
  `rx` float(8,4) NOT NULL,
  `ry` float(8,4) NOT NULL,
  `rz` float(8,4) NOT NULL,
  `scale` float(8,4) NOT NULL,
  `text` varchar(32) NOT NULL,
  `font` varchar(32) NOT NULL,
  `color` int(3) NOT NULL,
  `interior` int(3) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.doors
DROP TABLE IF EXISTS `doors`;
CREATE TABLE IF NOT EXISTS `doors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `config` text NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.entitydata
DROP TABLE IF EXISTS `entitydata`;
CREATE TABLE IF NOT EXISTS `entitydata` (
  `dkey` varchar(100) NOT NULL,
  `dvalue` text DEFAULT NULL,
  PRIMARY KEY (`dkey`),
  KEY `dkey` (`dkey`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.fidentity
DROP TABLE IF EXISTS `fidentity`;
CREATE TABLE IF NOT EXISTS `fidentity` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '',
  `name2` varchar(50) NOT NULL DEFAULT '',
  `locate` varchar(10) NOT NULL DEFAULT 'Sul',
  `port` int(1) NOT NULL DEFAULT 1,
  `blood` int(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.fortal_esc_vehicles
DROP TABLE IF EXISTS `fortal_esc_vehicles`;
CREATE TABLE IF NOT EXISTS `fortal_esc_vehicles` (
  `user_id` int(11) NOT NULL,
  `vehicle` varchar(100) NOT NULL,
  `vip_expiry` int(11) NOT NULL,
  PRIMARY KEY (`user_id`,`vehicle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.fortal_prison
DROP TABLE IF EXISTS `fortal_prison`;
CREATE TABLE IF NOT EXISTS `fortal_prison` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `prison_type` varchar(50) NOT NULL DEFAULT 'normal',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.founders_chests
DROP TABLE IF EXISTS `founders_chests`;
CREATE TABLE IF NOT EXISTS `founders_chests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `founder_id` int(11) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `weight` int(11) DEFAULT 0,
  `perm` varchar(50) DEFAULT NULL,
  `logs` int(1) DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.ftdip_bo
DROP TABLE IF EXISTS `ftdip_bo`;
CREATE TABLE IF NOT EXISTS `ftdip_bo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `occurrence_number` varchar(50) NOT NULL,
  `type` varchar(100) NOT NULL DEFAULT 'Boletim de Ocorrência',
  `description` text NOT NULL,
  `applicant_id` int(11) DEFAULT NULL,
  `applicant_name` varchar(255) DEFAULT NULL,
  `suspect_id` int(11) DEFAULT NULL,
  `suspect_name` varchar(255) DEFAULT NULL,
  `officer_id` int(11) NOT NULL,
  `officer_name` varchar(255) NOT NULL,
  `status` enum('Aberto','Em Andamento','Resolvido','Arquivado') NOT NULL DEFAULT 'Aberto',
  `created_at` date NOT NULL DEFAULT curdate(),
  `updated_at` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `occurrence_number` (`occurrence_number`),
  KEY `officer_id` (`officer_id`),
  KEY `applicant_id` (`applicant_id`),
  KEY `suspect_id` (`suspect_id`),
  KEY `created_at` (`created_at`),
  KEY `status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.ftdip_fines
DROP TABLE IF EXISTS `ftdip_fines`;
CREATE TABLE IF NOT EXISTS `ftdip_fines` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `player_id` int(11) NOT NULL,
  `player_name` varchar(255) NOT NULL,
  `fine_type` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `officer_id` int(11) NOT NULL,
  `officer_name` varchar(255) NOT NULL,
  `status` enum('Pendente','Paga','Vencida') NOT NULL DEFAULT 'Pendente',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `paid_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `player_id` (`player_id`),
  KEY `officer_id` (`officer_id`),
  KEY `status` (`status`),
  KEY `created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.ftdip_history
DROP TABLE IF EXISTS `ftdip_history`;
CREATE TABLE IF NOT EXISTS `ftdip_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `player_id` int(11) NOT NULL,
  `type` varchar(50) NOT NULL DEFAULT 'Multa',
  `description` text NOT NULL,
  `amount` decimal(10,2) DEFAULT 0.00,
  `months` int(11) DEFAULT 0,
  `officer_id` int(11) NOT NULL,
  `officer_name` varchar(255) NOT NULL,
  `created_at` date NOT NULL DEFAULT curdate(),
  PRIMARY KEY (`id`),
  KEY `player_id` (`player_id`),
  KEY `officer_id` (`officer_id`),
  KEY `created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.ftdip_members
DROP TABLE IF EXISTS `ftdip_members`;
CREATE TABLE IF NOT EXISTS `ftdip_members` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `charge` varchar(100) NOT NULL DEFAULT 'Agente',
  `rank` int(11) NOT NULL DEFAULT 1,
  `join_date` date NOT NULL DEFAULT curdate(),
  `status` enum('Ativo','Inativo','Suspenso') NOT NULL DEFAULT 'Ativo',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  KEY `status` (`status`),
  KEY `rank` (`rank`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.ftdip_officer_stats
DROP TABLE IF EXISTS `ftdip_officer_stats`;
CREATE TABLE IF NOT EXISTS `ftdip_officer_stats` (
  `user_id` int(11) NOT NULL,
  `arrests_made` int(11) DEFAULT 0,
  `fines_applied` int(11) DEFAULT 0,
  `total_fines_value` decimal(10,2) DEFAULT 0.00,
  `total_working_hours` int(11) DEFAULT 0,
  `vehicles_seized` int(11) DEFAULT 0,
  `reports_registered` int(11) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.ftdip_stats
DROP TABLE IF EXISTS `ftdip_stats`;
CREATE TABLE IF NOT EXISTS `ftdip_stats` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `type` varchar(50) NOT NULL,
  `count` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `date_type` (`date`,`type`),
  KEY `date` (`date`),
  KEY `type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.ftdip_wanted_users
DROP TABLE IF EXISTS `ftdip_wanted_users`;
CREATE TABLE IF NOT EXISTS `ftdip_wanted_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `last_seen` varchar(255) NOT NULL,
  `location` varchar(255) NOT NULL,
  `photo` varchar(500) DEFAULT NULL,
  `officer_id` int(11) NOT NULL,
  `status` enum('Ativo','Inativo','Capturado') NOT NULL DEFAULT 'Ativo',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `officer_id` (`officer_id`),
  KEY `status` (`status`),
  KEY `created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.ftdip_wanted_vehicles
DROP TABLE IF EXISTS `ftdip_wanted_vehicles`;
CREATE TABLE IF NOT EXISTS `ftdip_wanted_vehicles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `model` varchar(255) NOT NULL,
  `specifications` text NOT NULL,
  `last_seen` varchar(255) NOT NULL,
  `location` varchar(255) NOT NULL,
  `officer_id` int(11) NOT NULL,
  `status` enum('Ativo','Inativo','Recuperado') NOT NULL DEFAULT 'Ativo',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `officer_id` (`officer_id`),
  KEY `status` (`status`),
  KEY `created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.ftdip_warns
DROP TABLE IF EXISTS `ftdip_warns`;
CREATE TABLE IF NOT EXISTS `ftdip_warns` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `author_id` int(11) NOT NULL,
  `author_name` varchar(255) NOT NULL,
  `created_at` date NOT NULL DEFAULT curdate(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.ftpolice_bo
DROP TABLE IF EXISTS `ftpolice_bo`;
CREATE TABLE IF NOT EXISTS `ftpolice_bo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `occurrence_number` varchar(50) NOT NULL,
  `type` varchar(100) NOT NULL DEFAULT 'Boletim de Ocorrência',
  `description` text NOT NULL,
  `applicant_id` int(11) DEFAULT NULL,
  `applicant_name` varchar(255) DEFAULT NULL,
  `suspect_id` int(11) DEFAULT NULL,
  `suspect_name` varchar(255) DEFAULT NULL,
  `officer_id` int(11) NOT NULL,
  `officer_name` varchar(255) NOT NULL,
  `status` enum('Aberto','Em Andamento','Resolvido','Arquivado') NOT NULL DEFAULT 'Aberto',
  `created_at` date NOT NULL DEFAULT curdate(),
  `updated_at` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `occurrence_number` (`occurrence_number`),
  KEY `officer_id` (`officer_id`),
  KEY `applicant_id` (`applicant_id`),
  KEY `suspect_id` (`suspect_id`),
  KEY `created_at` (`created_at`),
  KEY `status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.ftpolice_fines
DROP TABLE IF EXISTS `ftpolice_fines`;
CREATE TABLE IF NOT EXISTS `ftpolice_fines` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `player_id` int(11) NOT NULL,
  `player_name` varchar(255) NOT NULL,
  `fine_type` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `officer_id` int(11) NOT NULL,
  `officer_name` varchar(255) NOT NULL,
  `status` enum('Pendente','Paga','Vencida') NOT NULL DEFAULT 'Pendente',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `paid_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `player_id` (`player_id`),
  KEY `officer_id` (`officer_id`),
  KEY `status` (`status`),
  KEY `created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.ftpolice_history
DROP TABLE IF EXISTS `ftpolice_history`;
CREATE TABLE IF NOT EXISTS `ftpolice_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `player_id` int(11) NOT NULL,
  `type` varchar(50) NOT NULL DEFAULT 'Multa',
  `description` text NOT NULL,
  `amount` decimal(10,2) DEFAULT 0.00,
  `months` int(11) DEFAULT 0,
  `officer_id` int(11) NOT NULL,
  `officer_name` varchar(255) NOT NULL,
  `created_at` date NOT NULL DEFAULT curdate(),
  PRIMARY KEY (`id`),
  KEY `player_id` (`player_id`),
  KEY `officer_id` (`officer_id`),
  KEY `created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.ftpolice_members
DROP TABLE IF EXISTS `ftpolice_members`;
CREATE TABLE IF NOT EXISTS `ftpolice_members` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `charge` varchar(100) NOT NULL DEFAULT 'Policial',
  `rank` int(11) NOT NULL DEFAULT 1,
  `join_date` date NOT NULL DEFAULT curdate(),
  `status` enum('Ativo','Inativo','Suspenso') NOT NULL DEFAULT 'Ativo',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  KEY `status` (`status`),
  KEY `rank` (`rank`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.ftpolice_officer_stats
DROP TABLE IF EXISTS `ftpolice_officer_stats`;
CREATE TABLE IF NOT EXISTS `ftpolice_officer_stats` (
  `user_id` int(11) NOT NULL,
  `arrests_made` int(11) DEFAULT 0,
  `fines_applied` int(11) DEFAULT 0,
  `total_fines_value` decimal(10,2) DEFAULT 0.00,
  `total_working_hours` int(11) DEFAULT 0,
  `vehicles_seized` int(11) DEFAULT 0,
  `reports_registered` int(11) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.ftpolice_stats
DROP TABLE IF EXISTS `ftpolice_stats`;
CREATE TABLE IF NOT EXISTS `ftpolice_stats` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `type` varchar(50) NOT NULL,
  `count` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `date_type` (`date`,`type`),
  KEY `date` (`date`),
  KEY `type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.ftpolice_wanted_users
DROP TABLE IF EXISTS `ftpolice_wanted_users`;
CREATE TABLE IF NOT EXISTS `ftpolice_wanted_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `last_seen` varchar(255) NOT NULL,
  `location` varchar(255) NOT NULL,
  `photo` varchar(500) DEFAULT NULL,
  `officer_id` int(11) NOT NULL,
  `status` enum('Ativo','Inativo','Capturado') NOT NULL DEFAULT 'Ativo',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `officer_id` (`officer_id`),
  KEY `status` (`status`),
  KEY `created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.ftpolice_wanted_vehicles
DROP TABLE IF EXISTS `ftpolice_wanted_vehicles`;
CREATE TABLE IF NOT EXISTS `ftpolice_wanted_vehicles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `model` varchar(255) NOT NULL,
  `specifications` text NOT NULL,
  `last_seen` varchar(255) NOT NULL,
  `location` varchar(255) NOT NULL,
  `officer_id` int(11) NOT NULL,
  `status` enum('Ativo','Inativo','Recuperado') NOT NULL DEFAULT 'Ativo',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `officer_id` (`officer_id`),
  KEY `status` (`status`),
  KEY `created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.ftpolice_warns
DROP TABLE IF EXISTS `ftpolice_warns`;
CREATE TABLE IF NOT EXISTS `ftpolice_warns` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `author_id` int(11) NOT NULL,
  `author_name` varchar(255) NOT NULL,
  `created_at` date NOT NULL DEFAULT curdate(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.fx_clothesdata
DROP TABLE IF EXISTS `fx_clothesdata`;
CREATE TABLE IF NOT EXISTS `fx_clothesdata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `nameClothes` varchar(50) NOT NULL DEFAULT '0',
  `clothes` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.groupmanager_bank
DROP TABLE IF EXISTS `groupmanager_bank`;
CREATE TABLE IF NOT EXISTS `groupmanager_bank` (
  `groups` varchar(255) DEFAULT NULL,
  `user` varchar(255) DEFAULT NULL,
  `quantity` varchar(255) DEFAULT NULL,
  `action` varchar(255) DEFAULT NULL,
  `createdAt` int(11) NOT NULL DEFAULT unix_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.groupmanager_chest
DROP TABLE IF EXISTS `groupmanager_chest`;
CREATE TABLE IF NOT EXISTS `groupmanager_chest` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `weight` int(10) NOT NULL DEFAULT 0,
  `perm` varchar(50) NOT NULL,
  `cds` varchar(255) NOT NULL DEFAULT '{"position": {"x": 0, "y":0, "z": 0}}',
  `cds2` varchar(255) NOT NULL DEFAULT '{"position": {"x": 0, "y":0, "z": 0}}',
  `liderW` int(255) DEFAULT 500,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `id` (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.groupmanager_chest_logs
DROP TABLE IF EXISTS `groupmanager_chest_logs`;
CREATE TABLE IF NOT EXISTS `groupmanager_chest_logs` (
  `groups` varchar(255) DEFAULT NULL,
  `user` varchar(255) DEFAULT NULL,
  `item` varchar(255) DEFAULT NULL,
  `action` varchar(255) DEFAULT NULL,
  `createdAt` int(11) NOT NULL DEFAULT unix_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.groupmanager_groups
DROP TABLE IF EXISTS `groupmanager_groups`;
CREATE TABLE IF NOT EXISTS `groupmanager_groups` (
  `name` varchar(255) NOT NULL,
  `bank` int(50) DEFAULT NULL,
  `message` varchar(255) DEFAULT NULL,
  `max_members` int(50) DEFAULT NULL,
  `createdAt` int(11) NOT NULL DEFAULT unix_timestamp(),
  PRIMARY KEY (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.groupmanager_members
DROP TABLE IF EXISTS `groupmanager_members`;
CREATE TABLE IF NOT EXISTS `groupmanager_members` (
  `id` int(50) NOT NULL DEFAULT uuid(),
  `name` varchar(255) DEFAULT NULL,
  `org` varchar(255) DEFAULT NULL,
  `cargo` varchar(255) DEFAULT NULL,
  `lastAt` varchar(255) DEFAULT NULL,
  `createdAt` int(11) NOT NULL DEFAULT unix_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.initial_black
DROP TABLE IF EXISTS `initial_black`;
CREATE TABLE IF NOT EXISTS `initial_black` (
  `id` int(11) NOT NULL,
  `isInitial` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.initial_streamer
DROP TABLE IF EXISTS `initial_streamer`;
CREATE TABLE IF NOT EXISTS `initial_streamer` (
  `id` int(11) NOT NULL,
  `isInitial` varchar(50) NOT NULL,
  `expire_time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.mengazo_kill
DROP TABLE IF EXISTS `mengazo_kill`;
CREATE TABLE IF NOT EXISTS `mengazo_kill` (
  `user_id` int(11) NOT NULL DEFAULT 0,
  `kills` int(11) NOT NULL DEFAULT 0,
  `mortes` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.nation_garages
DROP TABLE IF EXISTS `nation_garages`;
CREATE TABLE IF NOT EXISTS `nation_garages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `garage` varchar(10000) NOT NULL DEFAULT '[]',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.nation_user_vehicles
DROP TABLE IF EXISTS `nation_user_vehicles`;
CREATE TABLE IF NOT EXISTS `nation_user_vehicles` (
  `plate` varchar(8) NOT NULL DEFAULT '',
  `vehicle` varchar(50) NOT NULL DEFAULT '',
  `user` varchar(50) NOT NULL DEFAULT '',
  `status` text NOT NULL DEFAULT 'liberado',
  `tax` timestamp NOT NULL DEFAULT current_timestamp(),
  `remove` timestamp NULL DEFAULT NULL,
  `type` varchar(50) NOT NULL DEFAULT 'normal',
  `data` text NOT NULL DEFAULT '[]',
  `tuning` text NOT NULL DEFAULT '[]',
  `stolen` varchar(50) DEFAULT NULL,
  `stolenDate` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`plate`) USING BTREE,
  KEY `FK_nation_user_vehicles_nation_vehicles` (`vehicle`) USING BTREE,
  CONSTRAINT `FK_nation_user_vehicles_nation_vehicles` FOREIGN KEY (`vehicle`) REFERENCES `nation_vehicles` (`model`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.nation_vehicles
DROP TABLE IF EXISTS `nation_vehicles`;
CREATE TABLE IF NOT EXISTS `nation_vehicles` (
  `model` varchar(50) NOT NULL DEFAULT '',
  `name` varchar(50) NOT NULL DEFAULT '',
  `hash` bigint(20) NOT NULL DEFAULT 0,
  `price` int(11) NOT NULL DEFAULT 0,
  `trunkWeight` int(11) NOT NULL DEFAULT 0,
  `type` varchar(50) NOT NULL DEFAULT 'normal',
  `class` varchar(50) NOT NULL DEFAULT 'Compacts',
  PRIMARY KEY (`model`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.panel
DROP TABLE IF EXISTS `panel`;
CREATE TABLE IF NOT EXISTS `panel` (
  `passport` int(11) NOT NULL,
  `group` varchar(50) DEFAULT NULL,
  `hierarchy` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`passport`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.phone_backups
DROP TABLE IF EXISTS `phone_backups`;
CREATE TABLE IF NOT EXISTS `phone_backups` (
  `id` varchar(100) NOT NULL,
  `phone_number` varchar(15) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `phone_number` (`phone_number`),
  CONSTRAINT `phone_backups_ibfk_1` FOREIGN KEY (`phone_number`) REFERENCES `phone_phones` (`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.phone_clock_alarms
DROP TABLE IF EXISTS `phone_clock_alarms`;
CREATE TABLE IF NOT EXISTS `phone_clock_alarms` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `phone_number` varchar(15) NOT NULL,
  `hours` int(2) NOT NULL DEFAULT 0,
  `minutes` int(2) NOT NULL DEFAULT 0,
  `label` varchar(50) DEFAULT NULL,
  `enabled` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`id`,`phone_number`),
  KEY `phone_number` (`phone_number`),
  CONSTRAINT `phone_clock_alarms_ibfk_1` FOREIGN KEY (`phone_number`) REFERENCES `phone_phones` (`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.phone_crypto
DROP TABLE IF EXISTS `phone_crypto`;
CREATE TABLE IF NOT EXISTS `phone_crypto` (
  `id` varchar(100) NOT NULL,
  `coin` varchar(15) NOT NULL,
  `amount` double NOT NULL DEFAULT 0,
  `invested` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`,`coin`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.phone_darkchat_accounts
DROP TABLE IF EXISTS `phone_darkchat_accounts`;
CREATE TABLE IF NOT EXISTS `phone_darkchat_accounts` (
  `phone_number` varchar(15) NOT NULL,
  `username` varchar(20) NOT NULL,
  `password` varchar(100) NOT NULL,
  PRIMARY KEY (`username`),
  KEY `phone_number` (`phone_number`),
  CONSTRAINT `phone_darkchat_accounts_ibfk_1` FOREIGN KEY (`phone_number`) REFERENCES `phone_phones` (`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.phone_darkchat_channels
DROP TABLE IF EXISTS `phone_darkchat_channels`;
CREATE TABLE IF NOT EXISTS `phone_darkchat_channels` (
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.phone_darkchat_members
DROP TABLE IF EXISTS `phone_darkchat_members`;
CREATE TABLE IF NOT EXISTS `phone_darkchat_members` (
  `channel_name` varchar(50) NOT NULL,
  `username` varchar(20) NOT NULL,
  PRIMARY KEY (`channel_name`,`username`),
  KEY `username` (`username`),
  CONSTRAINT `phone_darkchat_members_ibfk_1` FOREIGN KEY (`channel_name`) REFERENCES `phone_darkchat_channels` (`name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `phone_darkchat_members_ibfk_2` FOREIGN KEY (`username`) REFERENCES `phone_darkchat_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.phone_darkchat_messages
DROP TABLE IF EXISTS `phone_darkchat_messages`;
CREATE TABLE IF NOT EXISTS `phone_darkchat_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `channel` varchar(50) NOT NULL,
  `sender` varchar(20) NOT NULL,
  `content` varchar(1000) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `channel` (`channel`),
  KEY `sender` (`sender`),
  CONSTRAINT `phone_darkchat_messages_ibfk_1` FOREIGN KEY (`channel`) REFERENCES `phone_darkchat_channels` (`name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `phone_darkchat_messages_ibfk_2` FOREIGN KEY (`sender`) REFERENCES `phone_darkchat_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.phone_instagram_accounts
DROP TABLE IF EXISTS `phone_instagram_accounts`;
CREATE TABLE IF NOT EXISTS `phone_instagram_accounts` (
  `display_name` varchar(30) NOT NULL,
  `username` varchar(20) NOT NULL,
  `password` varchar(100) NOT NULL,
  `profile_image` varchar(500) DEFAULT NULL,
  `bio` varchar(100) DEFAULT NULL,
  `post_count` int(11) NOT NULL DEFAULT 0,
  `story_count` int(11) NOT NULL DEFAULT 0,
  `follower_count` int(11) NOT NULL DEFAULT 0,
  `following_count` int(11) NOT NULL DEFAULT 0,
  `phone_number` varchar(15) NOT NULL,
  `private` tinyint(1) DEFAULT 0,
  `verified` tinyint(1) DEFAULT 0,
  `date_joined` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`username`),
  KEY `phone_number` (`phone_number`),
  CONSTRAINT `phone_instagram_accounts_ibfk_1` FOREIGN KEY (`phone_number`) REFERENCES `phone_phones` (`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.phone_instagram_comments
DROP TABLE IF EXISTS `phone_instagram_comments`;
CREATE TABLE IF NOT EXISTS `phone_instagram_comments` (
  `id` varchar(10) NOT NULL,
  `post_id` varchar(50) NOT NULL,
  `username` varchar(20) NOT NULL,
  `comment` varchar(500) NOT NULL DEFAULT '',
  `like_count` int(11) NOT NULL DEFAULT 0,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `post_id` (`post_id`),
  KEY `username` (`username`),
  CONSTRAINT `phone_instagram_comments_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `phone_instagram_posts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `phone_instagram_comments_ibfk_2` FOREIGN KEY (`username`) REFERENCES `phone_instagram_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.phone_instagram_follow_requests
DROP TABLE IF EXISTS `phone_instagram_follow_requests`;
CREATE TABLE IF NOT EXISTS `phone_instagram_follow_requests` (
  `requester` varchar(20) NOT NULL,
  `requestee` varchar(20) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`requester`,`requestee`),
  KEY `requestee` (`requestee`),
  CONSTRAINT `phone_instagram_follow_requests_ibfk_1` FOREIGN KEY (`requester`) REFERENCES `phone_instagram_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `phone_instagram_follow_requests_ibfk_2` FOREIGN KEY (`requestee`) REFERENCES `phone_instagram_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.phone_instagram_follows
DROP TABLE IF EXISTS `phone_instagram_follows`;
CREATE TABLE IF NOT EXISTS `phone_instagram_follows` (
  `followed` varchar(20) NOT NULL,
  `follower` varchar(20) NOT NULL,
  PRIMARY KEY (`followed`,`follower`),
  KEY `follower` (`follower`),
  CONSTRAINT `phone_instagram_follows_ibfk_1` FOREIGN KEY (`followed`) REFERENCES `phone_instagram_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `phone_instagram_follows_ibfk_2` FOREIGN KEY (`follower`) REFERENCES `phone_instagram_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.phone_instagram_likes
DROP TABLE IF EXISTS `phone_instagram_likes`;
CREATE TABLE IF NOT EXISTS `phone_instagram_likes` (
  `id` varchar(10) NOT NULL,
  `username` varchar(20) NOT NULL,
  `is_comment` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`,`username`),
  KEY `username` (`username`),
  CONSTRAINT `phone_instagram_likes_ibfk_1` FOREIGN KEY (`username`) REFERENCES `phone_instagram_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.phone_instagram_messages
DROP TABLE IF EXISTS `phone_instagram_messages`;
CREATE TABLE IF NOT EXISTS `phone_instagram_messages` (
  `id` varchar(10) NOT NULL,
  `sender` varchar(20) NOT NULL,
  `recipient` varchar(20) NOT NULL,
  `content` varchar(1000) DEFAULT NULL,
  `attachments` text DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `sender` (`sender`),
  KEY `recipient` (`recipient`),
  CONSTRAINT `phone_instagram_messages_ibfk_1` FOREIGN KEY (`sender`) REFERENCES `phone_instagram_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `phone_instagram_messages_ibfk_2` FOREIGN KEY (`recipient`) REFERENCES `phone_instagram_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.phone_instagram_notifications
DROP TABLE IF EXISTS `phone_instagram_notifications`;
CREATE TABLE IF NOT EXISTS `phone_instagram_notifications` (
  `id` varchar(10) NOT NULL,
  `username` varchar(20) NOT NULL,
  `from` varchar(20) NOT NULL,
  `type` varchar(20) NOT NULL,
  `post_id` varchar(50) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `username` (`username`),
  KEY `from` (`from`),
  CONSTRAINT `phone_instagram_notifications_ibfk_1` FOREIGN KEY (`username`) REFERENCES `phone_instagram_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `phone_instagram_notifications_ibfk_2` FOREIGN KEY (`from`) REFERENCES `phone_instagram_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.phone_instagram_posts
DROP TABLE IF EXISTS `phone_instagram_posts`;
CREATE TABLE IF NOT EXISTS `phone_instagram_posts` (
  `id` varchar(10) NOT NULL,
  `media` text DEFAULT NULL,
  `caption` varchar(500) NOT NULL DEFAULT '',
  `location` varchar(50) DEFAULT NULL,
  `like_count` int(11) NOT NULL DEFAULT 0,
  `comment_count` int(11) NOT NULL DEFAULT 0,
  `username` varchar(20) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `username` (`username`),
  CONSTRAINT `phone_instagram_posts_ibfk_1` FOREIGN KEY (`username`) REFERENCES `phone_instagram_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.phone_instagram_stories
DROP TABLE IF EXISTS `phone_instagram_stories`;
CREATE TABLE IF NOT EXISTS `phone_instagram_stories` (
  `id` varchar(10) NOT NULL,
  `username` varchar(20) NOT NULL,
  `image` varchar(500) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `username` (`username`),
  CONSTRAINT `phone_instagram_stories_ibfk_1` FOREIGN KEY (`username`) REFERENCES `phone_instagram_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.phone_instagram_stories_views
DROP TABLE IF EXISTS `phone_instagram_stories_views`;
CREATE TABLE IF NOT EXISTS `phone_instagram_stories_views` (
  `story_id` varchar(50) NOT NULL,
  `viewer` varchar(20) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`story_id`,`viewer`),
  KEY `viewer` (`viewer`),
  CONSTRAINT `phone_instagram_stories_views_ibfk_1` FOREIGN KEY (`story_id`) REFERENCES `phone_instagram_stories` (`id`) ON DELETE CASCADE,
  CONSTRAINT `phone_instagram_stories_views_ibfk_2` FOREIGN KEY (`viewer`) REFERENCES `phone_instagram_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.phone_last_phone
DROP TABLE IF EXISTS `phone_last_phone`;
CREATE TABLE IF NOT EXISTS `phone_last_phone` (
  `id` varchar(100) NOT NULL,
  `phone_number` varchar(15) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `phone_number` (`phone_number`),
  CONSTRAINT `phone_last_phone_ibfk_1` FOREIGN KEY (`phone_number`) REFERENCES `phone_phones` (`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.phone_logged_in_accounts
DROP TABLE IF EXISTS `phone_logged_in_accounts`;
CREATE TABLE IF NOT EXISTS `phone_logged_in_accounts` (
  `phone_number` varchar(15) NOT NULL,
  `app` varchar(50) NOT NULL,
  `username` varchar(100) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`phone_number`,`app`,`username`),
  CONSTRAINT `phone_logged_in_accounts_ibfk_1` FOREIGN KEY (`phone_number`) REFERENCES `phone_phones` (`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.phone_mail_accounts
DROP TABLE IF EXISTS `phone_mail_accounts`;
CREATE TABLE IF NOT EXISTS `phone_mail_accounts` (
  `address` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  PRIMARY KEY (`address`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.phone_mail_deleted
DROP TABLE IF EXISTS `phone_mail_deleted`;
CREATE TABLE IF NOT EXISTS `phone_mail_deleted` (
  `message_id` int(10) unsigned NOT NULL,
  `address` varchar(100) NOT NULL,
  PRIMARY KEY (`message_id`,`address`),
  KEY `address` (`address`),
  CONSTRAINT `phone_mail_deleted_ibfk_1` FOREIGN KEY (`message_id`) REFERENCES `phone_mail_messages` (`id`) ON DELETE CASCADE,
  CONSTRAINT `phone_mail_deleted_ibfk_2` FOREIGN KEY (`address`) REFERENCES `phone_mail_accounts` (`address`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.phone_mail_messages
DROP TABLE IF EXISTS `phone_mail_messages`;
CREATE TABLE IF NOT EXISTS `phone_mail_messages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `recipient` varchar(100) NOT NULL,
  `sender` varchar(100) NOT NULL,
  `subject` varchar(100) NOT NULL,
  `content` text NOT NULL,
  `attachments` longtext DEFAULT NULL,
  `actions` longtext DEFAULT NULL,
  `read` tinyint(1) NOT NULL DEFAULT 0,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.phone_maps_locations
DROP TABLE IF EXISTS `phone_maps_locations`;
CREATE TABLE IF NOT EXISTS `phone_maps_locations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `phone_number` varchar(15) NOT NULL,
  `name` varchar(50) NOT NULL,
  `x_pos` float NOT NULL,
  `y_pos` float NOT NULL,
  PRIMARY KEY (`id`),
  KEY `phone_number` (`phone_number`),
  CONSTRAINT `phone_maps_locations_ibfk_1` FOREIGN KEY (`phone_number`) REFERENCES `phone_phones` (`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.phone_marketplace_posts
DROP TABLE IF EXISTS `phone_marketplace_posts`;
CREATE TABLE IF NOT EXISTS `phone_marketplace_posts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `phone_number` varchar(15) NOT NULL,
  `title` varchar(50) NOT NULL,
  `description` varchar(1000) NOT NULL,
  `attachments` text DEFAULT NULL,
  `price` int(11) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `phone_number` (`phone_number`),
  CONSTRAINT `phone_marketplace_posts_ibfk_1` FOREIGN KEY (`phone_number`) REFERENCES `phone_phones` (`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.phone_message_channels
DROP TABLE IF EXISTS `phone_message_channels`;
CREATE TABLE IF NOT EXISTS `phone_message_channels` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `is_group` tinyint(1) NOT NULL DEFAULT 0,
  `name` varchar(50) DEFAULT NULL,
  `last_message` varchar(50) NOT NULL DEFAULT '',
  `last_message_timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.phone_message_members
DROP TABLE IF EXISTS `phone_message_members`;
CREATE TABLE IF NOT EXISTS `phone_message_members` (
  `channel_id` int(11) NOT NULL,
  `phone_number` varchar(15) NOT NULL,
  `is_owner` tinyint(1) NOT NULL DEFAULT 0,
  `deleted` tinyint(1) NOT NULL DEFAULT 0,
  `unread` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`channel_id`,`phone_number`),
  CONSTRAINT `phone_message_members_ibfk_1` FOREIGN KEY (`channel_id`) REFERENCES `phone_message_channels` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.phone_message_messages
DROP TABLE IF EXISTS `phone_message_messages`;
CREATE TABLE IF NOT EXISTS `phone_message_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `channel_id` int(11) NOT NULL,
  `sender` varchar(15) NOT NULL,
  `content` varchar(1000) DEFAULT NULL,
  `attachments` text DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `channel_id` (`channel_id`),
  CONSTRAINT `phone_message_messages_ibfk_1` FOREIGN KEY (`channel_id`) REFERENCES `phone_message_channels` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.phone_music_playlists
DROP TABLE IF EXISTS `phone_music_playlists`;
CREATE TABLE IF NOT EXISTS `phone_music_playlists` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `phone_number` varchar(15) NOT NULL,
  `name` varchar(50) NOT NULL,
  `cover` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `phone_number` (`phone_number`),
  CONSTRAINT `phone_music_playlists_ibfk_1` FOREIGN KEY (`phone_number`) REFERENCES `phone_phones` (`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.phone_music_saved_playlists
DROP TABLE IF EXISTS `phone_music_saved_playlists`;
CREATE TABLE IF NOT EXISTS `phone_music_saved_playlists` (
  `playlist_id` int(10) unsigned NOT NULL,
  `phone_number` varchar(15) NOT NULL,
  PRIMARY KEY (`playlist_id`,`phone_number`),
  KEY `phone_number` (`phone_number`),
  CONSTRAINT `phone_music_saved_playlists_ibfk_1` FOREIGN KEY (`playlist_id`) REFERENCES `phone_music_playlists` (`id`) ON DELETE CASCADE,
  CONSTRAINT `phone_music_saved_playlists_ibfk_2` FOREIGN KEY (`phone_number`) REFERENCES `phone_phones` (`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.phone_music_songs
DROP TABLE IF EXISTS `phone_music_songs`;
CREATE TABLE IF NOT EXISTS `phone_music_songs` (
  `song_id` varchar(100) NOT NULL,
  `playlist_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`song_id`,`playlist_id`),
  KEY `playlist_id` (`playlist_id`),
  CONSTRAINT `phone_music_songs_ibfk_1` FOREIGN KEY (`playlist_id`) REFERENCES `phone_music_playlists` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.phone_notes
DROP TABLE IF EXISTS `phone_notes`;
CREATE TABLE IF NOT EXISTS `phone_notes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `phone_number` varchar(15) NOT NULL,
  `title` varchar(50) NOT NULL,
  `content` longtext DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `phone_number` (`phone_number`),
  CONSTRAINT `phone_notes_ibfk_1` FOREIGN KEY (`phone_number`) REFERENCES `phone_phones` (`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.phone_notifications
DROP TABLE IF EXISTS `phone_notifications`;
CREATE TABLE IF NOT EXISTS `phone_notifications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `phone_number` varchar(15) NOT NULL,
  `app` varchar(50) NOT NULL,
  `title` varchar(50) DEFAULT NULL,
  `content` varchar(500) DEFAULT NULL,
  `thumbnail` varchar(500) DEFAULT NULL,
  `avatar` varchar(500) DEFAULT NULL,
  `show_avatar` tinyint(1) DEFAULT 0,
  `custom_data` text DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `phone_number` (`phone_number`),
  CONSTRAINT `phone_notifications_ibfk_1` FOREIGN KEY (`phone_number`) REFERENCES `phone_phones` (`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.phone_phone_blocked_numbers
DROP TABLE IF EXISTS `phone_phone_blocked_numbers`;
CREATE TABLE IF NOT EXISTS `phone_phone_blocked_numbers` (
  `phone_number` varchar(15) NOT NULL,
  `blocked_number` varchar(15) NOT NULL,
  PRIMARY KEY (`phone_number`,`blocked_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.phone_phone_calls
DROP TABLE IF EXISTS `phone_phone_calls`;
CREATE TABLE IF NOT EXISTS `phone_phone_calls` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `caller` varchar(15) NOT NULL,
  `callee` varchar(15) NOT NULL,
  `duration` int(11) NOT NULL DEFAULT 0,
  `answered` tinyint(1) DEFAULT 0,
  `hide_caller_id` tinyint(1) DEFAULT 0,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.phone_phone_contacts
DROP TABLE IF EXISTS `phone_phone_contacts`;
CREATE TABLE IF NOT EXISTS `phone_phone_contacts` (
  `contact_phone_number` varchar(15) NOT NULL,
  `firstname` varchar(50) NOT NULL DEFAULT '',
  `lastname` varchar(50) NOT NULL DEFAULT '',
  `profile_image` varchar(500) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `address` varchar(50) DEFAULT NULL,
  `favourite` tinyint(1) DEFAULT 0,
  `phone_number` varchar(15) NOT NULL,
  PRIMARY KEY (`contact_phone_number`,`phone_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.phone_phone_voicemail
DROP TABLE IF EXISTS `phone_phone_voicemail`;
CREATE TABLE IF NOT EXISTS `phone_phone_voicemail` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `caller` varchar(15) NOT NULL,
  `callee` varchar(15) NOT NULL,
  `url` varchar(500) NOT NULL,
  `duration` int(11) NOT NULL,
  `hide_caller_id` tinyint(1) DEFAULT 0,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.phone_phones
DROP TABLE IF EXISTS `phone_phones`;
CREATE TABLE IF NOT EXISTS `phone_phones` (
  `id` varchar(100) NOT NULL,
  `owner_id` varchar(100) NOT NULL,
  `phone_number` varchar(15) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `pin` varchar(4) DEFAULT NULL,
  `face_id` varchar(100) DEFAULT NULL,
  `settings` longtext DEFAULT NULL,
  `is_setup` tinyint(1) DEFAULT 0,
  `assigned` tinyint(1) DEFAULT 0,
  `battery` int(11) NOT NULL DEFAULT 100,
  `last_seen` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `phone_number` (`phone_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.phone_photo_album_photos
DROP TABLE IF EXISTS `phone_photo_album_photos`;
CREATE TABLE IF NOT EXISTS `phone_photo_album_photos` (
  `album_id` int(11) NOT NULL,
  `photo_id` int(11) NOT NULL,
  PRIMARY KEY (`album_id`,`photo_id`),
  KEY `photo_id` (`photo_id`),
  CONSTRAINT `phone_photo_album_photos_ibfk_1` FOREIGN KEY (`album_id`) REFERENCES `phone_photo_albums` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `phone_photo_album_photos_ibfk_2` FOREIGN KEY (`photo_id`) REFERENCES `phone_photos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.phone_photo_albums
DROP TABLE IF EXISTS `phone_photo_albums`;
CREATE TABLE IF NOT EXISTS `phone_photo_albums` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `phone_number` varchar(15) NOT NULL,
  `title` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `phone_number` (`phone_number`),
  CONSTRAINT `phone_photo_albums_ibfk_1` FOREIGN KEY (`phone_number`) REFERENCES `phone_phones` (`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.phone_photos
DROP TABLE IF EXISTS `phone_photos`;
CREATE TABLE IF NOT EXISTS `phone_photos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `phone_number` varchar(15) NOT NULL,
  `link` varchar(500) NOT NULL,
  `is_video` tinyint(1) DEFAULT 0,
  `size` float NOT NULL DEFAULT 0,
  `metadata` varchar(20) DEFAULT NULL,
  `is_favourite` tinyint(1) DEFAULT 0,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `phone_number` (`phone_number`),
  CONSTRAINT `phone_photos_ibfk_1` FOREIGN KEY (`phone_number`) REFERENCES `phone_phones` (`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.phone_services_channels
DROP TABLE IF EXISTS `phone_services_channels`;
CREATE TABLE IF NOT EXISTS `phone_services_channels` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `phone_number` varchar(15) NOT NULL,
  `company` varchar(50) NOT NULL,
  `last_message` varchar(100) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.phone_services_messages
DROP TABLE IF EXISTS `phone_services_messages`;
CREATE TABLE IF NOT EXISTS `phone_services_messages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `channel_id` int(10) unsigned NOT NULL,
  `sender` varchar(15) NOT NULL,
  `message` varchar(1000) NOT NULL,
  `x_pos` int(11) DEFAULT NULL,
  `y_pos` int(11) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `channel_id` (`channel_id`),
  CONSTRAINT `phone_services_messages_ibfk_1` FOREIGN KEY (`channel_id`) REFERENCES `phone_services_channels` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.phone_tiktok_accounts
DROP TABLE IF EXISTS `phone_tiktok_accounts`;
CREATE TABLE IF NOT EXISTS `phone_tiktok_accounts` (
  `name` varchar(30) NOT NULL,
  `bio` varchar(100) DEFAULT NULL,
  `avatar` varchar(500) DEFAULT NULL,
  `username` varchar(20) NOT NULL,
  `password` varchar(100) NOT NULL,
  `verified` tinyint(1) DEFAULT 0,
  `follower_count` int(11) NOT NULL DEFAULT 0,
  `following_count` int(11) NOT NULL DEFAULT 0,
  `like_count` int(11) NOT NULL DEFAULT 0,
  `video_count` int(11) NOT NULL DEFAULT 0,
  `twitter` varchar(20) DEFAULT NULL,
  `instagram` varchar(20) DEFAULT NULL,
  `show_likes` tinyint(1) DEFAULT 1,
  `phone_number` varchar(15) NOT NULL,
  `date_joined` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`username`),
  KEY `phone_number` (`phone_number`),
  CONSTRAINT `phone_tiktok_accounts_ibfk_1` FOREIGN KEY (`phone_number`) REFERENCES `phone_phones` (`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.phone_tiktok_channels
DROP TABLE IF EXISTS `phone_tiktok_channels`;
CREATE TABLE IF NOT EXISTS `phone_tiktok_channels` (
  `id` varchar(10) NOT NULL,
  `last_message` varchar(50) NOT NULL,
  `member_1` varchar(20) NOT NULL,
  `member_2` varchar(20) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `member_1` (`member_1`,`member_2`),
  KEY `member_2` (`member_2`),
  CONSTRAINT `phone_tiktok_channels_ibfk_1` FOREIGN KEY (`member_1`) REFERENCES `phone_tiktok_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `phone_tiktok_channels_ibfk_2` FOREIGN KEY (`member_2`) REFERENCES `phone_tiktok_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.phone_tiktok_comments
DROP TABLE IF EXISTS `phone_tiktok_comments`;
CREATE TABLE IF NOT EXISTS `phone_tiktok_comments` (
  `id` varchar(10) NOT NULL,
  `reply_to` varchar(10) DEFAULT NULL,
  `video_id` varchar(10) NOT NULL,
  `username` varchar(20) NOT NULL,
  `comment` varchar(550) NOT NULL,
  `likes` int(11) NOT NULL DEFAULT 0,
  `replies` int(11) NOT NULL DEFAULT 0,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `video_id` (`video_id`),
  KEY `username` (`username`),
  KEY `reply_to` (`reply_to`),
  CONSTRAINT `phone_tiktok_comments_ibfk_1` FOREIGN KEY (`video_id`) REFERENCES `phone_tiktok_videos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `phone_tiktok_comments_ibfk_2` FOREIGN KEY (`username`) REFERENCES `phone_tiktok_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `phone_tiktok_comments_ibfk_3` FOREIGN KEY (`reply_to`) REFERENCES `phone_tiktok_comments` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.phone_tiktok_comments_likes
DROP TABLE IF EXISTS `phone_tiktok_comments_likes`;
CREATE TABLE IF NOT EXISTS `phone_tiktok_comments_likes` (
  `username` varchar(20) NOT NULL,
  `comment_id` varchar(10) NOT NULL,
  PRIMARY KEY (`username`,`comment_id`),
  KEY `comment_id` (`comment_id`),
  CONSTRAINT `phone_tiktok_comments_likes_ibfk_1` FOREIGN KEY (`username`) REFERENCES `phone_tiktok_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `phone_tiktok_comments_likes_ibfk_2` FOREIGN KEY (`comment_id`) REFERENCES `phone_tiktok_comments` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.phone_tiktok_follows
DROP TABLE IF EXISTS `phone_tiktok_follows`;
CREATE TABLE IF NOT EXISTS `phone_tiktok_follows` (
  `followed` varchar(20) NOT NULL,
  `follower` varchar(20) NOT NULL,
  PRIMARY KEY (`followed`,`follower`),
  KEY `follower` (`follower`),
  CONSTRAINT `phone_tiktok_follows_ibfk_1` FOREIGN KEY (`followed`) REFERENCES `phone_tiktok_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `phone_tiktok_follows_ibfk_2` FOREIGN KEY (`follower`) REFERENCES `phone_tiktok_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.phone_tiktok_likes
DROP TABLE IF EXISTS `phone_tiktok_likes`;
CREATE TABLE IF NOT EXISTS `phone_tiktok_likes` (
  `username` varchar(20) NOT NULL,
  `video_id` varchar(10) NOT NULL,
  PRIMARY KEY (`username`,`video_id`),
  KEY `video_id` (`video_id`),
  CONSTRAINT `phone_tiktok_likes_ibfk_1` FOREIGN KEY (`username`) REFERENCES `phone_tiktok_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `phone_tiktok_likes_ibfk_2` FOREIGN KEY (`video_id`) REFERENCES `phone_tiktok_videos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.phone_tiktok_messages
DROP TABLE IF EXISTS `phone_tiktok_messages`;
CREATE TABLE IF NOT EXISTS `phone_tiktok_messages` (
  `id` varchar(10) NOT NULL,
  `channel_id` varchar(10) NOT NULL,
  `sender` varchar(20) NOT NULL,
  `content` varchar(500) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `channel_id` (`channel_id`),
  KEY `sender` (`sender`),
  CONSTRAINT `phone_tiktok_messages_ibfk_1` FOREIGN KEY (`channel_id`) REFERENCES `phone_tiktok_channels` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `phone_tiktok_messages_ibfk_2` FOREIGN KEY (`sender`) REFERENCES `phone_tiktok_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.phone_tiktok_notifications
DROP TABLE IF EXISTS `phone_tiktok_notifications`;
CREATE TABLE IF NOT EXISTS `phone_tiktok_notifications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(20) NOT NULL,
  `from` varchar(20) NOT NULL,
  `type` varchar(20) NOT NULL,
  `video_id` varchar(10) DEFAULT NULL,
  `comment_id` varchar(10) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `username` (`username`),
  KEY `from` (`from`),
  KEY `video_id` (`video_id`),
  KEY `comment_id` (`comment_id`),
  CONSTRAINT `phone_tiktok_notifications_ibfk_1` FOREIGN KEY (`username`) REFERENCES `phone_tiktok_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `phone_tiktok_notifications_ibfk_2` FOREIGN KEY (`from`) REFERENCES `phone_tiktok_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `phone_tiktok_notifications_ibfk_3` FOREIGN KEY (`video_id`) REFERENCES `phone_tiktok_videos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `phone_tiktok_notifications_ibfk_4` FOREIGN KEY (`comment_id`) REFERENCES `phone_tiktok_comments` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.phone_tiktok_pinned_videos
DROP TABLE IF EXISTS `phone_tiktok_pinned_videos`;
CREATE TABLE IF NOT EXISTS `phone_tiktok_pinned_videos` (
  `username` varchar(20) NOT NULL,
  `video_id` varchar(10) NOT NULL,
  PRIMARY KEY (`username`,`video_id`),
  KEY `video_id` (`video_id`),
  CONSTRAINT `phone_tiktok_pinned_videos_ibfk_1` FOREIGN KEY (`username`) REFERENCES `phone_tiktok_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `phone_tiktok_pinned_videos_ibfk_2` FOREIGN KEY (`video_id`) REFERENCES `phone_tiktok_videos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.phone_tiktok_saves
DROP TABLE IF EXISTS `phone_tiktok_saves`;
CREATE TABLE IF NOT EXISTS `phone_tiktok_saves` (
  `username` varchar(20) NOT NULL,
  `video_id` varchar(10) NOT NULL,
  PRIMARY KEY (`username`,`video_id`),
  KEY `video_id` (`video_id`),
  CONSTRAINT `phone_tiktok_saves_ibfk_1` FOREIGN KEY (`username`) REFERENCES `phone_tiktok_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `phone_tiktok_saves_ibfk_2` FOREIGN KEY (`video_id`) REFERENCES `phone_tiktok_videos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.phone_tiktok_unread_messages
DROP TABLE IF EXISTS `phone_tiktok_unread_messages`;
CREATE TABLE IF NOT EXISTS `phone_tiktok_unread_messages` (
  `username` varchar(20) NOT NULL,
  `channel_id` varchar(10) NOT NULL,
  `amount` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`username`,`channel_id`),
  KEY `channel_id` (`channel_id`),
  CONSTRAINT `phone_tiktok_unread_messages_ibfk_1` FOREIGN KEY (`username`) REFERENCES `phone_tiktok_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `phone_tiktok_unread_messages_ibfk_2` FOREIGN KEY (`channel_id`) REFERENCES `phone_tiktok_channels` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.phone_tiktok_videos
DROP TABLE IF EXISTS `phone_tiktok_videos`;
CREATE TABLE IF NOT EXISTS `phone_tiktok_videos` (
  `id` varchar(10) NOT NULL,
  `username` varchar(20) NOT NULL,
  `src` varchar(500) NOT NULL,
  `caption` varchar(100) DEFAULT NULL,
  `metadata` longtext DEFAULT NULL,
  `music` text DEFAULT NULL,
  `likes` int(11) NOT NULL DEFAULT 0,
  `comments` int(11) NOT NULL DEFAULT 0,
  `views` int(11) NOT NULL DEFAULT 0,
  `saves` int(11) NOT NULL DEFAULT 0,
  `pinned_comment` varchar(10) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `username` (`username`),
  CONSTRAINT `phone_tiktok_videos_ibfk_1` FOREIGN KEY (`username`) REFERENCES `phone_tiktok_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.phone_tiktok_views
DROP TABLE IF EXISTS `phone_tiktok_views`;
CREATE TABLE IF NOT EXISTS `phone_tiktok_views` (
  `username` varchar(20) NOT NULL,
  `video_id` varchar(10) NOT NULL,
  PRIMARY KEY (`username`,`video_id`),
  KEY `video_id` (`video_id`),
  CONSTRAINT `phone_tiktok_views_ibfk_1` FOREIGN KEY (`username`) REFERENCES `phone_tiktok_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `phone_tiktok_views_ibfk_2` FOREIGN KEY (`video_id`) REFERENCES `phone_tiktok_videos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.phone_tinder_accounts
DROP TABLE IF EXISTS `phone_tinder_accounts`;
CREATE TABLE IF NOT EXISTS `phone_tinder_accounts` (
  `name` varchar(50) NOT NULL,
  `phone_number` varchar(15) NOT NULL,
  `photos` text DEFAULT NULL,
  `bio` varchar(500) DEFAULT NULL,
  `dob` date NOT NULL,
  `is_male` tinyint(1) NOT NULL,
  `interested_men` tinyint(1) NOT NULL,
  `interested_women` tinyint(1) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`phone_number`),
  CONSTRAINT `phone_tinder_accounts_ibfk_1` FOREIGN KEY (`phone_number`) REFERENCES `phone_phones` (`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.phone_tinder_matches
DROP TABLE IF EXISTS `phone_tinder_matches`;
CREATE TABLE IF NOT EXISTS `phone_tinder_matches` (
  `phone_number_1` varchar(15) NOT NULL,
  `phone_number_2` varchar(15) NOT NULL,
  `latest_message` varchar(1000) DEFAULT NULL,
  `latest_message_timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`phone_number_1`,`phone_number_2`),
  KEY `phone_number_2` (`phone_number_2`),
  CONSTRAINT `phone_tinder_matches_ibfk_1` FOREIGN KEY (`phone_number_1`) REFERENCES `phone_phones` (`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `phone_tinder_matches_ibfk_2` FOREIGN KEY (`phone_number_2`) REFERENCES `phone_phones` (`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.phone_tinder_messages
DROP TABLE IF EXISTS `phone_tinder_messages`;
CREATE TABLE IF NOT EXISTS `phone_tinder_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sender` varchar(15) NOT NULL,
  `recipient` varchar(15) NOT NULL,
  `content` varchar(1000) DEFAULT NULL,
  `attachments` text DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `sender` (`sender`),
  KEY `recipient` (`recipient`),
  CONSTRAINT `phone_tinder_messages_ibfk_1` FOREIGN KEY (`sender`) REFERENCES `phone_phones` (`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `phone_tinder_messages_ibfk_2` FOREIGN KEY (`recipient`) REFERENCES `phone_phones` (`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.phone_tinder_swipes
DROP TABLE IF EXISTS `phone_tinder_swipes`;
CREATE TABLE IF NOT EXISTS `phone_tinder_swipes` (
  `swiper` varchar(15) NOT NULL,
  `swipee` varchar(15) NOT NULL,
  `liked` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`swiper`,`swipee`),
  KEY `swipee` (`swipee`),
  CONSTRAINT `phone_tinder_swipes_ibfk_1` FOREIGN KEY (`swiper`) REFERENCES `phone_phones` (`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `phone_tinder_swipes_ibfk_2` FOREIGN KEY (`swipee`) REFERENCES `phone_phones` (`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.phone_twitter_accounts
DROP TABLE IF EXISTS `phone_twitter_accounts`;
CREATE TABLE IF NOT EXISTS `phone_twitter_accounts` (
  `display_name` varchar(30) NOT NULL,
  `username` varchar(20) NOT NULL,
  `password` varchar(100) NOT NULL,
  `phone_number` varchar(15) NOT NULL,
  `bio` varchar(100) DEFAULT NULL,
  `profile_image` varchar(500) DEFAULT NULL,
  `profile_header` varchar(500) DEFAULT NULL,
  `pinned_tweet` varchar(50) DEFAULT NULL,
  `verified` tinyint(1) DEFAULT 0,
  `follower_count` int(11) NOT NULL DEFAULT 0,
  `following_count` int(11) NOT NULL DEFAULT 0,
  `private` tinyint(1) DEFAULT 0,
  `date_joined` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`username`),
  KEY `phone_number` (`phone_number`),
  CONSTRAINT `phone_twitter_accounts_ibfk_1` FOREIGN KEY (`phone_number`) REFERENCES `phone_phones` (`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.phone_twitter_follow_requests
DROP TABLE IF EXISTS `phone_twitter_follow_requests`;
CREATE TABLE IF NOT EXISTS `phone_twitter_follow_requests` (
  `requester` varchar(20) NOT NULL,
  `requestee` varchar(20) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`requester`,`requestee`),
  KEY `requestee` (`requestee`),
  CONSTRAINT `phone_twitter_follow_requests_ibfk_1` FOREIGN KEY (`requester`) REFERENCES `phone_twitter_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `phone_twitter_follow_requests_ibfk_2` FOREIGN KEY (`requestee`) REFERENCES `phone_twitter_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.phone_twitter_follows
DROP TABLE IF EXISTS `phone_twitter_follows`;
CREATE TABLE IF NOT EXISTS `phone_twitter_follows` (
  `followed` varchar(20) NOT NULL,
  `follower` varchar(20) NOT NULL,
  `notifications` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`followed`,`follower`),
  KEY `follower` (`follower`),
  CONSTRAINT `phone_twitter_follows_ibfk_1` FOREIGN KEY (`followed`) REFERENCES `phone_twitter_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `phone_twitter_follows_ibfk_2` FOREIGN KEY (`follower`) REFERENCES `phone_twitter_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.phone_twitter_hashtags
DROP TABLE IF EXISTS `phone_twitter_hashtags`;
CREATE TABLE IF NOT EXISTS `phone_twitter_hashtags` (
  `hashtag` varchar(50) NOT NULL,
  `amount` int(11) NOT NULL DEFAULT 0,
  `last_used` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`hashtag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.phone_twitter_likes
DROP TABLE IF EXISTS `phone_twitter_likes`;
CREATE TABLE IF NOT EXISTS `phone_twitter_likes` (
  `tweet_id` varchar(50) NOT NULL,
  `username` varchar(20) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`tweet_id`,`username`),
  KEY `username` (`username`),
  CONSTRAINT `phone_twitter_likes_ibfk_1` FOREIGN KEY (`username`) REFERENCES `phone_twitter_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.phone_twitter_messages
DROP TABLE IF EXISTS `phone_twitter_messages`;
CREATE TABLE IF NOT EXISTS `phone_twitter_messages` (
  `id` varchar(10) NOT NULL,
  `sender` varchar(20) NOT NULL,
  `recipient` varchar(20) NOT NULL,
  `content` varchar(1000) DEFAULT NULL,
  `attachments` text DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `sender` (`sender`),
  KEY `recipient` (`recipient`),
  CONSTRAINT `phone_twitter_messages_ibfk_1` FOREIGN KEY (`sender`) REFERENCES `phone_twitter_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `phone_twitter_messages_ibfk_2` FOREIGN KEY (`recipient`) REFERENCES `phone_twitter_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.phone_twitter_notifications
DROP TABLE IF EXISTS `phone_twitter_notifications`;
CREATE TABLE IF NOT EXISTS `phone_twitter_notifications` (
  `id` varchar(10) NOT NULL,
  `username` varchar(20) NOT NULL,
  `from` varchar(20) NOT NULL,
  `type` varchar(20) NOT NULL,
  `tweet_id` varchar(50) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `username` (`username`),
  KEY `from` (`from`),
  CONSTRAINT `phone_twitter_notifications_ibfk_1` FOREIGN KEY (`username`) REFERENCES `phone_twitter_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `phone_twitter_notifications_ibfk_2` FOREIGN KEY (`from`) REFERENCES `phone_twitter_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.phone_twitter_promoted
DROP TABLE IF EXISTS `phone_twitter_promoted`;
CREATE TABLE IF NOT EXISTS `phone_twitter_promoted` (
  `tweet_id` varchar(50) NOT NULL,
  `promotions` int(11) NOT NULL DEFAULT 0,
  `views` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`tweet_id`),
  CONSTRAINT `phone_twitter_promoted_ibfk_1` FOREIGN KEY (`tweet_id`) REFERENCES `phone_twitter_tweets` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.phone_twitter_retweets
DROP TABLE IF EXISTS `phone_twitter_retweets`;
CREATE TABLE IF NOT EXISTS `phone_twitter_retweets` (
  `tweet_id` varchar(50) NOT NULL,
  `username` varchar(20) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`tweet_id`,`username`),
  KEY `username` (`username`),
  CONSTRAINT `phone_twitter_retweets_ibfk_1` FOREIGN KEY (`username`) REFERENCES `phone_twitter_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.phone_twitter_tweets
DROP TABLE IF EXISTS `phone_twitter_tweets`;
CREATE TABLE IF NOT EXISTS `phone_twitter_tweets` (
  `id` varchar(10) NOT NULL,
  `username` varchar(20) NOT NULL,
  `content` varchar(280) DEFAULT NULL,
  `attachments` text DEFAULT NULL,
  `reply_to` varchar(50) DEFAULT NULL,
  `like_count` int(11) DEFAULT 0,
  `reply_count` int(11) DEFAULT 0,
  `retweet_count` int(11) DEFAULT 0,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `username` (`username`),
  CONSTRAINT `phone_twitter_tweets_ibfk_1` FOREIGN KEY (`username`) REFERENCES `phone_twitter_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.phone_voice_memos_recordings
DROP TABLE IF EXISTS `phone_voice_memos_recordings`;
CREATE TABLE IF NOT EXISTS `phone_voice_memos_recordings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `phone_number` varchar(15) NOT NULL,
  `file_name` varchar(50) NOT NULL,
  `file_url` varchar(500) NOT NULL,
  `file_length` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `phone_number` (`phone_number`),
  CONSTRAINT `phone_voice_memos_recordings_ibfk_1` FOREIGN KEY (`phone_number`) REFERENCES `phone_phones` (`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.phone_wallet_transactions
DROP TABLE IF EXISTS `phone_wallet_transactions`;
CREATE TABLE IF NOT EXISTS `phone_wallet_transactions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `phone_number` varchar(15) NOT NULL,
  `amount` int(11) NOT NULL,
  `company` varchar(50) NOT NULL,
  `logo` varchar(200) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `phone_number` (`phone_number`),
  CONSTRAINT `phone_wallet_transactions_ibfk_1` FOREIGN KEY (`phone_number`) REFERENCES `phone_phones` (`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.phone_yellow_pages_posts
DROP TABLE IF EXISTS `phone_yellow_pages_posts`;
CREATE TABLE IF NOT EXISTS `phone_yellow_pages_posts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `phone_number` varchar(15) NOT NULL,
  `title` varchar(50) NOT NULL,
  `description` varchar(1000) NOT NULL,
  `attachment` varchar(500) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.playerdata
DROP TABLE IF EXISTS `playerdata`;
CREATE TABLE IF NOT EXISTS `playerdata` (
  `user_id` int(11) NOT NULL,
  `dkey` varchar(100) NOT NULL,
  `dvalue` text DEFAULT NULL,
  PRIMARY KEY (`user_id`,`dkey`),
  KEY `user_id` (`user_id`),
  KEY `dkey` (`dkey`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.police_officers
DROP TABLE IF EXISTS `police_officers`;
CREATE TABLE IF NOT EXISTS `police_officers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `rank` varchar(50) DEFAULT 'Estagiário',
  `level` int(11) DEFAULT 8,
  `hire_date` varchar(20) DEFAULT NULL,
  `hired_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.prison
DROP TABLE IF EXISTS `prison`;
CREATE TABLE IF NOT EXISTS `prison` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `police` varchar(255) DEFAULT '0',
  `nuser_id` int(11) NOT NULL DEFAULT 0,
  `services` int(11) NOT NULL DEFAULT 0,
  `fines` int(20) NOT NULL DEFAULT 0,
  `text` longtext DEFAULT NULL,
  `date` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.propertys
DROP TABLE IF EXISTS `propertys`;
CREATE TABLE IF NOT EXISTS `propertys` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT 'Homes0001',
  `interior` varchar(50) NOT NULL DEFAULT 'Middle',
  `tax` int(20) NOT NULL DEFAULT 0,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `price` int(20) NOT NULL DEFAULT 0,
  `residents` int(1) NOT NULL DEFAULT 1,
  `vault` int(10) NOT NULL DEFAULT 1,
  `fridge` int(10) NOT NULL DEFAULT 1,
  `owner` int(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.races
DROP TABLE IF EXISTS `races`;
CREATE TABLE IF NOT EXISTS `races` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `raceid` int(3) NOT NULL DEFAULT 0,
  `user_id` int(5) NOT NULL DEFAULT 0,
  `name` varchar(100) NOT NULL DEFAULT 'Individuo Indigente',
  `vehicle` varchar(50) NOT NULL DEFAULT 'Sultan RS',
  `points` int(20) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.razebank_transactions
DROP TABLE IF EXISTS `razebank_transactions`;
CREATE TABLE IF NOT EXISTS `razebank_transactions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `receiver_identifier` varchar(255) NOT NULL,
  `receiver_name` varchar(255) NOT NULL,
  `sender_identifier` varchar(255) NOT NULL,
  `sender_name` varchar(255) NOT NULL,
  `date` varchar(255) NOT NULL,
  `value` int(50) NOT NULL,
  `type` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.smartphone_bank_invoices
DROP TABLE IF EXISTS `smartphone_bank_invoices`;
CREATE TABLE IF NOT EXISTS `smartphone_bank_invoices` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `payee_id` int(11) NOT NULL,
  `payer_id` int(11) NOT NULL,
  `reason` varchar(255) NOT NULL DEFAULT '',
  `value` int(11) NOT NULL,
  `paid` tinyint(4) NOT NULL DEFAULT 0,
  `created_at` int(11) NOT NULL,
  `updated_at` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.smartphone_blocks
DROP TABLE IF EXISTS `smartphone_blocks`;
CREATE TABLE IF NOT EXISTS `smartphone_blocks` (
  `user_id` int(11) NOT NULL,
  `phone` varchar(32) NOT NULL,
  PRIMARY KEY (`user_id`,`phone`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.smartphone_calls
DROP TABLE IF EXISTS `smartphone_calls`;
CREATE TABLE IF NOT EXISTS `smartphone_calls` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `initiator` varchar(255) NOT NULL,
  `target` varchar(255) NOT NULL,
  `duration` int(11) NOT NULL DEFAULT 0,
  `status` varchar(255) NOT NULL,
  `video` tinyint(4) NOT NULL DEFAULT 0,
  `anonymous` tinyint(4) NOT NULL DEFAULT 0,
  `created_at` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `initiator_index` (`initiator`),
  KEY `target_index` (`target`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.smartphone_casino
DROP TABLE IF EXISTS `smartphone_casino`;
CREATE TABLE IF NOT EXISTS `smartphone_casino` (
  `user_id` int(11) NOT NULL,
  `balance` bigint(20) NOT NULL DEFAULT 0,
  `double` bigint(20) NOT NULL DEFAULT 0,
  `crash` bigint(20) NOT NULL DEFAULT 0,
  `mine` bigint(20) NOT NULL DEFAULT 0,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.smartphone_contacts
DROP TABLE IF EXISTS `smartphone_contacts`;
CREATE TABLE IF NOT EXISTS `smartphone_contacts` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `owner` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `owner_index` (`owner`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.smartphone_gallery
DROP TABLE IF EXISTS `smartphone_gallery`;
CREATE TABLE IF NOT EXISTS `smartphone_gallery` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `folder` varchar(255) NOT NULL DEFAULT '/',
  `url` varchar(255) NOT NULL,
  `created_at` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.smartphone_instagram
DROP TABLE IF EXISTS `smartphone_instagram`;
CREATE TABLE IF NOT EXISTS `smartphone_instagram` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `username` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `bio` varchar(255) NOT NULL,
  `avatarURL` varchar(255) DEFAULT NULL,
  `verified` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.smartphone_instagram_followers
DROP TABLE IF EXISTS `smartphone_instagram_followers`;
CREATE TABLE IF NOT EXISTS `smartphone_instagram_followers` (
  `follower_id` bigint(20) NOT NULL,
  `profile_id` bigint(20) NOT NULL,
  PRIMARY KEY (`follower_id`,`profile_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.smartphone_instagram_likes
DROP TABLE IF EXISTS `smartphone_instagram_likes`;
CREATE TABLE IF NOT EXISTS `smartphone_instagram_likes` (
  `post_id` bigint(20) NOT NULL,
  `profile_id` bigint(20) NOT NULL,
  PRIMARY KEY (`post_id`,`profile_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.smartphone_instagram_notifications
DROP TABLE IF EXISTS `smartphone_instagram_notifications`;
CREATE TABLE IF NOT EXISTS `smartphone_instagram_notifications` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `profile_id` int(11) NOT NULL,
  `author_id` int(11) NOT NULL,
  `content` varchar(512) NOT NULL,
  `saw` tinyint(4) NOT NULL DEFAULT 0,
  `created_at` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `profile_id_index` (`profile_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.smartphone_instagram_posts
DROP TABLE IF EXISTS `smartphone_instagram_posts`;
CREATE TABLE IF NOT EXISTS `smartphone_instagram_posts` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `profile_id` bigint(20) NOT NULL,
  `post_id` bigint(20) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `content` varchar(255) DEFAULT NULL,
  `created_at` bigint(20) NOT NULL,
  `comments` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `profile_id_index` (`profile_id`),
  KEY `post_id_index` (`post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.smartphone_olx
DROP TABLE IF EXISTS `smartphone_olx`;
CREATE TABLE IF NOT EXISTS `smartphone_olx` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `category` varchar(255) NOT NULL,
  `price` int(11) NOT NULL,
  `description` varchar(1024) NOT NULL,
  `images` varchar(1024) NOT NULL,
  `created_at` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.smartphone_paypal_transactions
DROP TABLE IF EXISTS `smartphone_paypal_transactions`;
CREATE TABLE IF NOT EXISTS `smartphone_paypal_transactions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `target` bigint(20) NOT NULL,
  `type` varchar(255) NOT NULL DEFAULT 'payment',
  `description` varchar(255) DEFAULT NULL,
  `value` bigint(20) NOT NULL,
  `created_at` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id_index` (`user_id`),
  KEY `target_index` (`target`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.smartphone_tinder
DROP TABLE IF EXISTS `smartphone_tinder`;
CREATE TABLE IF NOT EXISTS `smartphone_tinder` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `image` varchar(255) NOT NULL,
  `bio` varchar(1024) NOT NULL,
  `age` tinyint(4) NOT NULL,
  `gender` varchar(255) NOT NULL,
  `show_gender` tinyint(4) NOT NULL,
  `tags` varchar(255) NOT NULL,
  `show_tags` tinyint(4) NOT NULL,
  `target` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id_index` (`user_id`),
  KEY `gender_index` (`gender`),
  KEY `target_index` (`target`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.smartphone_tinder_messages
DROP TABLE IF EXISTS `smartphone_tinder_messages`;
CREATE TABLE IF NOT EXISTS `smartphone_tinder_messages` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `sender` int(11) NOT NULL,
  `target` int(11) NOT NULL,
  `content` varchar(255) NOT NULL,
  `liked` tinyint(4) NOT NULL DEFAULT 0,
  `created_at` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sender_index` (`sender`),
  KEY `target_index` (`target`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.smartphone_tinder_rating
DROP TABLE IF EXISTS `smartphone_tinder_rating`;
CREATE TABLE IF NOT EXISTS `smartphone_tinder_rating` (
  `profile_id` int(11) NOT NULL,
  `rated_id` int(11) NOT NULL,
  `rating` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`profile_id`,`rated_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.smartphone_tor_messages
DROP TABLE IF EXISTS `smartphone_tor_messages`;
CREATE TABLE IF NOT EXISTS `smartphone_tor_messages` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `channel` varchar(24) NOT NULL DEFAULT 'geral',
  `sender` varchar(255) NOT NULL,
  `image` varchar(512) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `content` varchar(500) DEFAULT NULL,
  `created_at` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `channel_index` (`channel`),
  KEY `sender_index` (`sender`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.smartphone_tor_payments
DROP TABLE IF EXISTS `smartphone_tor_payments`;
CREATE TABLE IF NOT EXISTS `smartphone_tor_payments` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `sender` bigint(20) NOT NULL,
  `target` bigint(20) NOT NULL,
  `amount` int(11) NOT NULL,
  `created_at` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sender_index` (`sender`),
  KEY `target_index` (`target`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.smartphone_twitter_followers
DROP TABLE IF EXISTS `smartphone_twitter_followers`;
CREATE TABLE IF NOT EXISTS `smartphone_twitter_followers` (
  `follower_id` bigint(20) NOT NULL,
  `profile_id` bigint(20) NOT NULL,
  KEY `profile_id_index` (`profile_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.smartphone_twitter_likes
DROP TABLE IF EXISTS `smartphone_twitter_likes`;
CREATE TABLE IF NOT EXISTS `smartphone_twitter_likes` (
  `tweet_id` bigint(20) NOT NULL,
  `profile_id` bigint(20) NOT NULL,
  KEY `tweet_id_index` (`tweet_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.smartphone_twitter_profiles
DROP TABLE IF EXISTS `smartphone_twitter_profiles`;
CREATE TABLE IF NOT EXISTS `smartphone_twitter_profiles` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `avatarURL` varchar(255) NOT NULL,
  `bannerURL` varchar(255) NOT NULL,
  `bio` varchar(255) DEFAULT NULL,
  `verified` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.smartphone_twitter_tweets
DROP TABLE IF EXISTS `smartphone_twitter_tweets`;
CREATE TABLE IF NOT EXISTS `smartphone_twitter_tweets` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `profile_id` int(11) NOT NULL,
  `tweet_id` bigint(20) DEFAULT NULL,
  `content` varchar(280) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `profile_id_index` (`profile_id`),
  KEY `tweet_id_index` (`tweet_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.smartphone_uber_trips
DROP TABLE IF EXISTS `smartphone_uber_trips`;
CREATE TABLE IF NOT EXISTS `smartphone_uber_trips` (
  `id` varchar(10) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `driver_id` int(11) DEFAULT NULL,
  `total` int(11) DEFAULT NULL,
  `from` varchar(255) DEFAULT NULL,
  `to` varchar(255) DEFAULT NULL,
  `user_rate` tinyint(4) DEFAULT 0,
  `driver_rate` tinyint(4) DEFAULT 0,
  `created_at` int(11) DEFAULT NULL,
  `finished_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.smartphone_weazel
DROP TABLE IF EXISTS `smartphone_weazel`;
CREATE TABLE IF NOT EXISTS `smartphone_weazel` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `author` varchar(255) NOT NULL,
  `tag` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` varchar(4096) NOT NULL,
  `imageURL` varchar(255) DEFAULT NULL,
  `videoURL` varchar(255) DEFAULT NULL,
  `views` int(11) NOT NULL DEFAULT 0,
  `created_at` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.smartphone_whatsapp
DROP TABLE IF EXISTS `smartphone_whatsapp`;
CREATE TABLE IF NOT EXISTS `smartphone_whatsapp` (
  `owner` varchar(32) NOT NULL,
  `avatarURL` varchar(255) DEFAULT NULL,
  `read_receipts` tinyint(4) NOT NULL DEFAULT 1,
  PRIMARY KEY (`owner`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.smartphone_whatsapp_channels
DROP TABLE IF EXISTS `smartphone_whatsapp_channels`;
CREATE TABLE IF NOT EXISTS `smartphone_whatsapp_channels` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `sender` varchar(50) NOT NULL,
  `target` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sender_index` (`sender`),
  KEY `target_index` (`target`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.smartphone_whatsapp_groups
DROP TABLE IF EXISTS `smartphone_whatsapp_groups`;
CREATE TABLE IF NOT EXISTS `smartphone_whatsapp_groups` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `avatarURL` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `members` varchar(2048) NOT NULL,
  `created_at` bigint(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.smartphone_whatsapp_messages
DROP TABLE IF EXISTS `smartphone_whatsapp_messages`;
CREATE TABLE IF NOT EXISTS `smartphone_whatsapp_messages` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `channel_id` bigint(20) unsigned NOT NULL,
  `sender` varchar(50) NOT NULL,
  `image` varchar(512) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `content` varchar(500) DEFAULT NULL,
  `deleted_by` varchar(255) DEFAULT NULL,
  `readed` tinyint(4) NOT NULL DEFAULT 0,
  `saw_at` bigint(20) NOT NULL DEFAULT 0,
  `created_at` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sender_index` (`sender`),
  KEY `channel_id_index` (`channel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.vehicles
DROP TABLE IF EXISTS `vehicles`;
CREATE TABLE IF NOT EXISTS `vehicles` (
  `user_id` int(11) NOT NULL,
  `vehicle` varchar(100) NOT NULL,
  `tax` int(20) NOT NULL DEFAULT 0,
  `plate` varchar(20) DEFAULT NULL,
  `rental` int(20) NOT NULL DEFAULT 0,
  `rendays` int(11) NOT NULL DEFAULT 0,
  `arrest` int(20) NOT NULL DEFAULT 0,
  `engine` int(4) NOT NULL DEFAULT 1000,
  `body` int(4) NOT NULL DEFAULT 1000,
  `fuel` int(3) NOT NULL DEFAULT 100,
  `nitro` int(4) NOT NULL DEFAULT 0,
  `work` varchar(5) NOT NULL DEFAULT 'false',
  `doors` varchar(254) NOT NULL,
  `windows` varchar(254) NOT NULL,
  `tyres` varchar(254) NOT NULL,
  `vip_expiry` int(11) DEFAULT 0,
  PRIMARY KEY (`user_id`,`vehicle`),
  KEY `user_id` (`user_id`),
  KEY `vehicle` (`vehicle`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.vrp_banco
DROP TABLE IF EXISTS `vrp_banco`;
CREATE TABLE IF NOT EXISTS `vrp_banco` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `extrato` varchar(255) DEFAULT NULL,
  `data` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela blacknetwork.ws_gamepass
DROP TABLE IF EXISTS `ws_gamepass`;
CREATE TABLE IF NOT EXISTS `ws_gamepass` (
  `user_id` int(11) NOT NULL,
  `level` int(11) DEFAULT 1,
  `xp` int(11) DEFAULT 0,
  `received` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `unique_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para trigger blacknetwork.phone_instagram_decrement_comment_count
DROP TRIGGER IF EXISTS `phone_instagram_decrement_comment_count`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER IF NOT EXISTS phone_instagram_decrement_comment_count
AFTER DELETE ON phone_instagram_comments
FOR EACH ROW
BEGIN
    UPDATE phone_instagram_posts
    SET comment_count = comment_count - 1
    WHERE id = OLD.post_id;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Copiando estrutura para trigger blacknetwork.phone_instagram_decrement_like_count
DROP TRIGGER IF EXISTS `phone_instagram_decrement_like_count`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER IF NOT EXISTS phone_instagram_decrement_like_count
AFTER DELETE ON phone_instagram_likes
FOR EACH ROW
BEGIN
    IF OLD.is_comment = 0 THEN
        UPDATE phone_instagram_posts
        SET like_count = like_count - 1
        WHERE id = OLD.id;
    ELSE
        UPDATE phone_instagram_comments
        SET like_count = like_count - 1
        WHERE id = OLD.id;
    END IF;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Copiando estrutura para trigger blacknetwork.phone_instagram_decrement_post_count
DROP TRIGGER IF EXISTS `phone_instagram_decrement_post_count`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER IF NOT EXISTS phone_instagram_decrement_post_count
AFTER DELETE ON phone_instagram_posts
FOR EACH ROW
BEGIN
    UPDATE phone_instagram_accounts
    SET post_count = post_count - 1
    WHERE username = OLD.username;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Copiando estrutura para trigger blacknetwork.phone_instagram_decrement_story_count
DROP TRIGGER IF EXISTS `phone_instagram_decrement_story_count`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER IF NOT EXISTS phone_instagram_decrement_story_count
AFTER DELETE ON phone_instagram_stories
FOR EACH ROW
BEGIN
    UPDATE phone_instagram_accounts
    SET story_count = story_count - 1
    WHERE username = OLD.username;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Copiando estrutura para trigger blacknetwork.phone_instagram_increment_comment_count
DROP TRIGGER IF EXISTS `phone_instagram_increment_comment_count`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER IF NOT EXISTS phone_instagram_increment_comment_count
AFTER INSERT ON phone_instagram_comments
FOR EACH ROW
BEGIN
    UPDATE phone_instagram_posts
    SET comment_count = comment_count + 1
    WHERE id = NEW.post_id;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Copiando estrutura para trigger blacknetwork.phone_instagram_increment_like_count
DROP TRIGGER IF EXISTS `phone_instagram_increment_like_count`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER IF NOT EXISTS phone_instagram_increment_like_count
AFTER INSERT ON phone_instagram_likes
FOR EACH ROW
BEGIN
    IF NEW.is_comment = 0 THEN
        UPDATE phone_instagram_posts
        SET like_count = like_count + 1
        WHERE id = NEW.id;
    ELSE
        UPDATE phone_instagram_comments
        SET like_count = like_count + 1
        WHERE id = NEW.id;
    END IF;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Copiando estrutura para trigger blacknetwork.phone_instagram_increment_post_count
DROP TRIGGER IF EXISTS `phone_instagram_increment_post_count`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER IF NOT EXISTS phone_instagram_increment_post_count
AFTER INSERT ON phone_instagram_posts
FOR EACH ROW
BEGIN
    UPDATE phone_instagram_accounts
    SET post_count = post_count + 1
    WHERE username = NEW.username;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Copiando estrutura para trigger blacknetwork.phone_instagram_increment_story_count
DROP TRIGGER IF EXISTS `phone_instagram_increment_story_count`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER IF NOT EXISTS phone_instagram_increment_story_count
AFTER INSERT ON phone_instagram_stories
FOR EACH ROW
BEGIN
    UPDATE phone_instagram_accounts
    SET story_count = story_count + 1
    WHERE username = NEW.username;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Copiando estrutura para trigger blacknetwork.phone_instagram_update_counts_after_follow
DROP TRIGGER IF EXISTS `phone_instagram_update_counts_after_follow`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER IF NOT EXISTS phone_instagram_update_counts_after_follow
AFTER INSERT ON phone_instagram_follows
FOR EACH ROW
BEGIN
    UPDATE phone_instagram_accounts
    SET follower_count = follower_count + 1
    WHERE username = NEW.followed;

    UPDATE phone_instagram_accounts
    SET following_count = following_count + 1
    WHERE username = NEW.follower;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Copiando estrutura para trigger blacknetwork.phone_instagram_update_counts_after_unfollow
DROP TRIGGER IF EXISTS `phone_instagram_update_counts_after_unfollow`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER IF NOT EXISTS phone_instagram_update_counts_after_unfollow
AFTER DELETE ON phone_instagram_follows
FOR EACH ROW
BEGIN
    UPDATE phone_instagram_accounts
    SET follower_count = follower_count - 1
    WHERE username = OLD.followed;

    UPDATE phone_instagram_accounts
    SET following_count = following_count - 1
    WHERE username = OLD.follower;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Copiando estrutura para trigger blacknetwork.phone_tiktok_decrement_account_likes
DROP TRIGGER IF EXISTS `phone_tiktok_decrement_account_likes`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER IF NOT EXISTS phone_tiktok_decrement_account_likes
AFTER DELETE ON phone_tiktok_likes
FOR EACH ROW
BEGIN
    UPDATE phone_tiktok_accounts
    JOIN phone_tiktok_videos ON phone_tiktok_videos.username = phone_tiktok_accounts.username
    SET phone_tiktok_accounts.like_count = phone_tiktok_accounts.like_count - 1
    WHERE phone_tiktok_videos.id = OLD.video_id;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Copiando estrutura para trigger blacknetwork.phone_tiktok_decrement_comment_likes
DROP TRIGGER IF EXISTS `phone_tiktok_decrement_comment_likes`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER IF NOT EXISTS phone_tiktok_decrement_comment_likes
AFTER DELETE ON phone_tiktok_comments_likes
FOR EACH ROW
BEGIN
    UPDATE phone_tiktok_comments
    SET likes = likes - 1
    WHERE id = OLD.comment_id;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Copiando estrutura para trigger blacknetwork.phone_tiktok_decrement_video_comments
DROP TRIGGER IF EXISTS `phone_tiktok_decrement_video_comments`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER IF NOT EXISTS phone_tiktok_decrement_video_comments
BEFORE DELETE ON phone_tiktok_comments
FOR EACH ROW
BEGIN
    DECLARE v_replies_count INT;

    -- Count the replies for the comment
    SELECT COUNT(*) INTO v_replies_count
    FROM phone_tiktok_comments
    WHERE reply_to = OLD.id;

    -- Update the video's comments count
    UPDATE phone_tiktok_videos
    SET comments = comments - (1 + v_replies_count)
    WHERE id = OLD.video_id;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Copiando estrutura para trigger blacknetwork.phone_tiktok_decrement_video_likes
DROP TRIGGER IF EXISTS `phone_tiktok_decrement_video_likes`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER IF NOT EXISTS phone_tiktok_decrement_video_likes
AFTER DELETE ON phone_tiktok_likes
FOR EACH ROW
BEGIN
    UPDATE phone_tiktok_videos
    SET likes = likes - 1
    WHERE id = OLD.video_id;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Copiando estrutura para trigger blacknetwork.phone_tiktok_decrement_video_saves
DROP TRIGGER IF EXISTS `phone_tiktok_decrement_video_saves`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER IF NOT EXISTS phone_tiktok_decrement_video_saves
AFTER DELETE ON phone_tiktok_saves
FOR EACH ROW
BEGIN
    UPDATE phone_tiktok_videos
    SET saves = saves - 1
    WHERE id = OLD.video_id;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Copiando estrutura para trigger blacknetwork.phone_tiktok_increment_account_likes
DROP TRIGGER IF EXISTS `phone_tiktok_increment_account_likes`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER IF NOT EXISTS phone_tiktok_increment_account_likes
AFTER INSERT ON phone_tiktok_likes
FOR EACH ROW
BEGIN
    UPDATE phone_tiktok_accounts
    JOIN phone_tiktok_videos ON phone_tiktok_videos.username = phone_tiktok_accounts.username
    SET phone_tiktok_accounts.like_count = phone_tiktok_accounts.like_count + 1
    WHERE phone_tiktok_videos.id = NEW.video_id;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Copiando estrutura para trigger blacknetwork.phone_tiktok_increment_comment_likes
DROP TRIGGER IF EXISTS `phone_tiktok_increment_comment_likes`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER IF NOT EXISTS phone_tiktok_increment_comment_likes
AFTER INSERT ON phone_tiktok_comments_likes
FOR EACH ROW
BEGIN
    UPDATE phone_tiktok_comments
    SET likes = likes + 1
    WHERE id = NEW.comment_id;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Copiando estrutura para trigger blacknetwork.phone_tiktok_increment_video_comments
DROP TRIGGER IF EXISTS `phone_tiktok_increment_video_comments`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER IF NOT EXISTS phone_tiktok_increment_video_comments
AFTER INSERT ON phone_tiktok_comments
FOR EACH ROW
BEGIN
    UPDATE phone_tiktok_videos
    SET comments = comments + 1
    WHERE id = NEW.video_id;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Copiando estrutura para trigger blacknetwork.phone_tiktok_increment_video_count
DROP TRIGGER IF EXISTS `phone_tiktok_increment_video_count`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER IF NOT EXISTS phone_tiktok_increment_video_count
AFTER INSERT ON phone_tiktok_videos
FOR EACH ROW
BEGIN
    UPDATE phone_tiktok_accounts
    SET video_count = video_count + 1
    WHERE username = NEW.username;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Copiando estrutura para trigger blacknetwork.phone_tiktok_increment_video_likes
DROP TRIGGER IF EXISTS `phone_tiktok_increment_video_likes`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER IF NOT EXISTS phone_tiktok_increment_video_likes
AFTER INSERT ON phone_tiktok_likes
FOR EACH ROW
BEGIN
    UPDATE phone_tiktok_videos
    SET likes = likes + 1
    WHERE id = NEW.video_id;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Copiando estrutura para trigger blacknetwork.phone_tiktok_increment_video_saves
DROP TRIGGER IF EXISTS `phone_tiktok_increment_video_saves`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER IF NOT EXISTS phone_tiktok_increment_video_saves
AFTER INSERT ON phone_tiktok_saves
FOR EACH ROW
BEGIN
    UPDATE phone_tiktok_videos
    SET saves = saves + 1
    WHERE id = NEW.video_id;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Copiando estrutura para trigger blacknetwork.phone_tiktok_increment_video_views
DROP TRIGGER IF EXISTS `phone_tiktok_increment_video_views`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER IF NOT EXISTS phone_tiktok_increment_video_views
AFTER INSERT ON phone_tiktok_views
FOR EACH ROW
BEGIN
    UPDATE phone_tiktok_videos
    SET views = views + 1
    WHERE id = NEW.video_id;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Copiando estrutura para trigger blacknetwork.phone_tiktok_update_counts_after_follow
DROP TRIGGER IF EXISTS `phone_tiktok_update_counts_after_follow`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER IF NOT EXISTS phone_tiktok_update_counts_after_follow
AFTER INSERT ON phone_tiktok_follows
FOR EACH ROW
BEGIN
    -- Increment the follower_count for the followed user
    UPDATE phone_tiktok_accounts
    SET follower_count = follower_count + 1
    WHERE username = NEW.followed;

    -- Increment the following_count for the follower user
    UPDATE phone_tiktok_accounts
    SET following_count = following_count + 1
    WHERE username = NEW.follower;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Copiando estrutura para trigger blacknetwork.phone_tiktok_update_counts_after_unfollow
DROP TRIGGER IF EXISTS `phone_tiktok_update_counts_after_unfollow`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER IF NOT EXISTS phone_tiktok_update_counts_after_unfollow
AFTER DELETE ON phone_tiktok_follows
FOR EACH ROW
BEGIN
    -- Decrement the follower_count for the followed user
    UPDATE phone_tiktok_accounts
    SET follower_count = follower_count - 1
    WHERE username = OLD.followed;

    -- Decrement the following_count for the follower user
    UPDATE phone_tiktok_accounts
    SET following_count = following_count - 1
    WHERE username = OLD.follower;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Copiando estrutura para trigger blacknetwork.phone_tiktok_update_last_message
DROP TRIGGER IF EXISTS `phone_tiktok_update_last_message`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER IF NOT EXISTS phone_tiktok_update_last_message
AFTER INSERT ON phone_tiktok_messages
FOR EACH ROW
BEGIN
    DECLARE modified_content TEXT CHARACTER SET utf8mb4;

    IF NEW.content LIKE '<!SHARED-VIDEO-URL%' THEN
        SET modified_content = 'Shared a video';
    ELSEIF LENGTH(NEW.content) > 50 THEN
        SET modified_content = CONCAT(SUBSTR(NEW.content, 1, 17), '...');
    ELSE
        SET modified_content = NEW.content;
    END IF;

    UPDATE phone_tiktok_channels
    SET last_message = modified_content
    WHERE id = NEW.channel_id;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Copiando estrutura para trigger blacknetwork.phone_twitter_update_counts_after_follow
DROP TRIGGER IF EXISTS `phone_twitter_update_counts_after_follow`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER IF NOT EXISTS phone_twitter_update_counts_after_follow
AFTER INSERT ON phone_twitter_follows
FOR EACH ROW
BEGIN
    -- Increment the follower_count for the followed user
    UPDATE phone_twitter_accounts
    SET follower_count = follower_count + 1
    WHERE username = NEW.followed;

    -- Increment the following_count for the follower user
    UPDATE phone_twitter_accounts
    SET following_count = following_count + 1
    WHERE username = NEW.follower;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Copiando estrutura para trigger blacknetwork.phone_twitter_update_counts_after_unfollow
DROP TRIGGER IF EXISTS `phone_twitter_update_counts_after_unfollow`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER IF NOT EXISTS phone_twitter_update_counts_after_unfollow
AFTER DELETE ON phone_twitter_follows
FOR EACH ROW
BEGIN
    -- Decrement the follower_count for the followed user
    UPDATE phone_twitter_accounts
    SET follower_count = follower_count - 1
    WHERE username = OLD.followed;

    -- Decrement the following_count for the follower user
    UPDATE phone_twitter_accounts
    SET following_count = following_count - 1
    WHERE username = OLD.follower;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Copiando estrutura para trigger blacknetwork.phone_twitter_update_like_count_after_like
DROP TRIGGER IF EXISTS `phone_twitter_update_like_count_after_like`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER IF NOT EXISTS phone_twitter_update_like_count_after_like
AFTER INSERT ON phone_twitter_likes
FOR EACH ROW
BEGIN
    UPDATE phone_twitter_tweets
    SET like_count = like_count + 1
    WHERE id = NEW.tweet_id;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Copiando estrutura para trigger blacknetwork.phone_twitter_update_like_count_after_unlike
DROP TRIGGER IF EXISTS `phone_twitter_update_like_count_after_unlike`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER IF NOT EXISTS phone_twitter_update_like_count_after_unlike
AFTER DELETE ON phone_twitter_likes
FOR EACH ROW
BEGIN
    UPDATE phone_twitter_tweets
    SET like_count = like_count - 1
    WHERE id = OLD.tweet_id;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Copiando estrutura para trigger blacknetwork.phone_twitter_update_retweet_count_after_retweet
DROP TRIGGER IF EXISTS `phone_twitter_update_retweet_count_after_retweet`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER IF NOT EXISTS phone_twitter_update_retweet_count_after_retweet
AFTER INSERT ON phone_twitter_retweets
FOR EACH ROW
BEGIN
    UPDATE phone_twitter_tweets
    SET retweet_count = retweet_count + 1
    WHERE id = NEW.tweet_id;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Copiando estrutura para trigger blacknetwork.phone_twitter_update_retweet_count_after_unretweet
DROP TRIGGER IF EXISTS `phone_twitter_update_retweet_count_after_unretweet`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER IF NOT EXISTS phone_twitter_update_retweet_count_after_unretweet
AFTER DELETE ON phone_twitter_retweets
FOR EACH ROW
BEGIN
    UPDATE phone_twitter_tweets
    SET retweet_count = retweet_count - 1
    WHERE id = OLD.tweet_id;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
