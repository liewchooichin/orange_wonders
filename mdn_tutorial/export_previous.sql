BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "django_migrations" (
	"id"	integer NOT NULL,
	"app"	varchar(255) NOT NULL,
	"name"	varchar(255) NOT NULL,
	"applied"	datetime NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_group_permissions" (
	"id"	integer NOT NULL,
	"group_id"	integer NOT NULL,
	"permission_id"	integer NOT NULL,
	FOREIGN KEY("group_id") REFERENCES "auth_group"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("permission_id") REFERENCES "auth_permission"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_user_groups" (
	"id"	integer NOT NULL,
	"user_id"	integer NOT NULL,
	"group_id"	integer NOT NULL,
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("group_id") REFERENCES "auth_group"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_user_user_permissions" (
	"id"	integer NOT NULL,
	"user_id"	integer NOT NULL,
	"permission_id"	integer NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("permission_id") REFERENCES "auth_permission"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "django_admin_log" (
	"id"	integer NOT NULL,
	"object_id"	text,
	"object_repr"	varchar(200) NOT NULL,
	"action_flag"	smallint unsigned NOT NULL CHECK("action_flag" >= 0),
	"change_message"	text NOT NULL,
	"content_type_id"	integer,
	"user_id"	integer NOT NULL,
	"action_time"	datetime NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("content_type_id") REFERENCES "django_content_type"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "django_content_type" (
	"id"	integer NOT NULL,
	"app_label"	varchar(100) NOT NULL,
	"model"	varchar(100) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_permission" (
	"id"	integer NOT NULL,
	"content_type_id"	integer NOT NULL,
	"codename"	varchar(100) NOT NULL,
	"name"	varchar(255) NOT NULL,
	FOREIGN KEY("content_type_id") REFERENCES "django_content_type"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_group" (
	"id"	integer NOT NULL,
	"name"	varchar(150) NOT NULL UNIQUE,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_user" (
	"id"	integer NOT NULL,
	"password"	varchar(128) NOT NULL,
	"last_login"	datetime,
	"is_superuser"	bool NOT NULL,
	"username"	varchar(150) NOT NULL UNIQUE,
	"last_name"	varchar(150) NOT NULL,
	"email"	varchar(254) NOT NULL,
	"is_staff"	bool NOT NULL,
	"is_active"	bool NOT NULL,
	"date_joined"	datetime NOT NULL,
	"first_name"	varchar(150) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "django_session" (
	"session_key"	varchar(40) NOT NULL,
	"session_data"	text NOT NULL,
	"expire_date"	datetime NOT NULL,
	PRIMARY KEY("session_key")
);
CREATE TABLE IF NOT EXISTS "book_catalog_author" (
	"id"	integer NOT NULL,
	"first_name"	varchar(100) NOT NULL,
	"last_name"	varchar(100) NOT NULL,
	"date_of_birth"	date,
	"date_of_death"	date,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "book_catalog_genre" (
	"id"	integer NOT NULL,
	"name"	varchar(200) NOT NULL UNIQUE,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "book_catalog_book" (
	"id"	integer NOT NULL,
	"title"	varchar(200) NOT NULL,
	"summary"	text NOT NULL,
	"isbn"	varchar(13) NOT NULL UNIQUE,
	"author_id"	bigint,
	"language_id"	bigint,
	FOREIGN KEY("language_id") REFERENCES "book_catalog_language"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("author_id") REFERENCES "book_catalog_author"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "book_catalog_bookinstance" (
	"id"	char(32) NOT NULL,
	"imprint"	varchar(200) NOT NULL,
	"due_back"	date,
	"status"	varchar(1) NOT NULL,
	"book_id"	bigint,
	FOREIGN KEY("book_id") REFERENCES "book_catalog_book"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id")
);
CREATE TABLE IF NOT EXISTS "book_catalog_book_genre" (
	"id"	integer NOT NULL,
	"book_id"	bigint NOT NULL,
	"genre_id"	bigint NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("genre_id") REFERENCES "book_catalog_genre"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("book_id") REFERENCES "book_catalog_book"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "book_user_bookuser" (
	"BookUserId"	integer NOT NULL,
	"BookUserEmail"	varchar(64),
	"BookUserGroup"	smallint unsigned NOT NULL CHECK("BookUserGroup" >= 0),
	"BookUserValidityDate"	date NOT NULL,
	"BookUserName"	varchar(64) NOT NULL UNIQUE,
	PRIMARY KEY("BookUserId" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "book_catalog_language" (
	"id"	integer NOT NULL,
	"notes"	text,
	"name"	varchar(200) NOT NULL UNIQUE,
	PRIMARY KEY("id" AUTOINCREMENT)
);
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (1,'contenttypes','0001_initial','2024-06-16 08:53:47.203778'),
 (2,'auth','0001_initial','2024-06-16 08:53:47.442697'),
 (3,'admin','0001_initial','2024-06-16 08:53:47.627035'),
 (4,'admin','0002_logentry_remove_auto_add','2024-06-16 08:53:47.727657'),
 (5,'admin','0003_logentry_add_action_flag_choices','2024-06-16 08:53:47.845932'),
 (6,'contenttypes','0002_remove_content_type_name','2024-06-16 08:53:47.931632'),
 (7,'auth','0002_alter_permission_name_max_length','2024-06-16 08:53:48.036057'),
 (8,'auth','0003_alter_user_email_max_length','2024-06-16 08:53:48.142886'),
 (9,'auth','0004_alter_user_username_opts','2024-06-16 08:53:48.268071'),
 (10,'auth','0005_alter_user_last_login_null','2024-06-16 08:53:48.369913'),
 (11,'auth','0006_require_contenttypes_0002','2024-06-16 08:53:48.451314'),
 (12,'auth','0007_alter_validators_add_error_messages','2024-06-16 08:53:48.527278'),
 (13,'auth','0008_alter_user_username_max_length','2024-06-16 08:53:48.601699'),
 (14,'auth','0009_alter_user_last_name_max_length','2024-06-16 08:53:48.694151'),
 (15,'auth','0010_alter_group_name_max_length','2024-06-16 08:53:48.783737'),
 (16,'auth','0011_update_proxy_permissions','2024-06-16 08:53:48.880424'),
 (17,'auth','0012_alter_user_first_name_max_length','2024-06-16 08:53:48.963185'),
 (18,'sessions','0001_initial','2024-06-16 08:53:49.134536'),
 (19,'book_user','0001_initial','2024-06-16 09:18:39.275612'),
 (20,'book_catalog','0001_initial','2024-06-16 11:50:09.682823'),
 (21,'book_user','0002_alter_bookuser_bookusername','2024-06-16 11:50:09.761458'),
 (22,'book_catalog','0002_language_and_more','2024-06-16 13:23:34.652402'),
 (23,'book_catalog','0003_book_language_alter_language_name_and_more','2024-06-17 03:06:26.752491');
INSERT INTO "django_admin_log" ("id","object_id","object_repr","action_flag","change_message","content_type_id","user_id","action_time") VALUES (1,'1','Tragedies',1,'[{"added": {}}]',9,1,'2024-06-16 14:35:27.909207'),
 (2,'2','Sea stories',1,'[{"added": {}}]',9,1,'2024-06-16 14:36:12.285076'),
 (3,'3','Adventure stories',1,'[{"added": {}}]',9,1,'2024-06-16 14:36:20.982285'),
 (4,'4','Love stories',1,'[{"added": {}}]',9,1,'2024-06-16 14:36:41.128974'),
 (5,'5','Social classes',1,'[{"added": {}}]',9,1,'2024-06-16 14:37:15.514235'),
 (6,'6','England',1,'[{"added": {}}]',9,1,'2024-06-16 14:37:25.135361'),
 (7,'7','City and town life',1,'[{"added": {}}]',9,1,'2024-06-16 14:37:57.948544'),
 (8,'8','Didactic fiction',1,'[{"added": {}}]',9,1,'2024-06-16 14:38:05.464823'),
 (9,'1','William, Shakespeare',1,'[{"added": {}}]',8,1,'2024-06-16 14:41:37.585421'),
 (10,'2','Melville, Herman',1,'[{"added": {}}]',8,1,'2024-06-16 14:43:01.362917'),
 (11,'3','Austen, Jane',1,'[{"added": {}}]',8,1,'2024-06-16 14:44:09.204404'),
 (12,'4','Eliot, George',1,'[{"added": {}}]',8,1,'2024-06-16 14:45:22.380815'),
 (13,'5','Forster, E. M.',1,'[{"added": {}}]',8,1,'2024-06-16 14:46:44.207615'),
 (14,'9','Travel literature',1,'[{"added": {}}]',9,1,'2024-06-16 14:46:58.311218'),
 (15,'10','Manners',1,'[{"added": {}}]',9,1,'2024-06-16 14:47:12.007978'),
 (16,'1','en',1,'[{"added": {}}]',12,1,'2024-06-16 14:47:52.139525'),
 (17,'1','Romeo and Juliet',1,'[{"added": {}}]',10,1,'2024-06-16 14:50:47.244131'),
 (18,'2','Moby Dick',1,'[{"added": {}}]',10,1,'2024-06-16 14:51:52.562363'),
 (19,'3','Pride and prejudice',1,'[{"added": {}}]',10,1,'2024-06-16 14:52:59.524685'),
 (20,'4','Middlemarch',1,'[{"added": {}}]',10,1,'2024-06-16 14:54:24.101307'),
 (21,'5','A room with a view',1,'[{"added": {}}]',10,1,'2024-06-16 14:56:11.326234'),
 (22,'5','A room with a view',2,'[{"changed": {"fields": ["Genre"]}}]',10,1,'2024-06-16 14:56:57.614631'),
 (23,'f2fbdcd7-dd16-4e65-bdd4-b4ef19a69165','f2fbdcd7-dd16-4e65-bdd4-b4ef19a69165 (Romeo and Juliet)',1,'[{"added": {}}]',11,1,'2024-06-16 14:58:22.704194'),
 (24,'d8cc41f5-827c-4c2c-9a51-4ee2e4d91fd5','d8cc41f5-827c-4c2c-9a51-4ee2e4d91fd5 (Romeo and Juliet)',1,'[{"added": {}}]',11,1,'2024-06-16 14:58:43.669740'),
 (25,'098865df-8662-43fc-aa91-e5de62c3b705','098865df-8662-43fc-aa91-e5de62c3b705 (Moby Dick)',1,'[{"added": {}}]',11,1,'2024-06-16 14:59:26.431666'),
 (26,'f875fecb-b5b0-4ef8-a8f3-ef220e07c0da','f875fecb-b5b0-4ef8-a8f3-ef220e07c0da (Moby Dick)',1,'[{"added": {}}]',11,1,'2024-06-16 14:59:40.057272'),
 (27,'c6f32a17-4276-4907-9c65-ee0c3ae38115','c6f32a17-4276-4907-9c65-ee0c3ae38115 (Pride and prejudice)',1,'[{"added": {}}]',11,1,'2024-06-16 15:00:07.799315'),
 (28,'f2f79d9b-4015-4aa4-b396-afaf0d3dd789','f2f79d9b-4015-4aa4-b396-afaf0d3dd789 (Pride and prejudice)',1,'[{"added": {}}]',11,1,'2024-06-16 15:00:23.182961'),
 (29,'9869e717-69fb-4da5-b07b-6b46bbb7430b','9869e717-69fb-4da5-b07b-6b46bbb7430b (Middlemarch)',1,'[{"added": {}}]',11,1,'2024-06-16 15:00:56.328134'),
 (30,'badf0c1b-7f15-4476-b63c-029fe0143679','badf0c1b-7f15-4476-b63c-029fe0143679 (Middlemarch)',1,'[{"added": {}}]',11,1,'2024-06-16 15:01:09.043558'),
 (31,'f0e74700-5fa9-4e0a-a58a-5f47b89c6c62','f0e74700-5fa9-4e0a-a58a-5f47b89c6c62 (A room with a view)',1,'[{"added": {}}]',11,1,'2024-06-16 15:01:25.062574'),
 (32,'537467e9-826b-4ac7-b86f-c74f5f0af7d4','537467e9-826b-4ac7-b86f-c74f5f0af7d4 (A room with a view)',1,'[{"added": {}}]',11,1,'2024-06-16 15:01:41.886566'),
 (33,'5','A room with a view',2,'[]',10,1,'2024-06-16 15:02:36.396353'),
 (34,'1','Old English',2,'[{"changed": {"fields": ["Language"]}}]',12,1,'2024-06-17 03:08:44.858508'),
 (35,'2','Modern English',1,'[{"added": {}}]',12,1,'2024-06-17 03:09:38.959088'),
 (36,'5','A room with a view',2,'[{"changed": {"fields": ["Language"]}}]',10,1,'2024-06-17 03:10:30.788446'),
 (37,'4','Middlemarch',2,'[{"changed": {"fields": ["Language"]}}]',10,1,'2024-06-17 03:10:42.947680'),
 (38,'3','Pride and prejudice',2,'[{"changed": {"fields": ["Language"]}}]',10,1,'2024-06-17 03:10:50.143639'),
 (39,'2','Moby Dick',2,'[{"changed": {"fields": ["Language"]}}]',10,1,'2024-06-17 03:10:57.916626'),
 (40,'1','Romeo and Juliet',2,'[{"changed": {"fields": ["Language"]}}]',10,1,'2024-06-17 03:11:27.350270'),
 (41,'6','Smollet, T',1,'[{"added": {}}]',8,1,'2024-06-17 03:14:06.831444'),
 (42,'6','The Adventures of Ferdinand Count Fathom — Complete',1,'[{"added": {}}]',10,1,'2024-06-17 03:16:16.165632'),
 (43,'6','The Adventures of Ferdinand Count Fathom',2,'[{"changed": {"fields": ["Title"]}}]',10,1,'2024-06-17 03:16:44.778072'),
 (44,'25bc1526-b76e-4752-83f2-d1c448a10a13','25bc1526-b76e-4752-83f2-d1c448a10a13 (The Adventures of Ferdinand Count Fathom)',1,'[{"added": {}}]',11,1,'2024-06-17 13:54:28.843319'),
 (45,'f65ee015-2bb7-4e92-a3a1-25b61c9b6428','f65ee015-2bb7-4e92-a3a1-25b61c9b6428 (The Adventures of Ferdinand Count Fathom)',1,'[{"added": {}}]',11,1,'2024-06-17 13:54:51.601272'),
 (46,'25bc1526-b76e-4752-83f2-d1c448a10a13','25bc1526-b76e-4752-83f2-d1c448a10a13 (The Adventures of Ferdinand Count Fathom)',2,'[{"changed": {"fields": ["Status"]}}]',11,1,'2024-06-17 13:55:02.745798'),
 (47,'2','Moby Dick',2,'[{"added": {"name": "book instance", "object": "Moby Dick (661f3c2d-dbf3-411d-be43-3aefedb068fb)"}}]',10,1,'2024-06-17 14:31:51.221012'),
 (48,'2','Moby Dick',2,'[{"added": {"name": "book instance", "object": "Moby Dick (6bb9e1be-1f19-46dc-adb9-46889582a61d)"}}]',10,1,'2024-06-17 14:32:13.649922'),
 (49,'5','A room with a view',2,'[{"added": {"name": "book instance", "object": "A room with a view (25b645eb-b057-4cf4-ad5d-04639dc1b900)"}}, {"added": {"name": "book instance", "object": "A room with a view (241a671a-e9cd-46ba-aeff-9aa14b42bb7e)"}}, {"added": {"name": "book instance", "object": "A room with a view (ec21d138-40e7-42d6-b041-13af199a4a7e)"}}]',10,1,'2024-06-17 14:32:54.095960'),
 (50,'5','A room with a view',2,'[]',10,1,'2024-06-17 14:33:08.205442'),
 (51,'5','A room with a view',2,'[]',10,1,'2024-06-17 14:33:12.106500'),
 (52,'6','The Adventures of Ferdinand Count Fathom',2,'[{"added": {"name": "book instance", "object": "The Adventures of Ferdinand Count Fathom (ab2abed8-879e-4a62-805d-119842a49995)"}}, {"added": {"name": "book instance", "object": "The Adventures of Ferdinand Count Fathom (c69fd273-8a10-4959-8533-eb58b076f311)"}}, {"added": {"name": "book instance", "object": "The Adventures of Ferdinand Count Fathom (60498698-633d-45db-b8b1-9090f8ed48fa)"}}]',10,1,'2024-06-17 14:34:00.420242'),
 (53,'4','Middlemarch',2,'[{"added": {"name": "book instance", "object": "Middlemarch (f3f9a17b-ae4a-488b-b80e-6eaa463c0f0c)"}}, {"added": {"name": "book instance", "object": "Middlemarch (b303672d-f108-4d1b-9bea-e614138f2490)"}}, {"added": {"name": "book instance", "object": "Middlemarch (ac99a991-8ba7-4c9d-b743-8fedb9b1f967)"}}]',10,1,'2024-06-17 14:34:38.359963'),
 (54,'3','Pride and prejudice',2,'[{"added": {"name": "book instance", "object": "Pride and prejudice (d239d741-fd58-4326-acf1-7182d046e981)"}}, {"added": {"name": "book instance", "object": "Pride and prejudice (1054993b-514a-461d-a3ec-40a7011b4bcd)"}}, {"added": {"name": "book instance", "object": "Pride and prejudice (76f3a04b-730d-4434-b794-5e11caa12b8e)"}}, {"changed": {"name": "book instance", "object": "Pride and prejudice (f2f79d9b-4015-4aa4-b396-afaf0d3dd789)", "fields": ["Due back", "Status"]}}]',10,1,'2024-06-17 14:35:25.416291'),
 (55,'1','Romeo and Juliet',2,'[{"added": {"name": "book instance", "object": "Romeo and Juliet (ff07ffe5-6e41-43be-9490-68aa0331e84d)"}}, {"added": {"name": "book instance", "object": "Romeo and Juliet (b2a5dec7-ad61-41d7-a9d2-06390bb239ee)"}}, {"added": {"name": "book instance", "object": "Romeo and Juliet (25788bd9-c021-4d83-9128-c45e2537f18b)"}}]',10,1,'2024-06-17 14:36:03.069278'),
 (56,'6','The Adventures of Ferdinand Count Fathom',2,'[{"added": {"name": "book instance", "object": "The Adventures of Ferdinand Count Fathom (eb1e0558-bcb5-45a7-8e00-7958e386d437)"}}, {"added": {"name": "book instance", "object": "The Adventures of Ferdinand Count Fathom (2b237ee2-4348-40d9-bfcd-b0f4f0ad896a)"}}, {"added": {"name": "book instance", "object": "The Adventures of Ferdinand Count Fathom (b14fef43-f4f5-4f13-819a-ed3ab8de31dd)"}}]',10,1,'2024-06-17 14:36:58.473412'),
 (57,'4','Middlemarch',2,'[{"added": {"name": "book instance", "object": "Middlemarch (3d8b1695-5f8f-4db2-a595-b08c6c24edfd)"}}]',10,1,'2024-06-17 14:39:00.719896'),
 (58,'3','Austen, Jane',2,'[{"added": {"name": "book", "object": "Sense and sensibility"}}, {"added": {"name": "book", "object": "Mansfield Park"}}, {"added": {"name": "book", "object": "Persuasion"}}]',8,1,'2024-06-17 14:46:11.542424'),
 (59,'4','Eliot, George',2,'[{"added": {"name": "book", "object": "Scenes of Clerical Life"}}, {"added": {"name": "book", "object": "Daniel Deronda"}}, {"added": {"name": "book", "object": "The Lifted Veil"}}]',8,1,'2024-06-17 14:50:50.436399'),
 (60,'5','Forster, E. M.',2,'[{"added": {"name": "book", "object": "The Celestial Omnibus"}}, {"added": {"name": "book", "object": "Where Angels Fear to Tread"}}, {"added": {"name": "book", "object": "The Longest Journey"}}]',8,1,'2024-06-17 14:56:14.284197'),
 (61,'2','Melville, Herman',2,'[{"added": {"name": "book", "object": "Battle-Pieces and Aspects of the War"}}]',8,1,'2024-06-17 14:58:32.462958'),
 (62,'6','Smollet, T',2,'[{"added": {"name": "book", "object": "The Adventures of Roderick Random"}}, {"added": {"name": "book", "object": "The Expedition of Humphry Clinker"}}, {"added": {"name": "book", "object": "The Adventures of Peregrine Pickle"}}]',8,1,'2024-06-17 15:00:57.721537'),
 (63,'1','William, Shakespeare',2,'[{"added": {"name": "book", "object": "Shakespeare''s sonnets"}}, {"added": {"name": "book", "object": "Henry V"}}, {"added": {"name": "book", "object": "Much Ado About Nothing"}}]',8,1,'2024-06-17 15:04:53.049942'),
 (64,'7b24fc9a-51e6-402d-a2a4-d41bfebe999d','Sense and sensibility (7b24fc9a-51e6-402d-a2a4-d41bfebe999d)',1,'[{"added": {}}]',11,1,'2024-06-18 02:46:21.146287'),
 (65,'8ed18b6d-87c8-4443-a802-d8c775cd9826','Sense and sensibility (8ed18b6d-87c8-4443-a802-d8c775cd9826)',1,'[{"added": {}}]',11,1,'2024-06-18 02:46:39.089711');
INSERT INTO "django_content_type" ("id","app_label","model") VALUES (1,'admin','logentry'),
 (2,'auth','permission'),
 (3,'auth','group'),
 (4,'auth','user'),
 (5,'contenttypes','contenttype'),
 (6,'sessions','session'),
 (7,'book_user','bookuser'),
 (8,'book_catalog','author'),
 (9,'book_catalog','genre'),
 (10,'book_catalog','book'),
 (11,'book_catalog','bookinstance'),
 (12,'book_catalog','language');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (1,1,'add_logentry','Can add log entry'),
 (2,1,'change_logentry','Can change log entry'),
 (3,1,'delete_logentry','Can delete log entry'),
 (4,1,'view_logentry','Can view log entry'),
 (5,2,'add_permission','Can add permission'),
 (6,2,'change_permission','Can change permission'),
 (7,2,'delete_permission','Can delete permission'),
 (8,2,'view_permission','Can view permission'),
 (9,3,'add_group','Can add group'),
 (10,3,'change_group','Can change group'),
 (11,3,'delete_group','Can delete group'),
 (12,3,'view_group','Can view group'),
 (13,4,'add_user','Can add user'),
 (14,4,'change_user','Can change user'),
 (15,4,'delete_user','Can delete user'),
 (16,4,'view_user','Can view user'),
 (17,5,'add_contenttype','Can add content type'),
 (18,5,'change_contenttype','Can change content type'),
 (19,5,'delete_contenttype','Can delete content type'),
 (20,5,'view_contenttype','Can view content type'),
 (21,6,'add_session','Can add session'),
 (22,6,'change_session','Can change session'),
 (23,6,'delete_session','Can delete session'),
 (24,6,'view_session','Can view session'),
 (25,7,'add_bookuser','Can add Book users'),
 (26,7,'change_bookuser','Can change Book users'),
 (27,7,'delete_bookuser','Can delete Book users'),
 (28,7,'view_bookuser','Can view Book users'),
 (29,8,'add_author','Can add author'),
 (30,8,'change_author','Can change author'),
 (31,8,'delete_author','Can delete author'),
 (32,8,'view_author','Can view author'),
 (33,9,'add_genre','Can add genre'),
 (34,9,'change_genre','Can change genre'),
 (35,9,'delete_genre','Can delete genre'),
 (36,9,'view_genre','Can view genre'),
 (37,10,'add_book','Can add book'),
 (38,10,'change_book','Can change book'),
 (39,10,'delete_book','Can delete book'),
 (40,10,'view_book','Can view book'),
 (41,11,'add_bookinstance','Can add book instance'),
 (42,11,'change_bookinstance','Can change book instance'),
 (43,11,'delete_bookinstance','Can delete book instance'),
 (44,11,'view_bookinstance','Can view book instance'),
 (45,12,'add_language','Can add language'),
 (46,12,'change_language','Can change language'),
 (47,12,'delete_language','Can delete language'),
 (48,12,'view_language','Can view language');
INSERT INTO "auth_user" ("id","password","last_login","is_superuser","username","last_name","email","is_staff","is_active","date_joined","first_name") VALUES (1,'pbkdf2_sha256$720000$aNpN0FQSoQ4VE297xLQx3e$iBlhGQ+gkaxgQj9189rYCUviM+xjEZdwlyELEUwc/FM=','2024-06-18 02:45:21.945160',1,'mdn_tutorial','','catreadingwritingbook@gmail.com',1,1,'2024-06-16 14:03:31.093930','');
INSERT INTO "django_session" ("session_key","session_data","expire_date") VALUES ('h9hc99t54t2j1wjfhm25g1gql7u79dsd','.eJxVjMEOwiAQRP-FsyGFAgsevfsNZGFXqRpISnsy_rtt0oPeJvPezFtEXJcS185znEichRKn3y5hfnLdAT2w3pvMrS7zlOSuyIN2eW3Er8vh_h0U7GVbW0VGKTQhwQikOWBIzjFZQPIEHpIhdfODH2Akq7eYNBqHm4qcnRKfL9yfOAY:1sJ4OB:mVx6E06ahtumpAVsDqShoypI969rIoaK6VvuhMm9DAs','2024-07-01 04:54:43.442021'),
 ('2iw8g6emyvffax8g76kpz8zylc6oassk','.eJxVjMEOwiAQRP-FsyGFAgsevfsNZGFXqRpISnsy_rtt0oPeJvPezFtEXJcS185znEichRKn3y5hfnLdAT2w3pvMrS7zlOSuyIN2eW3Er8vh_h0U7GVbW0VGKTQhwQikOWBIzjFZQPIEHpIhdfODH2Akq7eYNBqHm4qcnRKfL9yfOAY:1sJAmb:JMnRgBlrCnTlvWVtyhKLzZMqo8nx-Erbofs6j36yWeI','2024-07-01 11:44:21.877088'),
 ('c9qr7j0hilyp212v6uaojdonidi4o0rm','.eJxVjMEOwiAQRP-FsyGFAgsevfsNZGFXqRpISnsy_rtt0oPeJvPezFtEXJcS185znEichRKn3y5hfnLdAT2w3pvMrS7zlOSuyIN2eW3Er8vh_h0U7GVbW0VGKTQhwQikOWBIzjFZQPIEHpIhdfODH2Akq7eYNBqHm4qcnRKfL9yfOAY:1sJOqY:_2t1DTUCOgDEn1Ocam3yInvvibsSfjaja-aiB5oVxYs','2024-07-02 02:45:22.027533');
INSERT INTO "book_catalog_author" ("id","first_name","last_name","date_of_birth","date_of_death") VALUES (1,'Shakespeare','William','1564-04-23','1616-04-23'),
 (2,'Herman','Melville','1819-08-01','1891-09-28'),
 (3,'Jane','Austen','1775-12-16','1817-07-18'),
 (4,'George','Eliot','1819-11-22','1880-12-22'),
 (5,'E. M.','Forster','1879-01-01','1970-06-07'),
 (6,'T','Smollet','1721-03-19','1771-09-17');
INSERT INTO "book_catalog_genre" ("id","name") VALUES (1,'Tragedies'),
 (2,'Sea stories'),
 (3,'Adventure stories'),
 (4,'Love stories'),
 (5,'Social classes'),
 (6,'England'),
 (7,'City and town life'),
 (8,'Didactic fiction'),
 (9,'Travel literature'),
 (10,'Manners');
INSERT INTO "book_catalog_book" ("id","title","summary","isbn","author_id","language_id") VALUES (1,'Romeo and Juliet','It is a tragic love story where the two main characters, Romeo and Juliet, are supposed to be sworn enemies but fall in love. Due to their families'' ongoing conflict, they cannot be together, so they kill themselves because they cannot cope with being separated from one another.','9780316477543',1,1),
 (2,'Moby Dick','Moby-Dick; or, The Whale is an 1851 novel by American writer Herman Melville. The book is the sailor Ishmael''s narrative of the maniacal quest of Ahab, captain of the whaling ship Pequod, for vengeance against Moby Dick, the giant white sperm whale that bit off his leg on the ship''s previous voyage.','9780316477553',2,2),
 (3,'Pride and prejudice','What is the plot of Pride and Prejudice? Pride and Prejudice follows the turbulent relationship between Elizabeth Bennet, the daughter of a country gentleman, and Fitzwilliam Darcy, a rich aristocratic landowner. They must overcome the titular sins of pride and prejudice in order to fall in love and marry.','9780316477544',3,2),
 (4,'Middlemarch','Middlemarch is a novel that explores the dynamics of marriage and social class in 19th-century England. A large web of characters, including the main stories of Dorothea Brooke and Dr. Lydgate, intersect with a number of related plotlines.','9781786090621',4,2),
 (5,'A room with a view','The book depicts Lucy''s struggles as she emerges as her own woman, growing from indecision to fulfillment. She struggles between strict, old-fashioned Victorian values and newer, more liberal mores. In this struggle Lucy''s own idea of what is true evolves and matures.','9781786090631',5,2),
 (6,'The Adventures of Ferdinand Count Fathom','The Adventures of Ferdinand, Count Fathom is a novel by Tobias Smollett first published in 1753. It was Smollett''s third novel and met with less success than his two previous more picaresque tales. The central character is a villainous dandy who cheats, swindles and philanders his way across Europe and England with little concern for the law or the welfare of others.[1] He is the son of an equally disreputable mother, and Smollett himself comments that "Fathom justifies the proverb, ''What''s bred in the bone will never come out of the flesh". Sir Walter Scott commented that the novel paints a "complete picture of human depravity" [1]','9781417939909',6,1),
 (7,'Sense and sensibility','Sense and Sensibility is the first novel by the English author Jane Austen, published in 1811. It was published anonymously; By A Lady appears on the title page where the author''s name might have been. It tells the story of the Dashwood sisters, Elinor (age 19) and Marianne (age 16½) as they come of age. They have an older half-brother, John, and a younger sister, Margaret (age 13).','9780316477545',3,2),
 (8,'Mansfield Park','Mansfield Park is the third published novel by the English author Jane Austen, first published in 1814 by Thomas Egerton. A second edition was published in 1816 by John Murray, still within Austen''s lifetime. The novel did not receive any public reviews until 1821.','9780316477546',3,2),
 (9,'Persuasion','Persuasion is the last novel completed by the English author Jane Austen. It was published on 20 December 1817, along with Northanger Abbey, six months after her death, although the title page is dated 1818.','9780316477547',3,2),
 (10,'Scenes of Clerical Life','Scenes of Clerical Life is George Eliot''s first published work of fiction, a collection of three short stories, published in book form; it was the first of her works to be released under her famous pseudonym. The stories were first published in Blackwood''s Magazine over the course of the year 1857, initially anonymously, before being released as a two-volume set by Blackwood and Sons in January 1858. The three stories are set during the last twenty years of the eighteenth century and the first half of the nineteenth century over a fifty-year period. The stories take place in and around the fictional town of Milby in the English Midlands.','9781786090622',4,2),
 (11,'Daniel Deronda','Daniel Deronda is a novel written by English author George Eliot, first published in eight parts (books) February to September 1876.[1] It was the last novel she completed and the only one set in the Victorian society of her day. The work''s mixture of social satire and moral searching, along with its sympathetic rendering of Jewish proto-Zionist ideas, has made it the controversial final statement of one of the most renowned Victorian novelists.','9781786090623',4,2),
 (12,'The Lifted Veil','The Lifted Veil is a novella by George Eliot, first published anonymously in Blackwood''s Magazine in 1859. [1][2] It was republished in 1879. Quite unlike the realistic fiction for which Eliot is best known, The Lifted Veil explores themes of extrasensory perception, possible life after death, and the power of fate. The story is a significant part of the Victorian tradition of horror fiction, which includes such other examples as Robert Louis Stevenson''s Strange Case of Dr. Jekyll and Mr. Hyde (1886), and Bram Stoker''s Dracula (1897).','9781786090624',4,2),
 (13,'The Celestial Omnibus','The Celestial Omnibus and Other Stories is the title of a collection of short stories by English writer E. M. Forster, first published in 1911. It contains stories written over the previous ten years, and together with the collection The Eternal Moment (1928) forms part of Forster''s Collected Short Stories (1947).','9781786090632',5,2),
 (14,'Where Angels Fear to Tread','Where Angels Fear to Tread (1905) is a novel by E. M. Forster. The title comes from a line in Alexander Pope''s poem An Essay on Criticism: "For fools rush in where angels fear to tread".','9781786090633',5,2),
 (15,'The Longest Journey','The Longest Journey is a bildungsroman by E. M. Forster, first published in 1907. It is the second of Forster''s six published novels, following Where Angels Fear to Tread (1905) and preceding A Room with a View (1908) and Howards End (1910). It was Forster’s favourite among his own novels.[1]','9781786090634',5,2),
 (16,'Battle-Pieces and Aspects of the War','Battle-Pieces and Aspects of the War is the first book of poetry of the American author Herman Melville. Published by Harper & Brothers of New York in 1866, the volume is dedicated "To the Memory of the Three Hundred Thousand Who in the War For the Maintenance of the Union Fell Devotedly Under the Flag of Their Fathers" and its 72 poems deal with the battles and personalities of the American Civil War and their aftermath. Also included are Notes and a Supplement in prose in which Melville sets forth his thoughts on how the Post-war Reconstruction should be carried out.','9780316477563',2,2),
 (17,'The Adventures of Roderick Random','The Adventures of Roderick Random is a picaresque novel by Tobias Smollett, first published in 1748. It is partially based on Smollett''s experience as a naval-surgeon''s mate in the Royal Navy, especially during the Battle of Cartagena de Indias in 1741. In the preface, Smollett acknowledges the connections of his novel to the two satirical picaresque works he translated into English: Miguel de Cervantes'' Don Quixote (1605–15) and Alain-René Lesage''s Gil Blas (1715–47)','9781417939919',6,1),
 (18,'The Expedition of Humphry Clinker','The Expedition of Humphry Clinker was the last of the picaresque novels of Tobias Smollett, published in London on 17 June 1771 (three months before Smollett''s death), and is considered by many to be his best and funniest work.[1] It is an epistolary novel, presented in the form of letters written by six characters: Matthew Bramble, a Welsh Squire; his sister Tabitha; their niece Lydia and nephew Jeremy Melford; Tabitha''s maid Winifred Jenkins; and Lydia''s suitor Wilson.','9781417939929',6,1),
 (19,'The Adventures of Peregrine Pickle','The Adventures of Peregrine Pickle is a picaresque novel by the Scottish author Tobias Smollett, first published in 1751 and revised and published again in 1758. It tells the story of an egotistical man who experiences luck and misfortunes in the height of 18th-century European society.','9781417939939',6,1),
 (20,'Shakespeare''s sonnets','William Shakespeare (1564–1616) wrote sonnets on a variety of themes. When discussing or referring to Shakespeare''s sonnets, it is almost always a reference to the 154 sonnets that were first published all together in a quarto in 1609. However, there are six additional sonnets that Shakespeare wrote and included in the plays Romeo and Juliet, Henry V and Love''s Labour''s Lost. There is also a partial sonnet found in the play Edward III.','9780316477653',1,1),
 (21,'Henry V','The epilogue at the end of the play Henry V is written in the form of a sonnet ("Thus far with rough, and all-unable pen…"). Formal epilogues were established as a theatrical tradition, and occur in 13 of Shakespeare''s plays. In Henry V, the character of Chorus, who has addressed the audience a few times during the play, speaks the wide-ranging epilogue/sonnet. It begins by allowing that the play may not have presented the story in its full glory. It points out that the next king would be Henry VI, who was an infant when he succeeded Henry V, and who "lost France, and made his England bleed/ Which oft our stage hath shown." It refers to the three parts of Henry VI and to Richard III — connecting the Lancastrian and the Yorkist cycles.','9780316477763',1,1),
 (22,'Much Ado About Nothing','Two sonnets are mentioned in Much Ado About Nothing—sonnets by Beatrice and Benedick—and though not committed to paper, they were in Shakespeare''s mind. The first one, revealed by Claudio, is described as "A halting sonnet of his own pure brain/Fashion''d to Beatrice". The second, found by Hero, was "Writ in my cousin''s hand, stolen from her pocket/Containing her affection unto Benedick".','9780316477573',1,1);
INSERT INTO "book_catalog_bookinstance" ("id","imprint","due_back","status","book_id") VALUES ('0','Windmill Books','2024-06-16','m',1),
 ('1','Windmill Books','2024-08-15','o',1),
 ('2','Random House','2024-08-01','o',2),
 ('3','Random House','2024-06-16','a',2),
 ('4','Wordsworth Classic','2024-06-16','r',3),
 ('5','Wordsworth Classic','2024-08-01','o',3),
 ('6','Everyday Classic','2024-08-31','o',4),
 ('7','Everyday Classic','2024-06-16','a',4),
 ('8','Wordsworth Classic','2024-06-16','m',5),
 ('9','Wordsworth Classic','2024-08-14','o',5),
 ('10','Wordsworth Classic','2024-06-02','a',6),
 ('11','Wordsworth Classic','2024-07-20','o',6),
 ('12','Random House','2024-07-10','o',2),
 ('13','Random House','2024-05-14','a',2),
 ('14','Wordsworth Classic','2024-06-01','m',5),
 ('15','Wordsworth Classic','2024-06-02','m',5),
 ('16','Wordsworth Classic','2024-07-20','o',5),
 ('17','Wordsworth Classic','2024-06-01','a',6),
 ('18','Wordsworth Classic','2024-07-01','o',6),
 ('19','Wordsworth Classic','2024-06-05','a',6),
 ('20','Everyday Classic','2024-07-12','o',4),
 ('21','Everyday Classic','2024-06-21','o',4),
 ('22','Everyday Classic','2024-06-17','a',4),
 ('23','Wordsworth Classic','2024-06-17','r',3),
 ('24','Wordsworth Classic','2024-06-18','r',3),
 ('25','Wordsworth Classic','2024-06-19','r',3),
 ('26','Windmill Books','2024-06-17','a',1),
 ('27','Windmill Books','2024-06-29','o',1),
 ('28','Windmill Books','2024-06-03','m',1),
 ('29','Wordsworth Classic','2024-08-31','o',6),
 ('30','Wordsworth Classic','2024-08-30','o',6),
 ('31','Wordsworth Classic','2024-06-21','r',6),
 ('32','Everyday Classic','2024-06-07','m',4),
 ('33','Everyday Classic','2024-07-05','o',7),
 ('34','Everyday Classic','2024-06-18','a',7);
INSERT INTO "book_catalog_book_genre" ("id","book_id","genre_id") VALUES (1,1,1),
 (2,1,4),
 (3,2,2),
 (4,2,3),
 (5,3,4),
 (6,3,5),
 (7,3,6),
 (8,4,8),
 (9,4,6),
 (10,4,7),
 (11,5,9),
 (12,5,10),
 (13,5,4),
 (14,6,1),
 (15,6,10),
 (16,6,4),
 (17,7,4),
 (18,7,5),
 (19,7,6),
 (20,8,4),
 (21,8,5),
 (22,8,6),
 (23,9,4),
 (24,9,5),
 (25,9,6),
 (26,10,1),
 (27,10,10),
 (28,10,6),
 (29,10,7),
 (30,11,8),
 (31,11,1),
 (32,11,6),
 (33,11,7),
 (34,12,8),
 (35,12,1),
 (36,12,10),
 (37,12,9),
 (38,13,3),
 (39,13,4),
 (40,14,1),
 (41,14,3),
 (42,14,4),
 (43,15,1),
 (44,15,3),
 (45,16,1),
 (46,16,3),
 (47,17,3),
 (48,17,6),
 (49,17,7),
 (50,18,1),
 (51,18,3),
 (52,18,6),
 (53,18,7),
 (54,19,1),
 (55,19,5),
 (56,19,6),
 (57,19,7),
 (58,20,1),
 (59,20,3),
 (60,20,4),
 (61,21,3),
 (62,21,6),
 (63,22,4);
INSERT INTO "book_catalog_language" ("id","notes","name") VALUES (1,'Older style English','Old English'),
 (2,'Modern English','Modern English');
CREATE UNIQUE INDEX IF NOT EXISTS "auth_group_permissions_group_id_permission_id_0cd325b0_uniq" ON "auth_group_permissions" (
	"group_id",
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "auth_group_permissions_group_id_b120cbf9" ON "auth_group_permissions" (
	"group_id"
);
CREATE INDEX IF NOT EXISTS "auth_group_permissions_permission_id_84c5c92e" ON "auth_group_permissions" (
	"permission_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_user_groups_user_id_group_id_94350c0c_uniq" ON "auth_user_groups" (
	"user_id",
	"group_id"
);
CREATE INDEX IF NOT EXISTS "auth_user_groups_user_id_6a12ed8b" ON "auth_user_groups" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "auth_user_groups_group_id_97559544" ON "auth_user_groups" (
	"group_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_user_user_permissions_user_id_permission_id_14a6b632_uniq" ON "auth_user_user_permissions" (
	"user_id",
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "auth_user_user_permissions_user_id_a95ead1b" ON "auth_user_user_permissions" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "auth_user_user_permissions_permission_id_1fbb5f2c" ON "auth_user_user_permissions" (
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "django_admin_log_content_type_id_c4bce8eb" ON "django_admin_log" (
	"content_type_id"
);
CREATE INDEX IF NOT EXISTS "django_admin_log_user_id_c564eba6" ON "django_admin_log" (
	"user_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "django_content_type_app_label_model_76bd3d3b_uniq" ON "django_content_type" (
	"app_label",
	"model"
);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_permission_content_type_id_codename_01ab375a_uniq" ON "auth_permission" (
	"content_type_id",
	"codename"
);
CREATE INDEX IF NOT EXISTS "auth_permission_content_type_id_2f476e4b" ON "auth_permission" (
	"content_type_id"
);
CREATE INDEX IF NOT EXISTS "django_session_expire_date_a5c62663" ON "django_session" (
	"expire_date"
);
CREATE UNIQUE INDEX IF NOT EXISTS "genre_name_case_insensitive_unique" ON "book_catalog_genre" (
	(LOWER("name"))
);
CREATE INDEX IF NOT EXISTS "book_catalog_book_author_id_265c1e66" ON "book_catalog_book" (
	"author_id"
);
CREATE INDEX IF NOT EXISTS "book_catalog_bookinstance_book_id_ea783c78" ON "book_catalog_bookinstance" (
	"book_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "book_catalog_book_genre_book_id_genre_id_ceaa6791_uniq" ON "book_catalog_book_genre" (
	"book_id",
	"genre_id"
);
CREATE INDEX IF NOT EXISTS "book_catalog_book_genre_book_id_55f06d50" ON "book_catalog_book_genre" (
	"book_id"
);
CREATE INDEX IF NOT EXISTS "book_catalog_book_genre_genre_id_ec94f940" ON "book_catalog_book_genre" (
	"genre_id"
);
CREATE INDEX IF NOT EXISTS "book_catalog_book_language_id_8cf6e5e3" ON "book_catalog_book" (
	"language_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "language_name_case_insensitive_unique" ON "book_catalog_language" (
	(LOWER("name"))
);
COMMIT;
