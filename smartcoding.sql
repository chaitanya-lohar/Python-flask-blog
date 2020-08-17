-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 14, 2020 at 01:08 PM
-- Server version: 10.1.38-MariaDB
-- PHP Version: 7.3.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `smartcoding`
--

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE `contacts` (
  `sno` int(11) NOT NULL,
  `name` text NOT NULL,
  `email` varchar(50) NOT NULL,
  `phone_no` varchar(30) NOT NULL,
  `message` varchar(100) NOT NULL,
  `date` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `contacts`
--

INSERT INTO `contacts` (`sno`, `name`, `email`, `phone_no`, `message`, `date`) VALUES
(2, 'chaitanya', 'chaitanyalohar01@gmail.com', '9784198818', 'rwerwrw', '2020-07-24 13:28:19'),
(3, 'now', 'now01@gmail.com', '9784198818', 'now', '2020-07-25 12:59:32'),
(4, 'now', 'now01@gmail.com', '9784198818', 'now', '2020-07-25 13:04:59'),
(5, 'now', 'now01@gmail.com', '9784198818', 'now', '2020-07-25 13:16:34'),
(13, 'nazre', 'chaitanyalohar01@gmail.com', '9784198818', 'sadasdas', '2020-07-25 13:48:00'),
(14, 'Iihpl@01691', 'chaitanyalohar01@gmail.com', '9784198818', 'dadad', '2020-07-25 13:54:33'),
(15, 'Iihpl@01691', 'chaitanyalohar01@gmail.com', '9784198818', 'aaaaa', '2020-07-25 13:59:18'),
(16, 'known', 'chaitanyalohar01@gmail.com', '9784198818', 'its me', '2020-07-25 14:02:19');

-- --------------------------------------------------------

--
-- Table structure for table `login`
--

CREATE TABLE `login` (
  `id` int(11) NOT NULL,
  `admin_name` varchar(50) NOT NULL,
  `admin_password` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `login`
--

INSERT INTO `login` (`id`, `admin_name`, `admin_password`) VALUES
(1, 'chetan', '123');

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `sno` int(11) NOT NULL,
  `title` varchar(50) NOT NULL,
  `sub_heading` varchar(100) NOT NULL,
  `slug` varchar(30) NOT NULL,
  `content` varchar(500) NOT NULL,
  `img_file` varchar(30) NOT NULL,
  `date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`sno`, `title`, `sub_heading`, `slug`, `content`, `img_file`, `date`) VALUES
(1, 'What is Jinja??', 'first blog', 'first-blog', 'Jinja2 is one of the most used template engines for Python. It is inspired by Django\'s templating system but extends it with an expressive language that gives template authors a more powerful set of tools. On top of that it adds sandboxed execution and optional {} escaping for applications where security is important.', 'post-bg.jpg', '2020-08-10 14:29:18'),
(2, 'update post', 'sub head', 'slug', 'adddddqqqq', 'about-bg.jpg', '2020-08-12 15:41:20'),
(3, 'Flask-SQLAlchemy', 'third blog', 'SQLAlchemy', 'from flask_sqlalchemy import SQLAlchemy\r\n\r\napp = Flask(__name__)\r\napp.config[\'SQLALCHEMY_DATABASE_URI\'] = \'sqlite:////tmp/test.db\'\r\ndb = SQLAlchemy(app)\r\n\r\n\r\nclass User(db.Model):\r\n    id = db.Column(db.Integer, primary_key=True)\r\n    username = db.Column(db.String(80), unique=True, nullable=False)\r\n    email = db.Column(db.String(120), unique=True, nullable=False)\r\n', 'about-bg.jpg', '2020-07-30 17:07:57'),
(5, 'new ', 'new post heading', 'last slugn', 'fsfdsfsfs', 'home-bg.jpg', '2020-08-14 14:40:58'),
(6, 'new post', 'sub head', 'old_slug', 'qqqqq', 'about-bg.jpg', '2020-08-14 10:36:18'),
(7, 'new post', 'new post heading', 'eee', 'eeeeeee', 'about-bg.jpg', '2020-08-14 10:36:37'),
(8, 'update post', 'new post heading update', 'new_post', 'tttttt', 'about-bg.jpg', '2020-08-14 10:36:53'),
(9, 'last post', 'final post', 'old_slug', 'uuuuuu', 'home-bg.jpg', '2020-08-14 10:37:11'),
(10, 'new post', 'new post heading updated', 'final slug', 'aaaa', 'about-bg.jpg', '2020-08-14 14:37:01');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`sno`);

--
-- Indexes for table `login`
--
ALTER TABLE `login`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`sno`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `sno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `login`
--
ALTER TABLE `login`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `sno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
