CREATE DATABASE IF NOT EXISTS `ipcc`
DEFAULT CHARACTER SET utf8
;

USE `ipcc`

CREATE TABLE IF NOT EXISTS `authors` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;

CREATE TABLE IF NOT EXISTS `author_aliases` (
  `alias` varchar(255) PRIMARY KEY
    COMMENT 'main or alternate form of author full name, including misspellings',
  `author_id` int(10) REFERENCES `authors` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;

CREATE TABLE IF NOT EXISTS `institution_types` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `symbol` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;

CREATE TABLE IF NOT EXISTS `institutions` (
  `id` int(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(255) DEFAULT NULL,
  `institution_type_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `institutions_type_fk` (`institution_type_id`),
  CONSTRAINT `institutions_type_fk`
    FOREIGN KEY (`institution_type_id`)
    REFERENCES `institution_types` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;

CREATE TABLE IF NOT EXISTS `institution_aliases` (
  `alias` varchar(255) PRIMARY KEY
    COMMENT
    'main or alternate form of institution name, including misspellings',
  `institution_id` int(10) REFERENCES `institutions` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;

CREATE TABLE IF NOT EXISTS `countries` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;

CREATE TABLE IF NOT EXISTS `country_aliases` (
  `alias` varchar(255) PRIMARY KEY
    COMMENT
    'main or alternate form of country name, including misspellings',
  `country_id` int(10) REFERENCES `countries` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;

CREATE TABLE IF NOT EXISTS `groups` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `symbol` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `type` varchar(3) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;

CREATE TABLE IF NOT EXISTS `groupings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `symbol` varchar(255) DEFAULT NULL,
  `country_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_groupings_country` (`country_id`),
  CONSTRAINT `groupings_country_fk`
    FOREIGN KEY (`country_id`)
    REFERENCES `countries` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;

CREATE TABLE IF NOT EXISTS `institution_countries` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `institution_id` int(10) DEFAULT NULL,
  `country_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_institutions_country` (`country_id`),
  CONSTRAINT `institutions_country_fk`
    FOREIGN KEY (`country_id`)
    REFERENCES `countries` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;

CREATE TABLE IF NOT EXISTS `author_institutions` (
  `author_id` int(10) unsigned NOT NULL,
  `institution_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`author_id`,`institution_id`),
  KEY `author_institutions_institution_fk` (`institution_id`),
  CONSTRAINT `author_institutions_author_fk`
    FOREIGN KEY (`author_id`)
    REFERENCES `authors` (`id`),
  CONSTRAINT `author_institutions_institution_fk`
    FOREIGN KEY (`institution_id`)
    REFERENCES `institution_countries` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;

CREATE TABLE IF NOT EXISTS `departments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `institution_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_departments_institution` (`institution_id`),
  CONSTRAINT `departments_institution_fk`
    FOREIGN KEY (`institution_id`)
    REFERENCES `institution_countries` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;

CREATE TABLE IF NOT EXISTS `author_departments` (
  `author_id` int(10) unsigned NOT NULL,
  `department_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`author_id`,`department_id`),
  KEY `author_departments_department_fk` (`department_id`),
  CONSTRAINT `author_departments_author_fk`
    FOREIGN KEY (`author_id`)
    REFERENCES `authors` (`id`),
  CONSTRAINT `author_departments_department_fk`
    FOREIGN KEY (`department_id`)
    REFERENCES `departments` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;

CREATE TABLE IF NOT EXISTS `chairman_offices` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ar` int(11) DEFAULT NULL,
  `wg` int(11) DEFAULT NULL,
  `role` varchar(255) DEFAULT NULL,
  `rank` int(11) DEFAULT NULL,
  `author_id` int(10) unsigned NOT NULL,
  `institution_id` int(10) unsigned DEFAULT NULL,
  `department_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_chairman_offices_ar` (`ar`),
  KEY `index_chairman_offices_wg` (`wg`),
  KEY `index_chairman_offices_rank` (`rank`),
  KEY `index_chairman_offices_author` (`author_id`),
  KEY `index_chairman_offices_institution` (`institution_id`),
  KEY `index_chairman_offices_department` (`department_id`),
  CONSTRAINT `chairman_offices_author_fk`
    FOREIGN KEY (`author_id`)
    REFERENCES `authors` (`id`),
  CONSTRAINT `chairman_offices_department_fk`
    FOREIGN KEY (`department_id`)
    REFERENCES `departments` (`id`),
  CONSTRAINT `chairman_offices_institution_fk`
    FOREIGN KEY (`institution_id`)
    REFERENCES `institution_countries` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;

CREATE TABLE IF NOT EXISTS `assessment_reports` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `year` varchar(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;

CREATE TABLE IF NOT EXISTS `working_groups` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `number` int(11) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `assessment_report_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_working_groups_assessment_report` (`assessment_report_id`),
  CONSTRAINT `working_groups_assessment_report_fk`
    FOREIGN KEY (`assessment_report_id`)
    REFERENCES `assessment_reports` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;
CREATE TABLE IF NOT EXISTS `chapters` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `number` varchar(4) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `wg` int(11) DEFAULT NULL,
  `ar` int(11) DEFAULT NULL,
  `assessment_report_id` int(10) unsigned NOT NULL,
  `working_group_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_chapters_assessment_report` (`assessment_report_id`),
  KEY `index_chapters_working_group` (`working_group_id`),
  CONSTRAINT `chapters_assessment_report_fk`
    FOREIGN KEY (`assessment_report_id`)
    REFERENCES `assessment_reports` (`id`),
  CONSTRAINT `chapters_working_group_fk`
    FOREIGN KEY (`working_group_id`)
    REFERENCES `working_groups` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;

CREATE TABLE IF NOT EXISTS `chapter_types` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `symbol` varchar(3) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;

CREATE TABLE IF NOT EXISTS `chapter_chapter_types` (
  `chapter_id` int(10) unsigned NOT NULL,
  `chapter_type_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`chapter_id`,`chapter_type_id`),
  KEY `index_chapter_chapter_types_chapter` (`chapter_id`),
  KEY `index_chapter_chapter_types_chapter_type` (`chapter_type_id`),
  CONSTRAINT `chapter_chapter_types_chapter_fk`
    FOREIGN KEY (`chapter_id`)
    REFERENCES `chapters` (`id`),
  CONSTRAINT `chapter_chapter_types_chapter_type_fk`
    FOREIGN KEY (`chapter_type_id`)
    REFERENCES `chapter_types` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;

CREATE TABLE IF NOT EXISTS `roles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `symbol` varchar(4) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `rank` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;

CREATE TABLE IF NOT EXISTS `participations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ar` int(11) DEFAULT NULL,
  `wg` int(11) DEFAULT NULL,
  `chapter` varchar(4) DEFAULT NULL,
  `role` varchar(4) DEFAULT NULL,
  `author_id` int(10) unsigned NOT NULL,
  `institution_country_id` int(10) DEFAULT NULL,
  `department_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_participations_ar` (`ar`),
  KEY `index_participations_wg` (`wg`),
  KEY `index_participations_chapter` (`chapter`),
  KEY `index_participations_role` (`role`),
  KEY `index_participations_author` (`author_id`),
  KEY `index_participations_institution` (`institution_country_id`),
  KEY `index_participations_department` (`department_id`),
  CONSTRAINT `participations_author_fk`
    FOREIGN KEY (`author_id`)
    REFERENCES `authors` (`id`),
  CONSTRAINT `participations_department_fk`
    FOREIGN KEY (`department_id`)
    REFERENCES `departments` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;
