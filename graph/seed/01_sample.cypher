// Warm-up data: 5 companies, 1 bank, 7 relationships. Replaced by the synthetic generator in Phase 1.
// Planted patterns: A→B→C→A supply cycle, E as a shared supplier of B and D, two firms on one lender.

MERGE (a:Company {tax_id: '1000000001'}) SET a.name = 'Anatolia Textiles Inc.',  a.sector = 'Textiles'
MERGE (b:Company {tax_id: '1000000002'}) SET b.name = 'Bosphorus Logistics Ltd.', b.sector = 'Logistics'
MERGE (c:Company {tax_id: '1000000003'}) SET c.name = 'Capital Foods Inc.',       c.sector = 'Food'
MERGE (d:Company {tax_id: '1000000004'}) SET d.name = 'Tigris Construction Inc.', d.sector = 'Construction'
MERGE (e:Company {tax_id: '1000000005'}) SET e.name = 'Aegean Packaging Ltd.',    e.sector = 'Packaging'
MERGE (k:Bank {code: 'BNK01'}) SET k.name = 'Sample Bank'

// Account 320 (Trade Payables): the counterparty appears as a supplier in the reporting
// company's trial balance → (counterparty)-[:SUPPLIES_TO]->(reporting company)
MERGE (b)-[r1:SUPPLIES_TO {period: '2025-12'}]->(a) SET r1.amount = 1250000, r1.account = '320'
MERGE (c)-[r2:SUPPLIES_TO {period: '2025-12'}]->(b) SET r2.amount = 800000,  r2.account = '320'
MERGE (a)-[r3:SUPPLIES_TO {period: '2025-12'}]->(c) SET r3.amount = 640000,  r3.account = '320'
MERGE (e)-[r4:SUPPLIES_TO {period: '2025-12'}]->(b) SET r4.amount = 300000,  r4.account = '320'
MERGE (e)-[r5:SUPPLIES_TO {period: '2025-12'}]->(d) SET r5.amount = 450000,  r5.account = '320'

// Account 300 (Bank Loans)
MERGE (a)-[r6:BORROWS_FROM {period: '2025-12'}]->(k) SET r6.amount = 5000000, r6.account = '300'
MERGE (d)-[r7:BORROWS_FROM {period: '2025-12'}]->(k) SET r7.amount = 3200000, r7.account = '300';
