CREATE TABLE IF NOT EXISTS settings(key TEXT PRIMARY KEY, value TEXT NOT NULL);
INSERT OR IGNORE INTO settings(key,value) VALUES ('auto_reply','1'),('mode','test'),('web','trusted');

-- بانک پاسخ: kind=faq (پرسش و پاسخ آماده) | ref (متن مرجع بلند برای کمک به هوش مصنوعی)
CREATE TABLE IF NOT EXISTS kb(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  slug TEXT UNIQUE,
  kind TEXT NOT NULL DEFAULT 'faq',
  topic TEXT NOT NULL DEFAULT 'عمومی',
  question TEXT NOT NULL,
  keywords TEXT NOT NULL DEFAULT '',
  variants TEXT NOT NULL DEFAULT '',
  answer TEXT NOT NULL,
  source TEXT NOT NULL DEFAULT '',
  sensitive INTEGER NOT NULL DEFAULT 0,
  active INTEGER NOT NULL DEFAULT 1,
  origin TEXT NOT NULL DEFAULT 'manual',
  stems TEXT NOT NULL,
  qstems TEXT NOT NULL,
  updated_at INTEGER NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_kb_active ON kb(active);

CREATE TABLE IF NOT EXISTS qa_log(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  created_at INTEGER NOT NULL,
  chat_id INTEGER NOT NULL,
  message_id INTEGER NOT NULL,
  thread_id INTEGER,
  user_id INTEGER,
  question TEXT NOT NULL,
  answer TEXT,
  sources TEXT,
  origin TEXT,
  status TEXT NOT NULL,
  reason TEXT,
  reviewed_by INTEGER,
  UNIQUE(chat_id, message_id)
);
CREATE INDEX IF NOT EXISTS idx_qa_status ON qa_log(status, created_at);
