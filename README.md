# CoqPilot Client Tactic for Coq

## Building the project from sources: 

### Opam setup:
Make sure you have a proper opam switch or create a new one:
```console
opam switch create coqpilotClient 4.13.1
eval $(opam env)
```

Install proper `Coq` version: 
```console
opam pin add coq 8.19.0
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
