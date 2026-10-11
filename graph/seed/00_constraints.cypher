// Uniqueness constraints: keep MERGE idempotent and lookups fast.
CREATE CONSTRAINT company_tax_id IF NOT EXISTS
FOR (c:Company) REQUIRE c.tax_id IS UNIQUE;

CREATE CONSTRAINT bank_code IF NOT EXISTS
FOR (b:Bank) REQUIRE b.code IS UNIQUE;

CREATE INDEX company_sector IF NOT EXISTS
FOR (c:Company) ON (c.sector);
