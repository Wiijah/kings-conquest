-- phpMyAdmin SQL Dump
-- version 4.5.2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jun 12, 2016 at 03:15 PM
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
('100_wins', 'images/achievements/100_wins.png', 'For winning 100 games.'),
('50_wins', 'images/achievements/50_wins.png', 'For winning 50 games.'),
('first_lost', 'images/achievements/bronze_trophy.png', 'For losing a game for the first time.'),
('first_win', 'images/achievements/silver_trophy.png', 'For winning a game for the first time.'),
('perfect_win', 'images/achievements/perfect_win.png', 'For winning a game without losing any units.');

-- --------------------------------------------------------

--
-- Table structure for table `ach_instances`
--

CREATE TABLE `ach_instances` (
  `ach_name` varchar(64) NOT NULL,
  `user_id` int(11) NOT NULL,
  `room_id` int(11) NOT NULL,
  `alert` tinyint(4) NOT NULL DEFAULT '1',
  `ach_created` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ach_instances`
--

INSERT INTO `ach_instances` (`ach_name`, `user_id`, `room_id`, `alert`, `ach_created`) VALUES
('100_wins', 6, 0, 1, 0),
('100_wins', 7, 0, 1, 0),
('100_wins', 8, 0, 1, 0),
('100_wins', 9, 0, 1, 0),
('100_wins', 10, 0, 1, 0),
('100_wins', 11, 0, 1, 0),
('100_wins', 12, 0, 1, 0),
('100_wins', 13, 0, 1, 0),
('100_wins', 14, 0, 1, 0),
('50_wins', 6, 0, 1, 0),
('50_wins', 7, 0, 1, 0),
('50_wins', 8, 0, 1, 0),
('50_wins', 9, 0, 1, 0),
('50_wins', 10, 0, 1, 0),
('50_wins', 11, 0, 1, 0),
('50_wins', 12, 0, 1, 0),
('50_wins', 13, 0, 1, 0),
('50_wins', 14, 0, 1, 0),
('first_lost', 6, 0, 1, 0),
('first_lost', 7, 0, 1, 0),
('first_lost', 8, 0, 1, 0),
('first_lost', 9, 0, 1, 0),
('first_lost', 10, 0, 1, 0),
('first_lost', 11, 0, 1, 0),
('first_lost', 12, 0, 1, 0),
('first_lost', 13, 0, 1, 0),
('first_lost', 14, 0, 1, 0),
('first_lost', 27, 0, 1, 0),
('first_lost', 31, 1, 0, 0),
('first_lost', 34, 6, 0, 0),
('first_lost', 35, 3, 0, 0),
('first_win', 6, 0, 1, 0),
('first_win', 7, 0, 1, 0),
('first_win', 8, 0, 1, 0),
('first_win', 9, 0, 1, 0),
('first_win', 10, 0, 1, 0),
('first_win', 11, 0, 1, 0),
('first_win', 12, 0, 1, 0),
('first_win', 13, 0, 1, 0),
('first_win', 14, 0, 1, 0),
('first_win', 27, 0, 1, 0),
('first_win', 28, 0, 1, 0),
('first_win', 32, 1, 0, 0),
('first_win', 34, 2, 0, 0),
('perfect_win', 6, 0, 1, 0),
('perfect_win', 7, 0, 1, 0),
('perfect_win', 8, 0, 1, 0),
('perfect_win', 9, 0, 1, 0),
('perfect_win', 10, 0, 1, 0),
('perfect_win', 11, 0, 1, 0),
('perfect_win', 12, 0, 1, 0),
('perfect_win', 13, 0, 1, 0),
('perfect_win', 14, 0, 1, 0),
('perfect_win', 27, 0, 1, 0),
('perfect_win', 28, 10, 0, 0),
('perfect_win', 32, 1, 0, 0),
('perfect_win', 34, 2, 0, 0);

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
(3, 'battleCry', 'graphics/spritesheet/spell/ss_inc_attack.png', ''),
(4, 'shield', '', 'graphics/buff/buff_shield.png'),
(5, 'Burn', '', ''),
(6, 'freeze', 'graphics/spritesheet/spell/ss_frozen.png', 'graphics/buffs/buff_frozen.png');

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
(13, 4, 62, -1, 7);

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
(18, '2016-06-12 12:27:17', 14, 'uh', 0, 'message', ''),
(19, '2016-06-12 12:27:38', 14, 'Leap Of Faith joined the room.', 8, 'event', ''),
(20, '2016-06-12 12:51:48', 14, 'Leap Of Faith left the room.', 8, 'event', ''),
(21, '2016-06-12 12:51:50', 14, 'Leap Of Faith joined the room.', 9, 'event', ''),
(22, '2016-06-12 12:51:52', 9, 'Wumpus joined the room.', 9, 'event', '');

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
  `luck` float NOT NULL,
  `commandable` int(11) NOT NULL DEFAULT '1',
  `move` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `classes`
--

INSERT INTO `classes` (`class_id`, `name`, `address`, `spritesheet`, `info`, `max_hp`, `attack`, `skill`, `skillMaxCD`, `moveRange`, `attackRange`, `damageEffect`, `gold`, `luck`, `commandable`, `move`) VALUES
(1, 'wizard', 'graphics/spritesheet/stand/ss_wizard_stand.png', 'graphics/spritesheet/attack/ss_wizard_attack.png', 'graphics/card/wizard_card.png', 200, 15, 'Magic Damage', 6, 3, 3, 'graphics/spritesheet/spell/ss_fireball.png', 100, 0.25, 1, 'graphics/spritesheet/move/ss_wizard_move.png'),
(2, 'archer', 'graphics/spritesheet/stand/ss_archer_stand.png', 'graphics/spritesheet/attack/ss_archer_attack.png', 'graphics/card/archer_card.png', 200, 20, 'Double Shoot', 6, 3, 4, 'graphics/spritesheet/spell/ss_arrow.png', 100, 0.4, 1, 'graphics/spritesheet/move/ss_archer_move.png'),
(3, 'knight', 'graphics/spritesheet/stand/ss_knight_stand.png', 'graphics/spritesheet/attack/ss_knight_attack.png', 'graphics/card/knight_card.png', 300, 40, 'Shield', 6, 2, 1, 'graphics/spritesheet/spell/ss_physical_attack.png', 100, 0.15, 1, 'graphics/spritesheet/move/ss_knight_move.png'),
(4, 'king', 'graphics/spritesheet/stand/ss_king_stand.png', 'graphics/spritesheet/attack/ss_king_attack.png', 'graphics/card/king_card.png', 100, 25, 'Battle Cry', 6, 3, 2, 'graphics/spritesheet/spell/ss_physical_attack.png', 0, 0.2, 1, 'graphics/spritesheet/move/ss_king_move.png'),
(5, 'red castle', 'graphics/spritesheet/special_unit/ss_castle_red.png', 'graphics/spritesheet/attack/ss_archer_attack.png', 'graphics/card/castle_card.png', 999, 999, 'RED', 6, 0, 10, 'graphics/spritesheet/spell/ss_physical_attack.png', 100, 0, 0, ''),
(6, 'blue castle', 'graphics/spritesheet/special_unit/ss_castle_blue.png', 'graphics/spritesheet/attack/ss_archer_attack.png', 'graphics/card/castle_card.png', 999, 999, 'BLUE', 6, 0, 10, 'graphics/spritesheet/spell/ss_physical_attack.png', 100, 0, 0, ''),
(7, 'dragon', 'graphics/spritesheet/stand/ss_dragon_stand.png', 'graphics/spritesheet/attack/ss_dragon_attack.png', 'graphics/card/dragon_card.png', 300, 35, 'Icy Wind', 6, 4, 3, 'graphics/spritesheet/spell/ss_icy_wind.png', 300, 0.25, 1, 'graphics/spritesheet/move/ss_dragon_move.png'),
(8, 'totem', 'graphics/spritesheet/special_unit/ss_totem_stand.png', 'graphics/spritesheet/special_unit/ss_totem_heal.png', 'graphics/card/totem_card.png', 1, 1, 'N/A', 6, 0, 0, 'graphics/spritesheet/special_unit/ss_totem_heal.png', 200, 0, 0, '');

-- --------------------------------------------------------

--
-- Table structure for table `feedback`
--

CREATE TABLE `feedback` (
  `fb_id` int(11) NOT NULL,
  `subject` int(11) NOT NULL,
  `body` text NOT NULL,
  `user_id` int(11) NOT NULL,
  `fb_created` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `feedback`
--

INSERT INTO `feedback` (`fb_id`, `subject`, `body`, `user_id`, `fb_created`) VALUES
(1, 1, 'implement match replay/history/spectate!', 28, 1465516462),
(3, 3, 'I am an ethnic minority and i want different skin colours, maybe an alien skin colour too for fun! i dont like how there is only one skin colour...', 13, 1465454723),
(4, 1, 'we need a timer so that users wont take forever to take their turn! ', 9, 1465432814),
(5, 2, 'itll be nice if we have an ingame currency and maybe some sort of shop to buy things frmo', 24, 1465247852),
(6, 1, 'achievement pls', 9, 1465555028),
(7, 1, 'Dear King''s conquest,\r\n\r\nplease can you create an elo system.\r\n\r\nall the best.', 9, 1465555058);

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
(21, 9, 12, 1),
(22, 9, 7, 0),
(23, 9, 8, 0),
(25, 28, 9, 0),
(26, 28, 14, 1),
(27, 14, 11, 0);

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
(1, 14, 1, 3),
(2, 14, 2, 9),
(5, 9, 3, 4),
(15, 14, 8, 2),
(20, 14, 12, 2),
(25, 27, 1, 1),
(26, 9, 1, 1),
(27, 33, 1, 1),
(31, 32, 1, 1),
(32, 34, 1, 1),
(33, 14, 6, 1),
(36, 14, 5, 1),
(37, 14, 9, 1),
(38, 14, 13, 1),
(39, 14, 11, 1);

-- --------------------------------------------------------

--
-- Table structure for table `items`
--

CREATE TABLE `items` (
  `item_id` int(11) NOT NULL,
  `name` varchar(64) NOT NULL,
  `type` set('hat','eyes','wig','mouth','body','na') NOT NULL,
  `image` varchar(128) NOT NULL,
  `price` int(11) NOT NULL,
  `description` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `items`
--

INSERT INTO `items` (`item_id`, `name`, `type`, `image`, `price`, `description`) VALUES
(1, 'Crown', 'hat', 'avatars/crown.png', 0, 'Although a plain crown, the golden material of the crown radiates with the passion of a king.'),
(2, 'Jeweled Crown', 'hat', 'avatars/jeweled_crown.png', 2500, 'A crown with some jewels embedded on it.'),
(3, 'Sunglasses', 'eyes', 'avatars/sunglasses.png', 500, 'A pair of sunglasses that will protect you from the sun.'),
(4, 'Black Crown Shirt', 'body', 'avatars/black_crown_shirt.png', 1000, 'A black shirt with a crown imprinted on it.'),
(5, 'White Crown Shirt', 'body', 'avatars/white_crown_shirt.png', 1000, 'A white shirt with a crown imprinted on it.'),
(6, 'Blue King Shirt', 'body', 'avatars/blue_king_shirt.png', 750, 'A blue shirt with the letter K imprinted on it. The K stands for King in Kings'' Conquest.'),
(7, 'Red Headband', 'hat', 'avatars/red_headband.png', 100, 'A headband worn by ninjas.'),
(8, 'Black Mask', 'mouth', 'avatars/black_mask.png', 100, 'A black mask worn by highly trained assassins.'),
(9, 'Legendary Crown', 'hat', 'avatars/legendary_crown.png', 10000000, 'A crown of a legendary king. It is said that only the best of kings have touched this crown before.'),
(10, 'Cigarette', 'mouth', 'avatars/cigarette.png', 2000, 'The cigarette smells awful.'),
(11, 'Suit', 'body', 'avatars/suit.png', 17500, 'A black suit with a tie. Looks smart.'),
(12, 'Monocle', 'eyes', 'avatars/monocle.png', 1750, 'A single eyeglass with a moustache.'),
(13, 'Gentleman''s Hat', 'hat', 'avatars/gentlemans_hat.png', 1750, 'A hat worn by gentlemen.');

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
(1, 'The Bridge', '{"0":[4, 4, 4, 0 ,1, 1, 1, 1, 1, 1, 1, 0, 1 ,0],\n "1":[4, 4, 4, 4 ,4, 4, 5, 5, 5, 5, 5, 5, 6 ,5],\n "2":[4, 4, 4, 0 ,1, 4, 5, 5, 5, 5, 5, 5, 6 ,5],\n "3":[0, 0, 0, 0 ,1, 4, 5, 5, 4, 4, 4, 0, 1 ,0],\n "4":[0, 1, 1, 1 ,1, 4, 3, 3, 4, 1, 1, 1, 1 ,0],\n "5":[0, 1, 1, 1 ,1, 4, 5, 5, 4, 1, 1, 1, 1 ,0],\n "6":[0, 1, 1, 1 ,1, 1, 5, 5, 1, 1, 1, 1, 1 ,0],\n "7":[0, 1, 1, 1 ,1, 4, 5, 5, 4, 1, 1, 1, 1 ,0],\n "8":[0, 1, 1, 1 ,1, 4, 3, 3, 4, 1, 1, 1, 1 ,0],\n "9":[0, 1, 1, 1 ,1, 4, 5, 5, 4, 1, 0, 0, 0 ,0],\n "10":[5, 6, 5, 5 ,5, 5, 5, 5, 4, 1, 0, 4, 4 ,4],\n "11":[5, 6, 5, 5 ,5, 5, 5, 5, 4, 4, 4, 4, 4 ,4],\n "12":[0, 1, 0, 1 ,1, 1, 1, 1, 1, 1, 0, 4, 4 ,4]\n}'),
(2, 'Waterfall', '{"0":[4, 4, 4, 0 ,1, 1, 1, 1, 1, 1, 1, 0, 1 ,0],\r\n "1":[4, 4, 4, 4 ,4, 4, 5, 5, 5, 5, 5, 5, 6 ,5],\r\n "2":[4, 4, 4, 0 ,1, 4, 5, 5, 5, 5, 5, 5, 6 ,5],\r\n "3":[0, 0, 0, 0 ,1, 4, 5, 5, 4, 4, 4, 0, 1 ,0],\r\n "4":[0, 1, 1, 1 ,1, 4, 3, 3, 4, 1, 1, 1, 1 ,0],\r\n "5":[0, 1, 1, 1 ,1, 4, 5, 5, 4, 1, 1, 1, 1 ,0],\r\n "6":[0, 1, 1, 1 ,1, 1, 5, 5, 1, 1, 1, 1, 1 ,0],\r\n "7":[0, 1, 1, 1 ,1, 4, 5, 5, 4, 1, 1, 1, 1 ,0],\r\n "8":[0, 1, 1, 1 ,1, 4, 3, 3, 4, 1, 1, 1, 1 ,0],\r\n "9":[0, 1, 1, 1 ,1, 4, 5, 5, 4, 1, 0, 0, 0 ,0],\r\n "10":[5, 6, 5, 5 ,5, 5, 5, 5, 4, 1, 0, 4, 4 ,4],\r\n "11":[5, 6, 5, 5 ,5, 5, 5, 5, 4, 4, 4, 4, 4 ,4],\r\n "12":[0, 1, 0, 1 ,1, 1, 1, 1, 1, 1, 0, 4, 4 ,4]\r\n}');

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
(1, 1, 31, 0, '{"error_code": 0,"actions": [{"action_type": "game_end", "reason":"quit_game","winner": 1}]}'),
(2, 2, 14, 0, '{"error_code": 0,"actions": [{"action_type": "create_unit", "unit": {"21": {\n      "address":"graphics/spritesheet/special_unit/ss_totem_stand.png","spritesheet":"graphics/spritesheet/special_unit/ss_totem_heal.png","unit_id": 21,"info":"graphics/card/totem_card.png","hp": 1,"max_hp": 1,"attack": 1,"skill":"N/A","luck": 0,"commandable": 0,"x": 2,"y": 3,"buffs": [],"moveRange": 0,"team": 0,"attackRange": 0,"canMove": 1,"canAttack": 1,"skillCoolDown": 0,"outOfMoves": 0,"damageEffect":"graphics/spritesheet/special_unit/ss_totem_heal.png"\n    }}},{"action_type" : "update_gold", "gold" : 300, "team" : 0}]}'),
(3, 2, 14, 0, '{"error_code": 0,"actions": [{"action_type": "move_unit", "unit_id": 13,"path": [[3,3],[3,4],[3,5]]},{ "action_type" : "update_unit",\n    "unit_id" : 13,\n    "canMove" : 0,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0}]}'),
(4, 2, 14, 0, '{"error_code": 0,"actions": [{"action_type": "create_unit", "unit": {"22": {\n      "address":"graphics/spritesheet/stand/ss_wizard_stand.png","spritesheet":"graphics/spritesheet/attack/ss_wizard_attack.png","unit_id": 22,"info":"graphics/card/wizard_card.png","hp": 200,"max_hp": 200,"attack": 15,"skill":"Magic Damage","luck": 0.25,"commandable": 1,"x": 2,"y": 2,"buffs": [],"moveRange": 3,"team": 0,"attackRange": 3,"canMove": 1,"canAttack": 1,"skillCoolDown": 0,"outOfMoves": 0,"damageEffect":"graphics/spritesheet/spell/ss_fireball.png"\n    }}},{"action_type" : "update_gold", "gold" : 200, "team" : 0}]}'),
(5, 2, 14, 0, '{"error_code": 0,"actions": [{"action_type": "move_unit", "unit_id": 22,"path": [[2,2],[1,2],[1,3],[1,4]]},{ "action_type" : "update_unit",\n    "unit_id" : 22,\n    "canMove" : 0,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0}]}'),
(6, 2, 34, 1, '{"error_code": 0,"actions": [{ "action_type" : "update_unit",\n    "unit_id" : 11,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 12,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 13,\n    "canMove" : 0,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 14,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 15,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 16,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 17,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 18,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 19,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 20,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 21,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 22,\n    "canMove" : 0,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{"action_type": "turn_change", "new_turn": 1,"effects_to_apply": [],"units_new_cd": [],"buffs_to_remove": []},{"action_type" : "trigger_buff",\n    "buff_effect" : "Heal",\n    "unit_id" : 11,\n    "health_change" : 0\n  },{"action_type" : "trigger_buff",\n    "buff_effect" : "Heal",\n    "unit_id" : 22,\n    "health_change" : 0\n  },{"action_type" : "update_gold", "gold" : 510, "team" : 1},{"action_type" : "update_gold", "gold" : 210, "team" : 0}]}'),
(7, 2, 14, 0, '{"error_code": 0,"actions": [{"action_type": "game_end", "reason":"quit_game","winner": 1}]}'),
(8, 3, 34, 0, '{"error_code": 0,"actions": [{"action_type": "move_unit", "unit_id": 27,"path": [[0,3],[0,4],[0,5],[1,5]]},{ "action_type" : "update_unit",\n    "unit_id" : 27,\n    "canMove" : 0,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0}]}'),
(9, 3, 34, 0, '{"error_code": 0,"actions": [{ "action_type" : "update_unit",\n    "unit_id" : 23,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 24,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 25,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 26,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 27,\n    "canMove" : 0,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 28,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 29,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 30,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 31,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 32,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{"action_type": "turn_change", "new_turn": 1,"effects_to_apply": [],"units_new_cd": [],"buffs_to_remove": []},{"action_type" : "update_gold", "gold" : 510, "team" : 0},{"action_type" : "update_gold", "gold" : 510, "team" : 1}]}'),
(10, 3, 35, 1, '{"error_code": 0,"actions": [{"action_type": "move_unit", "unit_id": 30,"path": [[9,10],[8,10],[7,10],[6,10]]},{ "action_type" : "update_unit",\n    "unit_id" : 30,\n    "canMove" : 0,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0}]}'),
(11, 3, 35, 1, '{"error_code": 0,"actions": [{"action_type": "create_unit", "unit": {"33": {\n      "address":"graphics/spritesheet/stand/ss_dragon_stand.png","spritesheet":"graphics/spritesheet/attack/ss_dragon_attack.png","unit_id": 33,"info":"graphics/card/dragon_card.png","hp": 300,"max_hp": 300,"attack": 35,"skill":"Icy Wind","luck": 0.25,"commandable": 1,"x": 10,"y": 13,"buffs": [],"moveRange": 4,"team": 1,"attackRange": 3,"canMove": 1,"canAttack": 1,"skillCoolDown": 0,"outOfMoves": 0,"damageEffect":"graphics/spritesheet/spell/ss_icy_wind.png"\n    }}},{"action_type" : "update_gold", "gold" : 210, "team" : 1}]}'),
(12, 3, 35, 1, '{"error_code": 0,"actions": [{"action_type": "game_end", "reason":"quit_game","winner": 0}]}'),
(13, 3, 35, 1, '{"error_code": 0,"actions": [{"action_type": "game_end", "reason":"quit_game","winner": 0}]}'),
(14, 5, 14, 0, '{"error_code": 0,"actions": [{"action_type": "game_end", "reason":"quit_game","winner": 1}]}'),
(15, 6, 14, 0, '{"error_code": 0,"actions": [{"action_type": "move_unit", "unit_id": 48,"path": [[0,3],[0,4],[1,4],[2,4]]},{ "action_type" : "update_unit",\n    "unit_id" : 48,\n    "canMove" : 0,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0}]}'),
(16, 6, 14, 0, '{"error_code": 0,"actions": [{"action_type": "move_unit", "unit_id": 46,"path": [[3,3],[3,4],[3,5]]},{ "action_type" : "update_unit",\n    "unit_id" : 46,\n    "canMove" : 0,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0}]}'),
(17, 6, 34, 1, '{"error_code": 0,"actions": [{"action_type": "game_end", "reason":"quit_game","winner": 0}]}'),
(18, 7, 36, 0, '{"error_code": 0,"actions": [{"action_type": "move_unit", "unit_id": 56,"path": [[3,3],[4,3],[5,3],[6,3]]},{ "action_type" : "update_unit",\n    "unit_id" : 56,\n    "canMove" : 0,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0}]}'),
(19, 7, 36, 0, '{"error_code": 0,"actions": [{"action_type": "move_unit", "unit_id": 54,"path": [[3,2],[3,3],[3,4],[4,4]]},{ "action_type" : "update_unit",\n    "unit_id" : 54,\n    "canMove" : 0,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0}]}'),
(20, 7, 36, 0, '{"error_code": 0,"actions": [{"action_type": "move_unit", "unit_id": 58,"path": [[0,3],[1,3],[2,3],[3,3]]},{ "action_type" : "update_unit",\n    "unit_id" : 58,\n    "canMove" : 0,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0}]}'),
(21, 7, 36, 0, '{"error_code": 0,"actions": [{"action_type": "move_unit", "unit_id": 57,"path": [[0,2],[1,2],[2,2]]},{ "action_type" : "update_unit",\n    "unit_id" : 57,\n    "canMove" : 0,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0}]}'),
(22, 7, 36, 0, '{"error_code": 0,"actions": [{ "action_type" : "update_unit",\n    "unit_id" : 54,\n    "canMove" : 0,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 55,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 56,\n    "canMove" : 0,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 57,\n    "canMove" : 0,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 58,\n    "canMove" : 0,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 59,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 60,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 61,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 62,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 63,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{"action_type": "turn_change", "new_turn": 1,"effects_to_apply": [],"units_new_cd": [],"buffs_to_remove": []},{"action_type" : "update_gold", "gold" : 510, "team" : 0},{"action_type" : "update_gold", "gold" : 510, "team" : 1}]}'),
(23, 7, 37, 1, '{"error_code": 0,"actions": [{"action_type": "move_unit", "unit_id": 61,"path": [[9,10],[8,10],[8,9],[8,8]]},{ "action_type" : "update_unit",\n    "unit_id" : 61,\n    "canMove" : 0,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0}]}'),
(24, 7, 37, 1, '{"error_code": 0,"actions": [{"action_type": "move_unit", "unit_id": 62,"path": [[12,10],[11,10],[10,10]]},{ "action_type" : "update_unit",\n    "unit_id" : 62,\n    "canMove" : 0,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0}]}'),
(25, 7, 37, 1, '{"error_code": 0,"actions": [{"action_type": "apply_buff", "buff_id": 2,"unit_id": 59},{"action_type" : "trigger_buff",\n    "buff_effect" : "IncAttack",\n    "unit_id" : 59,\n    "health_change" : 0\n  },{"action_type": "apply_buff", "buff_id": 2,"unit_id": 61},{"action_type" : "trigger_buff",\n    "buff_effect" : "IncAttack",\n    "unit_id" : 61,\n    "health_change" : 0\n  },{"action_type": "apply_buff", "buff_id": 2,"unit_id": 62},{"action_type" : "trigger_buff",\n    "buff_effect" : "IncAttack",\n    "unit_id" : 62,\n    "health_change" : 0\n  },{"action_type": "apply_buff", "buff_id": 2,"unit_id": 63},{"action_type" : "trigger_buff",\n    "buff_effect" : "IncAttack",\n    "unit_id" : 63,\n    "health_change" : 0\n  },{ "action_type" : "update_unit",\n    "unit_id" : 59,\n    "canMove" : 0,\n    "canAttack" : 0,\n    "outOfMoves" : 1,\n    "skillCoolDown" : 6}], "debug": "Battle Cry"}'),
(26, 7, 37, 1, '{"error_code": 0,"actions": [{"action_type": "create_unit", "unit": {"64": {\n      "address":"graphics/spritesheet/stand/ss_dragon_stand.png","spritesheet":"graphics/spritesheet/attack/ss_dragon_attack.png","unit_id": 64,"info":"graphics/card/dragon_card.png","hp": 300,"max_hp": 300,"attack": 35,"skill":"Icy Wind","luck": 0.25,"commandable": 1,"x": 10,"y": 11,"buffs": [],"moveRange": 4,"team": 1,"attackRange": 3,"canMove": 1,"canAttack": 1,"skillCoolDown": 0,"outOfMoves": 0,"damageEffect":"graphics/spritesheet/spell/ss_icy_wind.png"\n    }}},{"action_type" : "update_gold", "gold" : 210, "team" : 1}]}'),
(27, 7, 37, 1, '{"error_code": 0,"actions": [{"action_type": "move_unit", "unit_id": 64,"path": [[10,11],[11,11],[11,10],[11,9],[11,8]]},{ "action_type" : "update_unit",\n    "unit_id" : 64,\n    "canMove" : 0,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0}]}'),
(28, 7, 36, 0, '{"error_code": 0,"actions": [{ "action_type" : "update_unit",\n    "unit_id" : 54,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 55,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 56,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 57,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 58,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 59,\n    "canMove" : 0,\n    "canAttack" : 0,\n    "outOfMoves" : 1,\n    "skillCoolDown" : 5},{ "action_type" : "update_unit",\n    "unit_id" : 60,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 61,\n    "canMove" : 0,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 62,\n    "canMove" : 0,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 63,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 64,\n    "canMove" : 0,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{"action_type": "turn_change", "new_turn": 0,"effects_to_apply": [],"units_new_cd": [],"buffs_to_remove": []},{"action_type" : "update_gold", "gold" : 520, "team" : 0},{"action_type" : "update_gold", "gold" : 220, "team" : 1}]}'),
(29, 7, 36, 0, '{"error_code": 0,"actions": [{"action_type": "create_unit", "unit": {"65": {\n      "address":"graphics/spritesheet/stand/ss_dragon_stand.png","spritesheet":"graphics/spritesheet/attack/ss_dragon_attack.png","unit_id": 65,"info":"graphics/card/dragon_card.png","hp": 300,"max_hp": 300,"attack": 35,"skill":"Icy Wind","luck": 0.25,"commandable": 1,"x": 2,"y": 1,"buffs": [],"moveRange": 4,"team": 0,"attackRange": 3,"canMove": 1,"canAttack": 1,"skillCoolDown": 0,"outOfMoves": 0,"damageEffect":"graphics/spritesheet/spell/ss_icy_wind.png"\n    }}},{"action_type" : "update_gold", "gold" : 220, "team" : 0}]}'),
(30, 7, 36, 0, '{"error_code": 0,"actions": [{ "action_type" : "update_unit",\n    "unit_id" : 56,\n    "canMove" : 0,\n    "canAttack" : 0,\n    "outOfMoves" : 1,\n    "skillCoolDown" : 6}], "debug": "Magic Damage"}'),
(31, 7, 36, 0, '{"error_code": 0,"actions": [{ "action_type" : "update_unit",\n    "unit_id" : 56,\n    "canMove" : 0,\n    "canAttack" : 0,\n    "outOfMoves" : 1,\n    "skillCoolDown" : 6}], "debug": "Magic Damage"}'),
(32, 7, 36, 0, '{"error_code": 0,"actions": [{ "action_type" : "update_unit",\n    "unit_id" : 56,\n    "canMove" : 0,\n    "canAttack" : 0,\n    "outOfMoves" : 1,\n    "skillCoolDown" : 6}], "debug": "Magic Damage"}'),
(33, 7, 36, 0, '{"error_code": 0,"actions": [{ "action_type" : "update_unit",\n    "unit_id" : 56,\n    "canMove" : 0,\n    "canAttack" : 0,\n    "outOfMoves" : 1,\n    "skillCoolDown" : 6}], "debug": "Magic Damage"}'),
(34, 7, 36, 0, '{"error_code": 0,"actions": [{ "action_type" : "update_unit",\n    "unit_id" : 56,\n    "canMove" : 0,\n    "canAttack" : 0,\n    "outOfMoves" : 1,\n    "skillCoolDown" : 6}], "debug": "Magic Damage"}'),
(35, 7, 36, 0, '{"error_code": 0,"actions": [{"action_type": "apply_buff", "buff_id": 2,"unit_id": 54},{"action_type" : "trigger_buff",\n    "buff_effect" : "IncAttack",\n    "unit_id" : 54,\n    "health_change" : 0\n  },{"action_type": "apply_buff", "buff_id": 2,"unit_id": 56},{"action_type" : "trigger_buff",\n    "buff_effect" : "IncAttack",\n    "unit_id" : 56,\n    "health_change" : 0\n  },{"action_type": "apply_buff", "buff_id": 2,"unit_id": 57},{"action_type" : "trigger_buff",\n    "buff_effect" : "IncAttack",\n    "unit_id" : 57,\n    "health_change" : 0\n  },{"action_type": "apply_buff", "buff_id": 2,"unit_id": 58},{"action_type" : "trigger_buff",\n    "buff_effect" : "IncAttack",\n    "unit_id" : 58,\n    "health_change" : 0\n  },{"action_type": "apply_buff", "buff_id": 2,"unit_id": 65},{"action_type" : "trigger_buff",\n    "buff_effect" : "IncAttack",\n    "unit_id" : 65,\n    "health_change" : 0\n  },{ "action_type" : "update_unit",\n    "unit_id" : 54,\n    "canMove" : 0,\n    "canAttack" : 0,\n    "outOfMoves" : 1,\n    "skillCoolDown" : 6}], "debug": "Battle Cry"}'),
(36, 7, 36, 0, '{"error_code": 0,"actions": [{"action_type": "move_unit", "unit_id": 65,"path": [[2,1],[3,1],[4,1],[5,1],[6,1]]},{ "action_type" : "update_unit",\n    "unit_id" : 65,\n    "canMove" : 0,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0}]}'),
(37, 7, 36, 0, '{"error_code": 0,"actions": [{ "action_type" : "update_unit",\n    "unit_id" : 65,\n    "canMove" : 0,\n    "canAttack" : 0,\n    "outOfMoves" : 1,\n    "skillCoolDown" : 6}], "debug": "Icy Wind"}'),
(38, 7, 36, 0, '{"error_code": 0,"actions": [{ "action_type" : "update_unit",\n    "unit_id" : 65,\n    "canMove" : 0,\n    "canAttack" : 0,\n    "outOfMoves" : 1,\n    "skillCoolDown" : 6}], "debug": "Icy Wind"}'),
(39, 7, 36, 0, '{"error_code": 0,"actions": [{ "action_type" : "update_unit",\n    "unit_id" : 65,\n    "canMove" : 0,\n    "canAttack" : 0,\n    "outOfMoves" : 1,\n    "skillCoolDown" : 6}], "debug": "Icy Wind"}'),
(40, 7, 36, 0, '{"error_code": 0,"actions": [{ "action_type" : "update_unit",\n    "unit_id" : 65,\n    "canMove" : 0,\n    "canAttack" : 0,\n    "outOfMoves" : 1,\n    "skillCoolDown" : 6}], "debug": "Icy Wind"}'),
(41, 7, 36, 0, '{"error_code": 0,"actions": [{"action_type": "move_unit", "unit_id": 57,"path": [[2,2],[3,2],[4,2]]},{ "action_type" : "update_unit",\n    "unit_id" : 57,\n    "canMove" : 0,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0}]}'),
(42, 7, 36, 0, '{"error_code": 0,"actions": [{"action_type": "move_unit", "unit_id": 58,"path": [[3,3],[4,3],[5,3],[5,4]]},{ "action_type" : "update_unit",\n    "unit_id" : 58,\n    "canMove" : 0,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0}]}'),
(43, 7, 36, 0, '{"error_code": 0,"actions": [{ "action_type" : "update_unit",\n    "unit_id" : 54,\n    "canMove" : 0,\n    "canAttack" : 0,\n    "outOfMoves" : 1,\n    "skillCoolDown" : 5},{ "action_type" : "update_unit",\n    "unit_id" : 55,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 56,\n    "canMove" : 0,\n    "canAttack" : 0,\n    "outOfMoves" : 1,\n    "skillCoolDown" : 5},{ "action_type" : "update_unit",\n    "unit_id" : 57,\n    "canMove" : 0,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 58,\n    "canMove" : 0,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 59,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 4},{ "action_type" : "update_unit",\n    "unit_id" : 60,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 61,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 62,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 63,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 64,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 65,\n    "canMove" : 0,\n    "canAttack" : 0,\n    "outOfMoves" : 1,\n    "skillCoolDown" : 5},{"action_type": "turn_change", "new_turn": 1,"effects_to_apply": [],"units_new_cd": [],"buffs_to_remove": []},{"action_type" : "update_gold", "gold" : 230, "team" : 0},{"action_type" : "update_gold", "gold" : 230, "team" : 1}]}'),
(44, 7, 37, 1, '{"error_code": 0,"actions": [{"action_type": "move_unit", "unit_id": 61,"path": [[8,8],[8,7],[8,6],[8,5]]},{ "action_type" : "update_unit",\n    "unit_id" : 61,\n    "canMove" : 0,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0}]}'),
(45, 7, 37, 1, '{"error_code": 0,"actions": [{"action_type": "apply_buff", "buff_id": 5,"unit_id": 56},{"action_type": "attack_unit", "attacker_id": 61,"buffs": [],"target_id": 56,"dmg": 18,"is_critical": 0},{"action_type": "apply_buff", "buff_id": 5,"unit_id": 58},{"action_type": "attack_unit", "attacker_id": 61,"buffs": [],"target_id": 58,"dmg": 18,"is_critical": 0},{ "action_type" : "update_unit",\n    "unit_id" : 61,\n    "canMove" : 0,\n    "canAttack" : 0,\n    "outOfMoves" : 1,\n    "skillCoolDown" : 6}], "debug": "Magic Damage"}'),
(46, 7, 37, 1, '{"error_code": 0,"actions": [{"action_type": "move_unit", "unit_id": 64,"path": [[11,8],[10,8],[9,8],[8,8],[8,7]]},{ "action_type" : "update_unit",\n    "unit_id" : 64,\n    "canMove" : 0,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0}]}'),
(47, 7, 37, 1, '{"error_code": 0,"actions": [{"action_type": "create_unit", "unit": {"66": {\n      "address":"graphics/spritesheet/special_unit/ss_totem_stand.png","spritesheet":"graphics/spritesheet/special_unit/ss_totem_heal.png","unit_id": 66,"info":"graphics/card/totem_card.png","hp": 1,"max_hp": 1,"attack": 1,"skill":"N/A","luck": 0,"commandable": 0,"x": 5,"y": 3,"buffs": [],"moveRange": 0,"team": 1,"attackRange": 0,"canMove": 1,"canAttack": 1,"skillCoolDown": 0,"outOfMoves": 0,"damageEffect":"graphics/spritesheet/special_unit/ss_totem_heal.png"\n    }}},{"action_type" : "update_gold", "gold" : 30, "team" : 1}]}'),
(48, 7, 36, 0, '{"error_code": 0,"actions": [{ "action_type" : "update_unit",\n    "unit_id" : 54,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 4},{ "action_type" : "update_unit",\n    "unit_id" : 55,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 56,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 4},{ "action_type" : "update_unit",\n    "unit_id" : 57,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 58,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 59,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 3},{ "action_type" : "update_unit",\n    "unit_id" : 60,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 61,\n    "canMove" : 0,\n    "canAttack" : 0,\n    "outOfMoves" : 1,\n    "skillCoolDown" : 5},{ "action_type" : "update_unit",\n    "unit_id" : 62,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 63,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 64,\n    "canMove" : 0,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 65,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 4},{ "action_type" : "update_unit",\n    "unit_id" : 66,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{"action_type": "turn_change", "new_turn": 0,"effects_to_apply": [],"units_new_cd": [],"buffs_to_remove": []},{"action_type" : "trigger_buff",\n    "buff_effect" : "Burn",\n    "unit_id" : 56,\n    "health_change" : -4\n  },{"action_type" : "trigger_buff",\n    "buff_effect" : "Burn",\n    "unit_id" : 58,\n    "health_change" : -4\n  },{"action_type" : "update_gold", "gold" : 240, "team" : 0},{"action_type" : "update_gold", "gold" : 40, "team" : 1}]}'),
(49, 7, 36, 0, '{"error_code": 0,"actions": [{"action_type": "attack_unit", "attacker_id": 58,"buffs": [],"target_id": 61,"dmg": 24,"is_critical": 0},{ "action_type" : "update_unit",\n    "unit_id" : 58,\n    "canMove" : 0,\n    "canAttack" : 0,\n    "outOfMoves" : 1,\n    "skillCoolDown" : 0}]}'),
(50, 7, 36, 0, '{"error_code": 0,"actions": [{"action_type": "move_unit", "unit_id": 57,"path": [[4,2],[5,2]]},{ "action_type" : "update_unit",\n    "unit_id" : 57,\n    "canMove" : 0,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0}]}'),
(51, 7, 36, 0, '{"error_code": 0,"actions": [{"action_type": "attack_unit", "attacker_id": 57,"buffs": [],"target_id": 66,"dmg": 48,"is_critical": 0},{ "action_type" : "update_unit",\n    "unit_id" : 57,\n    "canMove" : 0,\n    "canAttack" : 0,\n    "outOfMoves" : 1,\n    "skillCoolDown" : 0}]}'),
(52, 7, 36, 0, '{"error_code": 0,"actions": [{"action_type": "move_unit", "unit_id": 56,"path": [[6,3],[6,4]]},{ "action_type" : "update_unit",\n    "unit_id" : 56,\n    "canMove" : 0,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 4}]}'),
(53, 7, 36, 0, '{"error_code": 0,"actions": [{"action_type": "attack_unit", "attacker_id": 56,"buffs": [],"target_id": 61,"dmg": 18,"is_critical": 0},{ "action_type" : "update_unit",\n    "unit_id" : 56,\n    "canMove" : 0,\n    "canAttack" : 0,\n    "outOfMoves" : 1,\n    "skillCoolDown" : 4}]}'),
(54, 7, 36, 0, '{"error_code": 0,"actions": [{"action_type": "move_unit", "unit_id": 65,"path": [[6,1],[6,2]]},{ "action_type" : "update_unit",\n    "unit_id" : 65,\n    "canMove" : 0,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 4}]}'),
(55, 7, 36, 0, '{"error_code": 0,"actions": [{"action_type": "move_unit", "unit_id": 54,"path": [[4,4],[3,4],[3,3],[3,2]]},{ "action_type" : "update_unit",\n    "unit_id" : 54,\n    "canMove" : 0,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 4}]}'),
(56, 7, 36, 0, '{"error_code": 0,"actions": [{ "action_type" : "update_unit",\n    "unit_id" : 54,\n    "canMove" : 0,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 3},{ "action_type" : "update_unit",\n    "unit_id" : 55,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 56,\n    "canMove" : 0,\n    "canAttack" : 0,\n    "outOfMoves" : 1,\n    "skillCoolDown" : 3},{ "action_type" : "update_unit",\n    "unit_id" : 57,\n    "canMove" : 0,\n    "canAttack" : 0,\n    "outOfMoves" : 1,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 58,\n    "canMove" : 0,\n    "canAttack" : 0,\n    "outOfMoves" : 1,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 59,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 2},{ "action_type" : "update_unit",\n    "unit_id" : 60,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 61,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 4},{ "action_type" : "update_unit",\n    "unit_id" : 62,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 63,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 64,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 65,\n    "canMove" : 0,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 3},{"action_type" : "remove_buff",\n    "buff_id" : "2",\n    "unit_id" : 59\n  },{"action_type" : "remove_buff",\n    "buff_id" : "2",\n    "unit_id" : 61\n  },{"action_type" : "remove_buff",\n    "buff_id" : "2",\n    "unit_id" : 62\n  },{"action_type" : "remove_buff",\n    "buff_id" : "2",\n    "unit_id" : 63\n  },{"action_type": "turn_change", "new_turn": 1,"effects_to_apply": [],"units_new_cd": [],"buffs_to_remove": []},{"action_type" : "trigger_buff",\n    "buff_effect" : "Burn",\n    "unit_id" : 56,\n    "health_change" : -4\n  },{"action_type" : "trigger_buff",\n    "buff_effect" : "Burn",\n    "unit_id" : 58,\n    "health_change" : -4\n  },{"action_type" : "update_gold", "gold" : 250, "team" : 0},{"action_type" : "update_gold", "gold" : 50, "team" : 1}]}'),
(57, 7, 37, 1, '{"error_code": 0,"actions": [{"action_type": "attack_unit", "attacker_id": 61,"buffs": [],"target_id": 56,"dmg": 15,"is_critical": 0},{ "action_type" : "update_unit",\n    "unit_id" : 61,\n    "canMove" : 0,\n    "canAttack" : 0,\n    "outOfMoves" : 1,\n    "skillCoolDown" : 4}]}'),
(58, 7, 37, 1, '{"error_code": 0,"actions": [{"action_type": "move_unit", "unit_id": 64,"path": [[8,7],[8,6]]},{ "action_type" : "update_unit",\n    "unit_id" : 64,\n    "canMove" : 0,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0}]}'),
(59, 7, 37, 1, '{"error_code": 0,"actions": [{"action_type": "apply_buff", "buff_id": 6,"unit_id": 56},{"action_type": "attack_unit", "attacker_id": 64,"buffs": [],"target_id": 56,"dmg": 35,"is_critical": 0},{ "action_type" : "update_unit",\n    "unit_id" : 64,\n    "canMove" : 0,\n    "canAttack" : 0,\n    "outOfMoves" : 1,\n    "skillCoolDown" : 6}], "debug": "Icy Wind"}'),
(60, 7, 37, 1, '{"error_code": 0,"actions": [{"action_type": "move_unit", "unit_id": 62,"path": [[10,10],[10,9],[10,8]]},{ "action_type" : "update_unit",\n    "unit_id" : 62,\n    "canMove" : 0,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0}]}'),
(61, 7, 37, 1, '{"error_code": 0,"actions": [{"action_type": "move_unit", "unit_id": 59,"path": [[9,11],[9,12],[9,13],[10,13]]},{ "action_type" : "update_unit",\n    "unit_id" : 59,\n    "canMove" : 0,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 2}]}'),
(62, 7, 37, 1, '{"error_code": 0,"actions": [{"action_type": "move_unit", "unit_id": 59,"path": [[10,13],[9,13],[9,12],[9,11]]},{ "action_type" : "update_unit",\n    "unit_id" : 59,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 2}]}'),
(63, 7, 36, 0, '{"error_code": 0,"actions": [{ "action_type" : "update_unit",\n    "unit_id" : 54,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 2},{ "action_type" : "update_unit",\n    "unit_id" : 55,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 56,\n    "canMove" : 0,\n    "canAttack" : 0,\n    "outOfMoves" : 1,\n    "skillCoolDown" : 2},{ "action_type" : "update_unit",\n    "unit_id" : 57,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 58,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 59,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 1},{ "action_type" : "update_unit",\n    "unit_id" : 60,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 61,\n    "canMove" : 0,\n    "canAttack" : 0,\n    "outOfMoves" : 1,\n    "skillCoolDown" : 3},{ "action_type" : "update_unit",\n    "unit_id" : 62,\n    "canMove" : 0,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 63,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 64,\n    "canMove" : 0,\n    "canAttack" : 0,\n    "outOfMoves" : 1,\n    "skillCoolDown" : 5},{ "action_type" : "update_unit",\n    "unit_id" : 65,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 2},{"action_type" : "remove_buff",\n    "buff_id" : "2",\n    "unit_id" : 54\n  },{"action_type" : "remove_buff",\n    "buff_id" : "2",\n    "unit_id" : 56\n  },{"action_type" : "remove_buff",\n    "buff_id" : "2",\n    "unit_id" : 57\n  },{"action_type" : "remove_buff",\n    "buff_id" : "2",\n    "unit_id" : 58\n  },{"action_type" : "remove_buff",\n    "buff_id" : "2",\n    "unit_id" : 65\n  },{"action_type": "turn_change", "new_turn": 0,"effects_to_apply": [],"units_new_cd": [],"buffs_to_remove": []},{"action_type" : "trigger_buff",\n    "buff_effect" : "Burn",\n    "unit_id" : 56,\n    "health_change" : -4\n  },{"action_type" : "trigger_buff",\n    "buff_effect" : "Burn",\n    "unit_id" : 58,\n    "health_change" : -4\n  },{"action_type" : "trigger_buff",\n    "buff_effect" : "Freeze",\n    "unit_id" : 56,\n    "health_change" : 0\n  },{"action_type" : "update_gold", "gold" : 260, "team" : 0},{"action_type" : "update_gold", "gold" : 60, "team" : 1}]}'),
(64, 7, 36, 0, '{"error_code": 0,"actions": [{"action_type": "move_unit", "unit_id": 65,"path": [[6,2],[6,3],[7,3]]},{ "action_type" : "update_unit",\n    "unit_id" : 65,\n    "canMove" : 0,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 2}]}'),
(65, 7, 36, 0, '{"error_code": 0,"actions": [{"action_type": "attack_unit", "attacker_id": 65,"buffs": [],"target_id": 61,"dmg": 35,"is_critical": 0},{ "action_type" : "update_unit",\n    "unit_id" : 65,\n    "canMove" : 0,\n    "canAttack" : 0,\n    "outOfMoves" : 1,\n    "skillCoolDown" : 2}]}'),
(66, 7, 36, 0, '{"error_code": 0,"actions": [{"action_type": "move_unit", "unit_id": 57,"path": [[5,2],[6,2],[7,2]]},{ "action_type" : "update_unit",\n    "unit_id" : 57,\n    "canMove" : 0,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0}]}'),
(67, 7, 36, 0, '{"error_code": 0,"actions": [{"action_type": "move_unit", "unit_id": 58,"path": [[5,4],[5,5],[6,5]]},{ "action_type" : "update_unit",\n    "unit_id" : 58,\n    "canMove" : 0,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0}]}'),
(68, 7, 36, 0, '{"error_code": 0,"actions": [{"action_type": "attack_unit", "attacker_id": 58,"buffs": [],"target_id": 61,"dmg": 20,"is_critical": 0},{ "action_type" : "update_unit",\n    "unit_id" : 58,\n    "canMove" : 0,\n    "canAttack" : 0,\n    "outOfMoves" : 1,\n    "skillCoolDown" : 0}]}'),
(69, 7, 36, 0, '{"error_code": 0,"actions": [{ "action_type" : "update_unit",\n    "unit_id" : 54,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 1},{ "action_type" : "update_unit",\n    "unit_id" : 55,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 56,\n    "canMove" : 0,\n    "canAttack" : 0,\n    "outOfMoves" : 1,\n    "skillCoolDown" : 1},{ "action_type" : "update_unit",\n    "unit_id" : 57,\n    "canMove" : 0,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 58,\n    "canMove" : 0,\n    "canAttack" : 0,\n    "outOfMoves" : 1,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 59,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 60,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 61,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 2},{ "action_type" : "update_unit",\n    "unit_id" : 62,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 63,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 64,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 4},{ "action_type" : "update_unit",\n    "unit_id" : 65,\n    "canMove" : 0,\n    "canAttack" : 0,\n    "outOfMoves" : 1,\n    "skillCoolDown" : 1},{"action_type" : "remove_buff",\n    "buff_id" : "6",\n    "unit_id" : 56\n  },{"action_type": "turn_change", "new_turn": 1,"effects_to_apply": [],"units_new_cd": [],"buffs_to_remove": []},{"action_type" : "trigger_buff",\n    "buff_effect" : "Burn",\n    "unit_id" : 56,\n    "health_change" : -4\n  },{"action_type" : "trigger_buff",\n    "buff_effect" : "Burn",\n    "unit_id" : 58,\n    "health_change" : -4\n  },{"action_type" : "trigger_buff",\n    "buff_effect" : "Freeze",\n    "unit_id" : 56,\n    "health_change" : 0\n  },{"action_type" : "update_gold", "gold" : 270, "team" : 0},{"action_type" : "update_gold", "gold" : 70, "team" : 1}]}'),
(70, 7, 37, 1, '{"error_code": 0,"actions": [{"action_type": "move_unit", "unit_id": 59,"path": [[9,11],[8,11],[8,12],[8,13]]},{ "action_type" : "update_unit",\n    "unit_id" : 59,\n    "canMove" : 0,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0}]}'),
(71, 7, 37, 1, '{"error_code": 0,"actions": [{"action_type": "attack_unit", "attacker_id": 64,"buffs": [],"target_id": 58,"dmg": 70,"is_critical": 1},{ "action_type" : "update_unit",\n    "unit_id" : 64,\n    "canMove" : 0,\n    "canAttack" : 0,\n    "outOfMoves" : 1,\n    "skillCoolDown" : 4}]}'),
(72, 7, 37, 1, '{"error_code": 0,"actions": [{"action_type": "attack_unit", "attacker_id": 61,"buffs": [],"target_id": 56,"dmg": 30,"is_critical": 1},{ "action_type" : "update_unit",\n    "unit_id" : 61,\n    "canMove" : 0,\n    "canAttack" : 0,\n    "outOfMoves" : 1,\n    "skillCoolDown" : 2}]}'),
(73, 7, 37, 1, '{"error_code": 0,"actions": [{"action_type": "attack_unit", "attacker_id": 61,"buffs": [],"target_id": 58,"dmg": 15,"is_critical": 0},{ "action_type" : "update_unit",\n    "unit_id" : 61,\n    "canMove" : 0,\n    "canAttack" : 0,\n    "outOfMoves" : 1,\n    "skillCoolDown" : 2}]}'),
(74, 7, 37, 1, '{"error_code": 0,"actions": [{"action_type": "move_unit", "unit_id": 63,"path": [[12,11],[12,10],[12,9],[12,8]]},{ "action_type" : "update_unit",\n    "unit_id" : 63,\n    "canMove" : 0,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0}]}'),
(75, 7, 37, 1, '{"error_code": 0,"actions": [{"action_type": "move_unit", "unit_id": 62,"path": [[10,8],[9,8],[8,8]]},{ "action_type" : "update_unit",\n    "unit_id" : 62,\n    "canMove" : 0,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0}]}'),
(76, 7, 37, 1, '{"error_code": 0,"actions": [{"action_type": "apply_buff", "buff_id": 4,"unit_id": 62},{ "action_type" : "update_unit",\n    "unit_id" : 62,\n    "canMove" : 0,\n    "canAttack" : 0,\n    "outOfMoves" : 1,\n    "skillCoolDown" : 6}], "debug": "Shield"}'),
(77, 7, 37, 1, '{"error_code": 0,"actions": [{ "action_type" : "update_unit",\n    "unit_id" : 54,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 55,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 56,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 57,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 58,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 59,\n    "canMove" : 0,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 60,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 61,\n    "canMove" : 0,\n    "canAttack" : 0,\n    "outOfMoves" : 1,\n    "skillCoolDown" : 1},{ "action_type" : "update_unit",\n    "unit_id" : 62,\n    "canMove" : 0,\n    "canAttack" : 0,\n    "outOfMoves" : 1,\n    "skillCoolDown" : 5},{ "action_type" : "update_unit",\n    "unit_id" : 63,\n    "canMove" : 0,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 64,\n    "canMove" : 0,\n    "canAttack" : 0,\n    "outOfMoves" : 1,\n    "skillCoolDown" : 3},{ "action_type" : "update_unit",\n    "unit_id" : 65,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{"action_type": "turn_change", "new_turn": 0,"effects_to_apply": [],"units_new_cd": [],"buffs_to_remove": []},{"action_type" : "trigger_buff",\n    "buff_effect" : "Burn",\n    "unit_id" : 56,\n    "health_change" : -4\n  },{"action_type" : "trigger_buff",\n    "buff_effect" : "Burn",\n    "unit_id" : 58,\n    "health_change" : -4\n  },{"action_type" : "update_gold", "gold" : 80, "team" : 1},{"action_type" : "update_gold", "gold" : 280, "team" : 0}]}'),
(78, 7, 36, 0, '{"error_code": 0,"actions": [{"action_type": "create_unit", "unit": {"67": {\n      "address":"graphics/spritesheet/special_unit/ss_totem_stand.png","spritesheet":"graphics/spritesheet/special_unit/ss_totem_heal.png","unit_id": 67,"info":"graphics/card/totem_card.png","hp": 1,"max_hp": 1,"attack": 1,"skill":"N/A","luck": 0,"commandable": 0,"x": 5,"y": 4,"buffs": [],"moveRange": 0,"team": 0,"attackRange": 0,"canMove": 1,"canAttack": 1,"skillCoolDown": 0,"outOfMoves": 0,"damageEffect":"graphics/spritesheet/special_unit/ss_totem_heal.png"\n    }}},{"action_type" : "update_gold", "gold" : 80, "team" : 0}]}'),
(79, 7, 36, 0, '{"error_code": 0,"actions": [{"action_type": "attack_unit", "attacker_id": 56,"buffs": [],"target_id": 61,"dmg": 15,"is_critical": 0},{ "action_type" : "update_unit",\n    "unit_id" : 56,\n    "canMove" : 0,\n    "canAttack" : 0,\n    "outOfMoves" : 1,\n    "skillCoolDown" : 0}]}'),
(80, 7, 36, 0, '{"error_code": 0,"actions": [{"action_type": "attack_unit", "attacker_id": 65,"buffs": [],"target_id": 61,"dmg": 35,"is_critical": 0},{ "action_type" : "update_unit",\n    "unit_id" : 65,\n    "canMove" : 0,\n    "canAttack" : 0,\n    "outOfMoves" : 1,\n    "skillCoolDown" : 0}]}'),
(81, 7, 36, 0, '{"error_code": 0,"actions": [{"action_type": "move_unit", "unit_id": 57,"path": [[7,2],[8,2],[8,3]]},{ "action_type" : "update_unit",\n    "unit_id" : 57,\n    "canMove" : 0,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0}]}'),
(82, 7, 36, 0, '{"error_code": 0,"actions": [{"action_type": "attack_unit", "attacker_id": 58,"buffs": [],"target_id": 61,"dmg": 20,"is_critical": 0},{ "action_type" : "update_unit",\n    "unit_id" : 58,\n    "canMove" : 0,\n    "canAttack" : 0,\n    "outOfMoves" : 1,\n    "skillCoolDown" : 0}]}'),
(83, 7, 36, 0, '{"error_code": 0,"actions": [{ "action_type" : "update_unit",\n    "unit_id" : 54,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 55,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 56,\n    "canMove" : 0,\n    "canAttack" : 0,\n    "outOfMoves" : 1,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 57,\n    "canMove" : 0,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 58,\n    "canMove" : 0,\n    "canAttack" : 0,\n    "outOfMoves" : 1,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 59,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 60,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 61,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 62,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 4},{ "action_type" : "update_unit",\n    "unit_id" : 63,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 64,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 2},{ "action_type" : "update_unit",\n    "unit_id" : 65,\n    "canMove" : 0,\n    "canAttack" : 0,\n    "outOfMoves" : 1,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 67,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{"action_type" : "remove_buff",\n    "buff_id" : "5",\n    "unit_id" : 56\n  },{"action_type" : "remove_buff",\n    "buff_id" : "5",\n    "unit_id" : 58\n  },{"action_type": "turn_change", "new_turn": 1,"effects_to_apply": [],"units_new_cd": [],"buffs_to_remove": []},{"action_type" : "trigger_buff",\n    "buff_effect" : "Burn",\n    "unit_id" : 56,\n    "health_change" : -4\n  },{"action_type" : "trigger_buff",\n    "buff_effect" : "Burn",\n    "unit_id" : 58,\n    "health_change" : -4\n  },{"action_type" : "trigger_buff",\n    "buff_effect" : "Heal",\n    "unit_id" : 56,\n    "health_change" : 6\n  },{"action_type" : "trigger_buff",\n    "buff_effect" : "Heal",\n    "unit_id" : 58,\n    "health_change" : 6\n  },{"action_type" : "update_gold", "gold" : 90, "team" : 0},{"action_type" : "update_gold", "gold" : 90, "team" : 1}]}'),
(84, 7, 37, 1, '{"error_code": 0,"actions": [{"action_type": "attack_unit", "attacker_id": 64,"buffs": [],"target_id": 58,"dmg": 35,"is_critical": 0},{ "action_type" : "update_unit",\n    "unit_id" : 64,\n    "canMove" : 0,\n    "canAttack" : 0,\n    "outOfMoves" : 1,\n    "skillCoolDown" : 2}]}'),
(85, 7, 37, 1, '{"error_code": 0,"actions": [{"action_type": "attack_unit", "attacker_id": 61,"buffs": [],"target_id": 58,"dmg": 15,"is_critical": 0},{ "action_type" : "update_unit",\n    "unit_id" : 61,\n    "canMove" : 0,\n    "canAttack" : 0,\n    "outOfMoves" : 1,\n    "skillCoolDown" : 0}]}'),
(86, 7, 37, 1, '{"error_code": 0,"actions": [{"action_type": "move_unit", "unit_id": 59,"path": [[8,13],[7,13],[6,13]]},{ "action_type" : "update_unit",\n    "unit_id" : 59,\n    "canMove" : 0,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0}]}'),
(87, 7, 37, 1, '{"error_code": 0,"actions": [{"action_type": "move_unit", "unit_id": 63,"path": [[12,8],[11,8],[10,8],[9,8]]},{ "action_type" : "update_unit",\n    "unit_id" : 63,\n    "canMove" : 0,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0}]}'),
(88, 7, 37, 1, '{"error_code": 0,"actions": [{"action_type": "move_unit", "unit_id": 62,"path": [[8,8],[8,7]]},{ "action_type" : "update_unit",\n    "unit_id" : 62,\n    "canMove" : 0,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 4}]}');
INSERT INTO `opp` (`opp_id`, `room_id`, `user_id`, `team`, `json`) VALUES
(89, 7, 36, 0, '{"error_code": 0,"actions": [{ "action_type" : "update_unit",\n    "unit_id" : 54,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 55,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 56,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 57,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 58,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 59,\n    "canMove" : 0,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 60,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 61,\n    "canMove" : 0,\n    "canAttack" : 0,\n    "outOfMoves" : 1,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 62,\n    "canMove" : 0,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 3},{ "action_type" : "update_unit",\n    "unit_id" : 63,\n    "canMove" : 0,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 64,\n    "canMove" : 0,\n    "canAttack" : 0,\n    "outOfMoves" : 1,\n    "skillCoolDown" : 1},{ "action_type" : "update_unit",\n    "unit_id" : 65,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 67,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{"action_type": "turn_change", "new_turn": 0,"effects_to_apply": [],"units_new_cd": [],"buffs_to_remove": []},{"action_type" : "update_gold", "gold" : 100, "team" : 0},{"action_type" : "update_gold", "gold" : 100, "team" : 1}]}'),
(90, 7, 36, 0, '{"error_code": 0,"actions": [{ "action_type" : "update_unit",\n    "unit_id" : 54,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 55,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 56,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 57,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 58,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 59,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 60,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 61,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 62,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 2},{ "action_type" : "update_unit",\n    "unit_id" : 63,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 64,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 65,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 67,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{"action_type": "turn_change", "new_turn": 1,"effects_to_apply": [],"units_new_cd": [],"buffs_to_remove": []},{"action_type" : "trigger_buff",\n    "buff_effect" : "Heal",\n    "unit_id" : 56,\n    "health_change" : 6\n  },{"action_type" : "trigger_buff",\n    "buff_effect" : "Heal",\n    "unit_id" : 58,\n    "health_change" : 6\n  },{"action_type" : "update_gold", "gold" : 110, "team" : 0},{"action_type" : "update_gold", "gold" : 110, "team" : 1}]}'),
(91, 7, 37, 1, '{"error_code": 0,"actions": [{"action_type": "attack_unit", "attacker_id": 61,"buffs": [],"target_id": 58,"dmg": 15,"is_critical": 0},{ "action_type" : "update_unit",\n    "unit_id" : 61,\n    "canMove" : 0,\n    "canAttack" : 0,\n    "outOfMoves" : 1,\n    "skillCoolDown" : 0}]}'),
(92, 7, 37, 1, '{"error_code": 0,"actions": [{"action_type": "attack_unit", "attacker_id": 64,"buffs": [],"target_id": 58,"dmg": 35,"is_critical": 0},{ "action_type" : "update_unit",\n    "unit_id" : 64,\n    "canMove" : 0,\n    "canAttack" : 0,\n    "outOfMoves" : 1,\n    "skillCoolDown" : 0}]}'),
(93, 7, 37, 1, '{"error_code": 0,"actions": [{"action_type": "move_unit", "unit_id": 63,"path": [[9,8],[8,8],[7,8],[6,8]]},{ "action_type" : "update_unit",\n    "unit_id" : 63,\n    "canMove" : 0,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0}]}'),
(94, 7, 37, 1, '{"error_code": 0,"actions": [{"action_type": "attack_unit", "attacker_id": 63,"buffs": [],"target_id": 56,"dmg": 20,"is_critical": 0},{ "action_type" : "update_unit",\n    "unit_id" : 63,\n    "canMove" : 0,\n    "canAttack" : 0,\n    "outOfMoves" : 1,\n    "skillCoolDown" : 0}]}'),
(95, 7, 37, 1, '{"error_code": 0,"actions": [{"action_type": "move_unit", "unit_id": 59,"path": [[6,13],[5,13],[4,13],[3,13]]},{ "action_type" : "update_unit",\n    "unit_id" : 59,\n    "canMove" : 0,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0}]}'),
(96, 7, 37, 1, '{"error_code": 0,"actions": [{"action_type": "move_unit", "unit_id": 62,"path": [[8,7],[8,8],[7,8]]},{ "action_type" : "update_unit",\n    "unit_id" : 62,\n    "canMove" : 0,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 2}]}'),
(97, 7, 37, 1, '{"error_code": 0,"actions": [{"action_type": "apply_buff", "buff_id": 2,"unit_id": 59},{"action_type" : "trigger_buff",\n    "buff_effect" : "IncAttack",\n    "unit_id" : 59,\n    "health_change" : 0\n  },{"action_type": "apply_buff", "buff_id": 2,"unit_id": 61},{"action_type" : "trigger_buff",\n    "buff_effect" : "IncAttack",\n    "unit_id" : 61,\n    "health_change" : 0\n  },{"action_type": "apply_buff", "buff_id": 2,"unit_id": 62},{"action_type" : "trigger_buff",\n    "buff_effect" : "IncAttack",\n    "unit_id" : 62,\n    "health_change" : 0\n  },{"action_type": "apply_buff", "buff_id": 2,"unit_id": 63},{"action_type" : "trigger_buff",\n    "buff_effect" : "IncAttack",\n    "unit_id" : 63,\n    "health_change" : 0\n  },{"action_type": "apply_buff", "buff_id": 2,"unit_id": 64},{"action_type" : "trigger_buff",\n    "buff_effect" : "IncAttack",\n    "unit_id" : 64,\n    "health_change" : 0\n  },{ "action_type" : "update_unit",\n    "unit_id" : 59,\n    "canMove" : 0,\n    "canAttack" : 0,\n    "outOfMoves" : 1,\n    "skillCoolDown" : 6}], "debug": "Battle Cry"}'),
(98, 7, 37, 1, '{"error_code": 0,"actions": [{ "action_type" : "update_unit",\n    "unit_id" : 54,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 55,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 56,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 57,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 59,\n    "canMove" : 0,\n    "canAttack" : 0,\n    "outOfMoves" : 1,\n    "skillCoolDown" : 5},{ "action_type" : "update_unit",\n    "unit_id" : 60,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 61,\n    "canMove" : 0,\n    "canAttack" : 0,\n    "outOfMoves" : 1,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 62,\n    "canMove" : 0,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 1},{ "action_type" : "update_unit",\n    "unit_id" : 63,\n    "canMove" : 0,\n    "canAttack" : 0,\n    "outOfMoves" : 1,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 64,\n    "canMove" : 0,\n    "canAttack" : 0,\n    "outOfMoves" : 1,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 65,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 67,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{"action_type": "turn_change", "new_turn": 0,"effects_to_apply": [],"units_new_cd": [],"buffs_to_remove": []},{"action_type" : "update_gold", "gold" : 120, "team" : 1},{"action_type" : "update_gold", "gold" : 120, "team" : 0}]}'),
(99, 7, 36, 0, '{"error_code": 0,"actions": [{ "action_type" : "update_unit",\n    "unit_id" : 54,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 55,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 56,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 57,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 59,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 4},{ "action_type" : "update_unit",\n    "unit_id" : 60,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 61,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 62,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 63,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 64,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 65,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 67,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{"action_type": "turn_change", "new_turn": 1,"effects_to_apply": [],"units_new_cd": [],"buffs_to_remove": []},{"action_type" : "trigger_buff",\n    "buff_effect" : "Heal",\n    "unit_id" : 56,\n    "health_change" : 6\n  },{"action_type" : "update_gold", "gold" : 130, "team" : 0},{"action_type" : "update_gold", "gold" : 130, "team" : 1}]}'),
(100, 7, 37, 1, '{"error_code": 0,"actions": [{"action_type": "attack_unit", "attacker_id": 61,"buffs": [],"target_id": 56,"dmg": 36,"is_critical": 1},{ "action_type" : "update_unit",\n    "unit_id" : 61,\n    "canMove" : 0,\n    "canAttack" : 0,\n    "outOfMoves" : 1,\n    "skillCoolDown" : 0}]}'),
(101, 7, 37, 1, '{"error_code": 0,"actions": [{"action_type": "move_unit", "unit_id": 63,"path": [[6,8],[5,8],[4,8],[4,7]]},{ "action_type" : "update_unit",\n    "unit_id" : 63,\n    "canMove" : 0,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0}]}'),
(102, 7, 37, 1, '{"error_code": 0,"actions": [{"action_type": "attack_unit", "attacker_id": 64,"buffs": [],"target_id": 57,"dmg": 42,"is_critical": 0},{ "action_type" : "update_unit",\n    "unit_id" : 64,\n    "canMove" : 0,\n    "canAttack" : 0,\n    "outOfMoves" : 1,\n    "skillCoolDown" : 0}]}'),
(103, 7, 37, 1, '{"error_code": 0,"actions": [{"action_type": "move_unit", "unit_id": 62,"path": [[7,8],[6,8],[5,8]]},{ "action_type" : "update_unit",\n    "unit_id" : 62,\n    "canMove" : 0,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0}]}'),
(104, 7, 37, 1, '{"error_code": 0,"actions": [{"action_type": "attack_unit", "attacker_id": 63,"buffs": [],"target_id": 67,"dmg": 48,"is_critical": 1},{ "action_type" : "update_unit",\n    "unit_id" : 63,\n    "canMove" : 0,\n    "canAttack" : 0,\n    "outOfMoves" : 1,\n    "skillCoolDown" : 0}]}'),
(105, 7, 36, 0, '{"error_code": 0,"actions": [{ "action_type" : "update_unit",\n    "unit_id" : 54,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 55,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 56,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 57,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 59,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 3},{ "action_type" : "update_unit",\n    "unit_id" : 60,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 61,\n    "canMove" : 0,\n    "canAttack" : 0,\n    "outOfMoves" : 1,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 62,\n    "canMove" : 0,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 63,\n    "canMove" : 0,\n    "canAttack" : 0,\n    "outOfMoves" : 1,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 64,\n    "canMove" : 0,\n    "canAttack" : 0,\n    "outOfMoves" : 1,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 65,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{"action_type": "turn_change", "new_turn": 0,"effects_to_apply": [],"units_new_cd": [],"buffs_to_remove": []},{"action_type" : "update_gold", "gold" : 140, "team" : 0},{"action_type" : "update_gold", "gold" : 140, "team" : 1}]}'),
(106, 7, 36, 0, '{"error_code": 0,"actions": [{ "action_type" : "update_unit",\n    "unit_id" : 54,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 55,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 56,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 57,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 59,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 2},{ "action_type" : "update_unit",\n    "unit_id" : 60,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 61,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 62,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 63,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 64,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 65,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{"action_type" : "remove_buff",\n    "buff_id" : "2",\n    "unit_id" : 59\n  },{"action_type" : "remove_buff",\n    "buff_id" : "2",\n    "unit_id" : 61\n  },{"action_type" : "remove_buff",\n    "buff_id" : "2",\n    "unit_id" : 62\n  },{"action_type" : "remove_buff",\n    "buff_id" : "2",\n    "unit_id" : 63\n  },{"action_type" : "remove_buff",\n    "buff_id" : "2",\n    "unit_id" : 64\n  },{"action_type": "turn_change", "new_turn": 1,"effects_to_apply": [],"units_new_cd": [],"buffs_to_remove": []},{"action_type" : "update_gold", "gold" : 150, "team" : 0},{"action_type" : "update_gold", "gold" : 150, "team" : 1}]}'),
(107, 7, 36, 0, '{"error_code": 0,"actions": [{ "action_type" : "update_unit",\n    "unit_id" : 54,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 55,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 56,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 57,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 59,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 1},{ "action_type" : "update_unit",\n    "unit_id" : 60,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 61,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 62,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 63,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 64,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{ "action_type" : "update_unit",\n    "unit_id" : 65,\n    "canMove" : 1,\n    "canAttack" : 1,\n    "outOfMoves" : 0,\n    "skillCoolDown" : 0},{"action_type": "turn_change", "new_turn": 0,"effects_to_apply": [],"units_new_cd": [],"buffs_to_remove": []},{"action_type" : "update_gold", "gold" : 160, "team" : 0},{"action_type" : "update_gold", "gold" : 160, "team" : 1}]}');

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
  `elo_lost` int(11) NOT NULL,
  `countdown` int(11) NOT NULL,
  `default_countdown` int(11) NOT NULL DEFAULT '90',
  `map_id` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `rooms`
--

INSERT INTO `rooms` (`room_id`, `user_id`, `joiner`, `created`, `name`, `password`, `max_players`, `state`, `turn`, `winner`, `elo_won`, `elo_lost`, `countdown`, `default_countdown`, `map_id`) VALUES
(1, 31, 0, '2016-06-10 13:00:12', 'sdfgsdfg', '', 2, 'ended', 0, 32, 16, 16, 1465563720, 90, 1),
(2, 14, 0, '2016-06-10 13:25:18', 'sdfgsdfg', '', 2, 'ended', 1, 34, 32, 32, 1465565323, 90, 1),
(3, 34, 0, '2016-06-10 13:40:16', 'ASDFG', '', 2, 'ended', 1, 34, 15, 15, 1465566200, 90, 1),
(5, 14, 0, '2016-06-10 13:47:41', 'hello guys', '', 2, 'ended', 0, 34, 32, 32, 1465566825, 90, 1),
(6, 14, 0, '2016-06-10 13:52:45', 'asda', '', 2, 'ended', 0, 14, 0, 0, 1465567038, 90, 1),
(7, 36, 0, '2016-06-11 00:42:18', 'NORTH KOREA', '', 2, 'ingame', 0, 0, 0, 0, 1465607258, 90, 1),
(9, 14, 0, '2016-06-12 12:51:50', 'qweqwe', '', 2, 'pregame', 0, 0, 0, 0, 0, 90, 1);

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
(1, 31, 1, 'red', 'owner', 'ended', 500, 0, 0),
(2, 32, 1, 'blue', 'ready', 'ended', 500, 0, 0),
(3, 14, 2, 'red', 'owner', 'ended', 210, 0, 2),
(4, 34, 2, 'blue', 'ready', 'ended', 510, 0, 0),
(5, 34, 3, 'red', 'ready', 'ended', 510, 0, 0),
(6, 35, 3, 'blue', 'ready', 'ended', 210, 0, 1),
(8, 14, 5, 'red', 'owner', 'ended', 500, 0, 0),
(9, 34, 5, 'blue', 'ready', 'ended', 500, 0, 0),
(10, 14, 6, 'red', 'owner', 'ended', 500, 0, 0),
(11, 34, 6, 'blue', 'ready', 'ended', 500, 0, 0),
(12, 36, 7, 'red', 'owner', '', 160, 1, 2),
(13, 37, 7, 'blue', 'ready', '', 160, 2, 2),
(15, 14, 9, 'red', 'owner', '', 500, 0, 0),
(16, 9, 9, 'blue', 'notready', '', 500, 0, 0);

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
  `room_id` int(11) NOT NULL,
  `prev_x` int(11) NOT NULL DEFAULT '-1',
  `prev_y` int(11) NOT NULL DEFAULT '-1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `units`
--

INSERT INTO `units` (`unit_id`, `class_id`, `hp`, `max_hp`, `attack`, `skillCoolDown`, `x`, `y`, `team`, `canMove`, `canAttack`, `outOfMoves`, `room_id`, `prev_x`, `prev_y`) VALUES
(1, 4, 100, 100, 25, 0, 3, 2, 0, 1, 1, 0, 1, -1, -1),
(2, 5, 999, 999, 999, 0, 0, 0, 0, 1, 1, 0, 1, -1, -1),
(3, 1, 200, 200, 15, 0, 3, 3, 0, 1, 1, 0, 1, -1, -1),
(4, 3, 300, 300, 40, 0, 0, 2, 0, 1, 1, 0, 1, -1, -1),
(5, 2, 200, 200, 20, 0, 0, 3, 0, 1, 1, 0, 1, -1, -1),
(6, 4, 100, 100, 25, 0, 9, 11, 1, 1, 1, 0, 1, -1, -1),
(7, 6, 999, 999, 999, 0, 12, 13, 1, 1, 1, 0, 1, -1, -1),
(8, 1, 200, 200, 15, 0, 9, 10, 1, 1, 1, 0, 1, -1, -1),
(9, 3, 300, 300, 40, 0, 12, 10, 1, 1, 1, 0, 1, -1, -1),
(10, 2, 200, 200, 20, 0, 12, 11, 1, 1, 1, 0, 1, -1, -1),
(11, 4, 100, 100, 25, 0, 3, 2, 0, 1, 1, 0, 2, -1, -1),
(12, 5, 999, 999, 999, 0, 0, 0, 0, 1, 1, 0, 2, -1, -1),
(13, 1, 200, 200, 15, 0, 3, 5, 0, 0, 1, 0, 2, 3, 3),
(14, 3, 300, 300, 40, 0, 0, 2, 0, 1, 1, 0, 2, -1, -1),
(15, 2, 200, 200, 20, 0, 0, 3, 0, 1, 1, 0, 2, -1, -1),
(16, 4, 100, 100, 25, 0, 9, 11, 1, 1, 1, 0, 2, -1, -1),
(17, 6, 999, 999, 999, 0, 12, 13, 1, 1, 1, 0, 2, -1, -1),
(18, 1, 200, 200, 15, 0, 9, 10, 1, 1, 1, 0, 2, -1, -1),
(19, 3, 300, 300, 40, 0, 12, 10, 1, 1, 1, 0, 2, -1, -1),
(20, 2, 200, 200, 20, 0, 12, 11, 1, 1, 1, 0, 2, -1, -1),
(21, 8, 1, 1, 1, 0, 2, 3, 0, 1, 1, 0, 2, -1, -1),
(22, 1, 200, 200, 15, 0, 1, 4, 0, 0, 1, 0, 2, 2, 2),
(23, 4, 100, 100, 25, 0, 3, 2, 0, 1, 1, 0, 3, -1, -1),
(24, 5, 999, 999, 999, 0, 0, 0, 0, 1, 1, 0, 3, -1, -1),
(25, 1, 200, 200, 15, 0, 3, 3, 0, 1, 1, 0, 3, -1, -1),
(26, 3, 300, 300, 40, 0, 0, 2, 0, 1, 1, 0, 3, -1, -1),
(27, 2, 200, 200, 20, 0, 1, 5, 0, 0, 1, 0, 3, 0, 3),
(28, 4, 100, 100, 25, 0, 9, 11, 1, 1, 1, 0, 3, -1, -1),
(29, 6, 999, 999, 999, 0, 12, 13, 1, 1, 1, 0, 3, -1, -1),
(30, 1, 200, 200, 15, 0, 6, 10, 1, 0, 1, 0, 3, 9, 10),
(31, 3, 300, 300, 40, 0, 12, 10, 1, 1, 1, 0, 3, -1, -1),
(32, 2, 200, 200, 20, 0, 12, 11, 1, 1, 1, 0, 3, -1, -1),
(33, 7, 300, 300, 35, 0, 10, 13, 1, 1, 1, 0, 3, -1, -1),
(34, 4, 100, 100, 25, 0, 3, 2, 0, 1, 1, 0, 5, -1, -1),
(35, 5, 999, 999, 999, 0, 0, 0, 0, 1, 1, 0, 5, -1, -1),
(36, 1, 200, 200, 15, 0, 3, 3, 0, 1, 1, 0, 5, -1, -1),
(37, 3, 300, 300, 40, 0, 0, 2, 0, 1, 1, 0, 5, -1, -1),
(38, 2, 200, 200, 20, 0, 0, 3, 0, 1, 1, 0, 5, -1, -1),
(39, 4, 100, 100, 25, 0, 9, 11, 1, 1, 1, 0, 5, -1, -1),
(40, 6, 999, 999, 999, 0, 12, 13, 1, 1, 1, 0, 5, -1, -1),
(41, 1, 200, 200, 15, 0, 9, 10, 1, 1, 1, 0, 5, -1, -1),
(42, 3, 300, 300, 40, 0, 12, 10, 1, 1, 1, 0, 5, -1, -1),
(43, 2, 200, 200, 20, 0, 12, 11, 1, 1, 1, 0, 5, -1, -1),
(44, 4, 100, 100, 25, 0, 3, 2, 0, 1, 1, 0, 6, -1, -1),
(45, 5, 999, 999, 999, 0, 0, 0, 0, 1, 1, 0, 6, -1, -1),
(46, 1, 200, 200, 15, 0, 3, 5, 0, 0, 1, 0, 6, 3, 3),
(47, 3, 300, 300, 40, 0, 0, 2, 0, 1, 1, 0, 6, -1, -1),
(48, 2, 200, 200, 20, 0, 2, 4, 0, 0, 1, 0, 6, 0, 3),
(49, 4, 100, 100, 25, 0, 9, 11, 1, 1, 1, 0, 6, -1, -1),
(50, 6, 999, 999, 999, 0, 12, 13, 1, 1, 1, 0, 6, -1, -1),
(51, 1, 200, 200, 15, 0, 9, 10, 1, 1, 1, 0, 6, -1, -1),
(52, 3, 300, 300, 40, 0, 12, 10, 1, 1, 1, 0, 6, -1, -1),
(53, 2, 200, 200, 20, 0, 12, 11, 1, 1, 1, 0, 6, -1, -1),
(54, 4, 100, 100, 25, 0, 3, 2, 0, 1, 1, 0, 7, -1, -1),
(55, 5, 999, 999, 999, 0, 0, 0, 0, 1, 1, 0, 7, -1, -1),
(56, 1, 40, 200, 15, 0, 6, 4, 0, 1, 1, 0, 7, -1, -1),
(57, 3, 258, 300, 40, 0, 8, 3, 0, 1, 1, 0, 7, -1, -1),
(59, 4, 100, 100, 25, 1, 3, 13, 1, 1, 1, 0, 7, -1, -1),
(60, 6, 999, 999, 999, 0, 12, 13, 1, 1, 1, 0, 7, -1, -1),
(61, 1, 33, 200, 15, 0, 8, 5, 1, 1, 1, 0, 7, -1, -1),
(62, 3, 300, 300, 40, 0, 5, 8, 1, 1, 1, 0, 7, -1, -1),
(63, 2, 200, 200, 20, 0, 4, 7, 1, 1, 1, 0, 7, -1, -1),
(64, 7, 300, 300, 35, 0, 8, 6, 1, 1, 1, 0, 7, -1, -1),
(65, 7, 300, 300, 35, 0, 7, 3, 0, 1, 1, 0, 7, -1, -1);

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
  `wig` int(11) NOT NULL,
  `eyes` int(11) NOT NULL,
  `mouth` int(11) NOT NULL,
  `body` int(11) NOT NULL,
  `kp` int(11) NOT NULL DEFAULT '1000',
  `skin_colour` int(11) NOT NULL,
  `tutorial` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `password`, `email`, `username`, `wins`, `losses`, `elo`, `created`, `member_type`, `lastactive`, `hat`, `wig`, `eyes`, `mouth`, `body`, `kp`, `skin_colour`, `tutorial`) VALUES
(6, '$2y$10$zmsIcYDqp8ScNRuDcj9jD.kbsW9vC7k655flzcYK66kC0jkWa0toK', 'alanduu50@gmail.com', 'xXN1NJ4Xx', 343, 148, 1742, '2016-05-23 21:22:33', 'normal', 1465372058, 1, 0, 0, 0, 5, 1000, 0, 0),
(7, '$2y$10$xGKFvkCEjUMSm1y6cr8v/.IsJCZfLhNtigg0eyETXQYbslu5X1IBK', 'kld14@ic.ac.uk', 'DragonSlayer52', 358, 145, 2100, '2016-05-23 21:22:01', 'normal', 1465372058, 1, 0, 0, 0, 0, 1000, 0, 0),
(8, '$2y$10$s7PfGa0iZcg2XDFrmEAnhegSMZzKi4Po4GyUEl1E9cA69tUJj5qSa', 'test@test.com', 'HaskellPrize', 147, 23, 2311, '2016-05-23 21:20:45', 'normal', 1465372058, 1, 0, 0, 0, 0, 1000, 0, 0),
(9, '$2y$10$y8geeo6e4vVMUkhJWycFruGOuplLwujzm8q4RZlZQPpkn6RKbkfpS', 'demo@demo.com', 'Wumpus', 201, 92, 889, '2016-05-23 21:20:18', 'normal', 1465737315, 0, 0, 3, 0, 5, 16650, 3, 1),
(10, '$2y$10$h9fvGHQrrOHh35pNzhIsqOR.0jDi4ZmVtHiCvP1wCexLef072jYqy', 'tonyfield@rules.com', 'OhBaby', 214, 26, 1400, '2016-05-23 18:59:26', 'normal', 1465372058, 1, 0, 0, 0, 0, 1000, 0, 0),
(11, '$2y$10$jOeNVa.g.MTq8j7NoOY3k.RTVeYpcrxA7gq8zv8hp9yiVBsk0z3C.', 'debug@debug.com', 'debug', 212, 52, 1600, '2016-06-01 20:52:54', 'normal', 1465372058, 1, 0, 0, 0, 0, 1000, 0, 0),
(12, '$2y$10$7.dtDYkyCuARy8JOOvnEM..015QDAO7YDKsNEmue6deyEyJvIDwr2', 'goku@goku.com', 'goku', 211, 62, 970, '2016-06-01 20:53:04', 'normal', 1465372058, 1, 0, 0, 0, 0, 1000, 0, 0),
(13, '$2y$10$EVxl9C85A3EGzS9/mbr4mO1eZwdAa7RoFtuXRU.4lwdohCezvuQTu', 'veg@veg.com', 'veg', 311, 73, 800, '2016-06-01 20:53:57', 'normal', 1465372058, 1, 0, 0, 0, 0, 1000, 0, 0),
(14, '$2y$10$IQSSyY./kNwyvuT7l5gxVOFeTTDB50Bfyt5yw9GqQgf.f.shFazX.', 'hiya@hiya.com', 'Leap Of Faith', 346, 283, 2587, '2016-06-04 21:40:28', 'normal', 1465737315, 7, 0, 3, 10, 11, 2137467197, 0, 1),
(15, '$2y$10$Q3aMDDCP8w2o8bV.SaRs4.4Mgr49ZHzl372S4qExpvmadU0mAHETi', 'asda@asda.com', 'asdasd', 0, 0, 870, '2016-06-04 21:40:51', 'normal', 1465372058, 1, 0, 0, 0, 0, 1000, 0, 0),
(16, '$2y$10$aZkr5proBXT1kbSu9WWoHOM/q4lHiyqVXj6/9FYTa9Tn6YaO31LPW', 'simon@simon.com', 'simon', 0, 0, 1200, '2016-06-06 09:29:26', 'normal', 1465372058, 1, 0, 0, 0, 0, 1000, 0, 0),
(17, '', '', 'guesto', 0, 0, 1000, '2016-06-07 13:22:51', 'guest', 1465372058, 1, 0, 0, 0, 0, 1000, 0, 0),
(23, '', '2234072218', 'queen', 0, 0, 1000, '2016-06-09 14:13:59', 'guest', 1465481643, 1, 0, 0, 0, 0, 1000, 0, 0),
(24, '', '2566310987', 'how hot is labs', 0, 0, 1000, '2016-06-09 14:16:05', 'guest', 1465482029, 1, 0, 0, 0, 0, 1000, 0, 0),
(25, '', '1497627383.com', 'queens conquest', 0, 0, 1000, '2016-06-09 14:20:37', 'guest', 1465482058, 1, 0, 0, 0, 0, 1000, 0, 0),
(26, '', '568440910@549463178.com', 'batka', 0, 0, 1000, '2016-06-09 14:21:04', 'guest', 1465482066, 1, 0, 0, 0, 0, 1000, 0, 0),
(27, '', '223181721@637244910.com', 'obama', 1, 2, 1000, '2016-06-09 19:52:50', 'guest', 1465511503, 0, 0, 0, 0, 0, 3600, 0, 0),
(28, '', '1366697652@370747727.com', 'donald trump', 5, 0, 1128, '2016-06-09 22:36:35', 'guest', 1465552143, 1, 0, 0, 0, 0, 6000, 0, 0),
(29, '', '17071479@1723581365.com', 'sdfg', 0, 0, 1000, '2016-06-10 10:07:39', 'guest', 1465559872, 1, 0, 0, 0, 0, 1000, 0, 2),
(30, '', '652332010@1392295839.com', 'epicness', 0, 0, 1000, '2016-06-10 11:59:06', 'guest', 1465559959, 1, 0, 0, 0, 0, 1000, 0, 2),
(31, '', '331022125@1687029227.com', 'yo momma', 0, 1, 984, '2016-06-10 13:00:02', 'guest', 1465563648, 1, 0, 0, 0, 0, 1300, 0, 1),
(32, '', '1714006954@42221233.com', 'hello', 1, 0, 1016, '2016-06-10 13:00:25', 'guest', 1465566936, 0, 0, 0, 0, 0, 2000, 2, 1),
(33, '', '692422947@1750790591.com', 'hello world aa', 0, 0, 1000, '2016-06-10 13:23:49', 'guest', 1465565102, 0, 0, 0, 0, 0, 1000, 0, 2),
(34, '', '1513316484@730211608.com', 'sdfgsdfg', 4, 1, 1094, '2016-06-10 13:25:29', 'guest', 1465572298, 7, 0, 0, 0, 5, 4200, 5, 3),
(35, '', '1766226800@1643555489.com', 'ads', 0, 2, 970, '2016-06-10 13:39:17', 'guest', 1465566151, 1, 0, 0, 0, 0, 1600, 0, 2),
(36, '', '1070065537@534017989.com', 'ZICH', 0, 0, 1000, '2016-06-11 00:41:58', 'guest', 1465607167, 1, 0, 0, 0, 0, 1000, 0, 1),
(37, '', '16069963@1296269743.com', 'CHUBAKA', 0, 0, 1000, '2016-06-11 00:42:03', 'guest', 1465607169, 1, 0, 0, 0, 0, 1000, 0, 1);

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
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email_2` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `buffs`
--
ALTER TABLE `buffs`
  MODIFY `buff_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `buff_instances`
--
ALTER TABLE `buff_instances`
  MODIFY `bi_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;
--
-- AUTO_INCREMENT for table `chat`
--
ALTER TABLE `chat`
  MODIFY `chat_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;
--
-- AUTO_INCREMENT for table `classes`
--
ALTER TABLE `classes`
  MODIFY `class_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT for table `feedback`
--
ALTER TABLE `feedback`
  MODIFY `fb_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `friends`
--
ALTER TABLE `friends`
  MODIFY `friend_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;
--
-- AUTO_INCREMENT for table `inventory`
--
ALTER TABLE `inventory`
  MODIFY `inv_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;
--
-- AUTO_INCREMENT for table `items`
--
ALTER TABLE `items`
  MODIFY `item_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;
--
-- AUTO_INCREMENT for table `maps`
--
ALTER TABLE `maps`
  MODIFY `map_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `opp`
--
ALTER TABLE `opp`
  MODIFY `opp_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=108;
--
-- AUTO_INCREMENT for table `rooms`
--
ALTER TABLE `rooms`
  MODIFY `room_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT for table `room_participants`
--
ALTER TABLE `room_participants`
  MODIFY `part_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;
--
-- AUTO_INCREMENT for table `units`
--
ALTER TABLE `units`
  MODIFY `unit_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=68;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
