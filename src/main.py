from pathlib import Path
import re
import sqlite3

# Oggetti Path usano operatore '/' per concatenare percorsi
# https://docs.python.org/3/library/pathlib.html#operators
BASE_DIR = Path(__file__).resolve().parent.parent
DB_PATH = BASE_DIR / "expenses.db"
SCHEMA_PATH = BASE_DIR / "sql" / "database.sql"

DATE_REGEX = re.compile(r"^\d{4}-(0[1-9]|1[0-2])-(0[1-9]|[12]\d|3[01])$")
MONTH_REGEX = re.compile(r"^\d{4}-(0[1-9]|1[0-2])$")

print(f"DB PATH: {DB_PATH}")
print(f"SCHEMA PATH: {SCHEMA_PATH}")

def get_connection(db_path) -> sqlite3.Connection:
    """Connects to a SQLite database"""
    conn = sqlite3.connect(db_path)
    conn.execute("PRAGMA foreign_keys = ON;")
    conn.row_factory = sqlite3.Row
    return conn

def init_database(db_path, schema_path) -> None:
    """Check id passed DB Path exists, otherwise create it"""
    if not db_path.exists():
        db_path.parent.mkdir(parents=True, exist_ok=True)
        with get_connection(db_path) as conn:
            sql_script = schema_path.read_text(encoding="utf-8")
            conn.executescript(sql_script)
            conn.commit()

def category_exists(conn: sqlite3.Connection, name: str) -> int | None:
    row = conn.execute(
        "SELECT id FROM categories WHERE lower(name) = lower(?);",
        (name,),
    ).fetchone()
    return row["id"] if row else None


def draw_menu() -> None:
    print("\nSISTEMA SPESE PERSONALI")
    print("1. Gestione Categorie")
    print("2. Inserisci Spesa")
    print("3. Definisci Budget Mensile")
    print("4. Visualizza Report")
    print("5. Esci")

def main() -> None:
    init_database(DB_PATH, SCHEMA_PATH)
    EXIT_CHOICE = "5"
    choice = 0
    print("System is under development =)! Wait for it!")
    print("Benvenuto nel Sistema di Gestione delle Spese Personali e del Budget!")
    while choice != EXIT_CHOICE:
        draw_menu()
        choice = input("Inserisci la tua scelta: ").strip()
        match choice:
            case "1":
                pass
            case "2":
                pass
            case "3":
                pass
            case "4":
                pass
            case "5":
                print("Uscita dal programma. A presto!")
            case _:
                print("Scelta non valida. Riprovare.")

if __name__ == "__main__":
    main()
