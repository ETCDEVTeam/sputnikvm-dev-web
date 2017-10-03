.PHONY: shell build

shell:
	reflex-platform/work-on ghcjs ./.

config:
	cabal configure --ghcjs

build:
	cabal build

dist:
	npm run build:dist

watch: dist
	npm run watch:all

clean:
	npm run clean:all
