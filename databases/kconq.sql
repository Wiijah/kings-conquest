-- phpMyAdmin SQL Dump
-- version 4.5.2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: May 24, 2016 at 07:59 PM
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
-- Table structure for table `chat`
--

CREATE TABLE `chat` (
  `chat_id` int(11) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user` int(11) NOT NULL,
  `message` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `chat`
--

INSERT INTO `chat` (`chat_id`, `created`, `user`, `message`) VALUES
(1, '2016-05-23 22:32:34', 6, 'Hi there, I''m a new player!'),
(2, '2016-05-23 22:32:49', 7, 'Cool, nice to see you! xD :D'),
(50, '2016-05-24 01:16:01', 9, 'hey, my name is wumpus, please to meet you guys!'),
(51, '2016-05-24 01:49:32', 9, 'oh baby!'),
(52, '2016-05-24 01:59:23', 9, 'anyone wanna game?'),
(53, '2016-05-24 09:54:11', 9, 'yeah'),
(54, '2016-05-24 09:54:20', 9, 'fdg'),
(55, '2016-05-24 09:54:21', 9, 'fag'),
(56, '2016-05-24 09:54:27', 9, 'sdfs'),
(57, '2016-05-24 09:54:49', 7, 'yea'),
(58, '2016-05-24 09:54:52', 9, 'noice'),
(59, '2016-05-24 12:54:37', 9, 'yo'),
(60, '2016-05-24 12:54:39', 9, 'how'),
(61, '2016-05-24 12:54:40', 9, 'are you guys'),
(62, '2016-05-24 12:54:42', 9, 'i don''t know'),
(63, '2016-05-24 12:54:44', 9, 'how  am i'),
(64, '2016-05-24 12:54:46', 9, 'asoijdioasjd '),
(65, '2016-05-24 12:54:53', 9, 'testing one two three @&quot;@&quot;&quot;@&quot;&quot;&quot;''''''''X:D&quot;LZ&quot;:XLC&quot;:ZXLC'),
(66, '2016-05-24 12:54:57', 9, '&lt;b&gt;sdfjsidof&lt;/b&gt;'),
(67, '2016-05-24 12:55:14', 9, '''; delete table users; --'),
(68, '2016-05-24 14:25:20', 9, 'i like dark forest'),
(69, '2016-05-24 14:25:22', 9, 'can we play that'),
(70, '2016-05-24 14:25:23', 9, 'thanks!'),
(71, '2016-05-24 14:25:25', 9, 'in advacne ;]'),
(73, '2016-05-24 15:43:57', 9, 'hi'),
(74, '2016-05-24 15:43:59', 9, 'so'),
(75, '2016-05-24 15:44:02', 9, 'i'),
(76, '2016-05-24 15:44:04', 9, 'need'),
(77, '2016-05-24 15:44:05', 9, 'some food'),
(78, '2016-05-24 15:44:06', 9, 'right now'),
(80, '2016-05-24 15:44:09', 9, 'yea'),
(82, '2016-05-24 15:57:40', 9, 'oki doki'),
(83, '2016-05-24 15:57:50', 9, 'i herd u liek mudkipz'),
(84, '2016-05-24 15:57:58', 9, 'sdfg'),
(85, '2016-05-24 15:57:58', 9, ']fsd'),
(86, '2016-05-24 15:57:58', 9, 'gsd'),
(87, '2016-05-24 15:57:58', 9, 'f'),
(88, '2016-05-24 15:57:59', 9, 'gsd'),
(89, '2016-05-24 15:57:59', 9, 'fg'),
(90, '2016-05-24 15:57:59', 9, 'sdf'),
(91, '2016-05-24 15:57:59', 9, 'gsd'),
(92, '2016-05-24 15:57:59', 9, 'fg'),
(93, '2016-05-24 15:57:59', 9, 'sdf'),
(94, '2016-05-24 15:58:00', 9, 'g'),
(95, '2016-05-24 15:58:00', 9, 'sdf'),
(96, '2016-05-24 15:58:00', 9, 'gs'),
(97, '2016-05-24 15:58:00', 9, 'dfg'),
(98, '2016-05-24 15:58:02', 9, 'a'),
(99, '2016-05-24 15:58:02', 9, 'b'),
(100, '2016-05-24 15:58:02', 9, 'c'),
(101, '2016-05-24 15:58:02', 9, 'd'),
(102, '2016-05-24 15:58:03', 9, 'e'),
(103, '2016-05-24 15:58:03', 9, 'f'),
(104, '2016-05-24 15:58:05', 9, 'g'),
(105, '2016-05-24 15:58:05', 9, 'h'),
(106, '2016-05-24 15:58:05', 9, 'i'),
(107, '2016-05-24 15:58:06', 9, 'q'),
(108, '2016-05-24 15:58:06', 9, 'w'),
(109, '2016-05-24 15:58:06', 9, 'e'),
(110, '2016-05-24 15:58:06', 9, 'r'),
(111, '2016-05-24 15:58:07', 9, 't'),
(112, '2016-05-24 15:58:07', 9, 'y'),
(113, '2016-05-24 15:58:07', 9, 'u'),
(114, '2016-05-24 15:58:07', 9, 'i'),
(115, '2016-05-24 15:58:08', 9, 'o'),
(116, '2016-05-24 15:58:08', 9, 'p'),
(117, '2016-05-24 17:53:33', 9, 'a'),
(118, '2016-05-24 17:53:33', 9, 's'),
(119, '2016-05-24 17:53:34', 9, 'a'),
(120, '2016-05-24 17:53:36', 9, 'q'),
(121, '2016-05-24 17:53:36', 9, 'w'),
(122, '2016-05-24 17:53:36', 9, 'e'),
(123, '2016-05-24 17:53:36', 9, 'r'),
(124, '2016-05-24 17:53:36', 9, 't'),
(125, '2016-05-24 17:53:37', 9, 'y');

-- --------------------------------------------------------

--
-- Table structure for table `games`
--

CREATE TABLE `games` (
  `game_id` int(11) NOT NULL,
  `user` int(11) NOT NULL,
  `joiner` int(11) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `name` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `games`
--

INSERT INTO `games` (`game_id`, `user`, `joiner`, `created`, `name`) VALUES
(1, 9, 0, '2016-05-24 14:38:49', 'Epic Game'),
(2, 7, 0, '2016-05-23 16:25:02', '');

-- --------------------------------------------------------

--
-- Table structure for table `game_participants`
--

CREATE TABLE `game_participants` (
  `part_id` int(11) NOT NULL,
  `user` int(11) NOT NULL,
  `game_id` int(11) NOT NULL,
  `colour` set('red','blue') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `game_participants`
--

INSERT INTO `game_participants` (`part_id`, `user`, `game_id`, `colour`) VALUES
(1, 9, 1, 'red'),
(2, 7, 1, 'blue');

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
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `password` varchar(64) NOT NULL,
  `email` varchar(64) NOT NULL,
  `username` varchar(64) NOT NULL,
  `wins` int(11) NOT NULL,
  `losses` int(11) NOT NULL,
  `elo` int(11) NOT NULL DEFAULT '1000',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `password`, `email`, `username`, `wins`, `losses`, `elo`, `created`) VALUES
(6, '$2y$10$zmsIcYDqp8ScNRuDcj9jD.kbsW9vC7k655flzcYK66kC0jkWa0toK', 'alanduu50@gmail.com', 'xXN1NJ4Xx', 343, 148, 1000, '2016-05-23 21:22:33'),
(7, '$2y$10$xGKFvkCEjUMSm1y6cr8v/.IsJCZfLhNtigg0eyETXQYbslu5X1IBK', 'kld14@ic.ac.uk', 'DragonSlayer52', 358, 145, 1000, '2016-05-23 21:22:01'),
(8, '$2y$10$s7PfGa0iZcg2XDFrmEAnhegSMZzKi4Po4GyUEl1E9cA69tUJj5qSa', 'test@test.com', 'HaskellPrize', 47, 23, 1000, '2016-05-23 21:20:45'),
(9, '$2y$10$y8geeo6e4vVMUkhJWycFruGOuplLwujzm8q4RZlZQPpkn6RKbkfpS', 'demo@demo.com', 'Wumpus', 93, 64, 1000, '2016-05-23 21:20:18'),
(10, '$2y$10$h9fvGHQrrOHh35pNzhIsqOR.0jDi4ZmVtHiCvP1wCexLef072jYqy', 'tonyfield@rules.com', 'OhBaby', 24, 26, 1000, '2016-05-23 18:59:26');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `chat`
--
ALTER TABLE `chat`
  ADD PRIMARY KEY (`chat_id`);

--
-- Indexes for table `games`
--
ALTER TABLE `games`
  ADD PRIMARY KEY (`game_id`);

--
-- Indexes for table `game_participants`
--
ALTER TABLE `game_participants`
  ADD PRIMARY KEY (`part_id`);

--
-- Indexes for table `login`
--
ALTER TABLE `login`
  ADD PRIMARY KEY (`socialid`,`type`);

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
-- AUTO_INCREMENT for table `chat`
--
ALTER TABLE `chat`
  MODIFY `chat_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=126;
--
-- AUTO_INCREMENT for table `games`
--
ALTER TABLE `games`
  MODIFY `game_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `game_participants`
--
ALTER TABLE `game_participants`
  MODIFY `part_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
