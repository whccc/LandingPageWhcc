-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 11-01-2021 a las 15:36:37
-- Versión del servidor: 10.4.11-MariaDB
-- Versión de PHP: 7.4.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `tomaped`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_CreateCity` (IN `strDescriptionCity` VARCHAR(100), IN `intIdZoneCity` INT)  Begin
        insert into tblCity (strDescription,intIdZone) values(strDescriptionCity,intIdZoneCity);
    end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_CreateCustomer` (IN `strDocumentCustomer` VARCHAR(100), IN `strNameCustomer` VARCHAR(100), IN `strLastNameCustomer` VARCHAR(100), IN `strEmailCustomer` VARCHAR(100), IN `strPhoneCustomer` VARCHAR(100), IN `strAddressCustomer` VARCHAR(100), IN `intIdCityCustomer` INT)  Begin
	insert into tblcustomer 
    (strDocument,strName,strLastName,strEmail
    ,strPhone,strAddress,intIdCity)
    values (strDocumentCustomer,strNameCustomer,strLastNameCustomer,strEmailCustomer
       ,strPhoneCustomer,strAddressCustomer,intIdCityCustomer); 
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_CreateDetailOrder` (IN `intQuantityOrder` INT, IN `intTotalOrder` INT, IN `intPriceProduct` INT, IN `intIdProductOrder` VARCHAR(100), IN `intIdOrderP` INT)  begin

        insert into tblorderdetail(intQuantity,intTotal,intPriceProduct,intIdProduct,intIdOrder)
        values(intQuantityOrder,intTotalOrder,intPriceProduct,intIdProductOrder,intIdOrderP);

    end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_CreateOrder` (IN `strDocumentSeller` VARCHAR(100), IN `strDocumentCustomer` VARCHAR(100))  begin
         insert into tblorder(dtFechaInicio,intNumeroItems,strDescription,intIdCustomer,intIdUser,intIdStateOrder)
        values (now(),0,'',
        (select tblcustomer.intIdCustomer from tblcustomer where tblcustomer.strDocument=strDocumentCustomer),
        (select tbluser.intIdUser from tbluser where tbluser.strDocument=strDocumentSeller),2);
        
        select  tblorder.intIdOrder from tblorder order by  tblorder.intIdOrder desc limit 1;
    end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_CreateOrderState` (IN `strDescriptionOrderState` VARCHAR(100))  Begin   
        insert into tblstateorder(strDescription) values(strDescriptionOrderState);
    end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_CreateProduct` (IN `strIdProduct` VARCHAR(100), IN `strDescriptionProduct` VARCHAR(100), IN `intPriceProduct` INT)  begin

        insert into tblProduct(intIdProduct,strDescription,strPrice,dtEntry) values(strIdProduct,
        strDescriptionProduct,intPriceProduct,now());

    end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_CreateUser` (IN `strDocumentUser` VARCHAR(100), IN `strNameUser` VARCHAR(100), IN `strLastNameUser` VARCHAR(100), IN `strEmailUser` VARCHAR(100), IN `strPasswordUser` VARCHAR(100), IN `strPhoneUser` VARCHAR(100), IN `strAddressUser` VARCHAR(100), IN `intIdTypeUser` INT, IN `intIdZoneUser` INT)  Begin
	insert into tblUser 
    (strDocument,strName,strLastName,strEmail,
    strPassword,strPhone,strAddress,intIdTypeUser,intIdZone)
    
    values (strDocumentUser,strNameUser,strLastNameUser,strEmailUser,
    strPasswordUser,strPhoneUser,strAddressUser,intIdTypeUser,intIdZoneUser);
    
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_CreateUserType` (IN `strDescriptionUserType` VARCHAR(100))  Begin
    insert into tblTypeUser (strDescription) values(strDescriptionUserType); 
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_CreateZone` (IN `strDescriptionZone` VARCHAR(100))  Begin

    insert into tblZone (strDescription) values(strDescriptionZone);

end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_EditCity` (IN `intIdCityEdit` INT, IN `strDescriptionCity` VARCHAR(100), IN `intIdZoneCity` INT)  Begin

        update tblCity set strDescription=strDescriptionCity,intIdZone=intIdZoneCity
         where tblCity.intIdCity=intIdCityEdit;

    end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_EditCustomer` (IN `strDocumentCustomer` VARCHAR(100), IN `strNameCustomer` VARCHAR(100), IN `strLastNameCustomer` VARCHAR(100), IN `strEmailCustomer` VARCHAR(100), IN `strPhoneCustomer` VARCHAR(100), IN `strAddressCustomer` VARCHAR(100), IN `intIdCityCustomer` INT)  Begin
    update tblcustomer set strDocument=strDocumentCustomer,
                        strName=strNameCustomer,
                        strLastName=strLastName,
                        strEmail=strEmailCustomer,
                        strPhone=strPhoneCustomer,
                        strAddress=strAddressCustomer,
                        intIdCity=intIdCityCustomer
                        where tblcustomer.strDocument=strDocumentCustomer;
    end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_EditProduct` (IN `intIdProductEdit` VARCHAR(100), IN `strDescriptionProduct` VARCHAR(100), IN `strPriceProduct` VARCHAR(100))  begin

        update tblproduct set strDescription=strDescriptionProduct,strPrice=strPriceProduct
        where tblproduct.intIdProduct=intIdProductEdit;

    end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_EditSeller` (IN `strDocumentUser` VARCHAR(100), IN `strNameUser` VARCHAR(100), IN `strLastNameUser` VARCHAR(100), IN `strEmailUser` VARCHAR(100), IN `strPasswordUser` VARCHAR(100), IN `strPhoneUser` VARCHAR(100), IN `strAddressUser` VARCHAR(100), IN `intIdZoneUser` INT)  Begin
   update tblUser set strDocument=strDocumentUser,
                        strName=strNameUser,
                        strLastName=strLastName,
                        strEmail=strEmailUser,
                        strPassword=strPasswordUser,
                        strPhone=strPhoneUser,
                        strAddress=strAddressUser,
                        intIdZone=intIdZoneUser
                        where tbluser.strDocument=strDocumentUser;
    end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_EditZone` (IN `intIdZoneEdit` INT, IN `strDescriptionZone` VARCHAR(100))  Begin
    update tblZone set strDescription=strDescriptionZone where tblzone.intIdZone=intIdZoneEdit;
 end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_FinalOrder` (IN `intIdOrderUpdate` INT)  begin
        update tblorder set tblorder.intIdStateOrder=3 where tblorder.intIdOrder=intIdOrderUpdate;
    end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_GetProduct` (IN `intIdProductSearch` VARCHAR(100))  begin
         select tblproduct.intIdProduct,
         tblproduct.strDescription,tblproduct.strPrice from tblproduct
         where tblproduct.intIdProduct=intIdProductSearch;
    end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ListCities` ()  Begin
        select tblcity.intIdCity,tblcity.strDescription,tblzone.strDescription as 'strDescriptionZone'
         from tblCity inner join tblZone on tblZone.intIdZone=tblcity.intIdZone;
    end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ListCustomers` ()  Begin
        select 
			tblcustomer.strDocument,tblcustomer.strName,
            tblcustomer.strLastName,tblcustomer.strEmail,
            tblcustomer.strPhone,tblcustomer.strAddress,
            tblcity.strDescription as 'strDescriptionCity'
				from tblcustomer inner join tblcity on tblcity.intIdCity=tblcustomer.intIdCity;

    End$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ListOrdes` ()  begin
    SELECT tblorder.intIdOrder,SUBSTRING_INDEX(tblorder.dtFechaInicio,' ',1) as 'dtFechaInicio',
    concat(tbluser.strName,tbluser.strLastName) as 'strNameSeller',
concat(tblcustomer.strName,tblcustomer.strLastName) as 'strNameCustomer' FROM tomaped.tblorder
inner join tbluser on tbluser.intiduser=tblorder.intiduser
inner join tblcustomer on tblcustomer.intIdCustomer=tblorder.intIdCustomer;
End$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ListProducts` ()  begin
      select tblproduct.intIdProduct,
        tblproduct.strDescription,tblproduct.strPrice,SUBSTRING_INDEX(tblproduct.dtEntry,' ',1) as 'dtEntry' from tblproduct;
    end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ListSellers` ()  Begin
       select 
			tbluser.strDocument,tbluser.strName,
            tbluser.strLastName,tbluser.strEmail,tblUser.strPassword,
            tbluser.strPhone,tbluser.strAddress,
            tblzone.strDescription as 'strDescriptionZone',
            (select count(*) from tblorder where tblorder.intIdUser=tbluser.intIdUser) as 'NroPedidos'
				from tblUser inner join tblzone on tblzone.intIdZone=tbluser.intIdZone
        where tblUser.intIdTypeUser=2;
    End$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ListZones` ()  Begin

    select * from tblZone;

End$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Login` (IN `strDocumentLogin` VARCHAR(100), IN `strPasswordLogin` VARCHAR(100))  begin
	declare blnLogin varchar(20) default true;
    declare DataConsult varchar(20);
    set DataConsult=(select tbluser.strDocument from tbluser
    where tbluser.strDocument=strDocumentLogin and tbluser.strPassword=strPasswordLogin limit 1) ;
    if isnull(DataConsult) then
		set blnLogin=false;
		select blnLogin;
     else
           select blnLogin,tbluser.strDocument,tbluser.strName,tbluser.strLastName,
           tbluser.strEmail,tbluser.strPhone,tbluser.strAddress,tbluser.intIdZone,tbluser.intIdTypeUser,
           tbltypeuser.strdescription as 'strDescriptionTypeUser'
           from tbluser inner join  tbltypeuser on tbluser.intidtypeuser=tbltypeuser.intIdtypeuser
           where tbluser.strDocument=strDocumentLogin and tbluser.strPassword=strPasswordLogin limit 1;
    end if;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_NroUserCustomerOrder` ()  begin

        select (select count(*) from tbluser) as 'NroUsers',(select count(*) from tblcustomer) as 'NroCustomers',
(select count(*) from tblorder) as 'NroOrders';
    end$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblcity`
--

CREATE TABLE `tblcity` (
  `intIdCity` int(11) NOT NULL,
  `strDescription` varchar(100) DEFAULT NULL,
  `intIdZone` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tblcity`
--

INSERT INTO `tblcity` (`intIdCity`, `strDescription`, `intIdZone`) VALUES
(24, 'Medellín', 4),
(25, 'Cali', 6),
(26, 'Bogota', 6);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblcustomer`
--

CREATE TABLE `tblcustomer` (
  `intIdCustomer` int(11) NOT NULL,
  `strDocument` varchar(100) DEFAULT NULL,
  `strName` varchar(100) DEFAULT NULL,
  `strLastName` varchar(100) DEFAULT NULL,
  `strEmail` varchar(100) DEFAULT NULL,
  `strPhone` varchar(100) DEFAULT NULL,
  `strAddress` varchar(100) DEFAULT NULL,
  `intIdCity` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tblcustomer`
--

INSERT INTO `tblcustomer` (`intIdCustomer`, `strDocument`, `strName`, `strLastName`, `strEmail`, `strPhone`, `strAddress`, `intIdCity`) VALUES
(2, '26529344', 'Juan Camilo', 'Chica Castro', 'juancamilo@gmail.com', '3113608269', 'Cll 116 # 64 D - 06', 24),
(3, '123456', 'pablo', 'castro', 'pc@gmail.com', '3113608269', 'Cll 116 # 64 D - 06', 25);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblorder`
--

CREATE TABLE `tblorder` (
  `intIdOrder` int(11) NOT NULL,
  `dtFechaInicio` datetime DEFAULT NULL,
  `intNumeroItems` int(11) DEFAULT NULL,
  `strDescription` varchar(200) DEFAULT NULL,
  `intIdCustomer` int(11) DEFAULT NULL,
  `intIdUser` int(11) DEFAULT NULL,
  `intIdStateOrder` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tblorder`
--

INSERT INTO `tblorder` (`intIdOrder`, `dtFechaInicio`, `intNumeroItems`, `strDescription`, `intIdCustomer`, `intIdUser`, `intIdStateOrder`) VALUES
(102, '2020-11-09 00:39:56', 0, '', 2, 18, 3),
(103, '2020-11-09 15:20:18', 0, '', 3, 20, 3),
(104, '2020-11-09 15:21:31', 0, '', 2, 20, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblorderdetail`
--

CREATE TABLE `tblorderdetail` (
  `intIdOrderDetail` int(11) NOT NULL,
  `intQuantity` int(11) DEFAULT NULL,
  `intTotal` int(11) DEFAULT NULL,
  `intPriceProduct` int(11) DEFAULT NULL,
  `intIdProduct` varchar(200) DEFAULT NULL,
  `intIdOrder` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tblorderdetail`
--

INSERT INTO `tblorderdetail` (`intIdOrderDetail`, `intQuantity`, `intTotal`, `intPriceProduct`, `intIdProduct`, `intIdOrder`) VALUES
(14, 3, 6000, 2000, 'CA280', 102),
(15, 4, 13600, 3400, 'CA281', 102),
(16, 5, 20000, 4000, 'CA200', 103),
(17, 10, 20000, 2000, 'CA280', 103);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblproduct`
--

CREATE TABLE `tblproduct` (
  `intIdProduct` varchar(200) NOT NULL,
  `strDescription` varchar(100) DEFAULT NULL,
  `strPrice` int(11) DEFAULT NULL,
  `dtEntry` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tblproduct`
--

INSERT INTO `tblproduct` (`intIdProduct`, `strDescription`, `strPrice`, `dtEntry`) VALUES
('CA200', 'Barberia', 4000, '2020-11-09 15:17:29'),
('CA280', 'Maquillaje', 2000, '2020-11-09 00:36:04'),
('CA281', 'Maquillaje', 3400, '2020-11-09 00:37:02');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblstateorder`
--

CREATE TABLE `tblstateorder` (
  `intIdStateOrder` int(11) NOT NULL,
  `strDescription` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tblstateorder`
--

INSERT INTO `tblstateorder` (`intIdStateOrder`, `strDescription`) VALUES
(2, 'En proceso'),
(3, 'Finalizado');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbltypeuser`
--

CREATE TABLE `tbltypeuser` (
  `intIdTypeUser` int(11) NOT NULL,
  `strDescription` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tbltypeuser`
--

INSERT INTO `tbltypeuser` (`intIdTypeUser`, `strDescription`) VALUES
(1, 'Admin'),
(2, 'Seller');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbluser`
--

CREATE TABLE `tbluser` (
  `intIdUser` int(11) NOT NULL,
  `strDocument` varchar(100) DEFAULT NULL,
  `strName` varchar(100) DEFAULT NULL,
  `strLastName` varchar(100) DEFAULT NULL,
  `strEmail` varchar(100) DEFAULT NULL,
  `strPassword` varchar(100) DEFAULT NULL,
  `strPhone` varchar(100) DEFAULT NULL,
  `strAddress` varchar(100) DEFAULT NULL,
  `intIdTypeUser` int(11) DEFAULT NULL,
  `intIdZone` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tbluser`
--

INSERT INTO `tbluser` (`intIdUser`, `strDocument`, `strName`, `strLastName`, `strEmail`, `strPassword`, `strPhone`, `strAddress`, `intIdTypeUser`, `intIdZone`) VALUES
(1, '1020480253', 'wilson herney', 'castro cabrera', 'wilsoncastro@gmail.com', '123456', '3113608269', 'cll ', 1, 6),
(18, '4920307', 'marly esperanza', 'cabrera chavarro', 'm_cabrera@hotmail.com', '123456', '3113608269', 'Cll 116 # 64 D - 06', 2, 4),
(20, '123456', 'jean paul', 'castro cabrera', 'jp@hotmail.com', '123456', '3113608269', 'Cll 116 # 64 d 06', 2, 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblzone`
--

CREATE TABLE `tblzone` (
  `intIdZone` int(11) NOT NULL,
  `strDescription` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tblzone`
--

INSERT INTO `tblzone` (`intIdZone`, `strDescription`) VALUES
(4, 'Occidente'),
(6, 'Sur'),
(12, 'Norte');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `tblcity`
--
ALTER TABLE `tblcity`
  ADD PRIMARY KEY (`intIdCity`),
  ADD KEY `intIdZone` (`intIdZone`);

--
-- Indices de la tabla `tblcustomer`
--
ALTER TABLE `tblcustomer`
  ADD PRIMARY KEY (`intIdCustomer`),
  ADD KEY `intIdCity` (`intIdCity`);

--
-- Indices de la tabla `tblorder`
--
ALTER TABLE `tblorder`
  ADD PRIMARY KEY (`intIdOrder`),
  ADD KEY `intIdCustomer` (`intIdCustomer`),
  ADD KEY `intIdUser` (`intIdUser`),
  ADD KEY `intIdStateOrder` (`intIdStateOrder`);

--
-- Indices de la tabla `tblorderdetail`
--
ALTER TABLE `tblorderdetail`
  ADD PRIMARY KEY (`intIdOrderDetail`),
  ADD KEY `intIdOrder` (`intIdOrder`),
  ADD KEY `intIdProduct` (`intIdProduct`);

--
-- Indices de la tabla `tblproduct`
--
ALTER TABLE `tblproduct`
  ADD PRIMARY KEY (`intIdProduct`);

--
-- Indices de la tabla `tblstateorder`
--
ALTER TABLE `tblstateorder`
  ADD PRIMARY KEY (`intIdStateOrder`);

--
-- Indices de la tabla `tbltypeuser`
--
ALTER TABLE `tbltypeuser`
  ADD PRIMARY KEY (`intIdTypeUser`);

--
-- Indices de la tabla `tbluser`
--
ALTER TABLE `tbluser`
  ADD PRIMARY KEY (`intIdUser`),
  ADD KEY `intIdTypeUser` (`intIdTypeUser`),
  ADD KEY `intIdZone` (`intIdZone`);

--
-- Indices de la tabla `tblzone`
--
ALTER TABLE `tblzone`
  ADD PRIMARY KEY (`intIdZone`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `tblcity`
--
ALTER TABLE `tblcity`
  MODIFY `intIdCity` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT de la tabla `tblcustomer`
--
ALTER TABLE `tblcustomer`
  MODIFY `intIdCustomer` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `tblorder`
--
ALTER TABLE `tblorder`
  MODIFY `intIdOrder` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=105;

--
-- AUTO_INCREMENT de la tabla `tblorderdetail`
--
ALTER TABLE `tblorderdetail`
  MODIFY `intIdOrderDetail` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT de la tabla `tblstateorder`
--
ALTER TABLE `tblstateorder`
  MODIFY `intIdStateOrder` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `tbltypeuser`
--
ALTER TABLE `tbltypeuser`
  MODIFY `intIdTypeUser` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `tbluser`
--
ALTER TABLE `tbluser`
  MODIFY `intIdUser` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de la tabla `tblzone`
--
ALTER TABLE `tblzone`
  MODIFY `intIdZone` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `tblcity`
--
ALTER TABLE `tblcity`
  ADD CONSTRAINT `tblcity_ibfk_1` FOREIGN KEY (`intIdZone`) REFERENCES `tblzone` (`intIdZone`);

--
-- Filtros para la tabla `tblcustomer`
--
ALTER TABLE `tblcustomer`
  ADD CONSTRAINT `tblcustomer_ibfk_1` FOREIGN KEY (`intIdCity`) REFERENCES `tblcity` (`intIdCity`);

--
-- Filtros para la tabla `tblorder`
--
ALTER TABLE `tblorder`
  ADD CONSTRAINT `tblorder_ibfk_1` FOREIGN KEY (`intIdCustomer`) REFERENCES `tblcustomer` (`intIdCustomer`),
  ADD CONSTRAINT `tblorder_ibfk_2` FOREIGN KEY (`intIdUser`) REFERENCES `tbluser` (`intIdUser`),
  ADD CONSTRAINT `tblorder_ibfk_3` FOREIGN KEY (`intIdStateOrder`) REFERENCES `tblstateorder` (`intIdStateOrder`);

--
-- Filtros para la tabla `tblorderdetail`
--
ALTER TABLE `tblorderdetail`
  ADD CONSTRAINT `tblorderdetail_ibfk_1` FOREIGN KEY (`intIdOrder`) REFERENCES `tblorder` (`intIdOrder`),
  ADD CONSTRAINT `tblorderdetail_ibfk_2` FOREIGN KEY (`intIdProduct`) REFERENCES `tblproduct` (`intIdProduct`);

--
-- Filtros para la tabla `tbluser`
--
ALTER TABLE `tbluser`
  ADD CONSTRAINT `tbluser_ibfk_1` FOREIGN KEY (`intIdTypeUser`) REFERENCES `tbltypeuser` (`intIdTypeUser`),
  ADD CONSTRAINT `tbluser_ibfk_2` FOREIGN KEY (`intIdZone`) REFERENCES `tblzone` (`intIdZone`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
