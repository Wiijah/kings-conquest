-- phpMyAdmin SQL Dump
-- version 4.5.2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jun 08, 2016 at 06:18 PM
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
-- Table structure for table `achievements`
--

CREATE TABLE `achievements` (
  `ach_name` varchar(64) NOT NULL,
  `image` varchar(128) NOT NULL,
  `label` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `achievements`
--

INSERT INTO `achievements` (`ach_name`, `image`, `label`) VALUES
('100_wins', 'images/achievements/100_wins.png', 'Won 100 games.'),
('50_wins', 'images/achievements/50_wins.png', 'Won 50 games.'),
('perfect_win', 'images/achievements/perfect_win.png', 'Won a game without losing any units.');

-- --------------------------------------------------------

--
-- Table structure for table `ach_instances`
--

CREATE TABLE `ach_instances` (
  `ach_name` varchar(64) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ach_instances`
--

INSERT INTO `ach_instances` (`ach_name`, `user_id`) VALUES
('perfect_win', 9);

-- --------------------------------------------------------

--
-- Table structure for table `buffs`
--

CREATE TABLE `buffs` (
  `buff_id` int(11) NOT NULL,
  `buff_name` varchar(64) NOT NULL,
  `graphics` varchar(64) NOT NULL,
  `icon` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `buffs`
--

INSERT INTO `buffs` (`buff_id`, `buff_name`, `graphics`, `icon`) VALUES
(1, 'heal', 'graphics/spritesheet/spell/ss_heal.png', ''),
(2, 'burning', 'graphics/spritesheet/spell/ss_burning.png', ''),
(4, 'shield', '', 'graphics/buff/buff_shield.png'),
(5, 'Burn', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `buff_instances`
--

CREATE TABLE `buff_instances` (
  `bi_id` int(11) NOT NULL,
  `buff_id` int(11) NOT NULL,
  `unit_id` int(11) NOT NULL,
  `turns_left` int(11) NOT NULL,
  `room_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `buff_instances`
--

INSERT INTO `buff_instances` (`bi_id`, `buff_id`, `unit_id`, `turns_left`, `room_id`) VALUES
(1, 5, 1015, 6, 0),
(2, 5, 1035, 6, 0),
(3, 5, 1045, 6, 0),
(4, 5, 1055, 6, 0),
(5, 5, 1085, 6, 0),
(6, 5, 965, 6, 0),
(7, 5, 1095, 6, 0),
(8, 5, 1115, 6, 0),
(9, 3, 1125, 6, 0),
(10, 2, 1124, 6, 0),
(11, 2, 1127, 6, 0),
(12, 2, 1126, 6, 0),
(13, 2, 1122, 6, 0),
(14, 2, 1123, 6, 0),
(15, 5, 1135, 6, 0),
(16, 5, 1165, 6, 0),
(17, 5, 1185, 6, 0),
(18, 5, 1195, 6, 0),
(19, 5, 1205, 6, 0),
(20, 5, 1215, 6, 0),
(21, 5, 1225, 6, 0),
(22, 5, 1235, 6, 0),
(23, 5, 1245, 6, 0);

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
(101, '2016-06-07 16:30:15', 13, 'veg joined the room.', 1, 'event', ''),
(102, '2016-06-07 16:30:18', 14, 'harry potter joined the room.', 1, 'event', ''),
(103, '2016-06-07 16:43:50', 14, 'harry potter left the game.', 1, 'event', ''),
(104, '2016-06-07 16:43:57', 14, 'harry potter joined the room.', 1, 'event', ''),
(105, '2016-06-07 16:44:09', 14, 'harry potter left the game.', 1, 'event', ''),
(106, '2016-06-07 16:44:11', 14, 'harry potter joined the room.', 1, 'event', ''),
(107, '2016-06-07 16:44:17', 13, 'hi', 1, 'message', ''),
(108, '2016-06-07 16:44:20', 13, 'yo', 1, 'message', ''),
(109, '2016-06-07 16:44:22', 14, 'yo', 1, 'message', ''),
(110, '2016-06-07 16:44:30', 14, 'harry potter left the game.', 1, 'event', ''),
(111, '2016-06-07 16:44:32', 14, 'wtf', 0, 'message', ''),
(112, '2016-06-07 16:44:33', 14, 'harry potter joined the room.', 1, 'event', ''),
(113, '2016-06-07 16:44:35', 14, 'wtf', 1, 'message', ''),
(114, '2016-06-07 16:46:04', 14, 'HELLO', 1, 'message', ''),
(115, '2016-06-07 16:48:52', 13, 'asda', 1, 'message', ''),
(116, '2016-06-07 16:49:19', 14, 'harry potter left the game.', 1, 'event', ''),
(117, '2016-06-07 16:49:21', 14, 'why', 0, 'message', ''),
(118, '2016-06-07 16:49:23', 14, 'does it work ehre', 0, 'message', ''),
(119, '2016-06-07 16:49:24', 14, 'but not in the rooms', 0, 'message', ''),
(120, '2016-06-07 16:49:26', 14, 'harry potter joined the room.', 1, 'event', ''),
(121, '2016-06-07 16:49:29', 13, 'wg', 1, 'message', ''),
(122, '2016-06-07 16:54:20', 13, 'umm', 1, 'message', ''),
(123, '2016-06-07 16:54:22', 14, 'hi there!', 1, 'message', ''),
(124, '2016-06-07 16:54:24', 14, 'harry potter left the game.', 1, 'event', ''),
(125, '2016-06-07 16:54:27', 14, 'harry potter joined the room.', 1, 'event', ''),
(126, '2016-06-07 16:54:44', 14, 'harry potter left the room.', 1, 'event', ''),
(127, '2016-06-07 16:54:49', 14, 'harry potter joined the room.', 1, 'event', ''),
(128, '2016-06-07 16:54:52', 13, 'veg left the room.', 1, 'event', ''),
(129, '2016-06-07 16:54:58', 14, 'harry potter joined the room.', 2, 'event', ''),
(130, '2016-06-07 16:55:05', 14, 'harry potter left the room.', 2, 'event', ''),
(131, '2016-06-07 16:55:08', 14, 'harry potter joined the room.', 3, 'event', ''),
(132, '2016-06-07 16:55:12', 13, 'veg joined the room.', 3, 'event', ''),
(133, '2016-06-07 17:17:11', 14, 'harry potter kicked veg.', 3, 'event', ''),
(134, '2016-06-07 17:17:16', 13, 'veg joined the room.', 3, 'event', ''),
(135, '2016-06-07 17:17:45', 14, 'harry potter kicked veg.', 3, 'event', ''),
(136, '2016-06-07 17:17:51', 13, 'veg joined the room.', 3, 'event', ''),
(137, '2016-06-07 17:17:52', 14, 'harry potter kicked veg.', 3, 'event', ''),
(138, '2016-06-07 18:18:46', 13, 'veg joined the room.', 3, 'event', ''),
(139, '2016-06-07 19:22:42', 9, 'hi', 0, 'message', ''),
(140, '2016-06-07 19:22:43', 9, 'everyone', 0, 'message', ''),
(141, '2016-06-08 06:41:48', 9, 'Wumpus joined the room.', 1, 'event', ''),
(142, '2016-06-08 06:42:48', 9, 'hi', 1, 'message', ''),
(143, '2016-06-08 06:43:20', 9, 'Wumpus left the room.', 1, 'event', ''),
(144, '2016-06-08 06:43:57', 9, 'Wumpus joined the room.', 1, 'event', ''),
(145, '2016-06-08 06:44:14', 9, 'Wumpus left the room.', 1, 'event', ''),
(146, '2016-06-08 06:44:30', 9, 'Wumpus joined the room.', 1, 'event', ''),
(147, '2016-06-08 06:44:32', 9, 'Wumpus left the room.', 1, 'event', ''),
(148, '2016-06-08 06:45:03', 9, 'Wumpus joined the room.', 1, 'event', ''),
(149, '2016-06-08 06:45:05', 9, 'Wumpus left the room.', 1, 'event', ''),
(150, '2016-06-08 06:45:24', 9, 'Wumpus joined the room.', 2, 'event', ''),
(151, '2016-06-08 06:47:28', 9, 'Wumpus left the room.', 2, 'event', ''),
(152, '2016-06-08 06:47:50', 9, 'test', 0, 'message', ''),
(153, '2016-06-08 06:47:53', 9, 'Wumpus joined the room.', 3, 'event', ''),
(154, '2016-06-08 06:48:16', 9, 'Wumpus left the room.', 3, 'event', ''),
(155, '2016-06-08 06:51:44', 9, 'yo', 0, 'message', ''),
(156, '2016-06-08 07:39:55', 9, 'whassup lets finish this project', 0, 'message', ''),
(157, '2016-06-08 09:03:05', 9, 'Wumpus joined the room.', 4, 'event', ''),
(158, '2016-06-08 09:03:24', 14, 'harry potter joined the room.', 4, 'event', ''),
(159, '2016-06-08 12:21:20', 14, 'harry potter joined the room.', 1, 'event', ''),
(160, '2016-06-08 12:21:27', 9, 'Wumpus joined the room.', 1, 'event', ''),
(161, '2016-06-08 13:31:39', 14, 'harry potter joined the room.', 2, 'event', ''),
(162, '2016-06-08 13:31:45', 9, 'Wumpus joined the room.', 2, 'event', ''),
(163, '2016-06-08 13:33:43', 14, 'harry potter joined the room.', 3, 'event', ''),
(164, '2016-06-08 13:33:46', 9, 'Wumpus joined the room.', 3, 'event', ''),
(165, '2016-06-08 13:34:34', 14, 'harry potter joined the room.', 4, 'event', ''),
(166, '2016-06-08 13:34:40', 9, 'Wumpus joined the room.', 4, 'event', ''),
(167, '2016-06-08 13:34:58', 14, 'harry potter joined the room.', 5, 'event', ''),
(168, '2016-06-08 13:35:04', 9, 'Wumpus joined the room.', 5, 'event', ''),
(169, '2016-06-08 13:35:53', 9, 'Wumpus joined the room.', 6, 'event', ''),
(170, '2016-06-08 13:35:57', 14, 'harry potter joined the room.', 6, 'event', ''),
(171, '2016-06-08 13:55:14', 14, 'harry potter joined the room.', 7, 'event', ''),
(172, '2016-06-08 13:55:18', 9, 'Wumpus joined the room.', 7, 'event', ''),
(173, '2016-06-08 15:08:56', 14, 'harry potter joined the room.', 8, 'event', ''),
(174, '2016-06-08 15:09:20', 9, 'Wumpus joined the room.', 8, 'event', ''),
(175, '2016-06-08 15:12:55', 14, 'harry potter joined the room.', 9, 'event', ''),
(176, '2016-06-08 15:13:01', 9, 'Wumpus joined the room.', 9, 'event', ''),
(177, '2016-06-08 15:14:56', 9, 'Wumpus joined the room.', 10, 'event', ''),
(178, '2016-06-08 15:15:00', 14, 'harry potter joined the room.', 10, 'event', ''),
(179, '2016-06-08 15:15:40', 14, 'harry potter joined the room.', 11, 'event', ''),
(180, '2016-06-08 15:15:45', 9, 'Wumpus joined the room.', 12, 'event', ''),
(181, '2016-06-08 15:15:52', 9, 'Wumpus left the room.', 12, 'event', ''),
(182, '2016-06-08 15:15:53', 9, 'Wumpus joined the room.', 11, 'event', ''),
(183, '2016-06-08 15:16:13', 9, 'Wumpus joined the room.', 13, 'event', ''),
(184, '2016-06-08 15:16:16', 14, 'harry potter joined the room.', 14, 'event', ''),
(185, '2016-06-08 15:16:20', 9, 'Wumpus left the room.', 13, 'event', ''),
(186, '2016-06-08 15:16:21', 9, 'Wumpus joined the room.', 14, 'event', ''),
(187, '2016-06-08 15:16:58', 14, 'harry potter joined the room.', 15, 'event', ''),
(188, '2016-06-08 15:17:02', 9, 'Wumpus joined the room.', 15, 'event', ''),
(189, '2016-06-08 15:17:58', 14, 'harry potter joined the room.', 16, 'event', ''),
(190, '2016-06-08 15:18:03', 9, 'Wumpus joined the room.', 17, 'event', ''),
(191, '2016-06-08 15:18:07', 9, 'Wumpus left the room.', 17, 'event', ''),
(192, '2016-06-08 15:18:08', 9, 'Wumpus joined the room.', 16, 'event', ''),
(193, '2016-06-08 15:20:30', 9, 'Wumpus joined the room.', 18, 'event', ''),
(194, '2016-06-08 15:20:35', 14, 'harry potter joined the room.', 18, 'event', ''),
(195, '2016-06-08 15:23:27', 9, 'Wumpus joined the room.', 19, 'event', ''),
(196, '2016-06-08 15:23:30', 14, 'harry potter joined the room.', 19, 'event', ''),
(197, '2016-06-08 15:27:08', 14, 'harry potter joined the room.', 20, 'event', ''),
(198, '2016-06-08 15:27:11', 9, 'Wumpus joined the room.', 21, 'event', ''),
(199, '2016-06-08 15:27:13', 9, 'Wumpus left the room.', 21, 'event', ''),
(200, '2016-06-08 15:27:14', 9, 'Wumpus joined the room.', 20, 'event', ''),
(201, '2016-06-08 15:27:55', 14, 'harry potter joined the room.', 22, 'event', ''),
(202, '2016-06-08 15:27:59', 9, 'Wumpus joined the room.', 22, 'event', ''),
(203, '2016-06-08 15:30:10', 14, 'harry potter joined the room.', 23, 'event', ''),
(204, '2016-06-08 15:30:11', 9, 'Wumpus joined the room.', 23, 'event', ''),
(205, '2016-06-08 15:47:23', 9, 'yup ^_^', 0, 'message', ''),
(206, '2016-06-08 15:47:29', 14, 'xD', 0, 'message', ''),
(207, '2016-06-08 16:13:31', 14, 'harry potter joined the room.', 24, 'event', ''),
(208, '2016-06-08 16:13:35', 9, 'Wumpus joined the room.', 24, 'event', '');

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
(4, 'king', 'graphics/spritesheet/stand/ss_king_stand.png', 'graphics/spritesheet/attack/ss_king_attack.png', 'graphics/card/king_card.png', 30, 25, 'Battle Cry', 3, 3, 2, 'graphics/spritesheet/spell/ss_physical_attack.png', 0, 0.2),
(5, 'red castle', 'graphics/spritesheet/special_unit/ss_castle_red.png', 'graphics/spritesheet/attack/ss_archer_attack.png', 'graphics/card/castle_card.png', 999, 999, 'RED', 0, 0, 10, 'graphics/spritesheet/spell/ss_physical_attack.png', 100, 0),
(6, 'blue castle', 'graphics/spritesheet/special_unit/ss_castle_blue.png', 'graphics/spritesheet/attack/ss_archer_attack.png', 'graphics/card/castle_card.png', 999, 999, 'BLUE', 0, 0, 10, 'graphics/spritesheet/spell/ss_physical_attack.png', 100, 0);

-- --------------------------------------------------------

--
-- Table structure for table `feedback`
--

CREATE TABLE `feedback` (
  `fb_id` int(11) NOT NULL,
  `subject` varchar(128) NOT NULL,
  `body` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `friends`
--

CREATE TABLE `friends` (
  `friend_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `other_id` int(11) NOT NULL,
  `accepted` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `friends`
--

INSERT INTO `friends` (`friend_id`, `user_id`, `other_id`, `accepted`) VALUES
(21, 9, 12, 1);

-- --------------------------------------------------------

--
-- Table structure for table `inventory`
--

CREATE TABLE `inventory` (
  `inv_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `inventory`
--

INSERT INTO `inventory` (`inv_id`, `user_id`, `item_id`, `quantity`) VALUES
(1, 14, 1, 2),
(2, 14, 2, 7);

-- --------------------------------------------------------

--
-- Table structure for table `items`
--

CREATE TABLE `items` (
  `item_id` int(11) NOT NULL,
  `name` varchar(64) NOT NULL,
  `type` set('hat','eyes','hair') NOT NULL,
  `image` varchar(128) NOT NULL,
  `price` int(11) NOT NULL,
  `icon` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `items`
--

INSERT INTO `items` (`item_id`, `name`, `type`, `image`, `price`, `icon`) VALUES
(1, 'Crown', 'hat', 'avatar/crown.png', 0, ''),
(2, 'Epic Crown', 'hat', '', 0, '');

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
(14, '1071989516156754', 'Facebook');

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
-- Table structure for table `opp`
--

CREATE TABLE `opp` (
  `opp_id` int(11) NOT NULL,
  `room_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `team` int(11) NOT NULL,
  `json` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `opp`
--

INSERT INTO `opp` (`opp_id`, `room_id`, `user_id`, `team`, `json`) VALUES
(230, 36, 14, 0, '{"error_code": 0,"action" : {"action_type": "create_unit", "unit": {"743": {\n      "address":"graphics/spritesheet/stand/ss_wizard_stand.png","spritesheet":"graphics/spritesheet/attack/ss_wizard_attack.png","unit_id": 743,"hp": 200,"max_hp": 200,"attack": 15,"skill":"Magic Damage","luck": 0.25,"x": 1,"y": 2,"moveRange": 3,"team": 0,"attackRange": 3,"canMove": 1,"canAttack": 1,"skillCoolDown": 0,"outOfMoves": 0,"damageEffect":"graphics/spritesheet/spell/ss_fireball.png"\n    }},"gold": 600}}'),
(231, 36, 14, 0, '{"error_code": 0,"action" : {"action_type": "create_unit", "unit": {"744": {\n      "address":"graphics/spritesheet/stand/ss_wizard_stand.png","spritesheet":"graphics/spritesheet/attack/ss_wizard_attack.png","unit_id": 744,"hp": 200,"max_hp": 200,"attack": 15,"skill":"Magic Damage","luck": 0.25,"x": 2,"y": 1,"moveRange": 3,"team": 0,"attackRange": 3,"canMove": 1,"canAttack": 1,"skillCoolDown": 0,"outOfMoves": 0,"damageEffect":"graphics/spritesheet/spell/ss_fireball.png"\n    }},"gold": 500}}'),
(232, 36, 14, 0, '{"error_code": 0,"action" : {"action_type": "create_unit", "unit": {"745": {\n      "address":"graphics/spritesheet/stand/ss_wizard_stand.png","spritesheet":"graphics/spritesheet/attack/ss_wizard_attack.png","unit_id": 745,"hp": 200,"max_hp": 200,"attack": 15,"skill":"Magic Damage","luck": 0.25,"x": 1,"y": 3,"moveRange": 3,"team": 0,"attackRange": 3,"canMove": 1,"canAttack": 1,"skillCoolDown": 0,"outOfMoves": 0,"damageEffect":"graphics/spritesheet/spell/ss_fireball.png"\n    }},"gold": 400}}'),
(233, 36, 14, 0, '{"error_code": 0,"action" : {"action_type": "create_unit", "unit": {"746": {\n      "address":"graphics/spritesheet/stand/ss_wizard_stand.png","spritesheet":"graphics/spritesheet/attack/ss_wizard_attack.png","unit_id": 746,"hp": 200,"max_hp": 200,"attack": 15,"skill":"Magic Damage","luck": 0.25,"x": 2,"y": 3,"moveRange": 3,"team": 0,"attackRange": 3,"canMove": 1,"canAttack": 1,"skillCoolDown": 0,"outOfMoves": 0,"damageEffect":"graphics/spritesheet/spell/ss_fireball.png"\n    }},"gold": 300}}'),
(234, 36, 14, 0, '{"error_code": 0,"action" : {"action_type": "create_unit", "unit": {"747": {\n      "address":"graphics/spritesheet/stand/ss_wizard_stand.png","spritesheet":"graphics/spritesheet/attack/ss_wizard_attack.png","unit_id": 747,"hp": 200,"max_hp": 200,"attack": 15,"skill":"Magic Damage","luck": 0.25,"x": 2,"y": 2,"moveRange": 3,"team": 0,"attackRange": 3,"canMove": 1,"canAttack": 1,"skillCoolDown": 0,"outOfMoves": 0,"damageEffect":"graphics/spritesheet/spell/ss_fireball.png"\n    }},"gold": 200}}'),
(235, 36, 14, 0, '{"error_code": 0,"action" : {"action_type": "create_unit", "unit": {"748": {\n      "address":"graphics/spritesheet/stand/ss_wizard_stand.png","spritesheet":"graphics/spritesheet/attack/ss_wizard_attack.png","unit_id": 748,"hp": 200,"max_hp": 200,"attack": 15,"skill":"Magic Damage","luck": 0.25,"x": 2,"y": 0,"moveRange": 3,"team": 0,"attackRange": 3,"canMove": 1,"canAttack": 1,"skillCoolDown": 0,"outOfMoves": 0,"damageEffect":"graphics/spritesheet/spell/ss_fireball.png"\n    }},"gold": 100}}'),
(236, 36, 14, 0, '{"error_code": 0,"action" : {"action_type": "create_unit", "unit": {"759": {\n      "address":"graphics/spritesheet/stand/ss_wizard_stand.png","spritesheet":"graphics/spritesheet/attack/ss_wizard_attack.png","unit_id": 759,"hp": 200,"max_hp": 200,"attack": 15,"skill":"Magic Damage","luck": 0.25,"x": 0,"y": 1,"moveRange": 3,"team": 0,"attackRange": 3,"canMove": 1,"canAttack": 1,"skillCoolDown": 0,"outOfMoves": 0,"damageEffect":"graphics/spritesheet/spell/ss_fireball.png"\n    }},"gold": 900}}'),
(237, 36, 14, 0, '{"error_code": 0,"action" : {"action_type": "create_unit", "unit": {"760": {\n      "address":"graphics/spritesheet/stand/ss_archer_stand.png","spritesheet":"graphics/spritesheet/attack/ss_archer_attack.png","unit_id": 760,"hp": 200,"max_hp": 200,"attack": 20,"skill":"Double Shoot","luck": 0.4,"x": 1,"y": 0,"moveRange": 3,"team": 0,"attackRange": 4,"canMove": 1,"canAttack": 1,"skillCoolDown": 0,"outOfMoves": 0,"damageEffect":"graphics/spritesheet/spell/ss_arrow.png"\n    }},"gold": 800}}'),
(238, 36, 14, 0, '{"error_code": 0,"action" : {"action_type": "create_unit", "unit": {"761": {\n      "address":"graphics/spritesheet/stand/ss_wizard_stand.png","spritesheet":"graphics/spritesheet/attack/ss_wizard_attack.png","unit_id": 761,"hp": 200,"max_hp": 200,"attack": 15,"skill":"Magic Damage","luck": 0.25,"x": 1,"y": 1,"moveRange": 3,"team": 0,"attackRange": 3,"canMove": 1,"canAttack": 1,"skillCoolDown": 0,"outOfMoves": 0,"damageEffect":"graphics/spritesheet/spell/ss_fireball.png"\n    }},"gold": 700}}'),
(239, 36, 14, 0, '{"error_code": 0,"action" : {"action_type": "create_unit", "unit": {"762": {\n      "address":"graphics/spritesheet/stand/ss_wizard_stand.png","spritesheet":"graphics/spritesheet/attack/ss_wizard_attack.png","unit_id": 762,"hp": 200,"max_hp": 200,"attack": 15,"skill":"Magic Damage","luck": 0.25,"x": 1,"y": 2,"moveRange": 3,"team": 0,"attackRange": 3,"canMove": 1,"canAttack": 1,"skillCoolDown": 0,"outOfMoves": 0,"damageEffect":"graphics/spritesheet/spell/ss_fireball.png"\n    }},"gold": 600}}'),
(240, 36, 14, 0, '{"error_code": 0,"action" : {"action_type": "create_unit", "unit": {"763": {\n      "address":"graphics/spritesheet/stand/ss_archer_stand.png","spritesheet":"graphics/spritesheet/attack/ss_archer_attack.png","unit_id": 763,"hp": 200,"max_hp": 200,"attack": 20,"skill":"Double Shoot","luck": 0.4,"x": 2,"y": 1,"moveRange": 3,"team": 0,"attackRange": 4,"canMove": 1,"canAttack": 1,"skillCoolDown": 0,"outOfMoves": 0,"damageEffect":"graphics/spritesheet/spell/ss_arrow.png"\n    }},"gold": 500}}'),
(241, 36, 14, 0, '{"error_code": 0,"action" : {"action_type": "move_unit", "unit_id": 763,"path": [[2,1],[2,2],[2,3],[2,4]]}}'),
(242, 36, 14, 0, '{"error_code": 0,"action" : {"action_type": "create_unit", "unit": {"764": {\n      "address":"graphics/spritesheet/stand/ss_wizard_stand.png","spritesheet":"graphics/spritesheet/attack/ss_wizard_attack.png","unit_id": 764,"hp": 200,"max_hp": 200,"attack": 15,"skill":"Magic Damage","luck": 0.25,"x": 2,"y": 0,"moveRange": 3,"team": 0,"attackRange": 3,"canMove": 1,"canAttack": 1,"skillCoolDown": 0,"outOfMoves": 0,"damageEffect":"graphics/spritesheet/spell/ss_fireball.png"\n    }},"gold": 400}}'),
(243, 36, 14, 0, '{"error_code": 0,"action" : {"action_type": "create_unit", "unit": {"765": {\n      "address":"graphics/spritesheet/stand/ss_archer_stand.png","spritesheet":"graphics/spritesheet/attack/ss_archer_attack.png","unit_id": 765,"hp": 200,"max_hp": 200,"attack": 20,"skill":"Double Shoot","luck": 0.4,"x": 3,"y": 0,"moveRange": 3,"team": 0,"attackRange": 4,"canMove": 1,"canAttack": 1,"skillCoolDown": 0,"outOfMoves": 0,"damageEffect":"graphics/spritesheet/spell/ss_arrow.png"\n    }},"gold": 300}}'),
(244, 36, 14, 0, '{"error_code": 0,"action" : {"action_type": "create_unit", "unit": {"766": {\n      "address":"graphics/spritesheet/stand/ss_knight_stand.png","spritesheet":"graphics/spritesheet/attack/ss_knight_attack.png","unit_id": 766,"hp": 300,"max_hp": 300,"attack": 40,"skill":"Shield","luck": 0.15,"x": 3,"y": 1,"moveRange": 2,"team": 0,"attackRange": 1,"canMove": 1,"canAttack": 1,"skillCoolDown": 0,"outOfMoves": 0,"damageEffect":"graphics/spritesheet/spell/ss_physical_attack.png"\n    }},"gold": 200}}'),
(245, 36, 14, 0, '{"error_code": 0,"action" : {"action_type": "create_unit", "unit": {"767": {\n      "address":"graphics/spritesheet/stand/ss_wizard_stand.png","spritesheet":"graphics/spritesheet/attack/ss_wizard_attack.png","unit_id": 767,"hp": 200,"max_hp": 200,"attack": 15,"skill":"Magic Damage","luck": 0.25,"x": 2,"y": 1,"moveRange": 3,"team": 0,"attackRange": 3,"canMove": 1,"canAttack": 1,"skillCoolDown": 0,"outOfMoves": 0,"damageEffect":"graphics/spritesheet/spell/ss_fireball.png"\n    }},"gold": 100}}'),
(246, 36, 14, 0, '{"error_code": 0,"action" : {"action_type": "create_unit", "unit": {"768": {\n      "address":"graphics/spritesheet/stand/ss_wizard_stand.png","spritesheet":"graphics/spritesheet/attack/ss_wizard_attack.png","unit_id": 768,"hp": 200,"max_hp": 200,"attack": 15,"skill":"Magic Damage","luck": 0.25,"x": 2,"y": 3,"moveRange": 3,"team": 0,"attackRange": 3,"canMove": 1,"canAttack": 1,"skillCoolDown": 0,"outOfMoves": 0,"damageEffect":"graphics/spritesheet/spell/ss_fireball.png"\n    }},"gold": 0}}'),
(247, 36, 9, 1, '{"error_code": 0,"action" : {"action_type": "create_unit", "unit": {"769": {\n      "address":"graphics/spritesheet/stand/ss_wizard_stand.png","spritesheet":"graphics/spritesheet/attack/ss_wizard_attack.png","unit_id": 769,"hp": 200,"max_hp": 200,"attack": 15,"skill":"Magic Damage","luck": 0.25,"x": 2,"y": 2,"moveRange": 3,"team": 1,"attackRange": 3,"canMove": 1,"canAttack": 1,"skillCoolDown": 0,"outOfMoves": 0,"damageEffect":"graphics/spritesheet/spell/ss_fireball.png"\n    }},"gold": 900}}'),
(248, 36, 9, 1, '{"error_code": 0,"action" : {"action_type": "create_unit", "unit": {"770": {\n      "address":"graphics/spritesheet/stand/ss_wizard_stand.png","spritesheet":"graphics/spritesheet/attack/ss_wizard_attack.png","unit_id": 770,"hp": 200,"max_hp": 200,"attack": 15,"skill":"Magic Damage","luck": 0.25,"x": 1,"y": 3,"moveRange": 3,"team": 1,"attackRange": 3,"canMove": 1,"canAttack": 1,"skillCoolDown": 0,"outOfMoves": 0,"damageEffect":"graphics/spritesheet/spell/ss_fireball.png"\n    }},"gold": 800}}'),
(249, 36, 9, 1, '{"error_code": 0,"action" : {"action_type": "move_unit", "unit_id": 770,"path": [[1,3],[1,4],[1,5],[2,5]]}}'),
(250, 36, 14, 0, '{"error_code": 0,"action" : {"action_type": "move_unit", "unit_id": 749,"path": [[3,2],[4,2],[4,3],[4,4]]}}'),
(251, 36, 14, 0, '{"error_code": 0,"action" : {"action_type": "move_unit", "unit_id": 753,"path": [[0,3],[0,4],[0,5],[0,6]]}}'),
(252, 36, 14, 0, '{"error_code": 0,"action" : {"action_type": "move_unit", "unit_id": 752,"path": [[0,2],[0,3],[0,4]]}}'),
(253, 36, 14, 0, '{"error_code": 0,"action" : {"action_type": "move_unit", "unit_id": 751,"path": [[3,3],[3,4],[3,5]]}}'),
(254, 36, 14, 0, '{"error_code": 0,"action" : {"action_type": "create_unit", "unit": {"781": {\n      "address":"graphics/spritesheet/stand/ss_wizard_stand.png","spritesheet":"graphics/spritesheet/attack/ss_wizard_attack.png","unit_id": 781,"hp": 200,"max_hp": 200,"attack": 15,"skill":"Magic Damage","luck": 0.25,"x": 3,"y": 1,"moveRange": 3,"team": 0,"attackRange": 3,"canMove": 1,"canAttack": 1,"skillCoolDown": 0,"outOfMoves": 0,"damageEffect":"graphics/spritesheet/spell/ss_fireball.png"\n    }},"gold": 900}}'),
(255, 36, 14, 0, '{"error_code": 0,"action" : {"action_type": "create_unit", "unit": {"782": {\n      "address":"graphics/spritesheet/stand/ss_archer_stand.png","spritesheet":"graphics/spritesheet/attack/ss_archer_attack.png","unit_id": 782,"hp": 200,"max_hp": 200,"attack": 20,"skill":"Double Shoot","luck": 0.4,"x": 2,"y": 1,"moveRange": 3,"team": 0,"attackRange": 4,"canMove": 1,"canAttack": 1,"skillCoolDown": 0,"outOfMoves": 0,"damageEffect":"graphics/spritesheet/spell/ss_arrow.png"\n    }},"gold": 800}}'),
(256, 36, 14, 0, '{"error_code": 0,"action" : {"action_type": "move_unit", "unit_id": 782,"path": [[2,1],[2,2],[2,3],[2,4]]}}'),
(257, 36, 14, 0, '{"error_code": 0,"action" : {"action_type": "create_unit", "unit": {"783": {\n      "address":"graphics/spritesheet/stand/ss_archer_stand.png","spritesheet":"graphics/spritesheet/attack/ss_archer_attack.png","unit_id": 783,"hp": 200,"max_hp": 200,"attack": 20,"skill":"Double Shoot","luck": 0.4,"x": 3,"y": 0,"moveRange": 3,"team": 0,"attackRange": 4,"canMove": 1,"canAttack": 1,"skillCoolDown": 0,"outOfMoves": 0,"damageEffect":"graphics/spritesheet/spell/ss_arrow.png"\n    }},"gold": 700}}'),
(258, 36, 14, 0, '{"error_code": 0,"action" : {"action_type": "create_unit", "unit": {"784": {\n      "address":"graphics/spritesheet/stand/ss_wizard_stand.png","spritesheet":"graphics/spritesheet/attack/ss_wizard_attack.png","unit_id": 784,"hp": 200,"max_hp": 200,"attack": 15,"skill":"Magic Damage","luck": 0.25,"x": 1,"y": 1,"moveRange": 3,"team": 0,"attackRange": 3,"canMove": 1,"canAttack": 1,"skillCoolDown": 0,"outOfMoves": 0,"damageEffect":"graphics/spritesheet/spell/ss_fireball.png"\n    }},"gold": 600}}'),
(259, 36, 14, 0, '{"error_code": 0,"action" : {"action_type": "move_unit", "unit_id": 784,"path": [[1,1],[1,2]]}}'),
(260, 36, 14, 0, '{"error_code": 0,"action" : {"action_type": "move_unit", "unit_id": 775,"path": [[0,3],[0,4],[0,5],[1,5]]}}'),
(261, 38, 13, 0, '{"error_code": 0,"action" : {"action_type": "move_unit", "unit_id": 797,"path": [[3,3],[3,4],[3,5]]}}'),
(262, 36, 14, 0, '{"error_code": 0,"action" : {"action_type": "move_unit", "unit_id": 809,"path": [[0,2],[1,2],[2,2]]}}'),
(263, 36, 14, 0, '{"error_code": 0,"action" : {"action_type": "turn_change", "new_turn": 1,"effects_to_apply": [],"units_new_cd": [],"buffs_to_remove": []}}'),
(264, 36, 9, 1, '{"error_code": 0,"action" : {"action_type": "move_unit", "unit_id": 808,"path": [[3,4],[4,4],[4,3],[4,2]]}}'),
(265, 36, 9, 1, '{"error_code": 0,"action" : {"action_type": "move_unit", "unit_id": 813,"path": [[9,10],[8,10],[8,9],[8,8]]}}'),
(266, 36, 14, 0, '{"error_code": 0,"action" : {"action_type": "move_unit", "unit_id": 816,"path": [[3,2],[2,2],[2,3],[2,4]]}}'),
(267, 36, 14, 0, '{"error_code": 0,"action" : {"action_type": "move_unit", "unit_id": 818,"path": [[3,3],[4,3],[4,4],[4,5]]}}'),
(268, 36, 14, 0, '{"error_code": 0,"action" : {"action_type": "attack_unit", "attacker_id": 816,"buffs": [],"target_id": 819,"dmg": 25,"is_critical": 0}}'),
(269, 36, 14, 0, '{"error_code": 0,"action" : {"action_type": "attack_unit", "attacker_id": 851,"buffs": [],"target_id": 852,"dmg": 15,"is_critical": 0}}'),
(270, 36, 14, 0, '{"error_code": 0,"action" : {"action_type": "attack_unit", "attacker_id": 862,"buffs": [],"target_id": 863,"dmg": 15,"is_critical": 0}}'),
(271, 1, 9, 0, '{"error_code": 0,"action" : {"action_type": "attack_unit", "attacker_id": 873,"buffs": [],"target_id": 874,"dmg": 15,"is_critical": 0}}'),
(272, 1, 9, 0, '{"error_code": 0,"action" : {"action_type": "move_unit", "unit_id": 871,"path": [[3,2],[4,2],[4,3],[4,4]]}}'),
(273, 1, 9, 0, '{"error_code": 0,"action" : {"action_type": "attack_unit", "attacker_id": 871,"buffs": [],"target_id": 874,"dmg": 25,"is_critical": 0}}'),
(274, 1, 9, 0, '{"error_code": 0,"action" : {"action_type": "attack_unit", "attacker_id": 884,"buffs": [],"target_id": 885,"dmg": 15,"is_critical": 0}}'),
(275, 1, 9, 0, '{"error_code": 0,"action" : {"action_type": "move_unit", "unit_id": 882,"path": [[3,2],[4,2],[4,3],[4,4]]}}'),
(276, 1, 9, 0, '{"error_code": 0,"action" : {"action_type": "attack_unit", "attacker_id": 882,"buffs": [],"target_id": 885,"dmg": 25,"is_critical": 0}}'),
(277, 1, 9, 0, '{"error_code": 0,"actions": ["action" : {"action_type": "move_unit", "unit_id": 887,"path": [[0,3],[0,4],[1,4],[2,4]]}]}'),
(278, 1, 9, 0, '{"error_code": 0,"actions": [{"action" : {"action_type": "move_unit", "unit_id": 886,"path": [[0,2],[0,3],[0,4]]}}]}'),
(279, 1, 9, 0, '{"error_code": 0,"actions": [{"action_type": "attack_unit", "attacker_id": 906,"buffs": [],"target_id": 907,"dmg": 15,"is_critical": 0}]}'),
(280, 1, 9, 0, '{"error_code": 0,"actions": [{"action_type": "move_unit", "unit_id": 904,"path": [[3,2],[4,2],[4,3],[4,4]]}]}'),
(281, 1, 9, 0, '{"error_code": 0,"actions": [{"action_type": "attack_unit", "attacker_id": 904,"buffs": [],"target_id": 907,"dmg": 25,"is_critical": 1}]}'),
(282, 1, 9, 0, '{"error_code": 0,"actions": [{"action_type": "move_unit", "unit_id": 908,"path": [[0,2],[0,1],[1,1]]}]}'),
(283, 1, 9, 0, '{"error_code": 0,"actions": [{"action_type": "create_unit", "unit": {"915": {\n      "address":"graphics/spritesheet/stand/ss_wizard_stand.png","spritesheet":"graphics/spritesheet/attack/ss_wizard_attack.png","unit_id": 915,"info":"graphics/card/wizard_card.png","hp": 200,"max_hp": 200,"attack": 15,"skill":"Magic Damage","luck": 0.25,"x": 2,"y": 0,"moveRange": 3,"team": 0,"attackRange": 3,"canMove": 1,"canAttack": 1,"skillCoolDown": 0,"outOfMoves": 0,"damageEffect":"graphics/spritesheet/spell/ss_fireball.png"\n    }},"gold": 900}]}'),
(284, 1, 9, 0, '{"error_code": 0,"actions": [{"action_type": "create_unit", "unit": {"916": {\n      "address":"graphics/spritesheet/stand/ss_wizard_stand.png","spritesheet":"graphics/spritesheet/attack/ss_wizard_attack.png","unit_id": 916,"info":"graphics/card/wizard_card.png","hp": 200,"max_hp": 200,"attack": 15,"skill":"Magic Damage","luck": 0.25,"x": 2,"y": 1,"moveRange": 3,"team": 0,"attackRange": 3,"canMove": 1,"canAttack": 1,"skillCoolDown": 0,"outOfMoves": 0,"damageEffect":"graphics/spritesheet/spell/ss_fireball.png"\n    }},"gold": 800}]}'),
(285, 1, 9, 0, '{"error_code": 0,"actions": [{"action_type": "create_unit", "unit": {"917": {\n      "address":"graphics/spritesheet/stand/ss_archer_stand.png","spritesheet":"graphics/spritesheet/attack/ss_archer_attack.png","unit_id": 917,"info":"graphics/card/archer_card.png","hp": 200,"max_hp": 200,"attack": 20,"skill":"Double Shoot","luck": 0.4,"x": 0,"y": 2,"moveRange": 3,"team": 0,"attackRange": 4,"canMove": 1,"canAttack": 1,"skillCoolDown": 0,"outOfMoves": 0,"damageEffect":"graphics/spritesheet/spell/ss_arrow.png"\n    }},"gold": 700}]}'),
(286, 1, 9, 0, '{"error_code": 0,"actions": [{"action_type": "create_unit", "unit": {"940": {\n      "address":"graphics/spritesheet/stand/ss_wizard_stand.png","spritesheet":"graphics/spritesheet/attack/ss_wizard_attack.png","unit_id": 940,"info":"graphics/card/wizard_card.png","hp": 200,"max_hp": 200,"attack": 15,"skill":"Magic Damage","luck": 0.25,"x": 1,"y": 2,"moveRange": 3,"team": 0,"attackRange": 3,"canMove": 1,"canAttack": 1,"skillCoolDown": 0,"outOfMoves": 0,"damageEffect":"graphics/spritesheet/spell/ss_fireball.png"\n    }},"gold": 900}]}'),
(287, 1, 9, 0, '{"error_code": 0,{"action_type": "turn_change", "new_turn": 1,"effects_to_apply": [],"units_new_cd": [],"buffs_to_remove": []}}'),
(288, 1, 9, 0, '{"error_code": 0,"actions": [{"action_type": "move_unit", "unit_id": 929,"path": [[3,2],[4,2],[4,3],[5,3]]}]}'),
(289, 1, 13, 1, '{"error_code": 0,"actions": [{"action_type": "move_unit", "unit_id": 932,"path": [[3,4],[2,4],[1,4],[1,3]]}]}'),
(290, 1, 13, 1, '{"error_code": 0,"actions": [{"action_type": "attack_unit", "attacker_id": 932,"buffs": [],"target_id": 940,"dmg": 15,"is_critical": 0}]}'),
(291, 1, 9, 0, '{"error_code": 0,"actions": [{"action_type": "attack_unit", "attacker_id": 943,"buffs": [],"target_id": 944,"dmg": 15,"is_critical": 0}]}'),
(292, 3, 14, 0, '{"error_code": 0,"actions": [{"action_type": "move_unit", "unit_id": 954,"path": [[3,3],[4,3],[4,4]]}]}'),
(293, 3, 14, 0, '{"error_code": 0,"actions": [{"action_type": "attack_unit", "attacker_id": 954,"buffs": [],"target_id": 955,"dmg": 15,"is_critical": 0}]}'),
(294, 3, 14, 0, '{"error_code": 0,"actions": [{"action_type": "move_unit", "unit_id": 952,"path": [[3,2],[2,2],[2,3],[2,4]]}]}'),
(295, 3, 14, 0, '{"error_code": 0,"actions": [{"action_type": "attack_unit", "attacker_id": 952,"buffs": [],"target_id": 955,"dmg": 25,"is_critical": 0}]}'),
(296, 3, 14, 0, '{"error_code": 0,"actions": [{"action_type": "move_unit", "unit_id": 957,"path": [[0,3],[1,3],[2,3]]}]}'),
(297, 3, 14, 0, '{"error_code": 0,"actions": [{"action_type": "attack_unit", "attacker_id": 957,"buffs": [],"target_id": 955,"dmg": 20,"is_critical": 0}]}'),
(298, 3, 14, 0, '{"error_code": 0,"actions": [{"action_type": "turn_change", "new_turn": 1,"effects_to_apply": [],"units_new_cd": [],"buffs_to_remove": []}]}'),
(299, 3, 13, 1, '{"error_code": 0,"actions": [{"action_type": "move_unit", "unit_id": 955,"path": [[3,4],[3,3],[3,2],[2,2]]}]}'),
(300, 3, 13, 1, '{"error_code": 0,"actions": [{"action_type": "attack_unit", "attacker_id": 955,"buffs": [],"target_id": 957,"dmg": 25,"is_critical": 0}]}'),
(301, 3, 13, 1, '{"error_code": 0,"actions": [{"action_type": "turn_change", "new_turn": 0,"effects_to_apply": [],"units_new_cd": [],"buffs_to_remove": []}]}'),
(302, 3, 14, 0, '{"error_code": 0,"actions": [{"action_type": "attack_unit", "attacker_id": 957,"buffs": [],"target_id": 955,"dmg": 20,"is_critical": 0}]}'),
(303, 3, 14, 0, '{"error_code": 0,"actions": [{"action_type": "move_unit", "unit_id": 954,"path": [[4,4],[3,4],[3,3],[3,2]]}]}'),
(304, 3, 14, 0, '{"error_code": 0,"actions": [{"action_type": "turn_change", "new_turn": 1,"effects_to_apply": [],"units_new_cd": [],"buffs_to_remove": []}]}'),
(305, 3, 13, 1, '{"error_code": 0,"actions": [{"action_type": "attack_unit", "attacker_id": 955,"buffs": [],"target_id": 954,"dmg": 25,"is_critical": 0}]}'),
(306, 3, 13, 1, '{"error_code": 0,"actions": [{"action_type": "turn_change", "new_turn": 0,"effects_to_apply": [],"units_new_cd": [],"buffs_to_remove": []}]}'),
(307, 3, 14, 0, '{"error_code": 0,"actions": [{"action_type": "attack_unit", "attacker_id": 954,"buffs": [],"target_id": 955,"dmg": 15,"is_critical": 0}]}'),
(308, 3, 14, 0, '{"error_code": 0,"actions": [{"action_type": "turn_change", "new_turn": 1,"effects_to_apply": [],"units_new_cd": [],"buffs_to_remove": []}]}'),
(309, 3, 13, 1, '{"error_code": 0,"actions": [{"action_type": "move_unit", "unit_id": 955,"path": [[2,2],[2,1],[3,1],[4,1]]}]}'),
(310, 3, 13, 1, '{"error_code": 0,"actions": [{"action_type": "turn_change", "new_turn": 0,"effects_to_apply": [],"units_new_cd": [],"buffs_to_remove": []}]}'),
(311, 3, 14, 0, '{"error_code": 0,"actions": [{"action_type": "attack_unit", "attacker_id": 954,"buffs": [],"target_id": 955,"dmg": 15,"is_critical": 0}]}'),
(312, 1, 14, 0, '{"error_code": 0,"actions": []}'),
(313, 1, 14, 0, '{"error_code": 0,"actions": [{"action_type": "move_unit", "unit_id": 992,"path": [[3,2],[2,2],[2,3],[2,4]]}]}'),
(314, 1, 14, 0, '{"error_code": 0,"actions": [Array]}'),
(315, 1, 14, 0, '{"error_code": 0,"actions": [{"action_type": "attack_unit", "attacker_id": 1014,"buffs": [],"target_id": 1015,"dmg": 15,"is_critical": 0}]}'),
(316, 1, 14, 0, '{"error_code": 0,"actions": [{"action_type": "attack_unit", "attacker_id": 1012,"buffs": [],"target_id": 1015,"dmg": 25,"is_critical": 0}]}'),
(317, 1, 14, 0, '{"error_code": 0,"actions": [{"action_type": "turn_change", "new_turn": 1,"effects_to_apply": [],"units_new_cd": [],"buffs_to_remove": []}]}'),
(318, 1, 9, 1, '{"error_code": 0,"actions": [{"action_type": "turn_change", "new_turn": 0,"effects_to_apply": [],"units_new_cd": [],"buffs_to_remove": []}]}'),
(319, 1, 14, 0, '{"error_code": 0,"actions": [{"action_type": "attack_unit", "attacker_id": 1014,"buffs": [],"target_id": 1015,"dmg": 15,"is_critical": 0}]}'),
(320, 1, 14, 0, '{"error_code": 0,"actions": [{"action_type": "attack_unit", "attacker_id": 1012,"buffs": [],"target_id": 1015,"dmg": 25,"is_critical": 0}]}'),
(321, 1, 14, 0, '{"error_code": 0,"actions": [{"action_type": "move_unit", "unit_id": 1017,"path": [[0,3],[0,4],[1,4],[2,4]]}]}'),
(322, 1, 14, 0, '{"error_code": 0,"actions": [{"action_type": "attack_unit", "attacker_id": 1017,"buffs": [],"target_id": 1015,"dmg": 20,"is_critical": 0}]}'),
(323, 1, 14, 0, '{"error_code": 0,"actions": [{"action_type": "turn_change", "new_turn": 1,"effects_to_apply": [],"units_new_cd": [],"buffs_to_remove": []}]}'),
(324, 1, 9, 1, '{"error_code": 0,"actions": [{"action_type": "turn_change", "new_turn": 0,"effects_to_apply": [],"units_new_cd": [],"buffs_to_remove": []}]}'),
(325, 1, 14, 0, '{"error_code": 0,"actions": [{"action_type": "attack_unit", "attacker_id": 1014,"buffs": [],"target_id": 1015,"dmg": 15,"is_critical": 0},{"action_type": "apply_buff", "buff_id": 5,"unit_id": 1015}], "debug": "Magic Damage"}'),
(326, 1, 14, 0, '{"error_code": 0,"actions": [{"action_type": "turn_change", "new_turn": 1,"effects_to_apply": [],"units_new_cd": [],"buffs_to_remove": []}]}'),
(327, 1, 9, 1, '{"error_code": 0,"actions": [{"action_type": "turn_change", "new_turn": 0,"effects_to_apply": [],"units_new_cd": [],"buffs_to_remove": []}]}'),
(328, 1, 14, 0, '{"error_code": 0,"actions": [], "debug": "Magic Damage"}'),
(329, 1, 14, 0, '{"error_code": 0,"actions": [{"action_type": "attack_unit", "attacker_id": 1014,"buffs": [],"target_id": 1015,"dmg": 30,"is_critical": 1},{"action_type": "apply_buff", "buff_id": 5,"unit_id": 1015}], "debug": "Magic Damage"}'),
(330, 1, 14, 0, '{"error_code": 0,"actions": [{"action_type": "turn_change", "new_turn": 1,"effects_to_apply": [],"units_new_cd": [],"buffs_to_remove": []}]}'),
(331, 1, 9, 1, '{"error_code": 0,"actions": [{"action_type": "turn_change", "new_turn": 0,"effects_to_apply": [],"units_new_cd": [],"buffs_to_remove": []}]}'),
(332, 1, 14, 0, '{"error_code": 0,"actions": [{"action_type": "attack_unit", "attacker_id": 1014,"buffs": [],"target_id": 1015,"dmg": 15,"is_critical": 0},{"action_type": "apply_buff", "buff_id": 5,"unit_id": 1015}], "debug": "Magic Damage"}'),
(333, 1, 14, 0, '{"error_code": 0,"actions": [{"action_type": "turn_change", "new_turn": 1,"effects_to_apply": [],"units_new_cd": [],"buffs_to_remove": []}]}'),
(334, 1, 9, 1, '{"error_code": 0,"actions": [{"action_type": "turn_change", "new_turn": 0,"effects_to_apply": [],"units_new_cd": [],"buffs_to_remove": []}]}'),
(335, 1, 14, 0, '{"error_code": 0,"actions": [{"action_type": "attack_unit", "attacker_id": 1014,"buffs": [],"target_id": 1015,"dmg": 30,"is_critical": 1},{"action_type": "apply_buff", "buff_id": 5,"unit_id": 1015}], "debug": "Magic Damage"}'),
(336, 1, 14, 0, '{"error_code": 0,"actions": [{"action_type": "turn_change", "new_turn": 1,"effects_to_apply": [],"units_new_cd": [],"buffs_to_remove": []}]}'),
(337, 1, 9, 1, '{"error_code": 0,"actions": [{"action_type": "turn_change", "new_turn": 0,"effects_to_apply": [],"units_new_cd": [],"buffs_to_remove": []}]}'),
(338, 1, 14, 0, '{"error_code": 0,"actions": [{"action_type": "attack_unit", "attacker_id": 1014,"buffs": [],"target_id": 1015,"dmg": 15,"is_critical": 0},{"action_type": "apply_buff", "buff_id": 5,"unit_id": 1015}], "debug": "Magic Damage"}'),
(339, 1, 14, 0, '{"error_code": 0,"actions": [{"action_type": "turn_change", "new_turn": 1,"effects_to_apply": [],"units_new_cd": [],"buffs_to_remove": []}]}'),
(340, 1, 9, 1, '{"error_code": 0,"actions": [{"action_type": "turn_change", "new_turn": 0,"effects_to_apply": [],"units_new_cd": [],"buffs_to_remove": []}]}'),
(341, 1, 14, 0, '{"error_code": 0,"actions": [{"action_type": "attack_unit", "attacker_id": 1014,"buffs": [],"target_id": 1015,"dmg": 15,"is_critical": 0},{"action_type": "apply_buff", "buff_id": 5,"unit_id": 1015}], "debug": "Magic Damage"}'),
(342, 1, 14, 0, '{"error_code": 0,"actions": [], "debug": "Magic Damage"}'),
(343, 1, 14, 0, '{"error_code": 0,"actions": [], "debug": "Magic Damage"}'),
(344, 1, 14, 0, '{"error_code": 0,"actions": [], "debug": "Magic Damage"}'),
(345, 1, 14, 0, '{"error_code": 0,"actions": [{"action_type": "attack_unit", "attacker_id": 1034,"buffs": [],"target_id": 1035,"dmg": 15,"is_critical": 0},{"action_type": "game_end", "reason":"king_death","winner": 0},{"action_type": "apply_buff", "buff_id": 5,"unit_id": 1035}], "debug": "Magic Damage"}'),
(346, 2, 14, 0, '{"error_code": 0,"actions": [{"action_type": "attack_unit", "attacker_id": 1044,"buffs": [],"target_id": 1045,"dmg": 15,"is_critical": 0},{"action_type": "apply_buff", "buff_id": 5,"unit_id": 1045}], "debug": "Magic Damage"}'),
(347, 2, 14, 0, '{"error_code": 0,"actions": [{"action_type": "attack_unit", "attacker_id": 1054,"buffs": [],"target_id": 1055,"dmg": 15,"is_critical": 0},{"action_type": "apply_buff", "buff_id": 5,"unit_id": 1055}], "debug": "Magic Damage"}'),
(348, 2, 14, 0, '{"error_code": 0,"actions": [{"action_type": "move_unit", "unit_id": 1052,"path": [[3,2],[4,2],[4,3],[4,4]]}]}'),
(349, 2, 14, 0, '{"error_code": 0,"actions": [{"action_type": "attack_unit", "attacker_id": 1052,"buffs": [],"target_id": 1055,"dmg": 25,"is_critical": 0},{"action_type": "game_end", "reason":"king_death","winner": 0}]}'),
(350, 3, 14, 0, '{"error_code": 0,"actions": [{"action_type": "attack_unit", "attacker_id": 1084,"buffs": [],"target_id": 1085,"dmg": 15,"is_critical": 0},{"action_type": "apply_buff", "buff_id": 5,"unit_id": 1085}], "debug": "Magic Damage"}'),
(351, 3, 14, 0, '{"error_code": 0,"actions": [{"action_type": "move_unit", "unit_id": 1082,"path": [[3,2],[4,2],[4,3],[4,4]]}]}'),
(352, 3, 14, 0, '{"error_code": 0,"actions": [{"action_type": "attack_unit", "attacker_id": 1082,"buffs": [],"target_id": 1085,"dmg": 25,"is_critical": 0},{"action_type": "game_end", "reason":"king_death","winner": 0}]}'),
(353, 4, 14, 0, '{"error_code": 0,"actions": [{"action_type": "attack_unit", "attacker_id": 964,"buffs": [],"target_id": 965,"dmg": 15,"is_critical": 0},{"action_type": "apply_buff", "buff_id": 5,"unit_id": 965},{"action_type": "attack_unit", "attacker_id": 964,"buffs": [],"target_id": 1095,"dmg": 30,"is_critical": 1},{"action_type": "game_end", "reason":"king_death","winner": 0},{"action_type": "apply_buff", "buff_id": 5,"unit_id": 1095}], "debug": "Magic Damage"}'),
(354, 5, 14, 0, '{"error_code": 0,"actions": [{"action_type": "attack_unit", "attacker_id": 1104,"buffs": [],"target_id": 1105,"dmg": 15,"is_critical": 0}]}'),
(355, 5, 14, 0, '{"error_code": 0,"actions": [{"action_type": "move_unit", "unit_id": 1102,"path": [[3,2],[4,2],[4,3],[4,4]]}]}'),
(356, 5, 14, 0, '{"error_code": 0,"actions": [{"action_type": "attack_unit", "attacker_id": 1102,"buffs": [],"target_id": 1105,"dmg": 25,"is_critical": 0},{"action_type": "game_end", "reason":"king_death","winner": 0}]}'),
(357, 6, 9, 0, '{"error_code": 0,"actions": [{"action_type": "move_unit", "unit_id": 1112,"path": [[3,2],[4,2],[4,3],[4,4]]}]}'),
(358, 6, 9, 0, '{"error_code": 0,"actions": [{"action_type": "attack_unit", "attacker_id": 1112,"buffs": [],"target_id": 1115,"dmg": 25,"is_critical": 0}]}'),
(359, 6, 9, 0, '{"error_code": 0,"actions": [{"action_type": "apply_buff", "buff_id": 5,"unit_id": 1115},{"action_type": "attack_unit", "attacker_id": 1114,"buffs": [],"target_id": 1115,"dmg": 15,"is_critical": 0},{"action_type": "game_end", "reason":"king_death","winner": 0}], "debug": "Magic Damage"}'),
(360, 7, 14, 0, '{"error_code": 0,"actions": [{"action_type": "apply_buff", "buff_id": 3,"unit_id": 1125},{"action_type": "attack_unit", "attacker_id": 1127,"buffs": [],"target_id": 1125,"dmg": 20,"is_critical": 0}], "debug": "Double Shoot"}'),
(361, 7, 14, 0, '{"error_code": 0,"actions": [{"action_type": "apply_buff", "buff_id": 2,"unit_id": 1124},{"action_type": "apply_buff", "buff_id": 2,"unit_id": 1127},{"action_type": "apply_buff", "buff_id": 2,"unit_id": 1126},{"action_type": "apply_buff", "buff_id": 2,"unit_id": 1122},{"action_type": "apply_buff", "buff_id": 2,"unit_id": 1123}], "debug": "Battle Cry"}'),
(362, 7, 14, 0, '{"error_code": 0,"actions": [{"action_type": "apply_buff", "buff_id": 3,"unit_id": 1125},{"action_type": "attack_unit", "attacker_id": 1127,"buffs": [],"target_id": 1125,"dmg": 40,"is_critical": 1},{"action_type": "game_end", "reason":"king_death","winner": 0}], "debug": "Double Shoot"}'),
(363, 8, 14, 0, '{"error_code": 0,"actions": [{"action_type": "apply_buff", "buff_id": 5,"unit_id": 1135},{"action_type": "attack_unit", "attacker_id": 1134,"buffs": [],"target_id": 1135,"dmg": 15,"is_critical": 0}], "debug": "Magic Damage"}'),
(364, 8, 14, 0, '{"error_code": 0,"actions": [], "debug": "Magic Damage"}'),
(365, 8, 14, 0, '{"error_code": 0,"actions": [{"action_type": "apply_buff", "buff_id": 5,"unit_id": 1135},{"action_type": "attack_unit", "attacker_id": 1134,"buffs": [],"target_id": 1135,"dmg": 15,"is_critical": 0},{"action_type": "game_end", "reason":"king_death","winner": 0}], "debug": "Magic Damage"}'),
(366, 9, 14, 0, '{"error_code": 0,"actions": [{"action_type": "attack_unit", "attacker_id": 1144,"buffs": [],"target_id": 1145,"dmg": 30,"is_critical": 1},{"action_type": "game_end", "reason":"king_death","winner": 0}]}'),
(367, 10, 9, 0, '{"error_code": 0,"actions": [{"action_type": "attack_unit", "attacker_id": 1154,"buffs": [],"target_id": 1155,"dmg": 15,"is_critical": 0}]}'),
(368, 10, 9, 0, '{"error_code": 0,"actions": [{"action_type": "move_unit", "unit_id": 1152,"path": [[3,2],[4,2],[4,3],[4,4]]}]}'),
(369, 10, 9, 0, '{"error_code": 0,"actions": [{"action_type": "attack_unit", "attacker_id": 1152,"buffs": [],"target_id": 1155,"dmg": 25,"is_critical": 0},{"action_type": "game_end", "reason":"king_death","winner": 0}]}'),
(370, 11, 14, 0, '{"error_code": 0,"actions": [{"action_type": "apply_buff", "buff_id": 5,"unit_id": 1165},{"action_type": "attack_unit", "attacker_id": 1164,"buffs": [],"target_id": 1165,"dmg": 15,"is_critical": 0}], "debug": "Magic Damage"}'),
(371, 11, 14, 0, '{"error_code": 0,"actions": [{"action_type": "apply_buff", "buff_id": 5,"unit_id": 1165},{"action_type": "attack_unit", "attacker_id": 1164,"buffs": [],"target_id": 1165,"dmg": 30,"is_critical": 1},{"action_type": "game_end", "reason":"king_death","winner": 0}], "debug": "Magic Damage"}'),
(372, 14, 14, 0, '{"error_code": 0,"actions": [{"action_type": "attack_unit", "attacker_id": 1174,"buffs": [],"target_id": 1175,"dmg": 30,"is_critical": 1},{"action_type": "game_end", "reason":"king_death","winner": 0}]}'),
(373, 15, 14, 0, '{"error_code": 0,"actions": [{"action_type": "apply_buff", "buff_id": 5,"unit_id": 1185},{"action_type": "attack_unit", "attacker_id": 1184,"buffs": [],"target_id": 1185,"dmg": 30,"is_critical": 1},{"action_type": "game_end", "reason":"king_death","winner": 0}], "debug": "Magic Damage"}'),
(374, 16, 14, 0, '{"error_code": 0,"actions": [{"action_type": "attack_unit", "attacker_id": 1194,"buffs": [],"target_id": 1195,"dmg": 15,"is_critical": 0}]}'),
(375, 16, 14, 0, '{"error_code": 0,"actions": [{"action_type": "turn_change", "new_turn": 1,"effects_to_apply": [],"units_new_cd": [],"buffs_to_remove": []}]}'),
(376, 16, 9, 1, '{"error_code": 0,"actions": [{"action_type": "turn_change", "new_turn": 0,"effects_to_apply": [],"units_new_cd": [],"buffs_to_remove": []}]}'),
(377, 16, 14, 0, '{"error_code": 0,"actions": [{"action_type": "apply_buff", "buff_id": 5,"unit_id": 1195},{"action_type": "attack_unit", "attacker_id": 1194,"buffs": [],"target_id": 1195,"dmg": 15,"is_critical": 0},{"action_type": "game_end", "reason":"king_death","winner": 0}], "debug": "Magic Damage"}'),
(378, 18, 9, 0, '{"error_code": 0,"actions": [{"action_type": "apply_buff", "buff_id": 5,"unit_id": 1205},{"action_type": "attack_unit", "attacker_id": 1204,"buffs": [],"target_id": 1205,"dmg": 15,"is_critical": 0}], "debug": "Magic Damage"}'),
(379, 18, 9, 0, '{"error_code": 0,"actions": [{"action_type": "attack_unit", "attacker_id": 1202,"buffs": [],"target_id": 1205,"dmg": 25,"is_critical": 0},{"action_type": "game_end", "reason":"king_death","winner": 0}]}'),
(380, 19, 9, 0, '{"error_code": 0,"actions": [{"action_type": "apply_buff", "buff_id": 5,"unit_id": 1215},{"action_type": "attack_unit", "attacker_id": 1214,"buffs": [],"target_id": 1215,"dmg": 15,"is_critical": 0}], "debug": "Magic Damage"}'),
(381, 19, 9, 0, '{"error_code": 0,"actions": [{"action_type": "move_unit", "unit_id": 1212,"path": [[3,2],[4,2],[4,3],[4,4]]}]}'),
(382, 19, 9, 0, '{"error_code": 0,"actions": [{"action_type": "attack_unit", "attacker_id": 1212,"buffs": [],"target_id": 1215,"dmg": 25,"is_critical": 0},{"action_type": "game_end", "reason":"king_death","winner": 0}]}'),
(383, 20, 14, 0, '{"error_code": 0,"actions": [{"action_type": "attack_unit", "attacker_id": 1224,"buffs": [],"target_id": 1225,"dmg": 15,"is_critical": 0}]}'),
(384, 20, 14, 0, '{"error_code": 0,"actions": [{"action_type": "turn_change", "new_turn": 1,"effects_to_apply": [],"units_new_cd": [],"buffs_to_remove": []}]}'),
(385, 20, 9, 1, '{"error_code": 0,"actions": [{"action_type": "turn_change", "new_turn": 0,"effects_to_apply": [],"units_new_cd": [],"buffs_to_remove": []}]}'),
(386, 20, 14, 0, '{"error_code": 0,"actions": [{"action_type": "apply_buff", "buff_id": 5,"unit_id": 1225},{"action_type": "attack_unit", "attacker_id": 1224,"buffs": [],"target_id": 1225,"dmg": 30,"is_critical": 1},{"action_type": "game_end", "reason":"king_death","winner": 0}], "debug": "Magic Damage"}'),
(387, 22, 14, 0, '{"error_code": 0,"actions": [{"action_type": "apply_buff", "buff_id": 5,"unit_id": 1235},{"action_type": "attack_unit", "attacker_id": 1234,"buffs": [],"target_id": 1235,"dmg": 15,"is_critical": 0}], "debug": "Magic Damage"}'),
(388, 22, 14, 0, '{"error_code": 0,"actions": [{"action_type": "move_unit", "unit_id": 1232,"path": [[3,2],[4,2],[4,3],[4,4]]}]}'),
(389, 22, 14, 0, '{"error_code": 0,"actions": [{"action_type": "attack_unit", "attacker_id": 1232,"buffs": [],"target_id": 1235,"dmg": 25,"is_critical": 0},{"action_type": "game_end", "reason":"king_death","winner": 0}]}'),
(390, 23, 14, 0, '{"error_code": 0,"actions": [{"action_type": "apply_buff", "buff_id": 5,"unit_id": 1245},{"action_type": "attack_unit", "attacker_id": 1244,"buffs": [],"target_id": 1245,"dmg": 15,"is_critical": 0}], "debug": "Magic Damage"}'),
(391, 23, 14, 0, '{"error_code": 0,"actions": [{"action_type": "attack_unit", "attacker_id": 1242,"buffs": [],"target_id": 1245,"dmg": 25,"is_critical": 0},{"action_type": "game_end", "reason":"king_death","winner": 0}]}'),
(392, 24, 14, 0, '{"error_code": 0,"actions": [{"action_type": "turn_change", "new_turn": 1,"effects_to_apply": [],"units_new_cd": [],"buffs_to_remove": []}]}'),
(393, 24, 9, 1, '{"error_code": 0,"actions": [{"action_type": "turn_change", "new_turn": 0,"effects_to_apply": [],"units_new_cd": [],"buffs_to_remove": []}]}'),
(394, 24, 14, 0, '{"error_code": 0,"actions": [{"action_type": "turn_change", "new_turn": 1,"effects_to_apply": [],"units_new_cd": [],"buffs_to_remove": []}]}'),
(395, 24, 9, 1, '{"error_code": 0,"actions": [{"action_type": "turn_change", "new_turn": 0,"effects_to_apply": [],"units_new_cd": [],"buffs_to_remove": []}]}'),
(396, 24, 14, 0, '{"error_code": 0,"actions": [{"action_type": "turn_change", "new_turn": 1,"effects_to_apply": [],"units_new_cd": [],"buffs_to_remove": []}]}'),
(397, 24, 9, 1, '{"error_code": 0,"actions": [{"action_type": "turn_change", "new_turn": 0,"effects_to_apply": [],"units_new_cd": [],"buffs_to_remove": []}]}');

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
  `password` varchar(128) NOT NULL,
  `max_players` tinyint(4) NOT NULL DEFAULT '2',
  `state` set('pregame','ingame','ended','deleted') NOT NULL DEFAULT 'pregame',
  `turn` int(11) NOT NULL,
  `winner` int(11) NOT NULL,
  `elo_won` int(11) NOT NULL,
  `elo_lost` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `rooms`
--

INSERT INTO `rooms` (`room_id`, `user_id`, `joiner`, `created`, `name`, `password`, `max_players`, `state`, `turn`, `winner`, `elo_won`, `elo_lost`) VALUES
(1, 14, 0, '2016-06-08 12:21:20', 'hiya', '', 2, 'ended', 0, 14, 0, 0),
(2, 14, 0, '2016-06-08 13:31:39', 'dfs', '', 2, 'ended', 0, 0, 0, 0),
(3, 14, 0, '2016-06-08 13:33:43', 'rqrq', '', 2, 'ended', 0, 0, 0, 0),
(4, 14, 0, '2016-06-08 13:34:34', 'yo momma', '', 2, 'ended', 0, 14, 0, 0),
(5, 14, 0, '2016-06-08 13:34:58', 'test', '', 2, 'ended', 0, 14, 0, 0),
(6, 9, 0, '2016-06-08 13:35:53', 'asda', '', 2, 'ended', 0, 9, 0, 0),
(7, 14, 0, '2016-06-08 13:55:14', 'yo momma', '', 2, 'ended', 0, 14, 0, 0),
(8, 14, 0, '2016-06-08 15:08:56', 'test', '', 2, 'ended', 0, 14, 16, 32),
(9, 14, 0, '2016-06-08 15:12:55', 'asda', '', 2, 'ended', 0, 14, 16, 16),
(10, 9, 0, '2016-06-08 15:14:56', 'asda', '', 2, 'ended', 0, 9, 15, 17),
(11, 14, 0, '2016-06-08 15:15:40', 'test', '', 2, 'ended', 0, 14, 15, 17),
(14, 14, 0, '2016-06-08 15:16:16', 'test', '', 2, 'ended', 0, 14, 17, 15),
(15, 14, 0, '2016-06-08 15:16:58', 'test', '', 2, 'ended', 0, 14, 18, 14),
(16, 14, 0, '2016-06-08 15:17:58', 'test', '', 2, 'ended', 0, 14, 20, 12),
(18, 9, 0, '2016-06-08 15:20:30', 'wtf', '', 2, 'ended', 0, 9, 11, 21),
(19, 9, 0, '2016-06-08 15:23:27', 'test', '', 2, 'ended', 0, 9, 1, 1),
(20, 14, 0, '2016-06-08 15:27:08', 'sfs', '', 2, 'ended', 0, 14, 15, 15),
(22, 14, 0, '2016-06-08 15:27:55', 'asda', '', 2, 'ended', 0, 14, 15, 15),
(23, 14, 0, '2016-06-08 15:30:10', 'asdf', '', 2, 'ended', 0, 14, 22, 10),
(24, 14, 0, '2016-06-08 16:13:31', 'test', '', 2, 'ingame', 0, 0, 0, 0);

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
  `event` set('kicked','left','ended') NOT NULL,
  `gold` int(11) NOT NULL DEFAULT '500',
  `unit_kills` int(11) NOT NULL,
  `unit_spawns` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `room_participants`
--

INSERT INTO `room_participants` (`part_id`, `user_id`, `room_id`, `colour`, `state`, `event`, `gold`, `unit_kills`, `unit_spawns`) VALUES
(43, 14, 24, 'red', 'owner', '', 1000, 0, 0),
(44, 9, 24, 'blue', 'ready', '', 1000, 0, 0);

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
(50, 4, 400, 400, 25, 0, 1, 2, 0, 1, 1, 0, 27),
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
(82, 1, 200, 200, 15, 0, 3, 0, 1, 1, 1, 0, 28),
(134, 4, 400, 400, 25, 0, 3, 2, 0, 1, 1, 0, 30),
(135, 5, 999, 999, 999, 0, 0, 0, 0, 1, 1, 0, 30),
(136, 1, 200, 200, 15, 0, 3, 3, 0, 1, 1, 0, 30),
(137, 3, 300, 300, 40, 0, 0, 2, 0, 1, 1, 0, 30),
(138, 2, 200, 200, 20, 0, 0, 3, 0, 1, 1, 0, 30),
(139, 4, 400, 400, 25, 0, 9, 11, 1, 1, 1, 0, 30),
(140, 6, 999, 999, 999, 0, 12, 13, 1, 1, 1, 0, 30),
(141, 1, 200, 200, 15, 0, 9, 10, 1, 1, 1, 0, 30),
(142, 3, 300, 300, 40, 0, 12, 10, 1, 1, 1, 0, 30),
(143, 2, 200, 200, 20, 0, 12, 11, 1, 1, 1, 0, 30),
(144, 1, 200, 200, 15, 0, 3, 0, 0, 1, 1, 0, 30),
(145, 2, 200, 200, 20, 0, 3, 0, 0, 1, 1, 0, 30),
(146, 1, 200, 200, 15, 0, 2, 0, 0, 1, 1, 0, 30),
(147, 1, 200, 200, 15, 0, 1, 0, 0, 1, 1, 0, 30),
(148, 2, 200, 200, 20, 0, 1, 1, 0, 1, 1, 0, 30),
(149, 3, 300, 300, 40, 0, 1, 2, 0, 1, 1, 0, 30),
(150, 3, 300, 300, 40, 0, 1, 2, 0, 1, 1, 0, 30),
(795, 4, 400, 400, 25, 0, 3, 2, 0, 1, 1, 0, 38),
(796, 5, 999, 999, 999, 0, 0, 0, 0, 1, 1, 0, 38),
(797, 1, 200, 200, 15, 0, 3, 5, 0, 0, 1, 0, 38),
(798, 3, 300, 300, 40, 0, 0, 2, 0, 1, 1, 0, 38),
(799, 2, 200, 200, 20, 0, 0, 3, 0, 1, 1, 0, 38),
(800, 4, 400, 400, 25, 0, 9, 11, 1, 1, 1, 0, 38),
(801, 6, 999, 999, 999, 0, 12, 13, 1, 1, 1, 0, 38),
(802, 1, 200, 200, 15, 0, 9, 10, 1, 1, 1, 0, 38),
(803, 3, 300, 300, 40, 0, 12, 10, 1, 1, 1, 0, 38),
(804, 2, 200, 200, 20, 0, 12, 11, 1, 1, 1, 0, 38),
(860, 4, 400, 400, 25, 0, 3, 2, 0, 1, 1, 0, 36),
(861, 5, 999, 999, 999, 0, 0, 0, 0, 1, 1, 0, 36),
(862, 1, 200, 200, 15, 0, 3, 3, 0, 0, 0, 1, 36),
(863, 1, 185, 200, 15, 0, 3, 4, 1, 1, 1, 0, 36),
(864, 3, 300, 300, 40, 0, 0, 2, 0, 1, 1, 0, 36),
(865, 2, 200, 200, 20, 0, 0, 3, 0, 1, 1, 0, 36),
(866, 4, 400, 400, 25, 0, 9, 11, 1, 1, 1, 0, 36),
(867, 6, 999, 999, 999, 0, 12, 13, 1, 1, 1, 0, 36),
(868, 1, 200, 200, 15, 0, 9, 10, 1, 1, 1, 0, 36),
(869, 3, 300, 300, 40, 0, 12, 10, 1, 1, 1, 0, 36),
(870, 2, 200, 200, 20, 0, 12, 11, 1, 1, 1, 0, 36),
(962, 4, 400, 400, 25, 0, 3, 2, 0, 1, 1, 0, 4),
(963, 5, 999, 999, 999, 0, 0, 0, 0, 1, 1, 0, 4),
(964, 1, 200, 200, 15, 0, 3, 3, 0, 0, 0, 1, 4),
(965, 4, 385, 400, 25, 0, 3, 4, 1, 1, 1, 0, 4),
(966, 3, 300, 300, 40, 0, 0, 2, 0, 1, 1, 0, 4),
(967, 2, 200, 200, 20, 0, 0, 3, 0, 1, 1, 0, 4),
(968, 6, 999, 999, 999, 0, 12, 13, 1, 1, 1, 0, 4),
(969, 1, 200, 200, 15, 0, 9, 10, 1, 1, 1, 0, 4),
(970, 3, 300, 300, 40, 0, 12, 10, 1, 1, 1, 0, 4),
(971, 2, 200, 200, 20, 0, 12, 11, 1, 1, 1, 0, 4),
(1032, 4, 400, 400, 25, 0, 3, 2, 0, 1, 1, 0, 1),
(1033, 5, 999, 999, 999, 0, 0, 0, 0, 1, 1, 0, 1),
(1034, 1, 200, 200, 15, 0, 3, 3, 0, 0, 0, 1, 1),
(1036, 3, 300, 300, 40, 0, 0, 2, 0, 1, 1, 0, 1),
(1037, 2, 200, 200, 20, 0, 0, 3, 0, 1, 1, 0, 1),
(1038, 6, 999, 999, 999, 0, 12, 13, 1, 1, 1, 0, 1),
(1039, 1, 200, 200, 15, 0, 9, 10, 1, 1, 1, 0, 1),
(1040, 3, 300, 300, 40, 0, 12, 10, 1, 1, 1, 0, 1),
(1041, 2, 200, 200, 20, 0, 12, 11, 1, 1, 1, 0, 1),
(1052, 4, 30, 30, 25, 0, 4, 4, 0, 0, 0, 1, 2),
(1053, 5, 999, 999, 999, 0, 0, 0, 0, 1, 1, 0, 2),
(1054, 1, 200, 200, 15, 0, 3, 3, 0, 0, 0, 1, 2),
(1056, 3, 300, 300, 40, 0, 0, 2, 0, 1, 1, 0, 2),
(1057, 2, 200, 200, 20, 0, 0, 3, 0, 1, 1, 0, 2),
(1058, 6, 999, 999, 999, 0, 12, 13, 1, 1, 1, 0, 2),
(1059, 1, 200, 200, 15, 0, 9, 10, 1, 1, 1, 0, 2),
(1060, 3, 300, 300, 40, 0, 12, 10, 1, 1, 1, 0, 2),
(1061, 2, 200, 200, 20, 0, 12, 11, 1, 1, 1, 0, 2),
(1082, 4, 30, 30, 25, 0, 4, 4, 0, 0, 0, 1, 3),
(1083, 5, 999, 999, 999, 0, 0, 0, 0, 1, 1, 0, 3),
(1084, 1, 200, 200, 15, 0, 3, 3, 0, 0, 0, 1, 3),
(1086, 3, 300, 300, 40, 0, 0, 2, 0, 1, 1, 0, 3),
(1087, 2, 200, 200, 20, 0, 0, 3, 0, 1, 1, 0, 3),
(1088, 6, 999, 999, 999, 0, 12, 13, 1, 1, 1, 0, 3),
(1089, 1, 200, 200, 15, 0, 9, 10, 1, 1, 1, 0, 3),
(1090, 3, 300, 300, 40, 0, 12, 10, 1, 1, 1, 0, 3),
(1091, 2, 200, 200, 20, 0, 12, 11, 1, 1, 1, 0, 3),
(1092, 4, 30, 30, 25, 0, 3, 2, 0, 1, 1, 0, 4),
(1093, 5, 999, 999, 999, 0, 0, 0, 0, 1, 1, 0, 4),
(1094, 1, 200, 200, 15, 0, 3, 3, 0, 1, 1, 0, 4),
(1096, 3, 300, 300, 40, 0, 0, 2, 0, 1, 1, 0, 4),
(1097, 2, 200, 200, 20, 0, 0, 3, 0, 1, 1, 0, 4),
(1098, 6, 999, 999, 999, 0, 12, 13, 1, 1, 1, 0, 4),
(1099, 1, 200, 200, 15, 0, 9, 10, 1, 1, 1, 0, 4),
(1100, 3, 300, 300, 40, 0, 12, 10, 1, 1, 1, 0, 4),
(1101, 2, 200, 200, 20, 0, 12, 11, 1, 1, 1, 0, 4),
(1102, 4, 30, 30, 25, 0, 4, 4, 0, 0, 0, 1, 5),
(1103, 5, 999, 999, 999, 0, 0, 0, 0, 1, 1, 0, 5),
(1104, 1, 200, 200, 15, 0, 3, 3, 0, 0, 0, 1, 5),
(1106, 3, 300, 300, 40, 0, 0, 2, 0, 1, 1, 0, 5),
(1107, 2, 200, 200, 20, 0, 0, 3, 0, 1, 1, 0, 5),
(1108, 6, 999, 999, 999, 0, 12, 13, 1, 1, 1, 0, 5),
(1109, 1, 200, 200, 15, 0, 9, 10, 1, 1, 1, 0, 5),
(1110, 3, 300, 300, 40, 0, 12, 10, 1, 1, 1, 0, 5),
(1111, 2, 200, 200, 20, 0, 12, 11, 1, 1, 1, 0, 5),
(1112, 4, 30, 30, 25, 0, 4, 4, 0, 0, 0, 1, 6),
(1113, 5, 999, 999, 999, 0, 0, 0, 0, 1, 1, 0, 6),
(1114, 1, 200, 200, 15, 0, 3, 3, 0, 0, 0, 1, 6),
(1116, 3, 300, 300, 40, 0, 0, 2, 0, 1, 1, 0, 6),
(1117, 2, 200, 200, 20, 0, 0, 3, 0, 1, 1, 0, 6),
(1118, 6, 999, 999, 999, 0, 12, 13, 1, 1, 1, 0, 6),
(1119, 1, 200, 200, 15, 0, 9, 10, 1, 1, 1, 0, 6),
(1120, 3, 300, 300, 40, 0, 12, 10, 1, 1, 1, 0, 6),
(1121, 2, 200, 200, 20, 0, 12, 11, 1, 1, 1, 0, 6),
(1122, 4, 30, 30, 25, 0, 3, 2, 0, 1, 1, 0, 7),
(1123, 5, 999, 999, 999, 0, 0, 0, 0, 1, 1, 0, 7),
(1124, 1, 200, 200, 15, 0, 3, 3, 0, 1, 1, 0, 7),
(1126, 3, 300, 300, 40, 0, 0, 2, 0, 1, 1, 0, 7),
(1127, 2, 200, 200, 20, 0, 0, 3, 0, 0, 0, 1, 7),
(1128, 6, 999, 999, 999, 0, 12, 13, 1, 1, 1, 0, 7),
(1129, 1, 200, 200, 15, 0, 9, 10, 1, 1, 1, 0, 7),
(1130, 3, 300, 300, 40, 0, 12, 10, 1, 1, 1, 0, 7),
(1131, 2, 200, 200, 20, 0, 12, 11, 1, 1, 1, 0, 7),
(1132, 4, 30, 30, 25, 0, 3, 2, 0, 1, 1, 0, 8),
(1133, 5, 999, 999, 999, 0, 0, 0, 0, 1, 1, 0, 8),
(1134, 1, 200, 200, 15, 0, 3, 3, 0, 0, 0, 1, 8),
(1136, 3, 300, 300, 40, 0, 0, 2, 0, 1, 1, 0, 8),
(1137, 2, 200, 200, 20, 0, 0, 3, 0, 1, 1, 0, 8),
(1138, 6, 999, 999, 999, 0, 12, 13, 1, 1, 1, 0, 8),
(1139, 1, 200, 200, 15, 0, 9, 10, 1, 1, 1, 0, 8),
(1140, 3, 300, 300, 40, 0, 12, 10, 1, 1, 1, 0, 8),
(1141, 2, 200, 200, 20, 0, 12, 11, 1, 1, 1, 0, 8),
(1142, 4, 30, 30, 25, 0, 3, 2, 0, 1, 1, 0, 9),
(1143, 5, 999, 999, 999, 0, 0, 0, 0, 1, 1, 0, 9),
(1144, 1, 200, 200, 15, 0, 3, 3, 0, 0, 0, 1, 9),
(1146, 3, 300, 300, 40, 0, 0, 2, 0, 1, 1, 0, 9),
(1147, 2, 200, 200, 20, 0, 0, 3, 0, 1, 1, 0, 9),
(1148, 6, 999, 999, 999, 0, 12, 13, 1, 1, 1, 0, 9),
(1149, 1, 200, 200, 15, 0, 9, 10, 1, 1, 1, 0, 9),
(1150, 3, 300, 300, 40, 0, 12, 10, 1, 1, 1, 0, 9),
(1151, 2, 200, 200, 20, 0, 12, 11, 1, 1, 1, 0, 9),
(1152, 4, 30, 30, 25, 0, 4, 4, 0, 0, 0, 1, 10),
(1153, 5, 999, 999, 999, 0, 0, 0, 0, 1, 1, 0, 10),
(1154, 1, 200, 200, 15, 0, 3, 3, 0, 0, 0, 1, 10),
(1156, 3, 300, 300, 40, 0, 0, 2, 0, 1, 1, 0, 10),
(1157, 2, 200, 200, 20, 0, 0, 3, 0, 1, 1, 0, 10),
(1158, 6, 999, 999, 999, 0, 12, 13, 1, 1, 1, 0, 10),
(1159, 1, 200, 200, 15, 0, 9, 10, 1, 1, 1, 0, 10),
(1160, 3, 300, 300, 40, 0, 12, 10, 1, 1, 1, 0, 10),
(1161, 2, 200, 200, 20, 0, 12, 11, 1, 1, 1, 0, 10),
(1162, 4, 30, 30, 25, 0, 3, 2, 0, 1, 1, 0, 11),
(1163, 5, 999, 999, 999, 0, 0, 0, 0, 1, 1, 0, 11),
(1164, 1, 200, 200, 15, 0, 3, 3, 0, 0, 0, 1, 11),
(1166, 3, 300, 300, 40, 0, 0, 2, 0, 1, 1, 0, 11),
(1167, 2, 200, 200, 20, 0, 0, 3, 0, 1, 1, 0, 11),
(1168, 6, 999, 999, 999, 0, 12, 13, 1, 1, 1, 0, 11),
(1169, 1, 200, 200, 15, 0, 9, 10, 1, 1, 1, 0, 11),
(1170, 3, 300, 300, 40, 0, 12, 10, 1, 1, 1, 0, 11),
(1171, 2, 200, 200, 20, 0, 12, 11, 1, 1, 1, 0, 11),
(1172, 4, 30, 30, 25, 0, 3, 2, 0, 1, 1, 0, 14),
(1173, 5, 999, 999, 999, 0, 0, 0, 0, 1, 1, 0, 14),
(1174, 1, 200, 200, 15, 0, 3, 3, 0, 0, 0, 1, 14),
(1176, 3, 300, 300, 40, 0, 0, 2, 0, 1, 1, 0, 14),
(1177, 2, 200, 200, 20, 0, 0, 3, 0, 1, 1, 0, 14),
(1178, 6, 999, 999, 999, 0, 12, 13, 1, 1, 1, 0, 14),
(1179, 1, 200, 200, 15, 0, 9, 10, 1, 1, 1, 0, 14),
(1180, 3, 300, 300, 40, 0, 12, 10, 1, 1, 1, 0, 14),
(1181, 2, 200, 200, 20, 0, 12, 11, 1, 1, 1, 0, 14),
(1182, 4, 30, 30, 25, 0, 3, 2, 0, 1, 1, 0, 15),
(1183, 5, 999, 999, 999, 0, 0, 0, 0, 1, 1, 0, 15),
(1184, 1, 200, 200, 15, 0, 3, 3, 0, 0, 0, 1, 15),
(1186, 3, 300, 300, 40, 0, 0, 2, 0, 1, 1, 0, 15),
(1187, 2, 200, 200, 20, 0, 0, 3, 0, 1, 1, 0, 15),
(1188, 6, 999, 999, 999, 0, 12, 13, 1, 1, 1, 0, 15),
(1189, 1, 200, 200, 15, 0, 9, 10, 1, 1, 1, 0, 15),
(1190, 3, 300, 300, 40, 0, 12, 10, 1, 1, 1, 0, 15),
(1191, 2, 200, 200, 20, 0, 12, 11, 1, 1, 1, 0, 15),
(1192, 4, 30, 30, 25, 0, 3, 2, 0, 1, 1, 0, 16),
(1193, 5, 999, 999, 999, 0, 0, 0, 0, 1, 1, 0, 16),
(1194, 1, 200, 200, 15, 0, 3, 3, 0, 0, 0, 1, 16),
(1196, 3, 300, 300, 40, 0, 0, 2, 0, 1, 1, 0, 16),
(1197, 2, 200, 200, 20, 0, 0, 3, 0, 1, 1, 0, 16),
(1198, 6, 999, 999, 999, 0, 12, 13, 1, 1, 1, 0, 16),
(1199, 1, 200, 200, 15, 0, 9, 10, 1, 1, 1, 0, 16),
(1200, 3, 300, 300, 40, 0, 12, 10, 1, 1, 1, 0, 16),
(1201, 2, 200, 200, 20, 0, 12, 11, 1, 1, 1, 0, 16),
(1202, 4, 30, 30, 25, 0, 3, 2, 0, 0, 0, 1, 18),
(1203, 5, 999, 999, 999, 0, 0, 0, 0, 1, 1, 0, 18),
(1204, 1, 200, 200, 15, 0, 3, 3, 0, 0, 0, 1, 18),
(1206, 3, 300, 300, 40, 0, 0, 2, 0, 1, 1, 0, 18),
(1207, 2, 200, 200, 20, 0, 0, 3, 0, 1, 1, 0, 18),
(1208, 6, 999, 999, 999, 0, 12, 13, 1, 1, 1, 0, 18),
(1209, 1, 200, 200, 15, 0, 9, 10, 1, 1, 1, 0, 18),
(1210, 3, 300, 300, 40, 0, 12, 10, 1, 1, 1, 0, 18),
(1211, 2, 200, 200, 20, 0, 12, 11, 1, 1, 1, 0, 18),
(1212, 4, 30, 30, 25, 0, 4, 4, 0, 0, 0, 1, 19),
(1213, 5, 999, 999, 999, 0, 0, 0, 0, 1, 1, 0, 19),
(1214, 1, 200, 200, 15, 0, 3, 3, 0, 0, 0, 1, 19),
(1216, 3, 300, 300, 40, 0, 0, 2, 0, 1, 1, 0, 19),
(1217, 2, 200, 200, 20, 0, 0, 3, 0, 1, 1, 0, 19),
(1218, 6, 999, 999, 999, 0, 12, 13, 1, 1, 1, 0, 19),
(1219, 1, 200, 200, 15, 0, 9, 10, 1, 1, 1, 0, 19),
(1220, 3, 300, 300, 40, 0, 12, 10, 1, 1, 1, 0, 19),
(1221, 2, 200, 200, 20, 0, 12, 11, 1, 1, 1, 0, 19),
(1222, 4, 30, 30, 25, 0, 3, 2, 0, 1, 1, 0, 20),
(1223, 5, 999, 999, 999, 0, 0, 0, 0, 1, 1, 0, 20),
(1224, 1, 200, 200, 15, 0, 3, 3, 0, 0, 0, 1, 20),
(1226, 3, 300, 300, 40, 0, 0, 2, 0, 1, 1, 0, 20),
(1227, 2, 200, 200, 20, 0, 0, 3, 0, 1, 1, 0, 20),
(1228, 6, 999, 999, 999, 0, 12, 13, 1, 1, 1, 0, 20),
(1229, 1, 200, 200, 15, 0, 9, 10, 1, 1, 1, 0, 20),
(1230, 3, 300, 300, 40, 0, 12, 10, 1, 1, 1, 0, 20),
(1231, 2, 200, 200, 20, 0, 12, 11, 1, 1, 1, 0, 20),
(1232, 4, 30, 30, 25, 0, 4, 4, 0, 0, 0, 1, 22),
(1233, 5, 999, 999, 999, 0, 0, 0, 0, 1, 1, 0, 22),
(1234, 1, 200, 200, 15, 0, 3, 3, 0, 0, 0, 1, 22),
(1236, 3, 300, 300, 40, 0, 0, 2, 0, 1, 1, 0, 22),
(1237, 2, 200, 200, 20, 0, 0, 3, 0, 1, 1, 0, 22),
(1238, 6, 999, 999, 999, 0, 12, 13, 1, 1, 1, 0, 22),
(1239, 1, 200, 200, 15, 0, 9, 10, 1, 1, 1, 0, 22),
(1240, 3, 300, 300, 40, 0, 12, 10, 1, 1, 1, 0, 22),
(1241, 2, 200, 200, 20, 0, 12, 11, 1, 1, 1, 0, 22),
(1252, 4, 30, 30, 25, 0, 3, 2, 0, 1, 1, 0, 23),
(1253, 5, 999, 999, 999, 0, 0, 0, 0, 1, 1, 0, 23),
(1254, 1, 200, 200, 15, 0, 3, 3, 0, 1, 1, 0, 23),
(1255, 4, 30, 30, 25, 0, 3, 4, 1, 1, 1, 0, 23),
(1256, 3, 300, 300, 40, 0, 0, 2, 0, 1, 1, 0, 23),
(1257, 2, 200, 200, 20, 0, 0, 3, 0, 1, 1, 0, 23),
(1258, 6, 999, 999, 999, 0, 12, 13, 1, 1, 1, 0, 23),
(1259, 1, 200, 200, 15, 0, 9, 10, 1, 1, 1, 0, 23),
(1260, 3, 300, 300, 40, 0, 12, 10, 1, 1, 1, 0, 23),
(1261, 2, 200, 200, 20, 0, 12, 11, 1, 1, 1, 0, 23),
(1282, 4, 30, 30, 25, 0, 3, 2, 0, 1, 1, 0, 24),
(1283, 5, 999, 999, 999, 0, 0, 0, 0, 1, 1, 0, 24),
(1284, 1, 200, 200, 15, 0, 3, 3, 0, 1, 1, 0, 24),
(1285, 4, 30, 30, 25, 0, 3, 4, 1, 1, 1, 0, 24),
(1286, 3, 300, 300, 40, 0, 0, 2, 0, 1, 1, 0, 24),
(1287, 2, 200, 200, 20, 0, 0, 3, 0, 1, 1, 0, 24),
(1288, 6, 999, 999, 999, 0, 12, 13, 1, 1, 1, 0, 24),
(1289, 1, 200, 200, 15, 0, 9, 10, 1, 1, 1, 0, 24),
(1290, 3, 300, 300, 40, 0, 12, 10, 1, 1, 1, 0, 24),
(1291, 2, 200, 200, 20, 0, 12, 11, 1, 1, 1, 0, 24);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `password` varchar(128) NOT NULL,
  `email` varchar(64) NOT NULL,
  `username` varchar(64) NOT NULL,
  `wins` int(11) NOT NULL,
  `losses` int(11) NOT NULL,
  `elo` smallint(6) NOT NULL DEFAULT '1000',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `member_type` set('normal','guest') NOT NULL DEFAULT 'normal',
  `lastactive` int(11) NOT NULL,
  `hat` int(11) NOT NULL DEFAULT '1',
  `hair` int(11) NOT NULL,
  `kp` int(11) NOT NULL DEFAULT '1000'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `password`, `email`, `username`, `wins`, `losses`, `elo`, `created`, `member_type`, `lastactive`, `hat`, `hair`, `kp`) VALUES
(6, '$2y$10$zmsIcYDqp8ScNRuDcj9jD.kbsW9vC7k655flzcYK66kC0jkWa0toK', 'alanduu50@gmail.com', 'xXN1NJ4Xx', 343, 148, 1000, '2016-05-23 21:22:33', 'normal', 1465372058, 1, 0, 1000),
(7, '$2y$10$xGKFvkCEjUMSm1y6cr8v/.IsJCZfLhNtigg0eyETXQYbslu5X1IBK', 'kld14@ic.ac.uk', 'DragonSlayer52', 358, 145, 1000, '2016-05-23 21:22:01', 'normal', 1465372058, 1, 0, 1000),
(8, '$2y$10$s7PfGa0iZcg2XDFrmEAnhegSMZzKi4Po4GyUEl1E9cA69tUJj5qSa', 'test@test.com', 'HaskellPrize', 147, 23, 1000, '2016-05-23 21:20:45', 'normal', 1465372058, 1, 0, 1000),
(9, '$2y$10$y8geeo6e4vVMUkhJWycFruGOuplLwujzm8q4RZlZQPpkn6RKbkfpS', 'demo@demo.com', 'Wumpus', 197, 77, 945, '2016-05-23 21:20:18', 'normal', 1465402545, 1, 0, 8900),
(10, '$2y$10$h9fvGHQrrOHh35pNzhIsqOR.0jDi4ZmVtHiCvP1wCexLef072jYqy', 'tonyfield@rules.com', 'OhBaby', 214, 26, 1000, '2016-05-23 18:59:26', 'normal', 1465372058, 1, 0, 1000),
(11, '$2y$10$jOeNVa.g.MTq8j7NoOY3k.RTVeYpcrxA7gq8zv8hp9yiVBsk0z3C.', 'debug@debug.com', 'debug', 212, 52, 1000, '2016-06-01 20:52:54', 'normal', 1465372058, 1, 0, 1000),
(12, '$2y$10$7.dtDYkyCuARy8JOOvnEM..015QDAO7YDKsNEmue6deyEyJvIDwr2', 'goku@goku.com', 'goku', 211, 62, 1000, '2016-06-01 20:53:04', 'normal', 1465372058, 1, 0, 1000),
(13, '$2y$10$EVxl9C85A3EGzS9/mbr4mO1eZwdAa7RoFtuXRU.4lwdohCezvuQTu', 'veg@veg.com', 'veg', 311, 73, 1000, '2016-06-01 20:53:57', 'normal', 1465372058, 1, 0, 1000),
(14, '$2y$10$sxwp7k4OSuCdCiO7y.JsOucq/YbXFR4oF8aBcgeTJ.UixSPKh.xJm', 'hp@hp.com', 'harry potter', 14, 4, 1115, '2016-06-04 21:40:28', 'normal', 1465402543, 1, 0, 16200),
(15, '$2y$10$Q3aMDDCP8w2o8bV.SaRs4.4Mgr49ZHzl372S4qExpvmadU0mAHETi', 'asda@asda.com', 'asdasd', 0, 0, 1000, '2016-06-04 21:40:51', 'normal', 1465372058, 1, 0, 1000),
(16, '$2y$10$aZkr5proBXT1kbSu9WWoHOM/q4lHiyqVXj6/9FYTa9Tn6YaO31LPW', 'simon@simon.com', 'simon', 0, 0, 1000, '2016-06-06 09:29:26', 'normal', 1465372058, 1, 0, 1000),
(17, '', '', 'guesto', 0, 0, 1000, '2016-06-07 13:22:51', 'guest', 1465372058, 1, 0, 1000);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `achievements`
--
ALTER TABLE `achievements`
  ADD PRIMARY KEY (`ach_name`);

--
-- Indexes for table `ach_instances`
--
ALTER TABLE `ach_instances`
  ADD PRIMARY KEY (`ach_name`,`user_id`);

--
-- Indexes for table `buffs`
--
ALTER TABLE `buffs`
  ADD PRIMARY KEY (`buff_id`);

--
-- Indexes for table `buff_instances`
--
ALTER TABLE `buff_instances`
  ADD PRIMARY KEY (`bi_id`);

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
-- Indexes for table `feedback`
--
ALTER TABLE `feedback`
  ADD PRIMARY KEY (`fb_id`);

--
-- Indexes for table `friends`
--
ALTER TABLE `friends`
  ADD PRIMARY KEY (`friend_id`);

--
-- Indexes for table `inventory`
--
ALTER TABLE `inventory`
  ADD PRIMARY KEY (`inv_id`);

--
-- Indexes for table `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`item_id`);

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
-- Indexes for table `opp`
--
ALTER TABLE `opp`
  ADD PRIMARY KEY (`opp_id`);

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
  MODIFY `buff_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `buff_instances`
--
ALTER TABLE `buff_instances`
  MODIFY `bi_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;
--
-- AUTO_INCREMENT for table `chat`
--
ALTER TABLE `chat`
  MODIFY `chat_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=209;
--
-- AUTO_INCREMENT for table `classes`
--
ALTER TABLE `classes`
  MODIFY `class_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `feedback`
--
ALTER TABLE `feedback`
  MODIFY `fb_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `friends`
--
ALTER TABLE `friends`
  MODIFY `friend_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;
--
-- AUTO_INCREMENT for table `inventory`
--
ALTER TABLE `inventory`
  MODIFY `inv_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `items`
--
ALTER TABLE `items`
  MODIFY `item_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `maps`
--
ALTER TABLE `maps`
  MODIFY `map_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `opp`
--
ALTER TABLE `opp`
  MODIFY `opp_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=398;
--
-- AUTO_INCREMENT for table `rooms`
--
ALTER TABLE `rooms`
  MODIFY `room_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;
--
-- AUTO_INCREMENT for table `room_participants`
--
ALTER TABLE `room_participants`
  MODIFY `part_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;
--
-- AUTO_INCREMENT for table `units`
--
ALTER TABLE `units`
  MODIFY `unit_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1292;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
