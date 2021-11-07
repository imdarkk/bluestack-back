-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Εξυπηρετητής: 127.0.0.1
-- Χρόνος δημιουργίας: 07 Νοε 2021 στις 13:50:27
-- Έκδοση διακομιστή: 10.4.21-MariaDB
-- Έκδοση PHP: 8.0.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Βάση δεδομένων: `bluestack`
--

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `cars`
--

CREATE TABLE `cars` (
  `license_plate` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Άδειασμα δεδομένων του πίνακα `cars`
--

INSERT INTO `cars` (`license_plate`) VALUES
('KPS902'),
('KHJ202');

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `jobs`
--

CREATE TABLE `jobs` (
  `Id` int(11) NOT NULL,
  `Subject` varchar(255) NOT NULL,
  `Location` varchar(255) NOT NULL,
  `StartTime` varchar(255) NOT NULL,
  `EndTime` varchar(255) NOT NULL,
  `IsAllDay` tinyint(4) NOT NULL,
  `Description` varchar(255) NOT NULL,
  `RecurrenceRule` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Άδειασμα δεδομένων του πίνακα `jobs`
--

INSERT INTO `jobs` (`Id`, `Subject`, `Location`, `StartTime`, `EndTime`, `IsAllDay`, `Description`, `RecurrenceRule`) VALUES
(1, 'A/C Installation', 'Megdova 4A', '2021-11-01T07:30:00.000Z', '2021-11-01T08:00:00.000Z', 0, 'Customer # - 99000000', NULL);

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `stock`
--

CREATE TABLE `stock` (
  `id` int(11) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `in_stock` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Άδειασμα δεδομένων του πίνακα `stock`
--

INSERT INTO `stock` (`id`, `product_name`, `in_stock`) VALUES
(1, '3/8\" Copper Pipe', 24.5),
(2, '1/4\" Copper Pipe', 14);

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `tools`
--

CREATE TABLE `tools` (
  `id` int(11) NOT NULL,
  `tool` varchar(255) NOT NULL,
  `category` varchar(255) NOT NULL,
  `car` varchar(10) NOT NULL,
  `amount` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Άδειασμα δεδομένων του πίνακα `tools`
--

INSERT INTO `tools` (`id`, `tool`, `category`, `car`, `amount`) VALUES
(1, 'Flare Box', 'ac', 'KPS902', 1),
(2, 'Pipe Cutter', 'ac', 'KHJ202', 1),
(3, 'Pipe Cutter', 'ac', 'KPS902', 1);

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `tool_category`
--

CREATE TABLE `tool_category` (
  `id` int(11) NOT NULL,
  `category` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Άδειασμα δεδομένων του πίνακα `tool_category`
--

INSERT INTO `tool_category` (`id`, `category`) VALUES
(1, 'ac'),
(2, 'plumbing'),
(3, 'heating');

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(2000) NOT NULL,
  `email` varchar(2000) NOT NULL,
  `name` varchar(200) NOT NULL,
  `surname` varchar(200) NOT NULL,
  `phoneNumber` varchar(200) NOT NULL,
  `role` varchar(20) NOT NULL DEFAULT 'employee'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Άδειασμα δεδομένων του πίνακα `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `email`, `name`, `surname`, `phoneNumber`, `role`) VALUES
(1, 'marios', '$2b$12$0YRBRsYWtjliiOIVD5uebusivyMU4YLmdWJlYrMaYr1nfsw.cbPTe', 'kmarios2005@gmail.com', 'marios', 'kyriacou', '96658220', 'admin'),
(2, 'kyriacos', '$2b$12$Aidm8TzYhFvcM12qi6S.Iedrp3UCYpBINqoD6RRZ/psZULldi41SK', 'koulliskyr@primehome.com', 'kyriacos', 'kyriacou', '99677076', 'employee');

--
-- Ευρετήρια για άχρηστους πίνακες
--

--
-- Ευρετήρια για πίνακα `stock`
--
ALTER TABLE `stock`
  ADD PRIMARY KEY (`id`);

--
-- Ευρετήρια για πίνακα `tools`
--
ALTER TABLE `tools`
  ADD PRIMARY KEY (`id`);

--
-- Ευρετήρια για πίνακα `tool_category`
--
ALTER TABLE `tool_category`
  ADD PRIMARY KEY (`id`);

--
-- Ευρετήρια για πίνακα `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT για άχρηστους πίνακες
--

--
-- AUTO_INCREMENT για πίνακα `stock`
--
ALTER TABLE `stock`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT για πίνακα `tools`
--
ALTER TABLE `tools`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT για πίνακα `tool_category`
--
ALTER TABLE `tool_category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT για πίνακα `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
