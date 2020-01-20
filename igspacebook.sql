/*
	Date: 1/17/20
	Author: Mike Mason
*/
START TRANSACTION;

CREATE DATABASE IF NOT EXISTS igspacebook;
USE igspacebook;

/* OPTIONAL DROPS */
DROP TABLE IF EXISTS `user_profile`;
DROP TABLE IF EXISTS `user`;
DROP TABLE IF EXISTS `user_role`;

/* CREATE TABLE: user_role */
CREATE TABLE IF NOT EXISTS `user_role`(
	
	/* User Role ID */
	user_role_id	TINYINT			NOT NULL	PRIMARY KEY
		COMMENT 'Primary key'
	,
	
	/* Role Description */
	role_desc		VARCHAR(20)		NOT NULL	UNIQUE
		COMMENT "A description of the alien user's role in the application"
	
)
	ENGINE 			= InnoDb,
	CHARACTER SET 	= utf8
	COLLATE			= utf8_bin	
;

/* POPULATE TABLE: user_role */
INSERT INTO `user_role`
	(user_role_id, role_desc)
VALUES
	 (1, 'User')
	,(2, 'Moderator')
	,(3, 'Site Admin')
	,(4, 'Master Admin')
;

/* CREATE TABLE: user */
DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user`(

	/* User ID */
	user_id			BIGINT			NOT NULL	PRIMARY KEY		AUTO_INCREMENT
		COMMENT 'Primary key'
	,
	
	/* Full Name */
	full_name		VARCHAR(75)		NOT NULL
		COMMENT 'The real, full name of the alien user'
		CHECK(full_name <> '')
	,
	
	/* Email Address */
	email			VARCHAR(255)	NOT NULL	UNIQUE
		COMMENT 'The email address which uniquely identifies the alien user on the application'
		CHECK(email <> '')
	,
	
	/* Password */
	passwd			CHAR(64)		NOT NULL
		COMMENT 'The hashed password of the user'
		CHECK(passwd <> '')
	,
	
	/* Salt used for hashing */
	salt			CHAR(64)		NOT NULL
		COMMENT 'The salt used to hash the password'
		CHECK(salt <> '')
	,
	
	/* User Role ID */
	user_role_id	TINYINT			NOT NULL	DEFAULT 1
		COMMENT 'Foreign key constraint referencing user_role.user_role_id'
	,
	
	/* FOREIGN KEYS */
	CONSTRAINT user_fk_user_role FOREIGN KEY (user_role_id)
		REFERENCES `user_role`(user_role_id)
		ON UPDATE CASCADE
		/*
			No ON UPDATE DELETE is on purpose...
			We don't want the comments of all users who 
			delete their accounts to disappear
		*/
)
	ENGINE 			= InnoDb,
	CHARACTER SET 	= utf8
	COLLATE			= utf8_general_ci
;

/* POPULATE TABLE: user */
/*
INSERT INTO `user`
	(full_name, display_name, email, passwd, user_role_id)
VALUES
	 ('Mike Mason', 'Xergii the Astrol', '')
	,()
;
*/

/* CREATE TABLE: user_profile */
DROP TABLE IF EXISTS `user_profile`; 
CREATE TABLE IF NOT EXISTS user_profile(

	/* User ID */
	user_id			BIGINT			NOT NULL	PRIMARY KEY
		COMMENT 'Primary key. Foreign key reference to user.user_id'
	,

	/* Display Name */
	display_name	VARCHAR(50)		NOT NULL
		COMMENT 'The display name, or alias, of the alien user, which may or may not be the same as their real name'
		CHECK(display_name <> '')
	,
	
	/* Tagline */
	tagline			VARCHAR(75)
		COMMENT '(Optional) A short tagline that summarizes the user'
	,
	
	/* Bio */
	bio				VARCHAR(1000)
		COMMENT '(Optional) A longer description, or biography, about the user'
	,
	
	/* Profile Photo */
	profile_photo	BLOB
		COMMENT '(Optional) A photo of the user'
	,
	
	/* Origin Galaxy Name */
	galaxy_name		VARCHAR(50)
		COMMENT '(Optional) Which galaxy the user is from'
	,
	
	/* Origin Solar System Name */
	solar_sys_name	VARCHAR(50)
		COMMENT '(Optional) Which solar system the user is from'
	,
	
	/* Origin Planet Name */
	planet_name		VARCHAR(50)
		COMMENT '(Optional) Which planet the user is from'
	,
	
	/* INDEXES */
	INDEX(galaxy_name),
	INDEX(solar_sys_name),
	INDEX(planet_name),
	INDEX(galaxy_name, solar_sys_name),
	INDEX(galaxy_name, solar_sys_name, planet_name),
	
	/* FOREIGN KEYS */
	CONSTRAINT user_profile_fk_user FOREIGN KEY (user_id)
		REFERENCES `user`(user_id)
)
	ENGINE 			= InnoDb,
	CHARACTER SET 	= utf8
	COLLATE			= utf8_general_ci
;

COMMIT;