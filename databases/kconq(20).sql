-- phpMyAdmin SQL Dump
-- version 4.5.2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jun 10, 2016 at 12:41 PM
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
('perfect_win', 28, 10, 0, 0);

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
  `commandable` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `classes`
--

INSERT INTO `classes` (`class_id`, `name`, `address`, `spritesheet`, `info`, `max_hp`, `attack`, `skill`, `skillMaxCD`, `moveRange`, `attackRange`, `damageEffect`, `gold`, `luck`, `commandable`) VALUES
(1, 'wizard', 'graphics/spritesheet/stand/ss_wizard_stand.png', 'graphics/spritesheet/attack/ss_wizard_attack.png', 'graphics/card/wizard_card.png', 200, 15, 'Magic Damage', 6, 3, 3, 'graphics/spritesheet/spell/ss_fireball.png', 100, 0.25, 1),
(2, 'archer', 'graphics/spritesheet/stand/ss_archer_stand.png', 'graphics/spritesheet/attack/ss_archer_attack.png', 'graphics/card/archer_card.png', 200, 20, 'Double Shoot', 6, 3, 4, 'graphics/spritesheet/spell/ss_arrow.png', 100, 0.4, 1),
(3, 'knight', 'graphics/spritesheet/stand/ss_knight_stand.png', 'graphics/spritesheet/attack/ss_knight_attack.png', 'graphics/card/knight_card.png', 300, 40, 'Shield', 6, 2, 1, 'graphics/spritesheet/spell/ss_physical_attack.png', 100, 0.15, 1),
(4, 'king', 'graphics/spritesheet/stand/ss_king_stand.png', 'graphics/spritesheet/attack/ss_king_attack.png', 'graphics/card/king_card.png', 30, 25, 'Battle Cry', 6, 3, 2, 'graphics/spritesheet/spell/ss_physical_attack.png', 0, 0.2, 1),
(5, 'red castle', 'graphics/spritesheet/special_unit/ss_castle_red.png', 'graphics/spritesheet/attack/ss_archer_attack.png', 'graphics/card/castle_card.png', 999, 999, 'RED', 6, 0, 10, 'graphics/spritesheet/spell/ss_physical_attack.png', 100, 0, 0),
(6, 'blue castle', 'graphics/spritesheet/special_unit/ss_castle_blue.png', 'graphics/spritesheet/attack/ss_archer_attack.png', 'graphics/card/castle_card.png', 999, 999, 'BLUE', 6, 0, 10, 'graphics/spritesheet/spell/ss_physical_attack.png', 100, 0, 0),
(7, 'dragon', 'graphics/spritesheet/stand/ss_dragon_stand.png', 'graphics/spritesheet/attack/ss_dragon_attack.png', 'graphics/card/dragon_card.png', 300, 35, 'Icy Wind', 6, 4, 3, 'graphics/spritesheet/spell/ss_icy_wind.png', 300, 0.25, 1),
(8, 'totem', 'graphics/spritesheet/special_unit/ss_totem_stand.png', 'graphics/spritesheet/special_unit/ss_totem_heal.png', 'graphics/card/totem_card.png', 1, 1, 'N/A', 6, 0, 0, 'graphics/spritesheet/special_unit/ss_totem_heal.png', 200, 0, 0);

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
(24, 14, 11, 0),
(25, 28, 9, 0),
(26, 28, 14, 1);

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
(5, 9, 3, 5),
(11, 14, 5, 1),
(12, 14, 6, 1),
(15, 14, 8, 2),
(18, 14, 7, 1),
(20, 14, 12, 1),
(21, 14, 3, 1),
(23, 14, 9, 1),
(25, 27, 1, 1);

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
  `countdown` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
  `skin_colour` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `password`, `email`, `username`, `wins`, `losses`, `elo`, `created`, `member_type`, `lastactive`, `hat`, `wig`, `eyes`, `mouth`, `body`, `kp`, `skin_colour`) VALUES
(6, '$2y$10$zmsIcYDqp8ScNRuDcj9jD.kbsW9vC7k655flzcYK66kC0jkWa0toK', 'alanduu50@gmail.com', 'xXN1NJ4Xx', 343, 148, 1742, '2016-05-23 21:22:33', 'normal', 1465372058, 1, 0, 0, 0, 5, 1000, 0),
(7, '$2y$10$xGKFvkCEjUMSm1y6cr8v/.IsJCZfLhNtigg0eyETXQYbslu5X1IBK', 'kld14@ic.ac.uk', 'DragonSlayer52', 358, 145, 2100, '2016-05-23 21:22:01', 'normal', 1465372058, 1, 0, 0, 0, 0, 1000, 0),
(8, '$2y$10$s7PfGa0iZcg2XDFrmEAnhegSMZzKi4Po4GyUEl1E9cA69tUJj5qSa', 'test@test.com', 'HaskellPrize', 147, 23, 2311, '2016-05-23 21:20:45', 'normal', 1465372058, 1, 0, 0, 0, 0, 1000, 0),
(9, '$2y$10$y8geeo6e4vVMUkhJWycFruGOuplLwujzm8q4RZlZQPpkn6RKbkfpS', 'demo@demo.com', 'Wumpus', 201, 92, 889, '2016-05-23 21:20:18', 'normal', 1465555256, 1, 0, 0, 0, 5, 16650, 5),
(10, '$2y$10$h9fvGHQrrOHh35pNzhIsqOR.0jDi4ZmVtHiCvP1wCexLef072jYqy', 'tonyfield@rules.com', 'OhBaby', 214, 26, 1400, '2016-05-23 18:59:26', 'normal', 1465372058, 1, 0, 0, 0, 0, 1000, 0),
(11, '$2y$10$jOeNVa.g.MTq8j7NoOY3k.RTVeYpcrxA7gq8zv8hp9yiVBsk0z3C.', 'debug@debug.com', 'debug', 212, 52, 1600, '2016-06-01 20:52:54', 'normal', 1465372058, 1, 0, 0, 0, 0, 1000, 0),
(12, '$2y$10$7.dtDYkyCuARy8JOOvnEM..015QDAO7YDKsNEmue6deyEyJvIDwr2', 'goku@goku.com', 'goku', 211, 62, 970, '2016-06-01 20:53:04', 'normal', 1465372058, 1, 0, 0, 0, 0, 1000, 0),
(13, '$2y$10$EVxl9C85A3EGzS9/mbr4mO1eZwdAa7RoFtuXRU.4lwdohCezvuQTu', 'veg@veg.com', 'veg', 311, 73, 800, '2016-06-01 20:53:57', 'normal', 1465372058, 1, 0, 0, 0, 0, 1000, 0),
(14, '$2y$10$sxwp7k4OSuCdCiO7y.JsOucq/YbXFR4oF8aBcgeTJ.UixSPKh.xJm', 'hp@hp.com', 'Leap Of Faith', 345, 281, 2651, '2016-06-04 21:40:28', 'normal', 1465517050, 13, 0, 12, 10, 11, 2137483097, 0),
(15, '$2y$10$Q3aMDDCP8w2o8bV.SaRs4.4Mgr49ZHzl372S4qExpvmadU0mAHETi', 'asda@asda.com', 'asdasd', 0, 0, 870, '2016-06-04 21:40:51', 'normal', 1465372058, 1, 0, 0, 0, 0, 1000, 0),
(16, '$2y$10$aZkr5proBXT1kbSu9WWoHOM/q4lHiyqVXj6/9FYTa9Tn6YaO31LPW', 'simon@simon.com', 'simon', 0, 0, 1200, '2016-06-06 09:29:26', 'normal', 1465372058, 1, 0, 0, 0, 0, 1000, 0),
(17, '', '', 'guesto', 0, 0, 1000, '2016-06-07 13:22:51', 'guest', 1465372058, 1, 0, 0, 0, 0, 1000, 0),
(23, '', '2234072218', 'queen', 0, 0, 1000, '2016-06-09 14:13:59', 'guest', 1465481643, 1, 0, 0, 0, 0, 1000, 0),
(24, '', '2566310987', 'how hot is labs', 0, 0, 1000, '2016-06-09 14:16:05', 'guest', 1465482029, 1, 0, 0, 0, 0, 1000, 0),
(25, '', '1497627383.com', 'queens conquest', 0, 0, 1000, '2016-06-09 14:20:37', 'guest', 1465482058, 1, 0, 0, 0, 0, 1000, 0),
(26, '', '568440910@549463178.com', 'batka', 0, 0, 1000, '2016-06-09 14:21:04', 'guest', 1465482066, 1, 0, 0, 0, 0, 1000, 0),
(27, '', '223181721@637244910.com', 'obama', 1, 2, 1000, '2016-06-09 19:52:50', 'guest', 1465511503, 0, 0, 0, 0, 0, 3600, 0),
(28, '', '1366697652@370747727.com', 'donald trump', 5, 0, 1128, '2016-06-09 22:36:35', 'guest', 1465552143, 1, 0, 0, 0, 0, 6000, 0),
(29, '', '17071479@1723581365.com', 'sdfg', 0, 0, 1000, '2016-06-10 10:07:39', 'guest', 1465555317, 1, 0, 0, 0, 0, 1000, 0);

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
  MODIFY `bi_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `chat`
--
ALTER TABLE `chat`
  MODIFY `chat_id` int(11) NOT NULL AUTO_INCREMENT;
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
  MODIFY `friend_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;
--
-- AUTO_INCREMENT for table `inventory`
--
ALTER TABLE `inventory`
  MODIFY `inv_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;
--
-- AUTO_INCREMENT for table `items`
--
ALTER TABLE `items`
  MODIFY `item_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;
--
-- AUTO_INCREMENT for table `maps`
--
ALTER TABLE `maps`
  MODIFY `map_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `opp`
--
ALTER TABLE `opp`
  MODIFY `opp_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `rooms`
--
ALTER TABLE `rooms`
  MODIFY `room_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `room_participants`
--
ALTER TABLE `room_participants`
  MODIFY `part_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `units`
--
ALTER TABLE `units`
  MODIFY `unit_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
