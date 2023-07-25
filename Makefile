COMPOSE=docker compose
COMPOSE_DOWN=${COMPOSE} down --remove-orphans
_MAKE=${COMPOSE} run --build --entrypoint /usr/bin/env --remove-orphans --rm nodejs make

.PHONY: all envfile _envfile deps _deps build _build test _test clean _clean

all:

envfile: _envfile
_envfile .env.local:
	touch .env.local

deps: .env.local
	${_MAKE} _deps
	${COMPOSE_DOWN}
_deps:
	npm install --from-lock-file

build: .env.local
	${_MAKE} _build
	${COMPOSE_DOWN}
_build: _deps
	npm run build

test: .env.local
	${_MAKE} _test
	${COMPOSE_DOWN}
_test: .env.local _deps
	npm run test

clean: .env.local
	${_MAKE} _clean
	${COMPOSE_DOWN}
_clean:
	npm run clean
	rm -fr node_modules
