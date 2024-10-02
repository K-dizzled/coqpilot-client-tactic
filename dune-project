(lang dune 3.8)
(using coq 0.8)
(name coqpilot)

(generate_opam_files true)

(source (github K-dizzled/coqpilot-client-tactic))
(homepage "https://github.com/K-dizzled/coqpilot-client-tactic")
(authors "CoqPilot Team @ JetBrains Research")
(maintainers "Andrei Kozyrev <kozyrev.andrei.a@gmail.com>")

(package
  (name coqpilot)
  (synopsis "CoqPilot: A proof generation plugin for Coq")
  (description "CoqPilot is a plugin that is designed to help automate writing of Coq proofs.
It uses Large Language Models to generate multiple potential proofs and then automatically typechecks them.")
  (sites (share plugins))
  (license MIT)
  (depends
    (ocaml (>= 4.13.1))
    dune
    (dune-site (>= 2.9.1))
    (opam-client (>= 2.1.0))
    (cmdliner (>= 1.1.0))
    (coq (and (>= 8.19.0)))
    conf-git
    (bos (>= 0.2.1))))