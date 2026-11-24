/-
Copyright (c) 2026 Andrew McCormack. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Andrew McCormack
-/
module

public import Mathlib.MeasureTheory.Group.Arithmetic
public import Mathlib.MeasureTheory.Measure.Map

/-!
# Group transformation families

A parametric family of measures `P : Θ → Measure Ω` is a *group transformation family* for a
group `G` acting on both the sample space `Ω` and the parameter space `Θ` if transforming the data
by `g` is the same as transforming the parameter by `g`.

## Main definitions

* `ProbabilityTheory.IsEquivariantFamily G P`: `P (g • θ) = (P θ).map (g • ·)` for all `g`, `θ`.
* `ProbabilityTheory.IsInvariantStatistic G T`: `T (g • x) = T x` for all `g`, `x`.

## Main statements

* `ProbabilityTheory.IsEquivariantFamily.map_invariant`: in a group transformation family, the law
  of a measurable invariant statistic is constant on orbits of the parameter space.
-/

@[expose] public section

open MeasureTheory

namespace ProbabilityTheory

variable (G : Type*) {Ω Θ 𝓣 : Type*} [Group G] [MeasurableSpace Ω]
  [MulAction G Ω] [MulAction G Θ]

/-- A parametric family of measures `P : Θ → Measure Ω` is a *group transformation family*
(is `G`-equivariant) if transforming the data by `g` is the same as transforming the
parameter by `g`: `P (g • θ) = (P θ).map (g • ·)`. -/
def IsEquivariantFamily (P : Θ → Measure Ω) : Prop :=
  ∀ (g : G) (θ : Θ), P (g • θ) = (P θ).map (fun x ↦ g • x)

/-- A statistic `T : Ω → 𝓣` is `G`-invariant if `T (g • x) = T x` for all `g` and `x`. -/
def IsInvariantStatistic (T : Ω → 𝓣) : Prop :=
  ∀ (g : G) (x : Ω), T (g • x) = T x

variable {G}

/-- In a group transformation family, the distribution of a measurable invariant statistic is
constant on orbits of the parameter space. -/
theorem IsEquivariantFamily.map_invariant [MeasurableSpace 𝓣] [MeasurableSpace G]
    [MeasurableSMul G Ω] {P : Θ → Measure Ω} (hP : IsEquivariantFamily G P)
    {T : Ω → 𝓣} (hT : IsInvariantStatistic G T) (hTm : Measurable T) (g : G) (θ : Θ) :
    (P (g • θ)).map T = (P θ).map T := by
  rw [hP g θ, Measure.map_map hTm (measurable_const_smul g)]
  congr 1
  funext x
  exact hT g x

end ProbabilityTheory
