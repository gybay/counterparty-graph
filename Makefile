include .env
export

CYPHER = docker exec -i counterparty-neo4j cypher-shell -u $(NEO4J_USER) -p $(NEO4J_PASSWORD)

.PHONY: up down logs shell seed smoke reset venv

up:            ## Start Neo4j and wait until healthy
	docker compose up -d --wait
	@echo "Browser: http://localhost:7474"

down:          ## Stop (data is kept)
	docker compose down

logs:
	docker compose logs -f neo4j

shell:         ## Interactive cypher-shell
	docker exec -it counterparty-neo4j cypher-shell -u $(NEO4J_USER) -p $(NEO4J_PASSWORD)

seed:          ## Load constraints and sample data
	$(CYPHER) < graph/seed/00_constraints.cypher
	$(CYPHER) < graph/seed/01_sample.cypher

smoke:         ## Check connection + APOC + GDS
	.venv/bin/python scripts/smoke_test.py

reset:         ## DELETE all data and start fresh
	docker compose down -v
	docker compose up -d --wait

venv:
	python3 -m venv .venv && .venv/bin/pip install -r requirements.txt
