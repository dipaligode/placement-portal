-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 22, 2025 at 12:14 PM
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
-- Database: `my_placement_portal`
--

-- --------------------------------------------------------

--
-- Table structure for table `applications`
--

CREATE TABLE `applications` (
  `id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `job_id` int(11) NOT NULL,
  `applied_on` timestamp NOT NULL DEFAULT current_timestamp(),
  `application_status` enum('Pending','Accepted','Rejected','Interview Scheduled') DEFAULT 'Pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `companies`
--

CREATE TABLE `companies` (
  `id` int(11) NOT NULL,
  `company_name` varchar(255) NOT NULL,
  `industry` varchar(255) DEFAULT NULL,
  `company_email` varchar(255) NOT NULL,
  `contact_number` varchar(20) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `companies`
--

INSERT INTO `companies` (`id`, `company_name`, `industry`, `company_email`, `contact_number`, `website`) VALUES
(3, 'google', 'technology', 'careers@google.com', '9876543210', 'https://www.google.com'),
(4, 'Amazon', 'E-commerce', 'jobs@amazon.com', '8765432109', 'https://www.amazon.com'),
(5, 'Microsoft', 'Software', 'hiring@microsoft.com', '7654321098', 'https://www.microsoft.com'),
(6, 'Tesla', 'Automotive', 'hr@tesla.com', '6543210987', 'https://www.tesla.com'),
(7, 'Adobe', 'Software', 'work@adobe.com', '5432109876', 'https://www.adobe.com');

-- --------------------------------------------------------

--
-- Table structure for table `job_posts`
--

CREATE TABLE `job_posts` (
  `id` int(11) NOT NULL,
  `job_title` varchar(255) NOT NULL,
  `job_description` text NOT NULL,
  `location` varchar(255) DEFAULT NULL,
  `salary` decimal(10,2) DEFAULT NULL,
  `eligibility_criteria` text NOT NULL,
  `last_date_to_apply` date NOT NULL,
  `posted_on` timestamp NOT NULL DEFAULT current_timestamp(),
  `rounds` int(11) DEFAULT NULL,
  `company` varchar(255) NOT NULL,
  `link_to_apply` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `job_posts`
--

INSERT INTO `job_posts` (`id`, `job_title`, `job_description`, `location`, `salary`, `eligibility_criteria`, `last_date_to_apply`, `posted_on`, `rounds`, `company`, `link_to_apply`) VALUES
(13, 'Software Developer', 'Develop and maintain web applications', 'Bangalore', 0.00, 'MCA, Good coding skills (Java/Python)', '2025-04-10', '2025-03-22 08:30:56', NULL, 'Google', ''),
(14, 'Backend Engineer', 'Build scalable APIs and database systems', 'Hyderabad', 0.00, 'MCA, SQL, Node.js, Java', '2025-04-12', '2025-03-22 08:34:46', NULL, 'Amazon', ''),
(15, 'Frontend Developer', 'Develop UI/UX for web applications', 'pune', 0.00, 'MCA, React.js, JavaScript', '2025-04-16', '2025-03-22 08:39:23', NULL, 'Microsoft', ''),
(16, 'Data Analyst', 'Analyze and interpret complex data', 'Chennai', 0.00, 'MCA, SQL, Python, Data Visualization', '2025-03-26', '2025-03-22 08:40:57', NULL, 'IBM', '');

-- --------------------------------------------------------

--
-- Table structure for table `job_rounds`
--

CREATE TABLE `job_rounds` (
  `id` int(11) NOT NULL,
  `job_post_id` int(11) NOT NULL,
  `round_number` int(11) NOT NULL,
  `round_name` varchar(255) NOT NULL,
  `round_description` text DEFAULT NULL,
  `scheduled_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `job_rounds`
--

INSERT INTO `job_rounds` (`id`, `job_post_id`, `round_number`, `round_name`, `round_description`, `scheduled_date`) VALUES
(3, 13, 1, 'Online Assessment', 'Aptitude & Coding Test (Java, Python)', '2025-04-25 00:00:00'),
(4, 13, 2, 'Technical Interview', 'Data Structures, Algorithms, System Design', '2025-04-15 00:00:00'),
(5, 13, 3, 'HR Interview', 'Behavioral & Cultural Fit Discussion', '2025-04-18 00:00:00'),
(6, 14, 1, 'Coding Challenge', 'Solve real-world backend problems', '2025-04-14 00:00:00'),
(7, 14, 2, 'System Design Interview', 'Architecture and database design evaluation', '2025-04-17 00:00:00'),
(8, 15, 1, '	UI/UX Design Task', 'Build an interactive frontend using React', '2025-04-16 00:00:00'),
(9, 15, 2, 'Frontend Technical', 'JavaScript, React, API integration', '2025-04-19 00:00:00'),
(10, 16, 1, '	Coding Challenge', 'Solve real-world backend problems', '2025-04-14 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `notices`
--

CREATE TABLE `notices` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `posted_by` int(11) NOT NULL,
  `posted_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `placements`
--

CREATE TABLE `placements` (
  `id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `company_id` int(11) NOT NULL,
  `job_id` int(11) NOT NULL,
  `salary_package` decimal(10,2) NOT NULL,
  `joining_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `skills`
--

CREATE TABLE `skills` (
  `id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `skill_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `id` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `rollno` int(11) NOT NULL,
  `dob` date NOT NULL,
  `pstreet` varchar(255) NOT NULL,
  `pcity` varchar(255) NOT NULL,
  `pstate` varchar(255) NOT NULL,
  `pcountry` varchar(255) NOT NULL,
  `cstreet` int(11) NOT NULL,
  `ccity` int(11) NOT NULL,
  `cstate` int(11) NOT NULL,
  `ccountry` int(11) NOT NULL,
  `prn_no` varchar(255) NOT NULL,
  `ssc` decimal(10,0) NOT NULL,
  `hsc` decimal(10,0) NOT NULL,
  `pg` decimal(10,0) NOT NULL,
  `clg_email` varchar(255) NOT NULL,
  `last_login` varchar(255) NOT NULL,
  `status` enum('placed','pending') NOT NULL,
  `resume` varchar(255) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `phone` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`id`, `uid`, `rollno`, `dob`, `pstreet`, `pcity`, `pstate`, `pcountry`, `cstreet`, `ccity`, `cstate`, `ccountry`, `prn_no`, `ssc`, `hsc`, `pg`, `clg_email`, `last_login`, `status`, `resume`, `first_name`, `last_name`, `phone`) VALUES
(1, 817493, 0, '2025-03-22', 'xxxxxx', 'aaaaaaa', 'aaaaaaa', 'aaaaa', 0, 0, 0, 0, '', 0, 0, 0, '', '2025-03-22 14:38:00', 'placed', '', 'Namrata', 'Kapse', ''),
(2, 247927, 0, '0000-00-00', '', '', '', '', 0, 0, 0, 0, '', 0, 0, 0, '', '', 'placed', '', 'Aaa', 'Aaa', '');

-- --------------------------------------------------------

--
-- Table structure for table `students_academic`
--

CREATE TABLE `students_academic` (
  `id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `semester` int(11) NOT NULL,
  `cgpa` decimal(4,2) NOT NULL,
  `backlog` int(11) DEFAULT 0,
  `certifications` text DEFAULT NULL,
  `recorded_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `students_achievements`
--

CREATE TABLE `students_achievements` (
  `id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `achievement_title` varchar(255) NOT NULL,
  `achievement_type` enum('Course Completion','Competition Rank','Research Paper','Other') NOT NULL,
  `organization` varchar(255) DEFAULT NULL,
  `certificate_link` text DEFAULT NULL,
  `achieved_on` date NOT NULL,
  `recorded_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `teachers`
--

CREATE TABLE `teachers` (
  `id` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `pstreet` varchar(255) DEFAULT NULL,
  `pcity` varchar(100) DEFAULT NULL,
  `pstate` varchar(100) DEFAULT NULL,
  `pcountry` varchar(100) DEFAULT NULL,
  `tstreet` varchar(255) DEFAULT NULL,
  `tcity` varchar(100) DEFAULT NULL,
  `tstate` varchar(100) DEFAULT NULL,
  `tcountry` varchar(100) DEFAULT NULL,
  `last_login` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `phone` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `teachers`
--

INSERT INTO `teachers` (`id`, `uid`, `first_name`, `last_name`, `pstreet`, `pcity`, `pstate`, `pcountry`, `tstreet`, `tcity`, `tstate`, `tcountry`, `last_login`, `phone`) VALUES
(8, 988363, 'Dipali', 'Gode', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-03-22 09:05:21', '');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `password`, `email`, `created_at`) VALUES
(247927, '$2y$10$fLUx6tlPzHXjUJRa6Z8.Ru7Hqz9od9/ysM2kV4RXnxwIO5J.1pGNC', 'bbbb@abc.cyn', '2025-03-22 09:07:32'),
(292532, '$2y$10$EdZu8qx6pBaGevjYISpQUu6y1mZ.w6aE.9aZlbLS3M4GNLqQwg8Gi', 'admin@gmail.com', '2025-03-22 09:05:39'),
(817493, '$2y$10$hNRCTTQjiM9ihIP9HzG1mOn.bUgAY2oKJeyW1t7TKLgLb9lpqriK.', 'dipali.gode21@stmirascollegepune.edu.in', '2025-03-22 08:58:18'),
(988363, '$2y$10$1GqSHHHOblAAc/JGc0y7keKcZ9EIIJCvl6geUqOgB2tXWwKVcX2Bu', 'dipali_gode_mca@moderncoe.edu.in', '2025-03-22 08:09:30');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `applications`
--
ALTER TABLE `applications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `student_id` (`student_id`),
  ADD KEY `job_id` (`job_id`);

--
-- Indexes for table `companies`
--
ALTER TABLE `companies`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `company_email` (`company_email`);

--
-- Indexes for table `job_posts`
--
ALTER TABLE `job_posts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `job_rounds`
--
ALTER TABLE `job_rounds`
  ADD PRIMARY KEY (`id`),
  ADD KEY `job_post_id` (`job_post_id`);

--
-- Indexes for table `notices`
--
ALTER TABLE `notices`
  ADD PRIMARY KEY (`id`),
  ADD KEY `posted_by` (`posted_by`);

--
-- Indexes for table `placements`
--
ALTER TABLE `placements`
  ADD PRIMARY KEY (`id`),
  ADD KEY `student_id` (`student_id`),
  ADD KEY `company_id` (`company_id`),
  ADD KEY `job_id` (`job_id`);

--
-- Indexes for table `skills`
--
ALTER TABLE `skills`
  ADD PRIMARY KEY (`id`),
  ADD KEY `student_id` (`student_id`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`id`),
  ADD KEY `userid` (`uid`);

--
-- Indexes for table `students_academic`
--
ALTER TABLE `students_academic`
  ADD PRIMARY KEY (`id`),
  ADD KEY `student_id` (`student_id`);

--
-- Indexes for table `students_achievements`
--
ALTER TABLE `students_achievements`
  ADD PRIMARY KEY (`id`),
  ADD KEY `student_id` (`student_id`);

--
-- Indexes for table `teachers`
--
ALTER TABLE `teachers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `uid` (`uid`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `applications`
--
ALTER TABLE `applications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `companies`
--
ALTER TABLE `companies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `job_posts`
--
ALTER TABLE `job_posts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `job_rounds`
--
ALTER TABLE `job_rounds`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `notices`
--
ALTER TABLE `notices`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `placements`
--
ALTER TABLE `placements`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `skills`
--
ALTER TABLE `skills`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `students`
--
ALTER TABLE `students`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `students_academic`
--
ALTER TABLE `students_academic`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `students_achievements`
--
ALTER TABLE `students_achievements`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `teachers`
--
ALTER TABLE `teachers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `applications`
--
ALTER TABLE `applications`
  ADD CONSTRAINT `applications_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `applications_ibfk_2` FOREIGN KEY (`job_id`) REFERENCES `job_posts` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `job_rounds`
--
ALTER TABLE `job_rounds`
  ADD CONSTRAINT `job_rounds_ibfk_1` FOREIGN KEY (`job_post_id`) REFERENCES `job_posts` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `placements`
--
ALTER TABLE `placements`
  ADD CONSTRAINT `placements_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `placements_ibfk_2` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `placements_ibfk_3` FOREIGN KEY (`job_id`) REFERENCES `job_posts` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `skills`
--
ALTER TABLE `skills`
  ADD CONSTRAINT `skills_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `students`
--
ALTER TABLE `students`
  ADD CONSTRAINT `students_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `students_academic`
--
ALTER TABLE `students_academic`
  ADD CONSTRAINT `students_academic_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `students_achievements`
--
ALTER TABLE `students_achievements`
  ADD CONSTRAINT `students_achievements_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `teachers`
--
ALTER TABLE `teachers`
  ADD CONSTRAINT `teachers_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
