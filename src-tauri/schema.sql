        CREATE TABLE patients(id INTEGER PRIMARY KEY, name TEXT NOT NULL, search_name TEXT NOT NULL, gender TEXT NOT NULL, birthdate TEXT, city TEXT NOT NULL DEFAULT '', street TEXT NOT NULL DEFAULT '', house TEXT NOT NULL DEFAULT '', flat TEXT NOT NULL DEFAULT '', hidden INTEGER NOT NULL DEFAULT 0, revision INTEGER NOT NULL DEFAULT 1);
        CREATE INDEX patients_search ON patients(search_name);
        CREATE TABLE doctors(id INTEGER PRIMARY KEY, name TEXT NOT NULL, hidden INTEGER NOT NULL);
        CREATE TABLE templates(id INTEGER PRIMARY KEY, name TEXT NOT NULL, code TEXT NOT NULL);
        CREATE TABLE studies(id INTEGER PRIMARY KEY, patient_id INTEGER NOT NULL REFERENCES patients(id), date TEXT NOT NULL, template_id INTEGER NOT NULL, doctor_id INTEGER NOT NULL, title TEXT NOT NULL, conclusion TEXT NOT NULL, addition TEXT NOT NULL, fields_json TEXT NOT NULL, legacy_version TEXT, origin TEXT NOT NULL, status TEXT NOT NULL, revision INTEGER NOT NULL DEFAULT 1, updated_at TEXT NOT NULL DEFAULT '');
        CREATE INDEX studies_patient_date ON studies(patient_id,date DESC,id DESC);
        CREATE INDEX studies_date ON studies(date DESC);
        CREATE TABLE audit(id INTEGER PRIMARY KEY, entity TEXT NOT NULL, entity_id INTEGER NOT NULL, previous_json TEXT, saved_at TEXT NOT NULL);
        CREATE TABLE metadata(key TEXT PRIMARY KEY,value TEXT NOT NULL);
        
