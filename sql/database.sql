-- Tabella delle categorie di spesa
CREATE TABLE IF NOT EXISTS categories (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(100) NOT NULL UNIQUE CHECK (length(trim(name)) > 0)
);

-- Tabella delle spese giornaliere
CREATE TABLE IF NOT EXISTS expenses (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    expense_date DATE NOT NULL CHECK (expense_date GLOB '[0-9][0-9][0-9][0-9]-[0-1][0-9]-[0-3][0-9]'),
    amount REAL NOT NULL CHECK (amount > 0),
    category_id INTEGER NOT NULL,
    description VARCHAR(255),
    FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE RESTRICT
);

-- Tabella dei budget mensili per categoria
CREATE TABLE IF NOT EXISTS budgets (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    month VARCHAR(7) NOT NULL CHECK (month GLOB '[0-9][0-9][0-9][0-9]-[0-1][0-9]'),
    category_id INTEGER NOT NULL,
    amount REAL NOT NULL CHECK (amount > 0),
    UNIQUE (month, category_id),
    FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE RESTRICT
);


-- ==================================== --
-- ========== DATI DI ESEMPIO ========= --
-- ==================================== --

-- Dati di esempio: Categorie
INSERT INTO categories (name) VALUES
    ('Alimentari'),
    ('Trasporti'),
    ('Svago');

-- Dati di esempio: Budget mensili (YYYY-MM)
INSERT INTO budgets (month, category_id, amount) VALUES
    ('2025-01', (SELECT id FROM categories WHERE name = 'Alimentari'), 300.00),
    ('2025-01', (SELECT id FROM categories WHERE name = 'Trasporti'), 150.00),
    ('2025-01', (SELECT id FROM categories WHERE name = 'Svago'), 100.00),
    ('2026-07', (SELECT id FROM categories WHERE name = 'Alimentari'), 275.00),
    ('2026-07', (SELECT id FROM categories WHERE name = 'Trasporti'), 99.00);

-- Dati di esempio: Spese (YYYY-MM-DD)
INSERT INTO expenses (expense_date, amount, category_id, description) VALUES
    ('2025-01-15', 25.00, (SELECT id FROM categories WHERE name = 'Alimentari'), 'Pranzo'),
    ('2025-01-20', 295.50, (SELECT id FROM categories WHERE name = 'Alimentari'), 'Spesa mensile supermercato'),
    ('2025-01-10', 120.00, (SELECT id FROM categories WHERE name = 'Trasporti'), 'Abbonamento mezzi'),
    ('2025-01-18', 45.00, (SELECT id FROM categories WHERE name = 'Svago'), 'Cinema e pizza'),
    ('2026-07-20', 250.50, (SELECT id FROM categories WHERE name = 'Alimentari'), 'Spesa mensile supermercato'),
    ('2026-07-11', 40.90, (SELECT id FROM categories WHERE name = 'Alimentari'), 'Cena speciale'),
    ('2026-07-10', 90.00, (SELECT id FROM categories WHERE name = 'Trasporti'), 'Abbonamento mezzi'),
    ('2026-07-21', 5.00, (SELECT id FROM categories WHERE name = 'Trasporti'), 'Biglietti mezzi');