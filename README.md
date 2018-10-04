# Web Interface for SputnikVM Development Environment

This is a small wrapper around SputnikVM Development Environment to
provide a web interface when interacting with it. In the future, this
will be bundled together with the `svmdev` executable.

## Get Started

First, clone this repository with its git submodules.

```
git clone https://github.com/ETCDEVTeam/sputnikvm-dev-web.git --recursive 
cd sputnikvm-dev-web
npm install
make shell
make watch
```

Have `svmdev` open. Then go to `http://localhost:3000` to interact
with the interface. Currently, enter a transaction hash, and click
"Debug", it will show the debug information of that transaction.

## Development with Emacs

This package comes with `intero` support. To use it, simply run Emacs
inside `nix-shell`.

## Build Minified Version

```
npm install
make shell
make dist
```

And you can find the minified bundle at `dist/html`.
