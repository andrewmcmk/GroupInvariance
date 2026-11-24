import Lean

/-!
Local replacement for `PatrickMassot/checkdecls`, which fails on recent Lean versions with
`invalid environment extension, 'Lake.packageAttr' has already been used` (it links Lake and
then imports modules that also import Lake).

Usage (also what `leanblueprint checkdecls` runs): `lake exe checkdecls blueprint/lean_decls`
-/

open Lean

unsafe def main (args : List String) : IO UInt32 := do
  let [filename] := args
    | IO.println "Usage: lake exe checkdecls <file listing one declaration name per line>"
      return 1
  unless ← System.FilePath.pathExists filename do
    IO.println s!"Could not find declaration list {filename}."
    return 1
  initSearchPath (← findSysroot)
  enableInitializersExecution
  let env ← importModules #[{ module := `Statlib }] {} (loadExts := true)
  let mut ok := true
  for line in ← IO.FS.lines filename do
    unless line.isEmpty || env.contains line.toName do
      IO.println s!"{line} is missing."
      ok := false
  return if ok then 0 else 1
