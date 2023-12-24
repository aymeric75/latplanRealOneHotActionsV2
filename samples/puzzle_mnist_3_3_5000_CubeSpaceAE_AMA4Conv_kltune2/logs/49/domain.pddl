(define (domain latent)
 (:requirements :strips :negative-preconditions)
 (:predicates (z0) (z1) (z2) (z3) (z4) (z5) (z6) (z7) (z8) (z9) (z10)
  (z11) (z12) (z13) (z14) (z15) (z16) (z17) (z18) (z19) (z20) (z21)
  (z22) (z23) (z24) (z25) (z26) (z27) (z28) (z29) (z30) (z31) (z32)
  (z33) (z34) (z35) (z36) (z37) (z38) (z39) (z40) (z41) (z42) (z43)
  (z44) (z45) (z46) (z47) (z48))
 (:action a0 :parameters () :precondition
  (and (not (z1)) (not (z2)) (not (z3)) (z8) (not (z10)) (not (z23))
       (z27) (not (z28)) (z34) (not (z46)) (z48))
  :effect
  (and (z1) (not (z2)) (z3) (z8) (not (z10)) (z23) (not (z27))
       (not (z28)) (not (z34)) (z46) (not (z48))))
 (:action a1 :parameters () :precondition
  (and (not (z1)) (not (z2)) (z8) (not (z10)) (not (z21)) (not (z26))
       (z27) (not (z28)))
  :effect
  (and (z1) (not (z2)) (not (z8)) (not (z10)) (z21) (z26) (not (z27))
       (not (z28))))
 (:action a2 :parameters () :precondition
  (and (not (z2)) (not (z8)) (not (z10)) (not (z19)) (z21)
       (not (z22)) (z26) (not (z28)) (not (z30)))
  :effect
  (and (not (z2)) (z8) (not (z10)) (z19) (not (z21)) (z22)
       (not (z26)) (z28)))
 (:action a3 :parameters () :precondition
  (and (z1) (not (z2)) (not (z8)) (not (z10)) (z21) (z26) (not (z27))
       (not (z28)))
  :effect
  (and (not (z1)) (not (z2)) (z8) (not (z10)) (not (z21)) (not (z26))
       (z27) (not (z28))))
 (:action a4 :parameters () :precondition
  (and (not (z2)) (not (z8)) (not (z10)) (z16) (not (z28))
       (not (z29)) (not (z36)) (z37))
  :effect
  (and (not (z2)) (z8) (z10) (not (z16)) (z28) (z29) (z36)
       (not (z37))))
 (:action a5 :parameters () :precondition
  (and (not (z2)) (z8) (z10) (z12) (not (z16)) (z17) (z21) (z26)
       (z28) (z29) (z36) (not (z37)))
  :effect
  (and (not (z2)) (z8) (z10) (not (z12)) (z16) (not (z17))
       (not (z21)) (not (z26)) (z28) (not (z29)) (not (z36)) (z37)))
 (:action a6 :parameters () :precondition
  (and (not (z2)) (z8) (z10) (not (z16)) (z28) (z29) (z36)
       (not (z37)))
  :effect
  (and (not (z2)) (not (z8)) (not (z10)) (z16) (not (z28))
       (not (z29)) (not (z36)) (z37)))
 (:action a7 :parameters () :precondition
  (and (z1) (not (z2)) (z3) (z8) (not (z10)) (z23) (not (z27))
       (not (z28)) (not (z34)) (z46) (not (z48)))
  :effect
  (and (not (z1)) (not (z2)) (not (z3)) (z8) (not (z10)) (not (z23))
       (z27) (not (z28)) (z34) (not (z46)) (z48)))
 (:action a8 :parameters () :precondition
  (and (not (z2)) (z7) (z8) (not (z10)) (z13) (z23) (not (z25))
       (not (z28)) (not (z34)) (z46) (not (z48)))
  :effect
  (and (not (z2)) (not (z7)) (z8) (z10) (not (z13)) (not (z23)) (z25)
       (not (z28)) (z34) (not (z46)) (z48)))
 (:action a9 :parameters () :precondition
  (and (not (z2)) (z3) (z8) (not (z10)) (not (z19)) (not (z21))
       (not (z22)) (z23) (not (z28)) (not (z34)) (z46) (not (z48)))
  :effect
  (and (not (z2)) (not (z3)) (z8) (not (z10)) (z19) (not (z21)) (z22)
       (not (z23)) (z28) (z34) (not (z46)) (z48)))
 (:action a10 :parameters () :precondition
  (and (not (z2)) (z8) (not (z10)) (z14) (z19) (not (z21)) (z22)
       (not (z26)) (z28) (not (z30)) (z40))
  :effect
  (and (not (z2)) (not (z8)) (not (z10)) (not (z19)) (z21)
       (not (z22)) (z26) (not (z28)) (not (z30))))
 (:action a11 :parameters () :precondition
  (and (z0) (not (z2)) (z8) (not (z10)) (z19) (z22) (z28) (z35)
       (not (z38)) (z42))
  :effect
  (and (not (z0)) (z2) (z8) (z10) (not (z19)) (not (z22)) (not (z28))
       (not (z35)) (z38) (not (z42))))
 (:action a12 :parameters () :precondition
  (and (not (z2)) (not (z3)) (z8) (not (z10)) (z19) (not (z21)) (z22)
       (not (z23)) (z28) (z34) (not (z46)) (z48))
  :effect
  (and (not (z2)) (z3) (z8) (not (z10)) (not (z19)) (not (z22)) (z23)
       (not (z28)) (not (z34)) (z46) (not (z48))))
 (:action a13 :parameters () :precondition
  (and (not (z2)) (z8) (not (z10)) (z12) (z17) (z19) (z22) (z28))
  :effect
  (and (not (z2)) (z8) (z10) (not (z12)) (not (z17)) (not (z19))
       (not (z22)) (z28)))
 (:action a14 :parameters () :precondition
  (and (not (z2)) (z8) (z10) (not (z12)) (z16) (not (z17))
       (not (z21)) (not (z26)) (z28) (not (z29)) (not (z36)) (z37))
  :effect
  (and (not (z2)) (z8) (z10) (z12) (not (z16)) (z17) (z21) (z26)
       (z28) (z29) (z36) (not (z37))))
 (:action a15 :parameters () :precondition
  (and (not (z2)) (z4) (z8) (z10) (not (z12)) (not (z17)) (z28)
       (not (z31)))
  :effect
  (and (not (z2)) (not (z4)) (z8) (z10) (z12) (z17) (z28) (z31)))
 (:action a16 :parameters () :precondition
  (and (not (z2)) (z8) (z10) (not (z12)) (not (z17)) (not (z19))
       (not (z20)) (not (z22)) (z28))
  :effect
  (and (not (z2)) (z8) (not (z10)) (z12) (z17) (z19) (z22) (z28)))
 (:action a17 :parameters () :precondition
  (and (not (z2)) (not (z7)) (z8) (z10) (not (z13)) (not (z23)) (z25)
       (not (z28)) (z34) (not (z46)) (z48))
  :effect
  (and (not (z2)) (z7) (z8) (not (z10)) (z13) (z23) (not (z25))
       (not (z28)) (not (z34)) (z46) (not (z48))))
 (:action a18 :parameters () :precondition
  (and (z0) (not (z2)) (z3) (not (z7)) (z8) (z10) (not (z13)) (z25)
       (not (z28)) (z35) (not (z38)) (z42))
  :effect
  (and (not (z0)) (z2) (not (z3)) (z7) (z8) (z10) (z13) (not (z25))
       (not (z28)) (not (z35)) (z38) (not (z42))))
 (:action a19 :parameters () :precondition
  (and (not (z0)) (z2) (z8) (z10) (not (z19)) (not (z22)) (not (z28))
       (not (z35)) (z38) (not (z42)))
  :effect
  (and (z0) (not (z2)) (z8) (not (z10)) (z19) (z22) (z28) (z35)
       (not (z38)) (z42)))
 (:action a20 :parameters () :precondition
  (and (not (z0)) (z2) (not (z3)) (z7) (z8) (z10) (z13) (not (z25))
       (not (z28)) (not (z35)) (z38) (not (z42)))
  :effect
  (and (z0) (not (z2)) (z3) (not (z7)) (z8) (z10) (not (z13)) (z25)
       (not (z28)) (z35) (not (z38)) (z42)))
 (:action a21 :parameters () :precondition
  (and (not (z0)) (z2) (z4) (z8) (z10) (not (z28)) (not (z31))
       (not (z35)) (z38) (not (z42)))
  :effect
  (and (z0) (not (z2)) (not (z4)) (z8) (z10) (z28) (z31) (z35)
       (not (z38)) (z42)))
 (:action a22 :parameters () :precondition
  (and (not (z2)) (not (z4)) (z8) (z10) (z12) (z17) (z28) (z31))
  :effect
  (and (not (z2)) (z4) (z8) (z10) (not (z12)) (not (z17)) (z28)
       (not (z31))))
 (:action a23 :parameters () :precondition
  (and (z0) (not (z2)) (not (z4)) (z8) (z10) (z28) (z31) (z35)
       (not (z38)) (not (z39)) (z42))
  :effect
  (and (not (z0)) (z2) (z4) (z8) (z10) (not (z28)) (not (z31))
       (not (z35)) (z38) (not (z42)))))
