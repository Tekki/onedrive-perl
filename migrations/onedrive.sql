-- 1 up
CREATE TABLE IF NOT EXISTS item (
  id INTEGER PRIMARY KEY,
  item_id TEXT NOT NULL,
  name TEXT NOT NULL,
  parent_id TEXT,
  etag TEXT NOT NULL,
  ctag TEXT,
  sha1 TEXT,
  quickxor TEXT,
  lastmodified TEXT NOT NULL,
  modifiedby TEXT NOT NULL,
  folder INTEGER,
  file INTEGER,
  package INTEGER,
  remote INTEGER
);

CREATE TABLE IF NOT EXISTS log (
  id INTEGER PRIMARY KEY,
  timestamp TEXT NOT NULL,
  item_id TEXT NOT NULL,
  name TEXT NOT NULL,
  lastmodified TEXT NOT NULL,
  modifiedby TEXT NOT NULL,
  action TEXT,
  result TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS task (
  id INTEGER PRIMARY KEY,
  item_id TEXT NOT NULL,
  description TEXT NOT NULL,
  failures INTEGER NOT NULL DEFAULT 0
);

-- 1 down
DROP TABLE IF EXISTS item;
DROP TABLE IF EXISTS log;
DROP TABLE IF EXISTS task;
