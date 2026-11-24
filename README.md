# Group Transformation Families in Statistics

A Lean 4 formalization of group transformation families (group-equivariant statistical models) and
group invariance in statistics, organized as a [Lean blueprint](https://github.com/PatrickMassot/leanblueprint).

- [Project website](https://andrewmcmk.github.io/GroupInvariance/)
- [Blueprint](https://andrewmcmk.github.io/GroupInvariance/blueprint/) ·
  [PDF](https://andrewmcmk.github.io/GroupInvariance/blueprint.pdf) ·
  [Dependency graph](https://andrewmcmk.github.io/GroupInvariance/blueprint/dep_graph_document.html)
- [API documentation](https://andrewmcmk.github.io/GroupInvariance/docs/)

## Relationship to Statlib

This project is developed on top of [Statlib](https://github.com/stat-lib/statlib), a community
library for formalizing mathematical statistics, and this repository is a GitHub fork of it. The
Statlib library code is included unchanged. This project adds:

- Lean code in `Statlib/Invariance/`
- the blueprint (`blueprint/`), the project website (`home_page/`), and the blueprint CI workflow
  (`.github/workflows/blueprint.yml`)
- `scripts/CheckDecls.lean` and the `checkdecls` executable in `lakefile.toml`, used by
  `leanblueprint checkdecls`

Statlib is released under the Apache License 2.0 (see `LICENSE`).

## Building

```sh
lake exe cache get                  # download prebuilt Mathlib
LEAN_NUM_THREADS=4 lake build       # build (limit parallel jobs on machines with 16 GB RAM)

leanblueprint web         # blueprint/web/index.html (+ dep_graph_document.html)
leanblueprint pdf         # blueprint/print/print.pdf
leanblueprint checkdecls  # check every \lean{...} name exists (run after lake build)
leanblueprint serve       # preview the web version at http://localhost:8000
```

## Blueprint conventions

- `\lean{Name}`: the Lean declaration(s) formalizing a statement.
- `\leanok` in a statement: the Lean statement exists. `\leanok` in a proof: it is fully proved.
- `\uses{label, ...}`: dependencies (drawn as edges in the dependency graph).
