"""Verify the Neo4j connection and plugins. Usage: make smoke"""
import os
import sys

from dotenv import load_dotenv
from neo4j import GraphDatabase

load_dotenv()

URI = os.getenv("NEO4J_URI", "bolt://localhost:7687")
AUTH = (os.getenv("NEO4J_USER", "neo4j"), os.environ["NEO4J_PASSWORD"])

CHECKS = {
    "connection": "RETURN 1 AS v",
    "neo4j": "CALL dbms.components() YIELD versions RETURN versions[0] AS v",
    "apoc": "RETURN apoc.version() AS v",
    "gds": "RETURN gds.version() AS v",
    "nodes": "MATCH (n) RETURN count(n) AS v",
    "relationships": "MATCH ()-[r]->() RETURN count(r) AS v",
}


def main() -> int:
    failed = False
    with GraphDatabase.driver(URI, auth=AUTH) as driver:
        for name, query in CHECKS.items():
            try:
                records, _, _ = driver.execute_query(query)
                print(f"  ok   {name:<14} {records[0]['v']}")
            except Exception as exc:  # noqa: BLE001
                failed = True
                print(f"  FAIL {name:<14} {exc.__class__.__name__}: {exc}")
    return 1 if failed else 0


if __name__ == "__main__":
    sys.exit(main())
