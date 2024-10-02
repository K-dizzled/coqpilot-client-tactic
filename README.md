# CoqPilot Client Tactic for Coq

**NOW ONLY A PROOF OF CONCEPT: UNDER DEVELOPMENT**

## Building the project from sources: 

### Opam setup:
Make sure you have a proper opam switch or create a new one:
```console
opam switch create coqpilotClient ocaml-base-compiler.4.14.0
eval $(opam env)
```

Install proper `Coq` version: 
```console
opam pin add coq 8.19.0
```

(*Optional*) Install `OCaml` language server: 
```console
opam install ocaml-lsp-server=1.16.1
opam install ocamlformat-rpc
```

Add required Coq libraries to opam: 
```console
opam repo add coq-released https://coq.inria.fr/opam/released
opam repo add coq-core-dev https://coq.inria.fr/opam/core-dev
opam repo add coq-extra-dev https://coq.inria.fr/opam/extra-dev
```

Install dependencies and check: 
```console
opam install . --deps-only --with-test
```

Build the project:
```console
dune build
```

Install plugin from sources using opam:
```console
opam install . -w
```

From now on the plugin will be available as `coqpilot` package. You can use contributed `tactics` from `Coq` files as such: 
```coq 
From Coqpilot Require Import Tactics.

Hello.
```

## Notes

When changing switches in opam, don't forget to modify you `coq-lsp` path if you have a custom one. 
