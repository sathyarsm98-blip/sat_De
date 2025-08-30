# dbt Project: training_project

## Run steps
1) Ensure Postgres has data in `raw.orders` (use the provided COPY/Meltano jobs).
2) Point dbt to the included profile:
   ```bash
   export DBT_PROFILES_DIR=/mnt/data/starter-kit/dbt
   ```
3) Run dbt:
   ```bash
   cd /mnt/data/starter-kit/dbt_project/training_project
   dbt debug
   dbt run --select stg_orders
   dbt test --select stg_orders
   ```
