CREATE TABLE IF NOT EXISTS events(
    id INTEGER PRIMARY KEY,
    title TEXT NOT NULL, description TEXT,
    permalink TEXT NOT NULL UNIQUE ON CONFLICT REPLACE,
    startDate TEXT,
    endDate TEXT,
    dateDetails TEXT,
    location TEXT,
    admission TEXT,
    website TEXT,
    contact TEXT,
    email TEXT,
    isFavorite INTEGER NOT NULL DEFAULT 0,
    dateFavorited TEXT
    );