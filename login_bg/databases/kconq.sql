-- phpMyAdmin SQL Dump
-- version 4.5.2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: May 24, 2016 at 11:05 PM
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
  `message` text NOT NULL,
  `room_id` int(11) NOT NULL,
  `chat_type` set('message','event') NOT NULL DEFAULT 'message'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `chat`
--

INSERT INTO `chat` (`chat_id`, `created`, `user`, `message`, `room_id`, `chat_type`) VALUES
(1, '2016-05-24 19:52:41', 6, 'Hi there, I''m a new player!', 0, 'message'),
(2, '2016-05-24 19:52:41', 7, 'Cool, nice to see you! xD :D', 0, 'message'),
(50, '2016-05-24 19:52:41', 9, 'hey, my name is wumpus, please to meet you guys!', 0, 'message'),
(51, '2016-05-24 19:52:41', 9, 'oh baby!', 0, 'message'),
(52, '2016-05-24 19:52:41', 9, 'anyone wanna game?', 0, 'message'),
(53, '2016-05-24 19:52:41', 9, 'yeah', 0, 'message'),
(54, '2016-05-24 19:52:41', 9, 'fdg', 0, 'message'),
(55, '2016-05-24 19:52:41', 9, 'fag', 0, 'message'),
(56, '2016-05-24 19:52:41', 9, 'sdfs', 0, 'message'),
(57, '2016-05-24 19:52:41', 7, 'yea', 0, 'message'),
(58, '2016-05-24 19:52:41', 9, 'noice', 0, 'message'),
(59, '2016-05-24 19:52:41', 9, 'yo', 0, 'message'),
(60, '2016-05-24 19:52:41', 9, 'how', 0, 'message'),
(61, '2016-05-24 19:52:41', 9, 'are you guys', 0, 'message'),
(62, '2016-05-24 19:52:41', 9, 'i don''t know', 0, 'message'),
(63, '2016-05-24 19:52:41', 9, 'how  am i', 0, 'message'),
(64, '2016-05-24 19:52:41', 9, 'asoijdioasjd ', 0, 'message'),
(65, '2016-05-24 19:52:41', 9, 'testing one two three @&quot;@&quot;&quot;@&quot;&quot;&quot;''''''''X:D&quot;LZ&quot;:XLC&quot;:ZXLC', 0, 'message'),
(66, '2016-05-24 19:52:41', 9, '&lt;b&gt;sdfjsidof&lt;/b&gt;', 0, 'message'),
(67, '2016-05-24 19:52:41', 9, '''; delete table users; --', 0, 'message'),
(68, '2016-05-24 19:52:41', 9, 'i like dark forest', 0, 'message'),
(69, '2016-05-24 19:52:41', 9, 'can we play that', 0, 'message'),
(70, '2016-05-24 19:52:41', 9, 'thanks!', 0, 'message'),
(71, '2016-05-24 19:52:41', 9, 'in advacne ;]', 0, 'message'),
(73, '2016-05-24 19:52:41', 9, 'hi', 0, 'message'),
(74, '2016-05-24 19:52:41', 9, 'so', 0, 'message'),
(75, '2016-05-24 19:52:41', 9, 'i', 0, 'message'),
(76, '2016-05-24 19:52:41', 9, 'need', 0, 'message'),
(77, '2016-05-24 19:52:41', 9, 'some food', 0, 'message'),
(78, '2016-05-24 19:52:41', 9, 'right now', 0, 'message'),
(80, '2016-05-24 19:52:41', 9, 'yea', 0, 'message'),
(82, '2016-05-24 19:52:41', 9, 'oki doki', 0, 'message'),
(83, '2016-05-24 19:52:41', 9, 'i herd u liek mudkipz', 0, 'message'),
(84, '2016-05-24 19:52:41', 9, 'sdfg', 0, 'message'),
(85, '2016-05-24 19:52:41', 9, ']fsd', 0, 'message'),
(86, '2016-05-24 19:52:41', 9, 'gsd', 0, 'message'),
(87, '2016-05-24 19:52:41', 9, 'f', 0, 'message'),
(88, '2016-05-24 19:52:41', 9, 'gsd', 0, 'message'),
(89, '2016-05-24 19:52:41', 9, 'fg', 0, 'message'),
(90, '2016-05-24 19:52:41', 9, 'sdf', 0, 'message'),
(91, '2016-05-24 19:52:41', 9, 'gsd', 0, 'message'),
(92, '2016-05-24 19:52:41', 9, 'fg', 0, 'message'),
(93, '2016-05-24 19:52:41', 9, 'sdf', 0, 'message'),
(94, '2016-05-24 19:52:41', 9, 'g', 0, 'message'),
(95, '2016-05-24 19:52:41', 9, 'sdf', 0, 'message'),
(96, '2016-05-24 19:52:41', 9, 'gs', 0, 'message'),
(97, '2016-05-24 19:52:41', 9, 'dfg', 0, 'message'),
(98, '2016-05-24 19:52:41', 9, 'a', 0, 'message'),
(99, '2016-05-24 19:52:41', 9, 'b', 0, 'message'),
(100, '2016-05-24 19:52:41', 9, 'c', 0, 'message'),
(101, '2016-05-24 19:52:41', 9, 'd', 0, 'message'),
(102, '2016-05-24 19:52:41', 9, 'e', 0, 'message'),
(103, '2016-05-24 19:52:41', 9, 'f', 0, 'message'),
(104, '2016-05-24 19:52:41', 9, 'g', 0, 'message'),
(105, '2016-05-24 19:52:41', 9, 'h', 0, 'message'),
(106, '2016-05-24 19:52:41', 9, 'i', 0, 'message'),
(107, '2016-05-24 19:52:41', 9, 'q', 0, 'message'),
(108, '2016-05-24 19:52:41', 9, 'w', 0, 'message'),
(109, '2016-05-24 19:52:41', 9, 'e', 0, 'message'),
(110, '2016-05-24 19:52:41', 9, 'r', 0, 'message'),
(111, '2016-05-24 19:52:41', 9, 't', 0, 'message'),
(112, '2016-05-24 19:52:41', 9, 'y', 0, 'message'),
(113, '2016-05-24 19:52:41', 9, 'u', 0, 'message'),
(114, '2016-05-24 19:52:41', 9, 'i', 0, 'message'),
(115, '2016-05-24 19:52:41', 9, 'o', 0, 'message'),
(116, '2016-05-24 19:52:41', 9, 'p', 0, 'message'),
(117, '2016-05-24 19:52:41', 9, 'a', 0, 'message'),
(118, '2016-05-24 19:52:41', 9, 's', 0, 'message'),
(119, '2016-05-24 19:52:41', 9, 'a', 0, 'message'),
(120, '2016-05-24 19:52:41', 9, 'q', 0, 'message'),
(121, '2016-05-24 19:52:41', 9, 'w', 0, 'message'),
(122, '2016-05-24 19:52:41', 9, 'e', 0, 'message'),
(123, '2016-05-24 19:52:41', 9, 'r', 0, 'message'),
(124, '2016-05-24 19:52:41', 9, 't', 0, 'message'),
(125, '2016-05-24 19:52:41', 9, 'y', 0, 'message'),
(126, '2016-05-24 19:52:41', 7, 'yo', 0, 'message'),
(127, '2016-05-24 19:52:41', 9, 'whassup', 0, 'message'),
(128, '2016-05-24 19:52:41', 7, 'not much', 0, 'message'),
(129, '2016-05-24 19:52:41', 9, 'really', 0, 'message'),
(130, '2016-05-24 19:52:41', 7, 'okay', 0, 'message'),
(131, '2016-05-24 19:52:41', 9, 'meh', 0, 'message'),
(132, '2016-05-24 19:52:41', 7, 'eorijg', 0, 'message'),
(133, '2016-05-24 19:52:41', 7, 'enough', 0, 'message'),
(134, '2016-05-24 19:52:41', 9, 'whahaaaa', 0, 'message'),
(135, '2016-05-24 19:52:41', 7, 'sieojfiose', 0, 'message'),
(136, '2016-05-24 19:52:41', 7, 'dfgdf', 0, 'message'),
(137, '2016-05-24 19:52:41', 9, 'yo', 0, 'message'),
(138, '2016-05-24 19:52:41', 9, 'sdf', 1, 'message'),
(139, '2016-05-24 19:52:41', 9, 'sdf', 0, 'message'),
(140, '2016-05-24 19:52:41', 9, 'yo', 0, 'message'),
(141, '2016-05-24 19:52:41', 9, 'hiya there', 0, 'message'),
(142, '2016-05-24 19:52:41', 9, 'yo', 1, 'message'),
(143, '2016-05-24 19:52:41', 9, 'what is up', 1, 'message'),
(144, '2016-05-24 19:52:41', 7, 'what is up', 0, 'message'),
(145, '2016-05-24 19:52:41', 7, 'i dont know', 1, 'message'),
(146, '2016-05-24 19:52:41', 9, 'why', 1, 'message'),
(147, '2016-05-24 19:52:41', 9, 'fgh', 1, 'message'),
(148, '2016-05-24 19:52:41', 9, 'dfg', 1, 'message'),
(149, '2016-05-24 19:52:41', 9, 'dfg', 1, 'message'),
(150, '2016-05-24 19:52:41', 9, 'hi', 1, 'message'),
(151, '2016-05-24 19:52:41', 9, 'sdf', 0, 'message'),
(152, '2016-05-24 19:52:41', 9, 'im not sure', 0, 'message'),
(153, '2016-05-24 19:52:41', 7, 'umm', 1, 'message'),
(154, '2016-05-24 19:52:41', 9, 'sdf', 0, 'message');

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
-- Table structure for table `rooms`
--

CREATE TABLE `rooms` (
  `room_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `joiner` int(11) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `name` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `rooms`
--

INSERT INTO `rooms` (`room_id`, `user_id`, `joiner`, `created`, `name`) VALUES
(1, 9, 0, '2016-05-24 14:38:49', 'Epic Game'),
(2, 7, 0, '2016-05-23 16:25:02', '');

-- --------------------------------------------------------

--
-- Table structure for table `room_participants`
--

CREATE TABLE `room_participants` (
  `part_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `room_id` int(11) NOT NULL,
  `colour` set('red','blue') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `room_participants`
--

INSERT INTO `room_participants` (`part_id`, `user_id`, `room_id`, `colour`) VALUES
(1, 9, 1, 'red'),
(2, 7, 1, 'blue');

-- --------------------------------------------------------

--
-- Table structure for table `units`
--

CREATE TABLE `units` (
  `unit_id` int(11) NOT NULL,
  `unit_type_id` int(11) NOT NULL,
  `health` int(11) NOT NULL,
  `max_health` int(11) NOT NULL,
  `movement` int(11) NOT NULL,
  `attack_range` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
-- Indexes for table `login`
--
ALTER TABLE `login`
  ADD PRIMARY KEY (`socialid`,`type`);

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
-- AUTO_INCREMENT for table `chat`
--
ALTER TABLE `chat`
  MODIFY `chat_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=155;
--
-- AUTO_INCREMENT for table `rooms`
--
ALTER TABLE `rooms`
  MODIFY `room_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `room_participants`
--
ALTER TABLE `room_participants`
  MODIFY `part_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `units`
--
ALTER TABLE `units`
  MODIFY `unit_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
