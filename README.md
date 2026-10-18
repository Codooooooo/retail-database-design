# Retail Database Design

A MySQL relational database coursework project modeling a Walmart-style retail business: customers, memberships, branches, employees, inventory, suppliers, orders, promotions, and payments.

Originally developed for ITCS413 Database Design, Phase 2. This portfolio edition organizes the original schema and replaces sensitive data fields with demo values. It is an educational model and is not affiliated with Walmart.

## Highlights

- 28 tables with primary keys, foreign keys, composite keys, and business enums.
- Customer membership and employee specialization tables.
- Association tables for products, suppliers, promotions, orders, and payments.
- CSV import scripts, example queries, a data dictionary, and an ER diagram.

## Repository layout

```text
sql/       Schema, demo-data loader, example queries
data/demo/ CSV fixtures with replaced personal and financial fields
docs/      ER diagram, data dictionary, data-handling notes
.github/   Issue and pull-request templates
```

## Run locally

Use a MySQL development server and the mysql command-line client. Run from the repository root so CSV paths resolve correctly. The schema uses MySQL-specific syntax; exact server compatibility has not been runtime-tested.

```sh
mysql -u YOUR_USER -p < sql/01_schema.sql
mysql --local-infile=1 -u YOUR_USER -p < sql/02_load_demo_data.sql
mysql -u YOUR_USER -p < sql/03_example_queries.sql
```

Use an empty development database named `WalmartDB`. If the server disables LOCAL INFILE, enable it only in your development environment. Existing databases are not automatically dropped, and repeated schema/import execution is not idempotent.

## Documentation and verification

- [Entity relationships](docs/erd.md)
- [Data dictionary](docs/data-dictionary.md)
- [Data handling and limitations](docs/data-handling.md)
- [Validation record](docs/validation.md)

No license is assigned pending confirmation of coursework authorship and source-data rights. See CONTRIBUTING.md before reuse.
