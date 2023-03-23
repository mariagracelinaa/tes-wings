-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 23, 2023 at 09:54 AM
-- Server version: 10.4.22-MariaDB
-- PHP Version: 7.4.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `tes-wings`
--

-- --------------------------------------------------------

--
-- Table structure for table `mstbonus`
--

CREATE TABLE `mstbonus` (
  `ProdCode` varchar(8) NOT NULL,
  `BonusCode` varchar(8) NOT NULL,
  `QtySmall` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `mstbonus`
--

INSERT INTO `mstbonus` (`ProdCode`, `BonusCode`, `QtySmall`) VALUES
('GIVMR', 'GIVPT', 6),
('GIVPT', 'GIVMR', 6),
('SK1', 'PIRING', 1);

-- --------------------------------------------------------

--
-- Table structure for table `mstcustomer`
--

CREATE TABLE `mstcustomer` (
  `CustCode` varchar(8) NOT NULL,
  `CustName` varchar(30) DEFAULT NULL,
  `PriceType` int(11) DEFAULT NULL,
  `CustDisc` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `mstcustomer`
--

INSERT INTO `mstcustomer` (`CustCode`, `CustName`, `PriceType`, `CustDisc`) VALUES
('0001', 'Suka Makmur, PT', 0, 0),
('0002', 'Suka Maju, CV', 1, 0),
('0003', 'Suka Zuka, UD', 0, 1),
('0004', 'Maju Terus', 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `mstproduct`
--

CREATE TABLE `mstproduct` (
  `ProdCode` varchar(8) NOT NULL,
  `ProdName` varchar(30) DEFAULT NULL,
  `Content` int(11) DEFAULT NULL,
  `UMBig` varchar(6) DEFAULT NULL,
  `UMSmall` varchar(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `mstproduct`
--

INSERT INTO `mstproduct` (`ProdCode`, `ProdName`, `Content`, `UMBig`, `UMSmall`) VALUES
('GIVMR', 'Sabun GIV Merah', 72, 'DOS', 'PCS'),
('GIVPT', 'Sabun GIV Putih', 72, 'DOS', 'PCS'),
('PIRING', 'Hadiah Piring', 12, 'LSN', 'PCS'),
('SK1', 'Deterjen So Klin 1 Kg', 10, 'DOS', 'PCS'),
('SM40G', 'Mie Sedap Goreng', 40, 'DOS', 'PCS');

-- --------------------------------------------------------

--
-- Table structure for table `mstproductprice`
--

CREATE TABLE `mstproductprice` (
  `ProdCode` varchar(8) NOT NULL,
  `PriceType` int(11) NOT NULL,
  `DateFrom` datetime NOT NULL,
  `DateTo` datetime DEFAULT NULL,
  `UnitPrice` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `mstproductprice`
--

INSERT INTO `mstproductprice` (`ProdCode`, `PriceType`, `DateFrom`, `DateTo`, `UnitPrice`) VALUES
('GIVMR', 0, '2000-01-01 00:00:00', '2099-12-31 00:00:00', 10000),
('GIVMR', 1, '2000-01-01 00:00:00', '2099-12-31 00:00:00', 12000),
('GIVMR', 1, '2008-01-01 00:00:00', '2099-12-31 00:00:00', 14000),
('GIVPT', 0, '2000-01-01 00:00:00', '2099-12-31 00:00:00', 10000),
('GIVPT', 1, '2000-01-01 00:00:00', '2099-12-31 00:00:00', 12000),
('GIVPT', 1, '2008-01-01 00:00:00', '2099-12-31 00:00:00', 14000),
('PIRING', 0, '2000-01-01 00:00:00', '2099-12-31 00:00:00', 1000),
('PIRING', 1, '2000-01-01 00:00:00', '2099-12-31 00:00:00', 1500),
('SK1', 0, '2000-01-01 00:00:00', '2099-12-31 00:00:00', 9500),
('SK1', 1, '2000-01-01 00:00:00', '2099-12-31 00:00:00', 11500),
('SM40G', 0, '2000-01-01 00:00:00', '2099-12-31 00:00:00', 1500),
('SM40G', 1, '2000-01-01 00:00:00', '2099-12-31 00:00:00', 2000);

-- --------------------------------------------------------

--
-- Table structure for table `trxdtl`
--

CREATE TABLE `trxdtl` (
  `DocNo` varchar(10) NOT NULL,
  `ProdCode` varchar(8) NOT NULL,
  `QtyBig` int(11) DEFAULT NULL,
  `QtySmall` int(11) DEFAULT NULL,
  `UnitPrice` double DEFAULT NULL,
  `GrossPrice` double DEFAULT NULL,
  `BonusCode` varchar(8) DEFAULT NULL,
  `QtyBonus` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `trxdtl`
--

INSERT INTO `trxdtl` (`DocNo`, `ProdCode`, `QtyBig`, `QtySmall`, `UnitPrice`, `GrossPrice`, `BonusCode`, `QtyBonus`) VALUES
('DOC-1', 'GIVPT', 0, 5, 10000, 50000, NULL, NULL),
('DOC-1', 'SK1', NULL, 5, 9500, 47500, NULL, NULL),
('DOC-1', 'SM40G', NULL, 3, 1500, 4500, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `trxhdr`
--

CREATE TABLE `trxhdr` (
  `DocNo` varchar(10) NOT NULL,
  `CustCode` varchar(8) NOT NULL,
  `DocDate` datetime DEFAULT NULL,
  `Notes` varchar(100) DEFAULT NULL,
  `TotGross` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `trxhdr`
--

INSERT INTO `trxhdr` (`DocNo`, `CustCode`, `DocDate`, `Notes`, `TotGross`) VALUES
('DOC-1', '0001', '2023-03-23 14:04:58', 'Ambil di toko', 102000),
('DOC-2', '0002', '2023-03-23 14:04:58', NULL, 73200);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `mstbonus`
--
ALTER TABLE `mstbonus`
  ADD PRIMARY KEY (`ProdCode`,`BonusCode`),
  ADD KEY `fk_MstProduct_has_MstProduct_MstProduct2_idx` (`BonusCode`),
  ADD KEY `fk_MstProduct_has_MstProduct_MstProduct1_idx` (`ProdCode`);

--
-- Indexes for table `mstcustomer`
--
ALTER TABLE `mstcustomer`
  ADD PRIMARY KEY (`CustCode`);

--
-- Indexes for table `mstproduct`
--
ALTER TABLE `mstproduct`
  ADD PRIMARY KEY (`ProdCode`);

--
-- Indexes for table `mstproductprice`
--
ALTER TABLE `mstproductprice`
  ADD PRIMARY KEY (`ProdCode`,`PriceType`,`DateFrom`),
  ADD KEY `fk_MstProductPrice_MstProduct_idx` (`ProdCode`);

--
-- Indexes for table `trxdtl`
--
ALTER TABLE `trxdtl`
  ADD PRIMARY KEY (`DocNo`,`ProdCode`),
  ADD KEY `fk_TrxHdr_has_MstProduct_MstProduct1_idx` (`ProdCode`),
  ADD KEY `fk_TrxHdr_has_MstProduct_TrxHdr1_idx` (`DocNo`);

--
-- Indexes for table `trxhdr`
--
ALTER TABLE `trxhdr`
  ADD PRIMARY KEY (`DocNo`),
  ADD KEY `fk_TrxHdr_MstCustomer1_idx` (`CustCode`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `mstbonus`
--
ALTER TABLE `mstbonus`
  ADD CONSTRAINT `fk_MstProduct_has_MstProduct_MstProduct1` FOREIGN KEY (`ProdCode`) REFERENCES `mstproduct` (`ProdCode`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_MstProduct_has_MstProduct_MstProduct2` FOREIGN KEY (`BonusCode`) REFERENCES `mstproduct` (`ProdCode`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `mstproductprice`
--
ALTER TABLE `mstproductprice`
  ADD CONSTRAINT `fk_MstProductPrice_MstProduct` FOREIGN KEY (`ProdCode`) REFERENCES `mstproduct` (`ProdCode`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `trxdtl`
--
ALTER TABLE `trxdtl`
  ADD CONSTRAINT `fk_TrxHdr_has_MstProduct_MstProduct1` FOREIGN KEY (`ProdCode`) REFERENCES `mstproduct` (`ProdCode`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_TrxHdr_has_MstProduct_TrxHdr1` FOREIGN KEY (`DocNo`) REFERENCES `trxhdr` (`DocNo`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `trxhdr`
--
ALTER TABLE `trxhdr`
  ADD CONSTRAINT `fk_TrxHdr_MstCustomer1` FOREIGN KEY (`CustCode`) REFERENCES `mstcustomer` (`CustCode`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
