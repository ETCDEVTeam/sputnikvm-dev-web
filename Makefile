.PHONY: shell build

shell:
	reflex-platform/work-on ghcjs ./.

build:
	cabal configure --ghcjs && cabal build

serve: build
	cd dist/build/svmdev-web/svmdev-web.jsexe && python -m SimpleHTTPServer 8000
