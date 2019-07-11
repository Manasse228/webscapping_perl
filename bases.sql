CREATE TABLE IF NOT EXISTS `console` (
  `ID` int(11) NOT NULL,
  `Heure` varchar(10) NOT NULL,
  `Date` varchar(10) NOT NULL,
  `NomScript` varchar(20) NOT NULL,
  `Operation` varchar(255) NOT NULL,
  `Temps` varchar(10) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=8505 DEFAULT CHARSET=latin1;




CREATE TABLE IF NOT EXISTS `datatest` (
  `id` int(11) NOT NULL,
  `Registrar` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `Nomdom` varchar(75) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `Expiration` varchar(12) DEFAULT NULL,
  `Creation` varchar(12) DEFAULT NULL,
  `Miseajour` varchar(12) DEFAULT NULL,
  `Type` varchar(35) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `Organisation` varchar(155) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `Nom` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `Prenom` varchar(100) CHARACTER SET utf32 COLLATE utf32_unicode_ci DEFAULT NULL,
  `Adresse` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `CP` int(10) DEFAULT NULL,
  `Ville` varchar(150) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `Tel` varchar(20) DEFAULT NULL,
  `Mail` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `DateInsert` varchar(12) DEFAULT NULL,
  `Adminemail` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `Techemail` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `IP` varchar(15) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `NS1` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `NA_Answer` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `Keywords` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `Mail02` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=21537 DEFAULT CHARSET=latin1;


CREATE TABLE IF NOT EXISTS `mutastats` (
  `Id` int(11) NOT NULL,
  `DateJour` varchar(11) DEFAULT NULL,
  `TotalDom` int(11) DEFAULT NULL,
  `FR` int(11) DEFAULT NULL,
  `FR_stat` decimal(3,1) DEFAULT NULL,
  `COM` int(11) DEFAULT NULL,
  `COM_stat` decimal(3,1) DEFAULT NULL,
  `Autres` int(11) DEFAULT NULL,
  `Autres_stat` decimal(3,1) DEFAULT NULL,
  `CORP` int(11) DEFAULT NULL,
  `CORP_stat` decimal(3,1) NOT NULL,
  `PERSON` int(11) NOT NULL,
  `PERS_stat` decimal(3,1) DEFAULT NULL,
  `ESTIM` decimal(10,0) DEFAULT NULL,
  `moyj` double DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=150 DEFAULT CHARSET=latin1;


CREATE TABLE IF NOT EXISTS `listeplugs` (
  `id` int(11) NOT NULL,
  `chemin` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `nom` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `version` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
