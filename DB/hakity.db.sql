BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "story" (
	"id"	INTEGER,
	"name"	TEXT,
	"cover_photo"	TEXT,
	"auther"	TEXT,
	"level"	INTEGER,
	"required_start"	INTEGER,
	PRIMARY KEY("id")
);
CREATE TABLE IF NOT EXISTS "meadia" (
	"id"	INTEGER,
	"page_no"	INTEGER,
	"story_id"	INTEGER,
	"photo"	TEXT,
	"sound"	TEXT,
	"text"	TEXT,
	FOREIGN KEY("story_id") REFERENCES "story"("id"),
	PRIMARY KEY("id")
);
COMMIT;
