tested for python >= 3.10
# Sistema di Gestione delle Spese Personali e del Budget

Applicazione console sviluppata in **Python** con database relazionale locale **SQLite** per registrare le spese giornaliere, organizzarle per categoria, impostare budget mensili e consultare report riepilogativi.

---

## Struttura del Repository

```text
Personal-Expense-System/
├── src/
│   └── main.py          # Codice sorgente dell'applicazione console
├── sql/
│   └── database.sql     # Script SQL di creazione tabelle, vincoli e dati di esempio
├── demo/
│   └── demo_video.mp4   # Video dimostrativo del funzionamento
├── expenses.db         # Database sqlite generato per l'applicazione
└── README.md            # Documentazione e istruzioni di esecuzione
```

---

## Requisiti per l'Esecuzione

* **Interprete:** Python **3.10** o superiore (necessario per il costrutto `match/case` utilizzato nella gestione dei menu).
* **Database:** SQLite 3 (integrato nativamente in Python tramite il modulo standard `sqlite3`).
* **Librerie utilizzate:** Solo librerie standard di Python (`sqlite3`, `pathlib`, `re`). Non è richiesta l'installazione di pacchetti esterni tramite `pip`.

---

## Istruzioni di Avvio ed Esecuzione

Il programma non richiede compilazione. Al primo avvio, lo script crea automaticamente il file del database (`sql/expenses.db`) eseguendo le istruzioni contenute in `sql/database.sql` (inclusi i vincoli di integrità e i dati iniziali di esempio).

1. Apri il terminale (o Prompt dei comandi) e spostati nella cartella principale del repository. A titolo d'esempio:
   ```bash
   cd Personal-Expense-System
   ```

2. Avvia l'applicazione eseguendo il comando:
   ```bash
   python ./src/main.py
   ```
   *(Su alcuni sistemi macOS o Linux potrebbe essere necessario usare `python3 ./src/main.py`)*

3. Segui le istruzioni a schermo per navigare tra i moduli del menu principale:
   * **1. Gestione Categorie** – Aggiunta di nuove categorie di spesa.
   * **2. Inserisci Spesa** – Registrazione di una nuova spesa con data (`YYYY-MM-DD`), importo, categoria e descrizione facoltativa.
   * **3. Definisci Budget Mensile** – Impostazione o aggiornamento del limite di spesa mensile (`YYYY-MM`) per una specifica categoria.
   * **4. Visualizza Report** – Accesso al sottomenu dei report (totale per categoria, confronto spese mensili vs budget, elenco cronologico completo delle spese).
   * **5. Esci** – Chiusura dell'applicazione.

---

## Note sul Database SQL

Lo script `sql/database.sql` implementa lo schema relazionale con i seguenti vincoli di integrità espliciti:
* `PRIMARY KEY` su tutte le tabelle (`categories`, `expenses`, `budgets`).
* `FOREIGN KEY` per collegare `expenses` e `budgets` a `categories`.
* `UNIQUE` sul nome della categoria e sulla coppia `(month, category_id)` nella tabella `budgets`.
* `CHECK` per garantire importi strettamente maggiori di zero (`amount > 0`), nomi non vuoti e formati validi per date e mesi in quanto SQLite non gestisce automaticamente la correttezza del tipo DATE.
* `NOT NULL` su tutti i campi obbligatori.