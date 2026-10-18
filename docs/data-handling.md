# Data handling and model limitations

The local coursework CSVs were not verified as synthetic. This repository replaces identity, contact, address, financial identifier, salary, and selected business-name fields with deterministic demo values. Original files remain outside the repository. IDs and relational structure are retained; these are demonstration fixtures, not real business evidence.

The historical coursework schema includes card numbers and CVV fields. These are retained only to document the original model, and all packaged values are placeholders. A production payment system must use provider tokens and must not store card verification codes. Other production improvements include decimal money types, stronger constraints, migrations, access control, and separate secrets management.

The schema no longer drops an existing database automatically. Import only into a disposable development database. The original SELECT FOUND_ROWS() table count is not a reliable schema audit; use information_schema for verification. The source dataset license and full group authorship were not supplied; no open-source license is inferred.
