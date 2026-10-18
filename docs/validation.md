# Validation record

- Checked 28 CSV tables and 16,303 demo rows with `python scripts/validate_demo_data.py`.
- Primary keys were present and unique; all declared single-column foreign keys resolved.
- Personal/contact and financial identifier fields were replaced with demo placeholders.
- Original input folders were left unchanged.
- MySQL schema/import execution was not tested: no MySQL client or running Docker engine was available. Static checks do not verify SQL modes, date parsing, CSV import behavior, or application suitability.
