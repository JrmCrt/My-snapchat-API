-- phpMyAdmin SQL Dump
-- version 4.4.13.1deb1
-- http://www.phpmyadmin.net
--
-- Client :  localhost
-- Généré le :  Lun 20 Juin 2016 à 11:22
-- Version du serveur :  5.6.30-0ubuntu0.15.10.1
-- Version de PHP :  5.6.11-1ubuntu3.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `snapchatAPI`
--
CREATE DATABASE IF NOT EXISTS `snapchatAPI` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `snapchatAPI`;

-- --------------------------------------------------------

--
-- Structure de la table `friends`
--

CREATE TABLE IF NOT EXISTS `friends` (
  `id` int(11) NOT NULL,
  `user_id1` int(11) DEFAULT NULL,
  `user_id2` int(11) DEFAULT NULL,
  `accepted` tinyint(1) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Contenu de la table `friends`
--

INSERT INTO `friends` (`id`, `user_id1`, `user_id2`, `accepted`, `created_at`, `updated_at`) VALUES
(3, 19, 17, 0, '2016-06-16 14:07:47', '2016-06-16 14:07:47'),
(4, 18, 17, 0, '2016-06-16 14:08:40', '2016-06-16 14:08:40');

-- --------------------------------------------------------

--
-- Structure de la table `schema_migrations`
--

CREATE TABLE IF NOT EXISTS `schema_migrations` (
  `version` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `schema_migrations`
--

INSERT INTO `schema_migrations` (`version`) VALUES
('20160607150723'),
('20160613110140'),
('20160614124117'),
('20160614133541'),
('20160616132310');

-- --------------------------------------------------------

--
-- Structure de la table `snaps`
--

CREATE TABLE IF NOT EXISTS `snaps` (
  `id` int(11) NOT NULL,
  `sender_id` int(11) DEFAULT NULL,
  `recipient_id` int(11) DEFAULT NULL,
  `duration` int(11) DEFAULT NULL,
  `file` varchar(255) DEFAULT NULL,
  `seen` tinyint(1) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Contenu de la table `snaps`
--

INSERT INTO `snaps` (`id`, `sender_id`, `recipient_id`, `duration`, `file`, `seen`, `created_at`, `updated_at`) VALUES
(1, 17, 19, 5, 'http://snapchat.samsung-campus.net/img/BTyWhn2jKE2HtUH0e_EuH4qriSNqgf94.', 1, '0000-00-00 00:00:00', '2016-06-15 14:38:05'),
(2, 18, 19, 5, 'http://snapchat.samsung-campus.net/img/BTyWhn2jKE2HtUH0e_EuH4qriSNqgf94.', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(3, 17, 18, 10, 'http://10.34.1.226/uploads/7b9c1850880f543d50436a0fd66bc4338a9f01fa.jpg', 0, '2016-06-18 14:51:38', '2016-06-18 14:51:38'),
(4, 17, 19, 10, 'http://10.34.1.226/uploads/7b9c1850880f543d50436a0fd66bc4338a9f01fa.jpg', 0, '2016-06-18 14:51:38', '2016-06-18 14:51:38');

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=latin1;

--
-- Contenu de la table `users`
--

INSERT INTO `users` (`id`, `password`, `email`, `token`, `created_at`, `updated_at`) VALUES
(17, 'password', 'crete_j@epitech.eu', 'ee6955a268b3f9afe077c44686a6f295558639f9', '2016-06-13 13:49:21', '2016-06-15 09:17:30'),
(18, 'password', 'crete_o@epitech.eu', '696c6f18c1b4384290e7e37f93d51365f845101a', '2016-06-13 21:53:50', '2016-06-13 21:53:50'),
(19, 'password', 'crete_jerome@epitech.eu', '350b7a50901017fcba6f9b12e9cf276f1380bca7', '2016-06-14 13:13:39', '2016-06-15 11:09:38'),
(28, 'password', 'crete_jeromeeeeeee@epitech.eu', '822238e01c7c66c367ac2ee6d2d04902f8e33413', '2016-06-15 09:49:37', '2016-06-15 09:49:37');

--
-- Index pour les tables exportées
--

--
-- Index pour la table `friends`
--
ALTER TABLE `friends`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `schema_migrations`
--
ALTER TABLE `schema_migrations`
  ADD UNIQUE KEY `unique_schema_migrations` (`version`);

--
-- Index pour la table `snaps`
--
ALTER TABLE `snaps`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT pour les tables exportées
--

--
-- AUTO_INCREMENT pour la table `friends`
--
ALTER TABLE `friends`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT pour la table `snaps`
--
ALTER TABLE `snaps`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT pour la table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=29;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
