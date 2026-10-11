# Counterparty Graph

A small end-to-end system that models inter-company counterparty relationships extracted from
trial balances (general-ledger account balances with counterparty sub-ledgers) as a Neo4j knowledge
graph, fed by an event-driven AWS pipeline (Lambda + Step Functions, provisioned with Pulumi).
All data is synthetic.

## Layout

```
data/generator/   Synthetic trial-balance generator (Phase 1)
data/synthetic/   Generated data (git-ignored)
graph/seed/       Constraints and warm-up data
graph/queries/    Cypher queries
graph/import/     LOAD CSV directory (mounted as /import in the container)
pipeline/         Parse → validate → transform → load steps (Phase 2)
infra/            Pulumi (Phase 3)
k8s/              minikube manifests (Phase 4)
scripts/          Helper scripts
```

## Quick start

Requirements: Docker (Compose v2), Python 3.11+, make.

```bash
cp .env.example .env          # change NEO4J_PASSWORD (min 8 characters)
make up                       # Neo4j + APOC + GDS, waits until healthy
make venv                     # .venv + neo4j driver
make seed                     # constraints + 5-company sample data
make smoke                    # connection / APOC / GDS / node-count check
```

Browser: <http://localhost:7474> (user `neo4j`, password from `.env`).
Warm-up queries: `graph/queries/00_warmup.cypher`.

Other targets: `make shell` (cypher-shell), `make logs`, `make down`, `make reset` (wipes all data).
