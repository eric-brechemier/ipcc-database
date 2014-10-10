CREATE DATABASE IF NOT EXISTS `giec`
DEFAULT CHARACTER SET utf8;

CREATE TABLE IF NOT EXISTS `assessment_reports` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `year` varchar(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `authors` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `author_departments` (
  `author_id` int(10) unsigned NOT NULL,
  `department_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`author_id`,`department_id`),
  KEY `author_departments_department_fk` (`department_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `author_institutions` (
  `author_id` int(10) unsigned NOT NULL,
  `institution_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`author_id`,`institution_id`),
  KEY `author_institutions_institution_fk` (`institution_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
  KEY `index_chairman_offices_department` (`department_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

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
  KEY `index_chapters_working_group` (`working_group_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `chapter_chapter_types` (
  `chapter_id` int(10) unsigned NOT NULL,
  `chapter_type_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`chapter_id`,`chapter_type_id`),
  KEY `index_chapter_chapter_types_chapter` (`chapter_id`),
  KEY `index_chapter_chapter_types_chapter_type` (`chapter_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `chapter_types` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `symbol` varchar(3) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `countries` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `departments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `institution_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_departments_institution` (`institution_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `groupings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `symbol` varchar(255) DEFAULT NULL,
  `country_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_groupings_country` (`country_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `groups` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `symbol` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `type` varchar(3) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `institutions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `country_id` int(10) unsigned NOT NULL,
  `type_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_institutions_country` (`country_id`),
  KEY `index_institutions_type` (`type_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `institution_types` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `symbol` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `participations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ar` int(11) DEFAULT NULL,
  `wg` int(11) DEFAULT NULL,
  `chapter` varchar(4) DEFAULT NULL,
  `role` varchar(4) DEFAULT NULL,
  `author_id` int(10) unsigned NOT NULL,
  `institution_id` int(10) unsigned DEFAULT NULL,
  `department_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_participations_ar` (`ar`),
  KEY `index_participations_wg` (`wg`),
  KEY `index_participations_chapter` (`chapter`),
  KEY `index_participations_role` (`role`),
  KEY `index_participations_author` (`author_id`),
  KEY `index_participations_institution` (`institution_id`),
  KEY `index_participations_department` (`department_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `roles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `symbol` varchar(4) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `rank` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `working_groups` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `number` int(11) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `assessment_report_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_working_groups_assessment_report` (`assessment_report_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

ALTER TABLE `author_departments`
  ADD CONSTRAINT `author_departments_author_fk`
    FOREIGN KEY (`author_id`)
    REFERENCES `authors` (`id`),
  ADD CONSTRAINT `author_departments_department_fk`
    FOREIGN KEY (`department_id`)
    REFERENCES `departments` (`id`);

ALTER TABLE `author_institutions`
  ADD CONSTRAINT `author_institutions_author_fk`
    FOREIGN KEY (`author_id`)
    REFERENCES `authors` (`id`),
  ADD CONSTRAINT `author_institutions_institution_fk`
    FOREIGN KEY (`institution_id`)
    REFERENCES `institutions` (`id`);

ALTER TABLE `chairman_offices`
  ADD CONSTRAINT `chairman_offices_department_fk`
    FOREIGN KEY (`department_id`)
    REFERENCES `departments` (`id`),
  ADD CONSTRAINT `chairman_offices_author_fk`
    FOREIGN KEY (`author_id`)
    REFERENCES `authors` (`id`),
  ADD CONSTRAINT `chairman_offices_institution_fk`
    FOREIGN KEY (`institution_id`)
    REFERENCES `institutions` (`id`);

ALTER TABLE `participations`
  ADD CONSTRAINT `participations_department_fk`
    FOREIGN KEY (`department_id`)
    REFERENCES `departments` (`id`),
  ADD CONSTRAINT `participations_author_fk`
    FOREIGN KEY (`author_id`)
    REFERENCES `authors` (`id`),
  ADD CONSTRAINT `participations_institution_fk`
    FOREIGN KEY (`institution_id`)
    REFERENCES `institutions` (`id`);

ALTER TABLE `working_groups`
  ADD CONSTRAINT `working_groups_assessment_report_fk`
  FOREIGN KEY (`assessment_report_id`)
  REFERENCES `assessment_reports` (`id`);
