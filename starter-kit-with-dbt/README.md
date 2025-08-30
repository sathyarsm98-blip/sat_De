# Starter Kit: PostgreSQL + dbt + Meltano (CSV demo)

## Prereqs
- Python 3.10+, `pipx` or `pip`, and `dbt-postgres` installed.
- Postgres running locally (Docker example):  
  `docker run --name pg -e POSTGRES_PASSWORD=db_pass -e POSTGRES_USER=db_user -e POSTGRES_DB=analytics -p 5432:5432 -d postgres`

## Paths
- dbt profiles: `dbt/profiles.yml`
- Meltano project: `meltano/meltano.yml`
- CSV data: `data/sample_orders.csv`
- SQL: `sql/create_and_copy_orders.sql`

## Option A — Load with psql
1) Create schemas & table and load CSV:
   ```
   psql "postgresql://db_user:db_pass@localhost:5432/analytics" -f sql/create_and_copy_orders.sql
   ```
2) Check a sample:
   ```
   psql "postgresql://db_user:db_pass@localhost:5432/analytics" -c "select * from raw.orders limit 5;"
   ```

## Option B — Load with Meltano (tap-csv -> target-postgres)
1) Install Meltano & plugins:
   ```bash
   pipx install meltano  # or: pip install meltano
   cd /mnt/data/starter-kit/meltano
   meltano install
   ```
2) Ensure env vars point to your Postgres:
   ```bash
   export PGHOST=localhost
   export PGPORT=5432
   export PGUSER=db_user
   export PGPASSWORD=db_pass
   export PGDATABASE=analytics
   ```
3) Run the job:
   ```bash
   meltano run csv_to_postgres
   ```
4) Verify:
   ```bash
   psql "postgresql://$PGUSER:$PGPASSWORD@$PGHOST:$PGPORT/$PGDATABASE" -c "select count(*) from raw.orders;"
   ```

## Option C — Use dbt against the `stg` schema
1) Copy `dbt/profiles.yml` to `~/.dbt/profiles.yml` or set `export DBT_PROFILES_DIR=$(pwd)/dbt`
2) Create a simple model in your dbt project that selects from `raw.orders` and materializes to `stg.orders`
3) Run:
   ```bash
   dbt debug
   dbt run
   dbt test
   ```
