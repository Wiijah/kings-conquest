-- phpMyAdmin SQL Dump
-- version 4.5.2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jun 07, 2016 at 02:37 PM
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
  `graphics` varchar(64) NOT NULL,
  `icon` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `buffs`
--

INSERT INTO `buffs` (`buff_id`, `buff_name`, `graphics`, `icon`) VALUES
(1, 'heal', 'graphics/spritesheet/spell/ss_heal.png', ''),
(2, 'burning', 'graphics/spritesheet/spell/ss_burning.png', '');

-- --------------------------------------------------------

--
-- Table structure for table `buff_instances`
--

CREATE TABLE `buff_instances` (
  `bi_id` int(11) NOT NULL,
  `buff_id` int(11) NOT NULL,
  `unit_id` int(11) NOT NULL,
  `turns_left` int(11) NOT NULL
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
(270, 36, 14, 0, '{"error_code": 0,"action" : {"action_type": "attack_unit", "attacker_id": 862,"buffs": [],"target_id": 863,"dmg": 15,"is_critical": 0}}');

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
  `winner` int(11) NOT NULL
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
  `event` set('kicked','left') NOT NULL,
  `gold` int(11) NOT NULL DEFAULT '500',
  `unit_kills` int(11) NOT NULL
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
(870, 2, 200, 200, 20, 0, 12, 11, 1, 1, 1, 0, 36);

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
(13, '$2y$10$EVxl9C85A3EGzS9/mbr4mO1eZwdAa7RoFtuXRU.4lwdohCezvuQTu', 'veg@veg.com', 'veg', 311, 73, 1000, '2016-06-01 20:53:57'),
(14, '$2y$10$sxwp7k4OSuCdCiO7y.JsOucq/YbXFR4oF8aBcgeTJ.UixSPKh.xJm', 'hp@hp.com', 'harry potter', 0, 0, 1000, '2016-06-04 21:40:28'),
(15, '$2y$10$Q3aMDDCP8w2o8bV.SaRs4.4Mgr49ZHzl372S4qExpvmadU0mAHETi', 'asda@asda.com', 'asdasd', 0, 0, 1000, '2016-06-04 21:40:51'),
(16, '$2y$10$aZkr5proBXT1kbSu9WWoHOM/q4lHiyqVXj6/9FYTa9Tn6YaO31LPW', 'simon@simon.com', 'simon', 0, 0, 1000, '2016-06-06 09:29:26');

--
-- Indexes for dumped tables
--

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
  MODIFY `buff_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `buff_instances`
--
ALTER TABLE `buff_instances`
  MODIFY `bi_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `chat`
--
ALTER TABLE `chat`
  MODIFY `chat_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=98;
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
-- AUTO_INCREMENT for table `opp`
--
ALTER TABLE `opp`
  MODIFY `opp_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=271;
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
  MODIFY `unit_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=871;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
