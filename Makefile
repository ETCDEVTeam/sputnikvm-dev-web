.PHONY: shell build

shell:
	reflex-platform/work-on ghcjs ./.

build:
	cabal configure --ghcjs && cabal build

dist:
	npm run build:dist

watch: dist
	npm run watch:all
