// Warm-up queries — run them one at a time in Neo4j Browser (localhost:7474).

// 1. Whole graph
MATCH (n)-[r]->(m) RETURN n, r, m;

// 2. Circular supply chains (e.g. A→B→C→A)
MATCH p = (c:Company)-[:SUPPLIES_TO*2..5]->(c)
RETURN [n IN nodes(p) | n.name] AS cycle, length(p) AS hops
LIMIT 10;

// 3. Shared suppliers: companies supplying two customers at once
MATCH (s:Company)-[:SUPPLIES_TO]->(x:Company), (s)-[:SUPPLIES_TO]->(y:Company)
WHERE elementId(x) < elementId(y)
RETURN s.name AS supplier, x.name AS customer_1, y.name AS customer_2;
