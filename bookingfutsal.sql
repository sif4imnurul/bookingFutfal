-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 07, 2024 at 10:08 AM
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
-- Database: `bookingfutsal`
--

-- --------------------------------------------------------

--
-- Table structure for table `booking`
--

CREATE TABLE `booking` (
  `Id_booking` int(11) NOT NULL,
  `Id_fasilitas` int(11) DEFAULT NULL,
  `Id_pengguna` int(11) DEFAULT NULL,
  `Id_ekstra_fasilitas` int(11) DEFAULT NULL,
  `Tanggal_booking` datetime DEFAULT NULL,
  `Waktu_mulai` datetime DEFAULT NULL,
  `Waktu_selesai` datetime DEFAULT NULL,
  `Uang_muka` decimal(10,2) DEFAULT NULL,
  `Status` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `booking`
--

INSERT INTO `booking` (`Id_booking`, `Id_fasilitas`, `Id_pengguna`, `Id_ekstra_fasilitas`, `Tanggal_booking`, `Waktu_mulai`, `Waktu_selesai`, `Uang_muka`, `Status`) VALUES
(1, 1, 1, 1, '2024-05-20 14:00:00', '2024-05-22 18:00:00', '2024-05-22 20:00:00', 60000.00, 'Terkonfirmasi'),
(2, 2, 2, 2, '2024-05-21 10:00:00', '2024-05-23 10:00:00', '2024-05-23 12:00:00', 70000.00, 'Terkonfirmasi'),
(3, 1, NULL, 1, '2024-05-19 14:00:00', '2024-05-20 09:00:00', '2024-05-20 10:00:00', 80000.00, 'Terkonfirmasi'),
(4, 1, 1, 1, '2024-05-19 14:00:00', '2024-05-20 10:00:00', '2024-05-20 12:00:00', 80000.00, 'Terkonfirmasi'),
(5, 1, 1, 1, '2024-05-19 14:00:00', '2024-05-20 14:00:00', '2024-05-20 16:00:00', 80000.00, 'Terkonfirmasi'),
(6, 1, 1, 1, '2024-05-19 14:00:00', '2024-05-20 14:00:00', '2024-05-20 16:00:00', 80000.00, 'Terkonfirmasi'),
(7, 1, 1, 1, '2024-05-19 14:00:00', '2024-05-20 14:00:00', '2024-05-20 16:00:00', 80000.00, 'Terkonfirmasi'),
(8, 1, 1, 1, '2024-05-19 14:00:00', '2024-05-20 14:00:00', '2024-05-20 16:00:00', 80000.00, 'Terkonfirmasi'),
(9, 1, 1, 1, '2024-05-19 14:00:00', '2024-05-20 20:00:00', '2024-05-20 22:00:00', 80000.00, 'Terkonfirmasi'),
(10, 1, 1, 1, '2024-05-19 14:00:00', '2024-05-21 14:00:00', '2024-05-21 16:00:00', 80000.00, 'Terkonfirmasi'),
(11, 1, 1, 1, '2024-05-19 14:00:00', '2024-05-20 08:00:00', '2024-05-20 10:00:00', 80000.00, 'Terkonfirmasi'),
(12, 2, 1, 1, '2024-05-19 14:00:00', '2024-05-20 14:00:00', '2024-05-20 16:00:00', 80000.00, 'Terkonfirmasi'),
(14, 2, 1, 1, '2024-05-19 14:00:00', '2024-05-20 14:00:00', '2024-05-20 16:00:00', 80000.00, 'Terkonfirmasi'),
(31, 1, 1, 1, '2024-05-29 10:00:00', '2024-05-29 11:00:00', '2024-05-29 12:00:00', 50000.00, 'Pending'),
(36, 2, 2, 2, '2024-05-29 14:21:00', '2024-05-30 16:21:00', '2024-05-29 14:21:00', 100000.00, 'Pending');

--
-- Triggers `booking`
--
DELIMITER $$
CREATE TRIGGER `after_insert_booking` AFTER INSERT ON `booking` FOR EACH ROW BEGIN
    DECLARE booking_start DATETIME;
    DECLARE booking_end DATETIME;

    -- Assign the new values to variables
    SET booking_start = NEW.Waktu_Mulai;
    SET booking_end = NEW.Waktu_Selesai;

    -- Update the corresponding records in the Jadwal table
    UPDATE Jadwal
    SET Status = CONCAT(COALESCE(Status, ''), ',', NEW.Id_fasilitas),
        Id_booking = NEW.Id_booking,
        Id_fasilitas = NEW.Id_fasilitas
    WHERE (Waktu_Mulai >= booking_start AND Waktu_Mulai < booking_end)
        OR (Waktu_Selesai > booking_start AND Waktu_Selesai <= booking_end)
        OR (Waktu_Mulai < booking_start AND Waktu_Selesai > booking_end);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `ekstra_fasilitas`
--

CREATE TABLE `ekstra_fasilitas` (
  `Id_ekstra_fasilitas` int(11) NOT NULL,
  `Nama` varchar(255) DEFAULT NULL,
  `Deskripsi` varchar(255) DEFAULT NULL,
  `Harga` decimal(10,2) DEFAULT NULL,
  `Status` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ekstra_fasilitas`
--

INSERT INTO `ekstra_fasilitas` (`Id_ekstra_fasilitas`, `Nama`, `Deskripsi`, `Harga`, `Status`) VALUES
(1, 'Minuman', 'Konsumsi', 5000.00, 'Tersedia'),
(2, 'Snack', 'Konsumsi', 7000.00, 'Tersedia');

-- --------------------------------------------------------

--
-- Table structure for table `fasilitas`
--

CREATE TABLE `fasilitas` (
  `Id_fasilitas` int(11) NOT NULL,
  `Nama` varchar(255) DEFAULT NULL,
  `Deskripsi` varchar(255) DEFAULT NULL,
  `Harga` decimal(10,2) DEFAULT NULL,
  `Stok` int(11) DEFAULT NULL,
  `gambar` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `fasilitas`
--

INSERT INTO `fasilitas` (`Id_fasilitas`, `Nama`, `Deskripsi`, `Harga`, `Stok`, `gambar`) VALUES
(1, 'Lapangan A', 'Lapangan futsal indoor', 600000.00, 1, 'lapangan1.jpg'),
(2, 'Lapangan B', 'Lapangan futsal indoor', 400000.00, 1, 'lapangan2.jpg'),
(3, 'Lapangan C', 'Lapangan futsal indoor', 600000.00, 1, 'lapangan3.jpg'),
(4, 'Lapangan D', 'Lapangan futsal indoor', 450000.00, 1, 'lapangan4.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `jadwal`
--

CREATE TABLE `jadwal` (
  `Id_jadwal` int(11) NOT NULL,
  `Id_booking` int(11) DEFAULT NULL,
  `Id_fasilitas` int(11) DEFAULT NULL,
  `Id_membership` int(11) DEFAULT NULL,
  `Hari` varchar(50) DEFAULT NULL,
  `Status` varchar(255) DEFAULT NULL,
  `Waktu_Mulai` datetime DEFAULT NULL,
  `Waktu_Selesai` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `jadwal`
--

INSERT INTO `jadwal` (`Id_jadwal`, `Id_booking`, `Id_fasilitas`, `Id_membership`, `Hari`, `Status`, `Waktu_Mulai`, `Waktu_Selesai`) VALUES
(1, 11, 1, NULL, 'Senin', 'Terisi 1', '2024-05-20 08:00:00', '2024-05-20 09:00:00'),
(2, 11, 1, NULL, 'Senin', 'Terisi 1', '2024-05-20 09:00:00', '2024-05-20 10:00:00'),
(3, 4, 1, NULL, 'Senin', 'Terisi: ', '2024-05-20 10:00:00', '2024-05-20 11:00:00'),
(4, NULL, NULL, NULL, 'Senin', 'Terisi: ', '2024-05-20 11:00:00', '2024-05-20 12:00:00'),
(5, NULL, NULL, NULL, 'Senin', 'Terisi: ', '2024-05-20 12:00:00', '2024-05-20 13:00:00'),
(6, NULL, NULL, NULL, 'Senin', 'Terisi: ', '2024-05-20 13:00:00', '2024-05-20 14:00:00'),
(7, 14, 2, NULL, 'Senin', 'Terisi 1,2', '2024-05-20 14:00:00', '2024-05-20 15:00:00'),
(8, 14, 2, NULL, 'Senin', 'Terisi 1,2', '2024-05-20 15:00:00', '2024-05-20 16:00:00'),
(9, 8, 1, NULL, 'Senin', 'Terisi: ', '2024-05-20 16:00:00', '2024-05-20 17:00:00'),
(10, NULL, NULL, NULL, 'Senin', 'Terisi: ', '2024-05-20 17:00:00', '2024-05-20 18:00:00'),
(11, NULL, NULL, NULL, 'Senin', 'Terisi: ', '2024-05-20 18:00:00', '2024-05-20 19:00:00'),
(12, NULL, NULL, NULL, 'Senin', 'Terisi: ', '2024-05-20 19:00:00', '2024-05-20 20:00:00'),
(13, 9, 1, NULL, 'Senin', 'Terisi: ', '2024-05-20 20:00:00', '2024-05-20 21:00:00'),
(14, 9, 1, NULL, 'Senin', 'Terisi: ', '2024-05-20 21:00:00', '2024-05-20 22:00:00'),
(15, NULL, NULL, NULL, 'Selasa', 'Terisi: ', '2024-05-21 08:00:00', '2024-05-21 09:00:00'),
(16, NULL, NULL, NULL, 'Selasa', 'Terisi: ', '2024-05-21 09:00:00', '2024-05-21 10:00:00'),
(17, NULL, NULL, NULL, 'Selasa', 'Terisi: ', '2024-05-21 10:00:00', '2024-05-21 11:00:00'),
(18, NULL, NULL, NULL, 'Selasa', 'Terisi: ', '2024-05-21 11:00:00', '2024-05-21 12:00:00'),
(19, NULL, NULL, NULL, 'Selasa', 'Terisi: ', '2024-05-21 12:00:00', '2024-05-21 13:00:00'),
(20, NULL, NULL, NULL, 'Selasa', 'Terisi: ', '2024-05-21 13:00:00', '2024-05-21 14:00:00'),
(21, 10, 1, NULL, 'Selasa', '1', '2024-05-21 14:00:00', '2024-05-21 15:00:00'),
(22, 10, 1, NULL, 'Selasa', '1', '2024-05-21 15:00:00', '2024-05-21 16:00:00'),
(23, NULL, NULL, NULL, 'Selasa', 'Terisi: ', '2024-05-21 16:00:00', '2024-05-21 17:00:00'),
(24, NULL, NULL, NULL, 'Selasa', 'Terisi: ', '2024-05-21 17:00:00', '2024-05-21 18:00:00'),
(25, NULL, NULL, NULL, 'Selasa', 'Terisi: ', '2024-05-21 18:00:00', '2024-05-21 19:00:00'),
(26, NULL, NULL, NULL, 'Selasa', 'Terisi: ', '2024-05-21 19:00:00', '2024-05-21 20:00:00'),
(27, NULL, NULL, NULL, 'Selasa', 'Terisi: ', '2024-05-21 20:00:00', '2024-05-21 21:00:00'),
(28, NULL, NULL, NULL, 'Selasa', 'Terisi: ', '2024-05-21 21:00:00', '2024-05-21 22:00:00'),
(29, NULL, NULL, NULL, 'Rabu', 'Terisi: ', '2024-05-22 08:00:00', '2024-05-22 09:00:00'),
(30, NULL, NULL, NULL, 'Rabu', 'Terisi: ', '2024-05-22 09:00:00', '2024-05-22 10:00:00'),
(31, NULL, NULL, NULL, 'Rabu', 'Terisi: ', '2024-05-22 10:00:00', '2024-05-22 11:00:00'),
(32, NULL, NULL, NULL, 'Rabu', 'Terisi: ', '2024-05-22 11:00:00', '2024-05-22 12:00:00'),
(33, NULL, NULL, NULL, 'Rabu', 'Terisi: ', '2024-05-22 12:00:00', '2024-05-22 13:00:00'),
(34, NULL, NULL, NULL, 'Rabu', 'Terisi: ', '2024-05-22 13:00:00', '2024-05-22 14:00:00'),
(35, NULL, NULL, NULL, 'Rabu', 'Terisi: ', '2024-05-22 14:00:00', '2024-05-22 15:00:00'),
(36, NULL, NULL, NULL, 'Rabu', 'Terisi: ', '2024-05-22 15:00:00', '2024-05-22 16:00:00'),
(37, NULL, NULL, NULL, 'Rabu', 'Terisi: ', '2024-05-22 16:00:00', '2024-05-22 17:00:00'),
(38, NULL, NULL, NULL, 'Rabu', 'Terisi: ', '2024-05-22 17:00:00', '2024-05-22 18:00:00'),
(39, NULL, NULL, NULL, 'Rabu', 'Terisi: ', '2024-05-22 18:00:00', '2024-05-22 19:00:00'),
(40, NULL, NULL, NULL, 'Rabu', 'Terisi: ', '2024-05-22 19:00:00', '2024-05-22 20:00:00'),
(41, NULL, NULL, NULL, 'Rabu', 'Terisi: ', '2024-05-22 20:00:00', '2024-05-22 21:00:00'),
(42, NULL, NULL, NULL, 'Rabu', 'Terisi: ', '2024-05-22 21:00:00', '2024-05-22 22:00:00'),
(43, NULL, NULL, NULL, 'Kamis', 'Terisi: ', '2024-05-23 08:00:00', '2024-05-23 09:00:00'),
(44, NULL, NULL, NULL, 'Kamis', 'Terisi: ', '2024-05-23 09:00:00', '2024-05-23 10:00:00'),
(45, NULL, NULL, NULL, 'Kamis', 'Terisi: ', '2024-05-23 10:00:00', '2024-05-23 11:00:00'),
(46, NULL, NULL, NULL, 'Kamis', 'Terisi: ', '2024-05-23 11:00:00', '2024-05-23 12:00:00'),
(47, NULL, NULL, NULL, 'Kamis', 'Terisi: ', '2024-05-23 12:00:00', '2024-05-23 13:00:00'),
(48, NULL, NULL, NULL, 'Kamis', 'Terisi: ', '2024-05-23 13:00:00', '2024-05-23 14:00:00'),
(49, NULL, NULL, NULL, 'Kamis', 'Terisi: ', '2024-05-23 14:00:00', '2024-05-23 15:00:00'),
(50, NULL, NULL, NULL, 'Kamis', 'Terisi: ', '2024-05-23 15:00:00', '2024-05-23 16:00:00'),
(51, NULL, NULL, NULL, 'Kamis', 'Terisi: ', '2024-05-23 16:00:00', '2024-05-23 17:00:00'),
(52, NULL, NULL, NULL, 'Kamis', 'Terisi: ', '2024-05-23 17:00:00', '2024-05-23 18:00:00'),
(53, NULL, NULL, NULL, 'Kamis', 'Terisi: ', '2024-05-23 18:00:00', '2024-05-23 19:00:00'),
(54, NULL, NULL, NULL, 'Kamis', 'Terisi: ', '2024-05-23 19:00:00', '2024-05-23 20:00:00'),
(55, NULL, NULL, NULL, 'Kamis', 'Terisi: ', '2024-05-23 20:00:00', '2024-05-23 21:00:00'),
(56, NULL, NULL, NULL, 'Kamis', 'Terisi: ', '2024-05-23 21:00:00', '2024-05-23 22:00:00'),
(57, NULL, NULL, NULL, 'Jumat', 'Terisi: ', '2024-05-24 08:00:00', '2024-05-24 09:00:00'),
(58, NULL, NULL, NULL, 'Jumat', 'Terisi: ', '2024-05-24 09:00:00', '2024-05-24 10:00:00'),
(59, NULL, NULL, NULL, 'Jumat', 'Terisi: ', '2024-05-24 10:00:00', '2024-05-24 11:00:00'),
(60, NULL, NULL, NULL, 'Jumat', 'Terisi: ', '2024-05-24 11:00:00', '2024-05-24 12:00:00'),
(61, NULL, NULL, NULL, 'Jumat', 'Terisi: ', '2024-05-24 12:00:00', '2024-05-24 13:00:00'),
(62, NULL, NULL, NULL, 'Jumat', 'Terisi: ', '2024-05-24 13:00:00', '2024-05-24 14:00:00'),
(63, NULL, NULL, NULL, 'Jumat', 'Terisi: ', '2024-05-24 14:00:00', '2024-05-24 15:00:00'),
(64, NULL, NULL, NULL, 'Jumat', 'Terisi: ', '2024-05-24 15:00:00', '2024-05-24 16:00:00'),
(65, NULL, NULL, NULL, 'Jumat', 'Terisi: ', '2024-05-24 16:00:00', '2024-05-24 17:00:00'),
(66, NULL, NULL, NULL, 'Jumat', 'Terisi: ', '2024-05-24 17:00:00', '2024-05-24 18:00:00'),
(67, NULL, NULL, NULL, 'Jumat', 'Terisi: ', '2024-05-24 18:00:00', '2024-05-24 19:00:00'),
(68, NULL, NULL, NULL, 'Jumat', 'Terisi: ', '2024-05-24 19:00:00', '2024-05-24 20:00:00'),
(69, NULL, NULL, NULL, 'Jumat', 'Terisi: ', '2024-05-24 20:00:00', '2024-05-24 21:00:00'),
(70, NULL, NULL, NULL, 'Jumat', 'Terisi: ', '2024-05-24 21:00:00', '2024-05-24 22:00:00'),
(71, NULL, NULL, NULL, 'Sabtu', 'Terisi: ', '2024-05-25 08:00:00', '2024-05-25 09:00:00'),
(72, NULL, NULL, NULL, 'Sabtu', 'Terisi: ', '2024-05-25 09:00:00', '2024-05-25 10:00:00'),
(73, NULL, NULL, NULL, 'Sabtu', 'Terisi: ', '2024-05-25 10:00:00', '2024-05-25 11:00:00'),
(74, NULL, NULL, NULL, 'Sabtu', 'Terisi: ', '2024-05-25 11:00:00', '2024-05-25 12:00:00'),
(75, NULL, NULL, NULL, 'Sabtu', 'Terisi: ', '2024-05-25 12:00:00', '2024-05-25 13:00:00'),
(76, NULL, NULL, NULL, 'Sabtu', 'Terisi: ', '2024-05-25 13:00:00', '2024-05-25 14:00:00'),
(77, NULL, NULL, NULL, 'Sabtu', 'Terisi: ', '2024-05-25 14:00:00', '2024-05-25 15:00:00'),
(78, NULL, NULL, NULL, 'Sabtu', 'Terisi: ', '2024-05-25 15:00:00', '2024-05-25 16:00:00'),
(79, NULL, NULL, NULL, 'Sabtu', 'Terisi: ', '2024-05-25 16:00:00', '2024-05-25 17:00:00'),
(80, NULL, NULL, NULL, 'Sabtu', 'Terisi: ', '2024-05-25 17:00:00', '2024-05-25 18:00:00'),
(81, NULL, NULL, NULL, 'Sabtu', 'Terisi: ', '2024-05-25 18:00:00', '2024-05-25 19:00:00'),
(82, NULL, NULL, NULL, 'Sabtu', 'Terisi: ', '2024-05-25 19:00:00', '2024-05-25 20:00:00'),
(83, NULL, NULL, NULL, 'Sabtu', 'Terisi: ', '2024-05-25 20:00:00', '2024-05-25 21:00:00'),
(84, NULL, NULL, NULL, 'Sabtu', 'Terisi: ', '2024-05-25 21:00:00', '2024-05-25 22:00:00'),
(85, NULL, NULL, NULL, 'Minggu', 'Terisi: ', '2024-05-26 08:00:00', '2024-05-26 09:00:00'),
(86, NULL, NULL, NULL, 'Minggu', 'Terisi: ', '2024-05-26 09:00:00', '2024-05-26 10:00:00'),
(87, NULL, NULL, NULL, 'Minggu', 'Terisi: ', '2024-05-26 10:00:00', '2024-05-26 11:00:00'),
(88, NULL, NULL, NULL, 'Minggu', 'Terisi: ', '2024-05-26 11:00:00', '2024-05-26 12:00:00'),
(89, NULL, NULL, NULL, 'Minggu', 'Terisi: ', '2024-05-26 12:00:00', '2024-05-26 13:00:00'),
(90, NULL, NULL, NULL, 'Minggu', 'Terisi: ', '2024-05-26 13:00:00', '2024-05-26 14:00:00'),
(91, NULL, NULL, NULL, 'Minggu', 'Terisi: ', '2024-05-26 14:00:00', '2024-05-26 15:00:00'),
(92, NULL, NULL, NULL, 'Minggu', 'Terisi: ', '2024-05-26 15:00:00', '2024-05-26 16:00:00'),
(93, NULL, NULL, NULL, 'Minggu', 'Terisi: ', '2024-05-26 16:00:00', '2024-05-26 17:00:00'),
(94, NULL, NULL, NULL, 'Minggu', 'Terisi: ', '2024-05-26 17:00:00', '2024-05-26 18:00:00'),
(95, NULL, NULL, NULL, 'Minggu', 'Terisi: ', '2024-05-26 18:00:00', '2024-05-26 19:00:00'),
(96, NULL, NULL, NULL, 'Minggu', 'Terisi: ', '2024-05-26 19:00:00', '2024-05-26 20:00:00'),
(97, NULL, NULL, NULL, 'Minggu', 'Terisi: ', '2024-05-26 20:00:00', '2024-05-26 21:00:00'),
(98, NULL, NULL, NULL, 'Minggu', 'Terisi: ', '2024-05-26 21:00:00', '2024-05-26 22:00:00'),
(99, NULL, NULL, NULL, 'Minggu', 'Terisi: ', '2024-05-26 22:00:00', '2024-05-26 23:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `membership`
--

CREATE TABLE `membership` (
  `Id_membership` int(11) NOT NULL,
  `Id_pengguna` int(11) DEFAULT NULL,
  `Id_fasilitas` int(11) DEFAULT NULL,
  `Id_pembayaran` int(11) DEFAULT NULL,
  `Tanggal_mulai_keanggotaan` datetime DEFAULT NULL,
  `Tanggal_berakhir_keanggotaan` datetime DEFAULT NULL,
  `Status` varchar(255) DEFAULT NULL,
  `Hari` varchar(255) DEFAULT NULL,
  `Waktu_awal` time DEFAULT NULL,
  `Waktu_akhir` time DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `membership`
--

INSERT INTO `membership` (`Id_membership`, `Id_pengguna`, `Id_fasilitas`, `Id_pembayaran`, `Tanggal_mulai_keanggotaan`, `Tanggal_berakhir_keanggotaan`, `Status`, `Hari`, `Waktu_awal`, `Waktu_akhir`) VALUES
(1, 1, 1, 1, '2024-01-01 00:00:00', '2024-12-31 00:00:00', 'Aktif', 'Wednesday', '18:00:00', '20:00:00'),
(2, 2, 2, 2, '2024-03-01 00:00:00', '2024-08-31 00:00:00', 'Tidak aktif', 'Thursday', '10:00:00', '12:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `pembayaran`
--

CREATE TABLE `pembayaran` (
  `Id_pembayaran` int(11) NOT NULL,
  `Id_booking` int(11) DEFAULT NULL,
  `Id_voucher` int(11) DEFAULT NULL,
  `Tanggal_pembayaran` datetime DEFAULT NULL,
  `Metode_pembayaran` varchar(255) DEFAULT NULL,
  `Status_pembayaran` varchar(255) DEFAULT NULL,
  `Total_harga` decimal(10,2) DEFAULT NULL,
  `Total_keseluruhan_harga` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pembayaran`
--

INSERT INTO `pembayaran` (`Id_pembayaran`, `Id_booking`, `Id_voucher`, `Tanggal_pembayaran`, `Metode_pembayaran`, `Status_pembayaran`, `Total_harga`, `Total_keseluruhan_harga`) VALUES
(1, 1, 1, '2024-05-22 18:30:00', 'Credit Card', 'Lunas', 245000.00, 97500.00),
(2, 2, 2, '2024-05-23 10:30:00', 'Cash', 'Belum lunas', 147000.00, 62300.00);

-- --------------------------------------------------------

--
-- Table structure for table `pengguna`
--

CREATE TABLE `pengguna` (
  `Id_pengguna` int(11) NOT NULL,
  `Nama` varchar(255) DEFAULT NULL,
  `Alamat` varchar(255) DEFAULT NULL,
  `Telp` varchar(15) DEFAULT NULL,
  `Jaminan` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pengguna`
--

INSERT INTO `pengguna` (`Id_pengguna`, `Nama`, `Alamat`, `Telp`, `Jaminan`) VALUES
(1, 'Jihan', 'Jl. Merdeka No. 123', '08123456789', 'KTP'),
(2, 'Syifa', 'Jl. Kebangsaan No. 456', '08129876543', 'SIM');

-- --------------------------------------------------------

--
-- Table structure for table `voucher`
--

CREATE TABLE `voucher` (
  `Id_voucher` int(11) NOT NULL,
  `Nama_voucher` varchar(255) DEFAULT NULL,
  `Deskripsi` varchar(255) DEFAULT NULL,
  `Berlaku_mulai` datetime DEFAULT NULL,
  `Berlaku_sampai` datetime DEFAULT NULL,
  `Stok` int(11) DEFAULT NULL,
  `Potongan_harga` decimal(10,2) DEFAULT NULL,
  `Cashback` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `voucher`
--

INSERT INTO `voucher` (`Id_voucher`, `Nama_voucher`, `Deskripsi`, `Berlaku_mulai`, `Berlaku_sampai`, `Stok`, `Potongan_harga`, `Cashback`) VALUES
(1, 'Voucher 50K', 'Diskon Rp50,000', '2024-05-01 00:00:00', '2024-06-01 00:00:00', 100, 50000.00, 0.00),
(2, 'Cashback 10%', 'Cashback 10% dari total pembayaran', '2024-05-15 00:00:00', '2024-06-15 00:00:00', 50, 0.00, 10.00);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `booking`
--
ALTER TABLE `booking`
  ADD PRIMARY KEY (`Id_booking`),
  ADD KEY `Id_fasilitas` (`Id_fasilitas`),
  ADD KEY `Id_pengguna` (`Id_pengguna`),
  ADD KEY `Id_ekstra_fasilitas` (`Id_ekstra_fasilitas`);

--
-- Indexes for table `ekstra_fasilitas`
--
ALTER TABLE `ekstra_fasilitas`
  ADD PRIMARY KEY (`Id_ekstra_fasilitas`);

--
-- Indexes for table `fasilitas`
--
ALTER TABLE `fasilitas`
  ADD PRIMARY KEY (`Id_fasilitas`);

--
-- Indexes for table `jadwal`
--
ALTER TABLE `jadwal`
  ADD PRIMARY KEY (`Id_jadwal`),
  ADD KEY `Id_booking` (`Id_booking`),
  ADD KEY `Id_fasilitas` (`Id_fasilitas`),
  ADD KEY `Id_membership` (`Id_membership`);

--
-- Indexes for table `membership`
--
ALTER TABLE `membership`
  ADD PRIMARY KEY (`Id_membership`),
  ADD KEY `Id_pengguna` (`Id_pengguna`),
  ADD KEY `Id_fasilitas` (`Id_fasilitas`),
  ADD KEY `Id_pembayaran` (`Id_pembayaran`);

--
-- Indexes for table `pembayaran`
--
ALTER TABLE `pembayaran`
  ADD PRIMARY KEY (`Id_pembayaran`),
  ADD KEY `Id_booking` (`Id_booking`),
  ADD KEY `Id_voucher` (`Id_voucher`);

--
-- Indexes for table `pengguna`
--
ALTER TABLE `pengguna`
  ADD PRIMARY KEY (`Id_pengguna`);

--
-- Indexes for table `voucher`
--
ALTER TABLE `voucher`
  ADD PRIMARY KEY (`Id_voucher`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `booking`
--
ALTER TABLE `booking`
  MODIFY `Id_booking` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `ekstra_fasilitas`
--
ALTER TABLE `ekstra_fasilitas`
  MODIFY `Id_ekstra_fasilitas` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `fasilitas`
--
ALTER TABLE `fasilitas`
  MODIFY `Id_fasilitas` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `jadwal`
--
ALTER TABLE `jadwal`
  MODIFY `Id_jadwal` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=100;

--
-- AUTO_INCREMENT for table `membership`
--
ALTER TABLE `membership`
  MODIFY `Id_membership` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `pembayaran`
--
ALTER TABLE `pembayaran`
  MODIFY `Id_pembayaran` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `pengguna`
--
ALTER TABLE `pengguna`
  MODIFY `Id_pengguna` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `voucher`
--
ALTER TABLE `voucher`
  MODIFY `Id_voucher` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `jadwal`
--
ALTER TABLE `jadwal`
  ADD CONSTRAINT `jadwal_ibfk_1` FOREIGN KEY (`Id_booking`) REFERENCES `booking` (`Id_booking`);

--
-- Constraints for table `pembayaran`
--
ALTER TABLE `pembayaran`
  ADD CONSTRAINT `pembayaran_ibfk_1` FOREIGN KEY (`Id_booking`) REFERENCES `booking` (`Id_booking`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
