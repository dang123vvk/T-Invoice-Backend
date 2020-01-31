-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Máy chủ: localhost
-- Thời gian đã tạo: Th1 31, 2020 lúc 11:07 AM
-- Phiên bản máy phục vụ: 10.4.10-MariaDB
-- Phiên bản PHP: 7.3.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `tinvoice`
--
CREATE DATABASE IF NOT EXISTS `tinvoice` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `tinvoice`;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `accounts_bank`
--

CREATE TABLE `accounts_bank` (
  `account_bank_id` int(11) NOT NULL,
  `account_bank_number` varchar(20) CHARACTER SET utf8 NOT NULL,
  `account_bank_name` varchar(100) CHARACTER SET utf8 NOT NULL,
  `account_bank_address` varchar(100) CHARACTER SET utf8 NOT NULL,
  `account_bank_swift` varchar(100) CHARACTER SET utf8 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Đang đổ dữ liệu cho bảng `accounts_bank`
--

INSERT INTO `accounts_bank` (`account_bank_id`, `account_bank_number`, `account_bank_name`, `account_bank_address`, `account_bank_swift`) VALUES
(6, '6380201008359', 'Agribank', ' Quận 10, Thành Phố Hồ Chí Minh', 'VBAAVNVX'),
(7, '12510000586328', 'BIDV', ' Quận 1, Thành Phố Hồ Chí Minh', 'BIDVVNVX'),
(8, '0531002223008', 'VietcomBank', 'Quận Phú Nhuận, Hồ Chí Minh', 'BFTVVNVX'),
(9, '331364', 'ACB', 'Quận Phú Nhuận, Hồ Chí Minh', 'ASCBVNVX');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `bills`
--

CREATE TABLE `bills` (
  `bill_id` int(11) NOT NULL,
  `po_number_id` int(11) DEFAULT NULL,
  `bill_reference` varchar(50) DEFAULT NULL,
  `customer_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `bill_date` varchar(50) DEFAULT NULL,
  `status_bill_id` int(11) NOT NULL,
  `account_bank_id` int(11) NOT NULL,
  `templates_id` int(11) NOT NULL DEFAULT 1,
  `bills_sum` float DEFAULT NULL,
  `bill_monthly_cost` varchar(50) DEFAULT NULL,
  `bill_content` varchar(50) DEFAULT NULL,
  `bill_get_date` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Đang đổ dữ liệu cho bảng `bills`
--

INSERT INTO `bills` (`bill_id`, `po_number_id`, `bill_reference`, `customer_id`, `user_id`, `bill_date`, `status_bill_id`, `account_bank_id`, `templates_id`, `bills_sum`, `bill_monthly_cost`, `bill_content`, `bill_get_date`) VALUES
(49, 19, 'JUL2019RH', 15, 4, '2019-07-14', 1, 8, 4, 3501, '2019-07', 'Monthly cost for', '2019-07-15 17:00:00'),
(51, 29, 'JUL2019BAT', 16, 4, '2019-07-15', 1, 9, 6, 1000, '2019-07', 'Monthly cost for', '2019-07-14 17:00:00'),
(52, 16, 'JUL2019NDK', 11, 11, '2019-07-15', 1, 9, 7, 123, '2019-07', 'Monthly cost for', '2019-07-15 17:00:00');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `bill_items`
--

CREATE TABLE `bill_items` (
  `bill_item_id` int(11) NOT NULL,
  `bill_id` int(11) NOT NULL,
  `bill_item_description` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `bill_item_cost` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Đang đổ dữ liệu cho bảng `bill_items`
--

INSERT INTO `bill_items` (`bill_item_id`, `bill_id`, `bill_item_description`, `bill_item_cost`) VALUES
(9, 49, 'Fee 1', 3000),
(10, 49, 'Fee 2', 501),
(13, 52, '123', 123),
(14, 51, 'rđxgf', 1000);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `currencies`
--

CREATE TABLE `currencies` (
  `currency_id` int(11) NOT NULL,
  `currency_name` varchar(50) NOT NULL,
  `currency_code` varchar(50) NOT NULL,
  `currency_month` varchar(50) NOT NULL,
  `currency_rate` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Đang đổ dữ liệu cho bảng `currencies`
--

INSERT INTO `currencies` (`currency_id`, `currency_name`, `currency_code`, `currency_month`, `currency_rate`) VALUES
(1, 'JAPANESE YEN', 'JPY', '2019-07', 0.0092),
(2, 'THAI BAHT', 'THB', '2020-01', 0.032),
(3, 'EURO', 'EUR', '2020-01', 1.1),
(4, 'US DOLLAR', 'USD', '2020-01', 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `customers`
--

CREATE TABLE `customers` (
  `customer_id` int(11) NOT NULL,
  `customer_name` varchar(100) CHARACTER SET utf8 NOT NULL,
  `customer_email` varchar(100) CHARACTER SET utf8 NOT NULL,
  `customer_number_phone` varchar(100) CHARACTER SET utf8 NOT NULL,
  `customer_address` varchar(300) CHARACTER SET utf8 NOT NULL,
  `customer_swift_code` varchar(50) DEFAULT NULL,
  `customer_details_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Đang đổ dữ liệu cho bảng `customers`
--

INSERT INTO `customers` (`customer_id`, `customer_name`, `customer_email`, `customer_number_phone`, `customer_address`, `customer_swift_code`, `customer_details_id`) VALUES
(8, 'Nguyễn An', 'nkan@gmail.com', '84397532112', 'Hà Nội', 'NB', 8),
(9, 'Trần Nghĩa', 'tnghia@gmail.com', '84703877210', 'Đà Nẵng', 'TN', 9),
(10, 'Alex', 'alex1982@gmail.com', '1877233411', 'New York', 'ALEX', 10),
(11, 'Nguyễn Diễm Kiều', 'ndkieu@gmail.com', '847332114310', 'Cần Thơ', 'NDK', 11),
(12, 'Taylor Swift', 'taylor@gmail.com', '17332122144', 'Texas', 'TLW', 12),
(13, 'Justin Bieber', 'justin@gmail.com', '1877211755', 'California', 'JB', 13),
(14, 'Ed Sheeran', 'ed@gmail.com', '17712898553', 'Suffolk', 'ES', 14),
(15, 'Rihana', 'Rihna@gmail.com', '0123456778', 'Texas', 'RH', 15),
(16, 'Bui Anh Tuan', 'bat@gmail.com', '847221566321', 'Ho Chi Minh', 'BAT', 16);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `customer_details`
--

CREATE TABLE `customer_details` (
  `customer_details_id` int(11) NOT NULL,
  `customer_details_company` varchar(100) CHARACTER SET utf8 NOT NULL,
  `customer_details_project` varchar(100) CHARACTER SET utf8 NOT NULL,
  `customer_details_country` varchar(100) CHARACTER SET utf8 NOT NULL,
  `customer_details_note` varchar(300) CHARACTER SET utf8 DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Đang đổ dữ liệu cho bảng `customer_details`
--

INSERT INTO `customer_details` (`customer_details_id`, `customer_details_company`, `customer_details_project`, `customer_details_country`, `customer_details_note`) VALUES
(8, 'An Company', 'Web1', 'Việt Nam', ''),
(9, 'Mete Company', 'App android chỉ đường', 'Việt Nam', ''),
(10, 'Alex Company', 'IOT', 'USA', ''),
(11, 'KC Company', 'KCW', 'Việt Nam', ''),
(12, ' Big Machine Records', 'Album Lover', 'USA', ''),
(13, ' RBMG Records', 'Album fifth', 'USA', ''),
(14, 'Ed Sheeran', 'Cooperation', 'England', ''),
(15, 'Mete Company', 'SN1', 'USA', '1111'),
(16, 'BAT Company', 'Project 1', 'Viet Nam', '');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `groups_user`
--

CREATE TABLE `groups_user` (
  `groups_user_id` int(11) NOT NULL,
  `groups_user_name` varchar(100) CHARACTER SET utf8 NOT NULL,
  `groups_user_description` varchar(100) CHARACTER SET utf8 DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Đang đổ dữ liệu cho bảng `groups_user`
--

INSERT INTO `groups_user` (`groups_user_id`, `groups_user_name`, `groups_user_description`) VALUES
(1, 'Group 2', 'Group 2'),
(2, 'Group 1', 'Group 1'),
(3, 'Group 3', 'Group 3');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `po_number`
--

CREATE TABLE `po_number` (
  `po_number_id` int(11) NOT NULL,
  `po_number_no` varchar(50) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `status_po_id` int(11) NOT NULL,
  `po_number_description` varchar(50) DEFAULT NULL,
  `po_number_payment` int(11) NOT NULL DEFAULT 0,
  `po_number_amount` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Đang đổ dữ liệu cho bảng `po_number`
--

INSERT INTO `po_number` (`po_number_id`, `po_number_no`, `customer_id`, `status_po_id`, `po_number_description`, `po_number_payment`, `po_number_amount`) VALUES
(16, '100100', 11, 2, '100100', 0, 0),
(19, '708770', 15, 2, 'Project 1', 0, 0),
(20, '708112', 15, 2, 'Project 2', 0, 0),
(24, '8917320', 10, 2, 'App 1', 0, 0),
(25, '8722390', 10, 2, 'App 2', 0, 0),
(26, '7820090', 10, 2, 'Old App', 0, 0),
(27, '8577223', 9, 2, 'Game 1', 0, 0),
(28, '8887123', 8, 2, 'App 315', 0, 0),
(29, '7822019', 16, 2, 'Web 1', 0, 0);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `roles`
--

CREATE TABLE `roles` (
  `role_id` int(11) NOT NULL,
  `role_name` varchar(100) CHARACTER SET utf8 NOT NULL,
  `rode_description` varchar(100) CHARACTER SET utf8 DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Đang đổ dữ liệu cho bảng `roles`
--

INSERT INTO `roles` (`role_id`, `role_name`, `rode_description`) VALUES
(1, 'Admin', ''),
(2, 'Director', ''),
(3, 'Sr.Director', '');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sessions`
--

CREATE TABLE `sessions` (
  `session_id` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `expires` int(11) UNSIGNED NOT NULL,
  `data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Đang đổ dữ liệu cho bảng `sessions`
--

INSERT INTO `sessions` (`session_id`, `expires`, `data`) VALUES
('-ND3g4ZR45Dfc5ugEIxDEc5h7ghuxGGt', 1578304489, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('-rZ500fSd7oKQNsK9EPQBxZO-F_NIRv-', 1578302705, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('0cPkkGfZm3_xir7tvHLrQF69SHd6C7XE', 1578302583, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('2qIv_mGK5uRNAe4svO-LlcGWq-9PPM9K', 1578304483, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('3iZla0hsAsxJ1MqH63DcxHVYBFY6Zbv4', 1578302585, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('4kgUBGXUWZ4q-V2r8q3Qp8-WdlK2xinR', 1578304488, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('5Re5phGB4irRoNIoxd2J_z2qR1MoCskf', 1578304492, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('5VCZ6JnZnqIT9WB6x6ey8w9ophxCLNMO', 1578302707, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('65PlNY4UYq3U_TVLWUOOKJFbB-tdRzZV', 1578302585, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('6k21i3nAGqh1olNwoiL2w-EgSyFmJWE9', 1578302707, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('6tB88bBy1W7wZa--tBDRBlJvpKhJTKG0', 1578307173, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('6tfRWazBANgLkU2CNMiRyPUPYKu_gxq0', 1578302585, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('6tgvTq5T9LcRV2O09q29qpRhzmkG2XPc', 1578307173, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('94lD-_wjW12Z6E2kRvk4Sl9Cbr1jJLIH', 1578302707, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('CH9n5cnMuCmK-8FE0OYwm5-7qUqAHrqR', 1578307173, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('CulCTB9QR_Uj0dkYO1uYatFMw44dcY40', 1578302707, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('DTw5VT77hVEmDJAyxSiYq-oQE8f5LGh2', 1578304483, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('DTwg3Ze6EyC2RIULzzRbm9nC-UD99-NL', 1578318452, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('E1_7V0Qdjn4MP0-edPFRd1M6FFHP7snE', 1578302585, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('HURQFE--ndmJTSUw9jjqye9SAhVESwMZ', 1578324124, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('Jxg45pHTP0F29MxsoNmwmBBrcjJg5t-E', 1578302707, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('KS4dVKnmI9uT_b4aiYebSefxCEdTmMkQ', 1578304492, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('KtYU7sbKcB1J2TI2ZmtMiNuAyKtsCbOc', 1578318452, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('L5RCZBFUBnIfp4Fsrd0wgKx6LuG5p9Gf', 1578304492, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('M7IIxf7t5gLdtY1I4g5UfNu0-48cvzro', 1578318452, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('MlgeEDQQ4ifniW0vkYJkYut-HXetjt3F', 1578302707, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('Ovp3x__VgNnn7JiOHFk8sbA9Cn8Z4CUW', 1578324124, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('P-GOElLJouNGPotoeH4pH92xDualcgaN', 1578302583, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('PCfgt3svKZ5UbisVAdWSdmWIPRQoWF7e', 1578302707, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('PHnVtdwnylXfXL2eDEzvNRT5hmIBGVzJ', 1578318452, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('Pel117oHfO2cl42bckIdXBAwsnl9p_ni', 1578292515, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('QgBSuoOauPOak5aBcvo7e8JTx8e0nvBm', 1578307170, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('RLBLBEMog79Tt0GpuIb-5NXj6OET4ofK', 1578304489, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('RvHUNiCLOM5-YRQ3gxVvgFtEItlUisCb', 1578292519, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('Su31_MNbgEaOhxxfX-OT21gGglGvPSk8', 1578304485, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('U5B1lcJDONw1ChqywSAHnfreA_hRd-18', 1578307173, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('VD4NP5dXPMA4wym_QexpxzGQeo-yh3J9', 1578304489, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('WEPHDWXoLzlrj3dkKvLrwC02iMJTihNJ', 1578302585, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('Y5Circp9TvS5w63b-aVR6eUrzN1PUb12', 1578302707, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('Y91J9PXIkm-nLQ4bXNAB3Q3TYdRWr5HL', 1578302585, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('Z2et5FZi1I8uZlGKjjF6ygYOhLXJKlZR', 1578292519, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('Z47BuR9BI8Nj4LpR7OhVljWkyjOM6xhj', 1578304492, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('Zkqw0t9o_M33lyB9Um_qYV_q0jSKBQKb', 1578304492, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('_J8TVbeVBLGth0V82Gl9t4YxVn7fOIQx', 1578307173, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('_kFbyZ4cOIhEnI5BTlWTZIy4cVE-n9Ar', 1578292515, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('_vLbwva70FB_BQHbR-BI7HGRPuX-UHnL', 1578324125, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('aPjcGmvtjO8MrlXeq3xW7UulZmCMY5ij', 1578292515, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('aQgonROixyMYZmq2brkNtrvVZFaGZy98', 1578302707, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('bASqSw0WAznvsaKAwQ_LJbHjhvdj2Aj1', 1578302707, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('biktjgsOhrUnoPq-VgHnBx8K9dXC-10p', 1578304490, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('bqnvEXG9aNJ1MUQKn7ldCy7PEdoq51yo', 1578304492, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('gEShKtZO46hLDMy-A0Swvmc_ldBQxT0p', 1578302585, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('irE5QDYxcYIP0sKYPTMOFxZThMjWdAIc', 1578292515, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('k-KE_WpX3QJjRgwFI26Zbg72vTnH8cMg', 1578318452, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('kigIVjNVbi2gyWK4GzF34bqkTmrxUpeX', 1578302707, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('mg0tvsTGkICKowaUOJLORYeFVW1HLDNF', 1578318452, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('n1LAXieWR81OhK-E65PTT02zMPsEZ1nB', 1578302707, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('na6aQC1LiSyz6H9JA42JFT_fShryjl0L', 1578304488, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('o-r4K7XW4JPEyy4SOhEHifOcy3MY8tpk', 1578304487, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('py5nk8jKuooqZJUmZ_wy9MQJWso0VaTR', 1578307173, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('qE3oFzSNm3fMl5dfaObMVaVw__rsi_zH', 1578304488, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('qFrbCu6_bbpghsfr5HHMaJcaRo9XoeyO', 1578302585, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('qOl-RwLOfTPti8VMU5WTxPJrHSinmRKu', 1578318452, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('qfik5rgMO75BtSUTH989tATn_vkqfiZH', 1578302707, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('rvy6jhPbyMFS9FfmTLho5mL_hl1Kbe1u', 1578292515, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('tYQA7Xvk5TxYva6ssgFg-4AuikNznBov', 1578324125, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('tZAVj_MlNO4zJ9xEYOLIi_0nyKXfAwq8', 1578304486, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('tcbO4GDQ2YuPNO-h6QW1gF-Eqs7R874T', 1578302707, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('u-nR1BLWtXozvsIYMEN_sp0BzRSWri00', 1578292515, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('u0wz7HMllPweo8QABj7sStdpb4ZdQfrY', 1578307173, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('uT2mjpMBSS9B-hAPErURn6er0YarnWvg', 1578302707, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('uwh_36HsFUb1CuTub6nlAC76Ed-FG9hB', 1578302707, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('vKzcUTvLhur37srfIc1xgioear-b1OJT', 1578318452, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('w0hG_WXvoN-eoGjOqE7Qjdu5yC_9Q2vB', 1578292515, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('wCdEd4aO5YMIGaxdx_hWIE9zyjYqQuGA', 1578304485, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('wJgbgjQ4R9W8VSc0InpKvMdSnkwhTc6G', 1578307170, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('wt3MhN7fD2K7AMWoqOKxa1i6dX2m490H', 1578304492, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('xldFNiEZIsPXm59m87u3i_YX7AJ1e0Ex', 1578307173, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('xvbIwogCReq3wObdErwyDTU7WuKQaQI6', 1578302705, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('yLE8Z9ejiMcsPQKD4Rcqhj3nCOCH0d2Y', 1578292515, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}'),
('z6ZAv5JchgxDb8Hzt1T7YdO8FgTztSBA', 1578304492, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `status_bill`
--

CREATE TABLE `status_bill` (
  `status_bill_id` int(11) NOT NULL,
  `status_bill_name` varchar(100) CHARACTER SET utf8 NOT NULL,
  `status_bill_description` varchar(300) CHARACTER SET utf8 DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Đang đổ dữ liệu cho bảng `status_bill`
--

INSERT INTO `status_bill` (`status_bill_id`, `status_bill_name`, `status_bill_description`) VALUES
(1, 'Not Sent', ''),
(2, 'Sent', ''),
(3, 'Paid', '');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `status_po`
--

CREATE TABLE `status_po` (
  `status_po_id` int(11) NOT NULL,
  `status_po_name` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Đang đổ dữ liệu cho bảng `status_po`
--

INSERT INTO `status_po` (`status_po_id`, `status_po_name`) VALUES
(1, 'New'),
(2, 'Active'),
(3, 'Used');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `templates_bill`
--

CREATE TABLE `templates_bill` (
  `templates_id` int(11) NOT NULL,
  `templates_name_company` varchar(100) CHARACTER SET utf8 NOT NULL,
  `templates_address` varchar(100) CHARACTER SET utf8 NOT NULL,
  `templates_phone` varchar(30) CHARACTER SET utf8 NOT NULL,
  `templates_email` varchar(100) CHARACTER SET utf8 NOT NULL,
  `templates_name_on_account` varchar(100) CHARACTER SET utf8 NOT NULL,
  `templates_tel` varchar(100) CHARACTER SET utf8 NOT NULL,
  `templates_fax` varchar(100) CHARACTER SET utf8 NOT NULL,
  `templates_sign` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `templates_name_cfo` varchar(100) CHARACTER SET utf8 NOT NULL,
  `templates_tel_cfo` varchar(100) CHARACTER SET utf8 NOT NULL,
  `templates_extension_cfo` varchar(100) CHARACTER SET utf8 NOT NULL,
  `templates_email_cfo` varchar(100) CHARACTER SET utf8 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Đang đổ dữ liệu cho bảng `templates_bill`
--

INSERT INTO `templates_bill` (`templates_id`, `templates_name_company`, `templates_address`, `templates_phone`, `templates_email`, `templates_name_on_account`, `templates_tel`, `templates_fax`, `templates_sign`, `templates_name_cfo`, `templates_tel_cfo`, `templates_extension_cfo`, `templates_email_cfo`) VALUES
(1, 'TUONG MINH SOFTWARE SOLUTIONS COMPANY LIMITED (TMA SOLUTIONS CO., LTD)', '111 Nguyen Dinh Chinh, Phu Nhuan Dist., Ho Chi Minh City, Vietnam', '+84 28 3997 8000', 'tma@tma.com.vn', 'TMA Solutions Co., LTD', '+84-28 38292288', '+84-28 38230530', 'Your sincerely', 'Pham Ngoc Nhu Duong', '  +84 28 3997 8000', ' 5211', 'pnnduong@tma.com.vn'),
(2, 'TUONG MINH SOFTWARE SOLUTIONS COMPANY LIMITED (TMA SOLUTIONS CO., LTD)', '111 Nguyen Dinh Chinh, Phu Nhuan Dist., Ho Chi Minh City, Vietnam', '+84 28 3997 8000', 'tma@tma.com.vn', 'TMA Solutions Co., LTD', '+84-28 38292288', '+84-28 38230530', 'Your sincerely', 'Pham Ngoc Nhu Duong', '+84 28 3997 8000', ' 5211', 'pnnduong@tma.com.vn'),
(3, 'TUONG MINH SOFTWARE SOLUTIONS COMPANY LIMITED (TMA SOLUTIONS CO., LTD)', '111 Nguyen Dinh Chinh, Phu Nhuan Dist., Ho Chi Minh City, Vietnam', '+84 28 3997 8000', 'tma@tma.com.vn', 'TMA Solutions Co., LTD', '+84-28 38292288', '+84-28 38230530', 'Your sincerely', 'Pham Ngoc Nhu Duong', '+84 28 3997 8000', ' 5211', 'pnnduong@tma.com.vn'),
(4, 'TUONG MINH SOFTWARE SOLUTIONS COMPANY LIMITED (TMA SOLUTIONS CO., LTD) abc', '111 Nguyen Dinh Chinh, Phu Nhuan Dist., Ho Chi Minh City, Vietnam', '+84 28 3997 8000', 'tma@tma.com.vn', 'TMA Solutions Co., LTD', '+84-28 38292288', '+84-28 38230530', 'Your sincerely', 'Pham Ngoc Nhu Duong', '+84 28 3997 8000', ' 5211', 'pnnduong@tma.com.vn'),
(5, 'TUONG MINH SOFTWARE SOLUTIONS COMPANY LIMITED (TMA SOLUTIONS CO., LTD)', '111 Nguyen Dinh Chinh, Phu Nhuan Dist., Ho Chi Minh City, Vietnam', '+84 28 3997 8000', 'tma@tma.com.vn', 'TMA Solutions Co., LTD', '+84-28 38292288', '+84-28 38230530', 'Your sincerely', 'Pham Ngoc Nhu Duong', '+84 28 3997 8000', ' 5211', 'pnnduong@tma.com.vn'),
(6, 'TUONG MINH SOFTWARE SOLUTIONS COMPANY LIMITED (TMA SOLUTIONS CO., LTD)', '111 Nguyen Dinh Chinh, Phu Nhuan Dist., Ho Chi Minh City, Vietnam', '+84 28 3997 80001', 'tma@tma.com.vn', 'TMA Solutions Co., LTD', '+84-28 38292288', '+84-28 38230530', 'Your sincerely', 'Pham Ngoc Nhu Duong', '+84 28 3997 8000', ' 5211', 'pnnduong@tma.com.vn'),
(7, 'TUONG MINH SOFTWARE SOLUTIONS COMPANY LIMITED (TMA SOLUTIONS CO., LTD)b', '111 Nguyen Dinh Chinh, Phu Nhuan Dist., Ho Chi Minh City, Vietnam b', '+84 28 3997 8000', 'tma@tma.com.vn', 'TMA Solutions Co., LTD', '+84-28 38292288', '+84-28 38230530', 'Your sincerely', 'Pham Ngoc Nhu Duong', '+84 28 3997 8000', ' 5211', 'pnnduong@tma.com.vn');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `templates_customer`
--

CREATE TABLE `templates_customer` (
  `templates_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `templates_name_company` varchar(100) CHARACTER SET utf8 NOT NULL,
  `templates_address` varchar(100) CHARACTER SET utf8 NOT NULL,
  `templates_phone` varchar(30) CHARACTER SET utf8 NOT NULL,
  `templates_email` varchar(100) CHARACTER SET utf8 NOT NULL,
  `templates_name_on_account` varchar(100) CHARACTER SET utf8 NOT NULL,
  `templates_tel` varchar(100) CHARACTER SET utf8 NOT NULL,
  `templates_fax` varchar(100) CHARACTER SET utf8 NOT NULL,
  `templates_sign` varchar(100) CHARACTER SET utf8 NOT NULL,
  `templates_name_cfo` varchar(100) CHARACTER SET utf8 NOT NULL,
  `templates_tel_cfo` varchar(100) CHARACTER SET utf8 NOT NULL,
  `templates_extension_cfo` varchar(100) CHARACTER SET utf8 NOT NULL,
  `templates_email_cfo` varchar(100) CHARACTER SET utf8 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Đang đổ dữ liệu cho bảng `templates_customer`
--

INSERT INTO `templates_customer` (`templates_id`, `customer_id`, `templates_name_company`, `templates_address`, `templates_phone`, `templates_email`, `templates_name_on_account`, `templates_tel`, `templates_fax`, `templates_sign`, `templates_name_cfo`, `templates_tel_cfo`, `templates_extension_cfo`, `templates_email_cfo`) VALUES
(1, 0, 'TUONG MINH SOFTWARE SOLUTIONS COMPANY LIMITED (TMA SOLUTIONS CO., LTD)', '111 Nguyen Dinh Chinh, Phu Nhuan Dist., Ho Chi Minh City, Vietnam', '+84 28 3997 8000', 'tma@tma.com.vn', 'TMA Solutions Co., LTD', '+84-28 38292288', '+84-28 38230530', 'Your sincerely', 'Pham Ngoc Nhu Duong', '+84 28 3997 8000', ' 5211', 'pnnduong@tma.com.vn'),
(2, 8, 'TUONG MINH SOFTWARE SOLUTIONS COMPANY LIMITED (TMA SOLUTIONS CO., LTD)aaa', '111 Nguyen Dinh Chinh, Phu Nhuan Dist., Ho Chi Minh City, Vietnam', '+84 28 3997 8000', 'tma@tma.com.vn', 'TMA Solutions Co., LTD', '+84-28 38292288', '+84-28 38230530', 'Your sincerely', 'Pham Ngoc Nhu Duong', '+84 28 3997 8000', ' 5211', 'pnnduong@tma.com.vn'),
(3, 15, 'TUONG MINH SOFTWARE SOLUTIONS COMPANY LIMITED (TMA SOLUTIONS CO., LTD)', '111 Nguyen Dinh Chinh, Phu Nhuan Dist., Ho Chi Minh City, Vietnam', '+84 28 3997 8000', 'tma@tma.com.vn', 'TMA Solutions Co., LTD', '+84-28 38292288', '+84-28 38230530', 'Your sincerely', 'Pham Ngoc Nhu Duong', '+84 28 3997 8000', ' 5211', 'pnnduong@tma.com.vn'),
(4, 11, 'TUONG MINH SOFTWARE SOLUTIONS COMPANY LIMITED (TMA SOLUTIONS CO., LTD)a', '111 Nguyen Dinh Chinh, Phu Nhuan Dist., Ho Chi Minh City, Vietnam a', '+84 28 3997 8000', 'tma@tma.com.vn', 'TMA Solutions Co., LTD', '+84-28 38292288', '+84-28 38230530', 'Your sincerely', 'Pham Ngoc Nhu Duong', '+84 28 3997 8000', ' 5211', 'pnnduong@tma.com.vn');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `user_fullname` varchar(100) CHARACTER SET utf8 NOT NULL,
  `user_email` varchar(50) DEFAULT NULL,
  `user_dateAdd` timestamp NOT NULL DEFAULT current_timestamp(),
  `user_username` varchar(100) CHARACTER SET utf8 NOT NULL,
  `user_password` varchar(60) CHARACTER SET utf8 NOT NULL,
  `role_id` int(11) NOT NULL,
  `groups_user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Đang đổ dữ liệu cho bảng `users`
--

INSERT INTO `users` (`user_id`, `user_fullname`, `user_email`, `user_dateAdd`, `user_username`, `user_password`, `role_id`, `groups_user_id`) VALUES
(1, 'Admin', 'admin@gmail.com', '2020-01-12 08:20:23', 'admin', '$2a$10$iOwTTWL7lEvQijYv7ilKi.Re150jRCw6CuiXQEcf4f6C23/Q4Fa9S', 1, 1),
(2, 'Nguyen Van A', 'nva@gmail.com', '2020-01-12 08:20:23', 'nva', '$2a$10$vxx8G64NYat253zNSd6TKeyOBN/IezliysWBUhq.tktvszFtAmjEq', 2, 2),
(4, 'Nguyễn Văn Đặng', 'nvb@gmail.com', '2020-01-12 08:20:23', 'nvb', '$2a$10$AzbIc7VeriXJgVfGdiX1b.pajnw4KW69xT1CNtpeX2a82aply1d1W', 2, 2),
(5, 'Tran Van C', 'tvc@gmail.com', '2020-01-12 08:20:23', 'tvc', '$2a$10$kWwCfFLJ4zPYRh8rhDQETuFfvsEcg8ZQC58X.RLZXoatQ5xQJt1mu', 2, 1),
(6, 'Senior Group 2', 'group2@gmail.com', '2020-01-12 08:20:23', 'group2', '$2a$10$tJ0pbvioym8Td7dh06LvzuNEEu.Bnrmnfehkxma6NqOvgjW/1BGSm', 3, 1),
(10, 'Le Thi E', 'lte@gmail.com', '2020-01-12 08:20:23', 'lte', '$2a$10$oEce.m9XM3eqCuZ7Lt0.Ke/Aod8Kc1vDQa6ClEBqYmVYMrjHeiR1i', 2, 1),
(11, 'Senior Group 1', 'group1@gmail.com', '2020-01-12 08:20:23', 'group1', '$2a$10$HIytnAM48PBpFI3RlYmRROs.JrUj.SywW4i5LhSi3.rEe9MU2p.SK', 3, 2),
(12, 'User 1', 'user1@gmail.com', '2020-01-12 18:15:51', 'user1', '$2a$10$Wtg9U4FweQU7Dq.HK4Sa8elCydCsHrIUK3uHZIHEi/BTwOIoP0woi', 2, 1),
(13, 'user2', 'user2@gmail.com', '2020-01-14 09:46:57', 'user2', '$2a$10$DPPkCb4pdWtm8aZZrSwxze.m33kE3RkJdktjivrlU3N3EQXs.gc4C', 2, 1),
(14, 'User 3', 'user3@gmail.com', '2020-01-14 09:49:33', 'user3', '$2a$10$KUD2pbXgwZkrnwdmc391I.6as5kJIzivrOrH8JG2RR2mz6tsHQt.W', 2, 2);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `users_customers`
--

CREATE TABLE `users_customers` (
  `users_customers` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Đang đổ dữ liệu cho bảng `users_customers`
--

INSERT INTO `users_customers` (`users_customers`, `user_id`, `customer_id`) VALUES
(1, 4, 8),
(2, 4, 9),
(3, 4, 10),
(4, 11, 11),
(5, 10, 12),
(6, 10, 13),
(7, 10, 14),
(8, 4, 15),
(9, 4, 16);

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `accounts_bank`
--
ALTER TABLE `accounts_bank`
  ADD PRIMARY KEY (`account_bank_id`);

--
-- Chỉ mục cho bảng `bills`
--
ALTER TABLE `bills`
  ADD PRIMARY KEY (`bill_id`),
  ADD KEY `customer_id` (`customer_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `status_bill_id` (`status_bill_id`),
  ADD KEY `account_bank_id` (`account_bank_id`),
  ADD KEY `templates_id` (`templates_id`);

--
-- Chỉ mục cho bảng `bill_items`
--
ALTER TABLE `bill_items`
  ADD PRIMARY KEY (`bill_item_id`),
  ADD KEY `bill_id` (`bill_id`);

--
-- Chỉ mục cho bảng `currencies`
--
ALTER TABLE `currencies`
  ADD PRIMARY KEY (`currency_id`);

--
-- Chỉ mục cho bảng `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`customer_id`),
  ADD KEY `customer_details_id` (`customer_details_id`);

--
-- Chỉ mục cho bảng `customer_details`
--
ALTER TABLE `customer_details`
  ADD PRIMARY KEY (`customer_details_id`);

--
-- Chỉ mục cho bảng `groups_user`
--
ALTER TABLE `groups_user`
  ADD PRIMARY KEY (`groups_user_id`);

--
-- Chỉ mục cho bảng `po_number`
--
ALTER TABLE `po_number`
  ADD PRIMARY KEY (`po_number_id`),
  ADD KEY `status_po_id` (`status_po_id`),
  ADD KEY `customer_id` (`customer_id`);

--
-- Chỉ mục cho bảng `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`role_id`);

--
-- Chỉ mục cho bảng `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`session_id`);

--
-- Chỉ mục cho bảng `status_bill`
--
ALTER TABLE `status_bill`
  ADD PRIMARY KEY (`status_bill_id`);

--
-- Chỉ mục cho bảng `status_po`
--
ALTER TABLE `status_po`
  ADD PRIMARY KEY (`status_po_id`);

--
-- Chỉ mục cho bảng `templates_bill`
--
ALTER TABLE `templates_bill`
  ADD PRIMARY KEY (`templates_id`);

--
-- Chỉ mục cho bảng `templates_customer`
--
ALTER TABLE `templates_customer`
  ADD PRIMARY KEY (`templates_id`);

--
-- Chỉ mục cho bảng `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD KEY `role_id` (`role_id`),
  ADD KEY `groups_user_id` (`groups_user_id`);

--
-- Chỉ mục cho bảng `users_customers`
--
ALTER TABLE `users_customers`
  ADD PRIMARY KEY (`users_customers`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `customer_id` (`customer_id`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `accounts_bank`
--
ALTER TABLE `accounts_bank`
  MODIFY `account_bank_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT cho bảng `bills`
--
ALTER TABLE `bills`
  MODIFY `bill_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- AUTO_INCREMENT cho bảng `bill_items`
--
ALTER TABLE `bill_items`
  MODIFY `bill_item_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT cho bảng `currencies`
--
ALTER TABLE `currencies`
  MODIFY `currency_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT cho bảng `customers`
--
ALTER TABLE `customers`
  MODIFY `customer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT cho bảng `customer_details`
--
ALTER TABLE `customer_details`
  MODIFY `customer_details_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT cho bảng `groups_user`
--
ALTER TABLE `groups_user`
  MODIFY `groups_user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT cho bảng `po_number`
--
ALTER TABLE `po_number`
  MODIFY `po_number_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT cho bảng `roles`
--
ALTER TABLE `roles`
  MODIFY `role_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT cho bảng `status_bill`
--
ALTER TABLE `status_bill`
  MODIFY `status_bill_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT cho bảng `status_po`
--
ALTER TABLE `status_po`
  MODIFY `status_po_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT cho bảng `templates_bill`
--
ALTER TABLE `templates_bill`
  MODIFY `templates_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT cho bảng `templates_customer`
--
ALTER TABLE `templates_customer`
  MODIFY `templates_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT cho bảng `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT cho bảng `users_customers`
--
ALTER TABLE `users_customers`
  MODIFY `users_customers` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `bills`
--
ALTER TABLE `bills`
  ADD CONSTRAINT `bills_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`),
  ADD CONSTRAINT `bills_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `bills_ibfk_3` FOREIGN KEY (`status_bill_id`) REFERENCES `status_bill` (`status_bill_id`),
  ADD CONSTRAINT `bills_ibfk_4` FOREIGN KEY (`account_bank_id`) REFERENCES `accounts_bank` (`account_bank_id`),
  ADD CONSTRAINT `bills_ibfk_5` FOREIGN KEY (`templates_id`) REFERENCES `templates_bill` (`templates_id`);

--
-- Các ràng buộc cho bảng `bill_items`
--
ALTER TABLE `bill_items`
  ADD CONSTRAINT `bill_items_ibfk_1` FOREIGN KEY (`bill_id`) REFERENCES `bills` (`bill_id`);

--
-- Các ràng buộc cho bảng `customers`
--
ALTER TABLE `customers`
  ADD CONSTRAINT `customers_ibfk_1` FOREIGN KEY (`customer_details_id`) REFERENCES `customer_details` (`customer_details_id`);

--
-- Các ràng buộc cho bảng `po_number`
--
ALTER TABLE `po_number`
  ADD CONSTRAINT `po_number_ibfk_1` FOREIGN KEY (`status_po_id`) REFERENCES `status_po` (`status_po_id`),
  ADD CONSTRAINT `po_number_ibfk_2` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`);

--
-- Các ràng buộc cho bảng `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`role_id`),
  ADD CONSTRAINT `users_ibfk_2` FOREIGN KEY (`groups_user_id`) REFERENCES `groups_user` (`groups_user_id`);

--
-- Các ràng buộc cho bảng `users_customers`
--
ALTER TABLE `users_customers`
  ADD CONSTRAINT `users_customers_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `users_customers_ibfk_2` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
