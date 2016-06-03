-- phpMyAdmin SQL Dump
-- version 4.5.2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jun 03, 2016 at 01:01 PM
-- Server version: 10.1.10-MariaDB
-- PHP Version: 7.0.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `kconq`
--

-- --------------------------------------------------------

--
-- Table structure for table `buffs`
--

CREATE TABLE `buffs` (
  `buff_id` int(11) NOT NULL,
  `buff_name` varchar(64) NOT NULL,
  `graphics` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `buffs`
--

INSERT INTO `buffs` (`buff_id`, `buff_name`, `graphics`) VALUES
(1, 'heal', 'graphics/spritesheet/spell/ss_heal.png'),
(2, 'burning', 'graphics/spritesheet/spell/ss_burning.png');

-- --------------------------------------------------------

--
-- Table structure for table `chat`
--

CREATE TABLE `chat` (
  `chat_id` int(11) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `user` int(11) NOT NULL,
  `message` text NOT NULL,
  `room_id` int(11) NOT NULL,
  `chat_type` set('message','event') NOT NULL DEFAULT 'message',
  `colour` set('red','blue') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `chat`
--

INSERT INTO `chat` (`chat_id`, `created`, `user`, `message`, `room_id`, `chat_type`, `colour`) VALUES
(32, '2016-06-02 12:21:13', 9, 'Wumpus joined the room.', 27, 'event', ''),
(33, '2016-06-02 12:27:12', 7, 'DragonSlayer52 joined the room.', 27, 'event', ''),
(34, '2016-06-02 18:00:58', 9, 'dfg', 27, 'message', ''),
(35, '2016-06-02 18:01:01', 9, 'Wumpus left the game.', 27, 'event', ''),
(36, '2016-06-02 18:09:06', 7, 'DragonSlayer52 joined the room.', 28, 'event', ''),
(37, '2016-06-02 18:09:18', 9, 'Wumpus joined the room.', 28, 'event', ''),
(38, '2016-06-03 09:12:39', 9, 'Wumpus joined the room.', 29, 'event', ''),
(39, '2016-06-03 09:15:22', 6, 'xXN1NJ4Xx joined the room.', 29, 'event', ''),
(40, '2016-06-03 09:17:40', 6, '[02:33pm] yomomma: hey mom', 29, 'message', ''),
(41, '2016-06-03 09:26:09', 6, 'xXN1NJ4Xx left the game.', 29, 'event', ''),
(42, '2016-06-03 09:27:09', 9, 'Wumpus left the game.', 29, 'event', ''),
(43, '2016-06-03 09:27:13', 9, 'hi everyone', 0, 'message', ''),
(44, '2016-06-03 09:27:14', 9, 'how is it going', 0, 'message', ''),
(45, '2016-06-03 09:27:21', 9, 'cool', 0, 'message', ''),
(46, '2016-06-03 09:28:15', 6, 'dfs', 0, 'message', ''),
(47, '2016-06-03 09:28:18', 6, 'yeaa', 0, 'message', ''),
(48, '2016-06-03 09:28:22', 6, 'hh', 0, 'message', ''),
(49, '2016-06-03 09:29:27', 6, 'yo', 0, 'message', ''),
(50, '2016-06-03 10:02:23', 9, 'w', 0, 'message', ''),
(51, '2016-06-03 10:02:27', 9, 'oh hiyaa', 0, 'message', ''),
(52, '2016-06-03 10:02:59', 9, 'ew', 0, 'message', ''),
(53, '2016-06-03 10:05:21', 9, 'w', 0, 'message', ''),
(54, '2016-06-03 10:05:22', 9, 'am', 0, 'message', ''),
(55, '2016-06-03 10:05:24', 9, 'yeaa', 0, 'message', ''),
(56, '2016-06-03 10:05:25', 9, 'cool', 0, 'message', ''),
(57, '2016-06-03 10:05:28', 9, 'lol', 0, 'message', ''),
(58, '2016-06-03 10:07:11', 9, 'lol', 0, 'message', ''),
(59, '2016-06-03 10:07:12', 9, 'ikr', 0, 'message', '');

-- --------------------------------------------------------

--
-- Table structure for table `classes`
--

CREATE TABLE `classes` (
  `class_id` int(11) NOT NULL,
  `name` varchar(32) NOT NULL,
  `address` varchar(64) NOT NULL,
  `spritesheet` varchar(64) NOT NULL,
  `info` varchar(64) NOT NULL,
  `max_hp` int(11) NOT NULL,
  `attack` int(11) NOT NULL,
  `skill` varchar(64) NOT NULL,
  `skillMaxCD` int(11) NOT NULL,
  `moveRange` int(11) NOT NULL,
  `attackRange` int(11) NOT NULL,
  `damageEffect` varchar(64) NOT NULL,
  `gold` int(11) NOT NULL DEFAULT '100',
  `luck` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `classes`
--

INSERT INTO `classes` (`class_id`, `name`, `address`, `spritesheet`, `info`, `max_hp`, `attack`, `skill`, `skillMaxCD`, `moveRange`, `attackRange`, `damageEffect`, `gold`, `luck`) VALUES
(1, 'wizard', 'graphics/spritesheet/stand/ss_wizard_stand.png', 'graphics/spritesheet/attack/ss_wizard_attack.png', 'graphics/card/wizard_card.png', 200, 15, 'Magic Damage', 3, 3, 3, 'graphics/spritesheet/spell/ss_fireball.png', 100, 0.25),
(2, 'archer', 'graphics/spritesheet/stand/ss_archer_stand.png', 'graphics/spritesheet/attack/ss_archer_attack.png', 'graphics/card/archer_card.png', 200, 20, 'Double Shoot', 3, 3, 4, 'graphics/spritesheet/spell/ss_arrow.png', 100, 0.4),
(3, 'knight', 'graphics/spritesheet/stand/ss_knight_stand.png', 'graphics/spritesheet/attack/ss_knight_attack.png', 'graphics/card/knight_card.png', 300, 40, 'Shield', 3, 2, 1, 'graphics/spritesheet/spell/ss_physical_attack.png', 100, 0.15),
(4, 'king', 'graphics/spritesheet/stand/ss_king_stand.png', 'graphics/spritesheet/attack/ss_king_attack.png', 'graphics/card/king_card.png', 400, 25, 'Buffer', 3, 3, 2, 'graphics/spritesheet/spell/ss_physical_attack.png', 0, 0.2),
(5, 'red castle', 'graphics/spritesheet/special_unit/ss_castle_red.png', 'graphics/spritesheet/attack/ss_archer_attack.png', 'graphics/card/castle_card.png', 999, 999, 'RED', 0, 0, 10, 'graphics/spritesheet/spell/ss_physical_attack.png', 100, 0),
(6, 'blue castle', 'graphics/spritesheet/special_unit/ss_castle_blue.png', 'graphics/spritesheet/attack/ss_archer_attack.png', 'graphics/card/castle_card.png', 999, 999, 'BLUE', 0, 0, 10, 'graphics/spritesheet/spell/ss_physical_attack.png', 100, 0);

-- --------------------------------------------------------

--
-- Table structure for table `login`
--

CREATE TABLE `login` (
  `userid` int(11) NOT NULL,
  `socialid` varchar(64) NOT NULL,
  `type` set('Facebook','Twitter','GooglePlus') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `login`
--

INSERT INTO `login` (`userid`, `socialid`, `type`) VALUES
(6, '1071989516156754', 'Facebook');

-- --------------------------------------------------------

--
-- Table structure for table `maps`
--

CREATE TABLE `maps` (
  `map_id` int(11) NOT NULL,
  `map_name` varchar(64) NOT NULL,
  `points` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `maps`
--

INSERT INTO `maps` (`map_id`, `map_name`, `points`) VALUES
(1, 'The Bridge', '{"0":[4, 4, 4, 0 ,1, 1, 1, 1, 1, 1, 1, 0, 1 ,0],\n "1":[4, 4, 4, 4 ,4, 4, 5, 5, 5, 5, 5, 5, 6 ,5],\n "2":[4, 4, 4, 0 ,1, 4, 5, 5, 5, 5, 5, 5, 6 ,5],\n "3":[0, 0, 0, 0 ,1, 4, 5, 5, 4, 4, 4, 0, 1 ,0],\n "4":[0, 1, 1, 1 ,1, 4, 3, 3, 4, 1, 1, 1, 1 ,0],\n "5":[0, 1, 1, 1 ,1, 4, 5, 5, 4, 1, 1, 1, 1 ,0],\n "6":[0, 1, 1, 1 ,1, 1, 5, 5, 1, 1, 1, 1, 1 ,0],\n "7":[0, 1, 1, 1 ,1, 4, 5, 5, 4, 1, 1, 1, 1 ,0],\n "8":[0, 1, 1, 1 ,1, 4, 3, 3, 4, 1, 1, 1, 1 ,0],\n "9":[0, 1, 1, 1 ,1, 4, 5, 5, 4, 1, 0, 0, 0 ,0],\n "10":[5, 6, 5, 5 ,5, 5, 5, 5, 4, 1, 0, 4, 4 ,4],\n "11":[5, 6, 5, 5 ,5, 5, 5, 5, 4, 4, 4, 4, 4 ,4],\n "12":[0, 1, 0, 1 ,1, 1, 1, 1, 1, 1, 0, 4, 4 ,4]\n}');

-- --------------------------------------------------------

--
-- Table structure for table `rooms`
--

CREATE TABLE `rooms` (
  `room_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `joiner` int(11) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `name` varchar(64) NOT NULL,
  `password` varchar(64) NOT NULL,
  `max_players` tinyint(4) NOT NULL DEFAULT '2',
  `state` set('pregame','ingame','ended','deleted') NOT NULL DEFAULT 'pregame',
  `turn` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `rooms`
--

INSERT INTO `rooms` (`room_id`, `user_id`, `joiner`, `created`, `name`, `password`, `max_players`, `state`, `turn`) VALUES
(29, 9, 0, '2016-06-03 09:27:09', 'hello world', 'hello world', 2, 'deleted', 0);

-- --------------------------------------------------------

--
-- Table structure for table `room_participants`
--

CREATE TABLE `room_participants` (
  `part_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `room_id` int(11) NOT NULL,
  `colour` set('red','blue') NOT NULL,
  `state` set('notready','ready','owner') NOT NULL DEFAULT 'notready',
  `event` set('kicked','left') NOT NULL,
  `gold` int(11) NOT NULL DEFAULT '500'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `units`
--

CREATE TABLE `units` (
  `unit_id` int(11) NOT NULL,
  `class_id` int(11) NOT NULL,
  `hp` int(11) NOT NULL,
  `max_hp` int(11) NOT NULL,
  `attack` int(11) NOT NULL,
  `skillCoolDown` int(11) NOT NULL,
  `x` int(11) NOT NULL,
  `y` int(11) NOT NULL,
  `team` int(11) NOT NULL,
  `canMove` tinyint(1) NOT NULL DEFAULT '1',
  `canAttack` tinyint(1) NOT NULL DEFAULT '1',
  `outOfMoves` tinyint(1) NOT NULL DEFAULT '0',
  `room_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `units`
--

INSERT INTO `units` (`unit_id`, `class_id`, `hp`, `max_hp`, `attack`, `skillCoolDown`, `x`, `y`, `team`, `canMove`, `canAttack`, `outOfMoves`, `room_id`) VALUES
(50, 4, 400, 400, 25, 0, 3, 2, 0, 1, 1, 0, 27),
(51, 5, 999, 999, 999, 0, 0, 0, 0, 1, 1, 0, 27),
(52, 1, 200, 200, 15, 0, 3, 3, 0, 1, 1, 0, 27),
(53, 3, 300, 300, 40, 0, 0, 2, 0, 1, 1, 0, 27),
(54, 2, 200, 200, 20, 0, 0, 3, 0, 1, 1, 0, 27),
(55, 4, 400, 400, 25, 0, 9, 11, 1, 1, 1, 0, 27),
(56, 6, 999, 999, 999, 0, 12, 13, 1, 1, 1, 0, 27),
(57, 1, 200, 200, 15, 0, 9, 10, 1, 1, 1, 0, 27),
(58, 3, 300, 300, 40, 0, 12, 10, 1, 1, 1, 0, 27),
(59, 2, 200, 200, 20, 0, 12, 11, 1, 1, 1, 0, 27),
(60, 2, 200, 200, 20, 0, 2, 3, 1, 1, 1, 0, 27),
(61, 1, 200, 200, 15, 0, 1, 3, 1, 1, 1, 0, 27),
(62, 4, 400, 400, 25, 0, 3, 2, 0, 1, 1, 0, 28),
(63, 5, 999, 999, 999, 0, 0, 0, 0, 1, 1, 0, 28),
(64, 1, 200, 200, 15, 0, 3, 3, 0, 1, 1, 0, 28),
(65, 3, 300, 300, 40, 0, 0, 2, 0, 1, 1, 0, 28),
(66, 2, 200, 200, 20, 0, 0, 3, 0, 1, 1, 0, 28),
(67, 4, 400, 400, 25, 0, 9, 11, 1, 1, 1, 0, 28),
(68, 6, 999, 999, 999, 0, 12, 13, 1, 1, 1, 0, 28),
(69, 1, 200, 200, 15, 0, 9, 10, 1, 1, 1, 0, 28),
(70, 3, 300, 300, 40, 0, 12, 10, 1, 1, 1, 0, 28),
(71, 2, 200, 200, 20, 0, 12, 11, 1, 1, 1, 0, 28),
(72, 1, 200, 200, 15, 0, 1, 3, 1, 1, 1, 0, 28),
(73, 2, 200, 200, 20, 0, 2, 3, 1, 1, 1, 0, 28),
(74, 3, 300, 300, 40, 0, 3, 1, 0, 1, 1, 0, 28),
(75, 3, 300, 300, 40, 0, 1, 1, 0, 1, 1, 0, 28),
(76, 1, 200, 200, 15, 0, 2, 2, 0, 1, 1, 0, 28),
(77, 2, 200, 200, 20, 0, 1, 0, 0, 1, 1, 0, 28),
(78, 1, 200, 200, 15, 0, 0, 1, 0, 1, 1, 0, 28),
(79, 1, 200, 200, 15, 0, 1, 2, 1, 1, 1, 0, 28),
(80, 1, 200, 200, 15, 0, 2, 1, 1, 1, 1, 0, 28),
(81, 1, 200, 200, 15, 0, 2, 0, 1, 1, 1, 0, 28),
(82, 1, 200, 200, 15, 0, 3, 0, 1, 1, 1, 0, 28);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `password` varchar(64) NOT NULL,
  `email` varchar(64) NOT NULL,
  `username` varchar(64) NOT NULL,
  `wins` int(11) NOT NULL,
  `losses` int(11) NOT NULL,
  `elo` smallint(6) NOT NULL DEFAULT '1000',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `password`, `email`, `username`, `wins`, `losses`, `elo`, `created`) VALUES
(6, '$2y$10$zmsIcYDqp8ScNRuDcj9jD.kbsW9vC7k655flzcYK66kC0jkWa0toK', 'alanduu50@gmail.com', 'xXN1NJ4Xx', 343, 148, 1000, '2016-05-23 21:22:33'),
(7, '$2y$10$xGKFvkCEjUMSm1y6cr8v/.IsJCZfLhNtigg0eyETXQYbslu5X1IBK', 'kld14@ic.ac.uk', 'DragonSlayer52', 358, 145, 1000, '2016-05-23 21:22:01'),
(8, '$2y$10$s7PfGa0iZcg2XDFrmEAnhegSMZzKi4Po4GyUEl1E9cA69tUJj5qSa', 'test@test.com', 'HaskellPrize', 147, 23, 1000, '2016-05-23 21:20:45'),
(9, '$2y$10$y8geeo6e4vVMUkhJWycFruGOuplLwujzm8q4RZlZQPpkn6RKbkfpS', 'demo@demo.com', 'Wumpus', 193, 64, 1000, '2016-05-23 21:20:18'),
(10, '$2y$10$h9fvGHQrrOHh35pNzhIsqOR.0jDi4ZmVtHiCvP1wCexLef072jYqy', 'tonyfield@rules.com', 'OhBaby', 214, 26, 1000, '2016-05-23 18:59:26'),
(11, '$2y$10$jOeNVa.g.MTq8j7NoOY3k.RTVeYpcrxA7gq8zv8hp9yiVBsk0z3C.', 'debug@debug.com', 'debug', 212, 52, 1000, '2016-06-01 20:52:54'),
(12, '$2y$10$7.dtDYkyCuARy8JOOvnEM..015QDAO7YDKsNEmue6deyEyJvIDwr2', 'goku@goku.com', 'goku', 211, 62, 1000, '2016-06-01 20:53:04'),
(13, '$2y$10$EVxl9C85A3EGzS9/mbr4mO1eZwdAa7RoFtuXRU.4lwdohCezvuQTu', 'veg@veg.com', 'veg', 311, 73, 1000, '2016-06-01 20:53:57');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `buffs`
--
ALTER TABLE `buffs`
  ADD PRIMARY KEY (`buff_id`);

--
-- Indexes for table `chat`
--
ALTER TABLE `chat`
  ADD PRIMARY KEY (`chat_id`);

--
-- Indexes for table `classes`
--
ALTER TABLE `classes`
  ADD PRIMARY KEY (`class_id`);

--
-- Indexes for table `login`
--
ALTER TABLE `login`
  ADD PRIMARY KEY (`socialid`,`type`);

--
-- Indexes for table `maps`
--
ALTER TABLE `maps`
  ADD PRIMARY KEY (`map_id`);

--
-- Indexes for table `rooms`
--
ALTER TABLE `rooms`
  ADD PRIMARY KEY (`room_id`);

--
-- Indexes for table `room_participants`
--
ALTER TABLE `room_participants`
  ADD PRIMARY KEY (`part_id`);

--
-- Indexes for table `units`
--
ALTER TABLE `units`
  ADD PRIMARY KEY (`unit_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `buffs`
--
ALTER TABLE `buffs`
  MODIFY `buff_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `chat`
--
ALTER TABLE `chat`
  MODIFY `chat_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=60;
--
-- AUTO_INCREMENT for table `classes`
--
ALTER TABLE `classes`
  MODIFY `class_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `maps`
--
ALTER TABLE `maps`
  MODIFY `map_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `rooms`
--
ALTER TABLE `rooms`
  MODIFY `room_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;
--
-- AUTO_INCREMENT for table `room_participants`
--
ALTER TABLE `room_participants`
  MODIFY `part_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=98;
--
-- AUTO_INCREMENT for table `units`
--
ALTER TABLE `units`
  MODIFY `unit_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=83;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
