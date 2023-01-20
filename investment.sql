-- phpMyAdmin SQL Dump
-- version 5.1.1deb5ubuntu1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Oct 10, 2022 at 08:30 AM
-- Server version: 8.0.30-0ubuntu0.22.04.1
-- PHP Version: 8.1.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `investment`
--

-- --------------------------------------------------------

--
-- Table structure for table `ck_admins`
--

CREATE TABLE `ck_admins` (
  `id` int NOT NULL,
  `username` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` int NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL,
  `modified_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ck_faq_categories`
--

CREATE TABLE `ck_faq_categories` (
  `id` int NOT NULL,
  `category_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `status` int UNSIGNED DEFAULT '1',
  `created_at` timestamp NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  `modified_at` timestamp NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ck_faq_categories`
--

INSERT INTO `ck_faq_categories` (`id`, `category_name`, `status`, `created_at`, `modified_at`) VALUES
(1, 'test 1', 1, '2022-10-10 01:08:42', '2022-10-10 01:08:42'),
(2, 'test2', 1, '2022-10-10 01:08:42', '2022-10-10 01:08:42'),
(3, 'test 3', 1, '2022-10-10 01:08:42', '2022-10-10 01:08:42'),
(4, 'test4', 0, '2022-10-10 01:26:25', '2022-10-10 01:08:42');

-- --------------------------------------------------------

--
-- Table structure for table `ck_faq_question_answers`
--

CREATE TABLE `ck_faq_question_answers` (
  `id` int NOT NULL,
  `category_id` int NOT NULL,
  `question` tinytext COLLATE utf8mb4_unicode_ci,
  `answer` text COLLATE utf8mb4_unicode_ci,
  `status` int NOT NULL,
  `created_at` timestamp NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  `modified_at` timestamp NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ck_faq_question_answers`
--

INSERT INTO `ck_faq_question_answers` (`id`, `category_id`, `question`, `answer`, `status`, `created_at`, `modified_at`) VALUES
(1, 1, 'question1', 'answer1', 1, '2022-10-10 01:09:43', '2022-10-10 01:09:43'),
(2, 1, 'question2', 'answer2', 1, '2022-10-10 01:09:43', '2022-10-11 01:09:43'),
(3, 1, 'question3', 'answer3', 1, '2022-10-10 01:09:43', '2022-10-10 01:09:43'),
(4, 1, 'question4', 'answer4', 1, '2022-10-10 01:09:43', '2022-10-11 01:09:43'),
(5, 2, 'question5', 'answer5', 1, '2022-10-10 01:09:43', '2022-10-10 01:09:43'),
(6, 3, 'question6', 'answer6', 1, '2022-10-10 01:09:43', '2022-10-11 01:09:43');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `ck_admins`
--
ALTER TABLE `ck_admins`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `ck_faq_categories`
--
ALTER TABLE `ck_faq_categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_name` (`category_name`);

--
-- Indexes for table `ck_faq_question_answers`
--
ALTER TABLE `ck_faq_question_answers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_id` (`category_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `ck_admins`
--
ALTER TABLE `ck_admins`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ck_faq_categories`
--
ALTER TABLE `ck_faq_categories`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `ck_faq_question_answers`
--
ALTER TABLE `ck_faq_question_answers`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
