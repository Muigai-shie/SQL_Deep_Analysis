# SQL Tools used in this repository

This repository (SQL_Deep_Analysis) contains SQL projects and examples demonstrating DML, DDL, DQL, and DCL. To make it clear which SQL tools and workflows are used, this file documents common tools and commands you can use to run, lint, and format the SQL in this repo.

Relevant path examples: features/copilot/plans/**

Quick run examples

- Run a .sql file with sqlite3 (local file-based DB):
  sqlite3 sample.db < features/copilot/plans/example.sql

- Run a .sql file with psql (Postgres):
  PGPASSWORD=mysecret psql -h localhost -U postgres -d mydb -f features/copilot/plans/example.sql

- Run a .sql file with mysql:
  mysql -u root -p mydb < features/copilot/plans/example.sql

Containerized postgres example

- Start a temporary Postgres and run a script:
  docker run --name tmp-pg -e POSTGRES_PASSWORD=pass -d -p 5432:5432 postgres:15
  PGPASSWORD=pass psql -h localhost -U postgres -d postgres -f features/copilot/plans/example.sql
  docker rm -f tmp-pg

Linting and formatting

- Lint SQL with sqlfluff (recommended):
  sqlfluff lint features/copilot/plans/*.sql
  sqlfluff fix features/copilot/plans/*.sql

- Check style with sqlfmt (or other formatters):
  sqlfmt -w features/copilot/plans/*.sql

DBT / transformations (if you use dbt):

- Run dbt models (if this repo is connected to a dbt project):
  dbt run --profiles-dir . --project-dir .

Sample SQL snippet

-- name: top_customers.sql
SELECT customer_id, SUM(amount) AS total_spent
FROM sales
WHERE sale_date >= '2024-01-01'
GROUP BY customer_id
ORDER BY total_spent DESC
LIMIT 10;

Notes

- Replace host/credentials with your environment values.
- This file is a short guide so contributors know which tools to use when working with the SQL in this repo.
