-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3308
-- Generation Time: Jun 20, 2025 at 07:17 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `agritrack`
--

-- --------------------------------------------------------

--
-- Table structure for table `crops`
--

CREATE TABLE `crops` (
  `crop_id` int(11) NOT NULL,
  `user_email` varchar(255) NOT NULL,
  `crop_name` varchar(100) NOT NULL,
  `planting_date` date NOT NULL,
  `status` varchar(50) NOT NULL,
  `notes` text DEFAULT NULL,
  `image_path` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `crops`
--

INSERT INTO `crops` (`crop_id`, `user_email`, `crop_name`, `planting_date`, `status`, `notes`, `image_path`) VALUES
(12, 'aqilmizwar42@gmail.com', 'Corn', '2025-06-21', 'Germination', 'bejkaa', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `equipment`
--

CREATE TABLE `equipment` (
  `equipment_id` int(11) NOT NULL,
  `user_email` varchar(255) NOT NULL,
  `equipment_name` varchar(100) NOT NULL,
  `condition_status` varchar(50) NOT NULL CHECK (`condition_status` in ('Excellent','Good','Needs Maintenance','Out of Service')),
  `last_maintenance` date DEFAULT NULL,
  `next_maintenance` date DEFAULT NULL,
  `hours_used` int(11) DEFAULT 0,
  `equipment_type` varchar(50) NOT NULL DEFAULT 'Tractor',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `harvest_plans`
--

CREATE TABLE `harvest_plans` (
  `plan_id` int(11) NOT NULL,
  `crop_id` int(11) DEFAULT NULL,
  `harvest_date` date NOT NULL,
  `season_type` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `harvest_plans`
--

INSERT INTO `harvest_plans` (`plan_id`, `crop_id`, `harvest_date`, `season_type`) VALUES
(13, 12, '2025-09-29', 'Dry');

-- --------------------------------------------------------

--
-- Table structure for table `suggested_crops`
--

CREATE TABLE `suggested_crops` (
  `suggestion_id` int(11) NOT NULL,
  `crop_name` varchar(255) NOT NULL,
  `suggested_by_user_id` int(11) DEFAULT NULL,
  `suggestion_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `suggested_crops`
--

INSERT INTO `suggested_crops` (`suggestion_id`, `crop_name`, `suggested_by_user_id`, `suggestion_date`) VALUES
(1, 'tomato', NULL, '2025-06-11 18:31:17'),
(2, 'Wheat', NULL, '2025-06-11 18:36:38'),
(3, 'Corn', NULL, '2025-06-11 18:48:58'),
(4, 'Soybeans', NULL, '2025-06-11 19:02:43');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `email` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `reset_code` varchar(10) DEFAULT NULL,
  `reset_code_expiry` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`email`, `password`, `reset_code`, `reset_code_expiry`) VALUES
('aqilmizwar42@gmail.com', 'aqil0113', NULL, NULL),
('wan@test.com', '123456', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user_profiles`
--

CREATE TABLE `user_profiles` (
  `email` varchar(255) NOT NULL,
  `full_name` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `farm_size` varchar(100) DEFAULT NULL,
  `main_crops` text DEFAULT NULL,
  `member_since` date DEFAULT NULL,
  `profile_image_url` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_profiles`
--

INSERT INTO `user_profiles` (`email`, `full_name`, `title`, `phone_number`, `location`, `farm_size`, `main_crops`, `member_since`, `profile_image_url`) VALUES
('aqilmizwar42@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `crops`
--
ALTER TABLE `crops`
  ADD PRIMARY KEY (`crop_id`);

--
-- Indexes for table `equipment`
--
ALTER TABLE `equipment`
  ADD PRIMARY KEY (`equipment_id`),
  ADD KEY `fk_equipment_user` (`user_email`);

--
-- Indexes for table `harvest_plans`
--
ALTER TABLE `harvest_plans`
  ADD PRIMARY KEY (`plan_id`),
  ADD KEY `harvest_plans_ibfk_1` (`crop_id`);

--
-- Indexes for table `suggested_crops`
--
ALTER TABLE `suggested_crops`
  ADD PRIMARY KEY (`suggestion_id`),
  ADD UNIQUE KEY `uq_crop_name` (`crop_name`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `user_profiles`
--
ALTER TABLE `user_profiles`
  ADD PRIMARY KEY (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `crops`
--
ALTER TABLE `crops`
  MODIFY `crop_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `equipment`
--
ALTER TABLE `equipment`
  MODIFY `equipment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `harvest_plans`
--
ALTER TABLE `harvest_plans`
  MODIFY `plan_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `suggested_crops`
--
ALTER TABLE `suggested_crops`
  MODIFY `suggestion_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `equipment`
--
ALTER TABLE `equipment`
  ADD CONSTRAINT `fk_equipment_user` FOREIGN KEY (`user_email`) REFERENCES `users` (`email`) ON DELETE CASCADE;

--
-- Constraints for table `harvest_plans`
--
ALTER TABLE `harvest_plans`
  ADD CONSTRAINT `harvest_plans_ibfk_1` FOREIGN KEY (`crop_id`) REFERENCES `crops` (`crop_id`) ON DELETE CASCADE;

--
-- Constraints for table `user_profiles`
--
ALTER TABLE `user_profiles`
  ADD CONSTRAINT `fk_user_email` FOREIGN KEY (`email`) REFERENCES `users` (`email`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
