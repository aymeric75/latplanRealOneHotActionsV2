(define (domain latent)
 (:requirements :strips :negative-preconditions)
 (:predicates (z0) (z1) (z2) (z3) (z4) (z5) (z6) (z7) (z8) (z9) (z10)
  (z11) (z12) (z13) (z14) (z15) (z16) (z17) (z18) (z19) (z20) (z21)
  (z22) (z23) (z24) (z25) (z26) (z27) (z28) (z29) (z30) (z31) (z32)
  (z33) (z34) (z35) (z36) (z37) (z38) (z39) (z40) (z41) (z42) (z43)
  (z44) (z45) (z46) (z47) (z48) (z49))
 (:action a0 :parameters () :precondition (and) :effect
  (and (z0) (not (z3)) (not (z8)) (not (z11)) (not (z12)) (not (z14))
       (not (z20)) (z21) (not (z28)) (not (z32)) (z34) (not (z35))
       (not (z39)) (not (z40)) (not (z43)) (not (z44))))
 (:action a1 :parameters () :precondition (and) :effect
  (and (not (z3)) (not (z8)) (not (z11)) (not (z12)) (not (z14))
       (z18) (not (z20)) (z21) (not (z28)) (not (z32)) (not (z35))
       (not (z39)) (not (z40)) (not (z43)) (not (z44))))
 (:action a2 :parameters () :precondition (and) :effect
  (and (not (z3)) (not (z5)) (not (z8)) (not (z11)) (not (z12))
       (not (z14)) (not (z20)) (z21) (not (z23)) (not (z26))
       (not (z32)) (not (z35)) (not (z39)) (not (z40)) (not (z41))
       (not (z43)) (not (z44)) (z47)))
 (:action a3 :parameters () :precondition (and) :effect
  (and (not (z3)) (not (z8)) (not (z11)) (not (z12)) (not (z20))
       (z21) (z22) (not (z32)) (not (z35)) (not (z39)) (not (z40))
       (not (z43)) (not (z44))))
 (:action a4 :parameters () :precondition (and) :effect
  (and (not (z3)) (not (z8)) (not (z11)) (not (z12)) (not (z20))
       (z21) (not (z28)) (z31) (not (z32)) (not (z35)) (not (z39))
       (not (z40)) (not (z43)) (not (z44))))
 (:action a5 :parameters () :precondition (and) :effect
  (and (not (z3)) (not (z5)) (not (z8)) (not (z11)) (not (z12)) (z19)
       (not (z20)) (z21) (not (z23)) (not (z32)) (not (z35))
       (not (z39)) (not (z40)) (not (z41)) (not (z43)) (not (z44))))
 (:action a6 :parameters () :precondition (and) :effect
  (and (not (z3)) (not (z5)) (not (z8)) (not (z11)) (not (z12))
       (not (z14)) (not (z20)) (z21) (not (z23)) (z27) (not (z32))
       (not (z35)) (not (z39)) (not (z40)) (not (z41)) (not (z43))
       (not (z44))))
 (:action a7 :parameters () :precondition (and) :effect
  (and (not (z3)) (not (z5)) (not (z8)) (not (z11)) (not (z12))
       (not (z20)) (z21) (not (z28)) (z29) (not (z32)) (not (z35))
       (z38) (not (z39)) (not (z40)) (not (z43)) (not (z44))))
 (:action a8 :parameters () :precondition (and) :effect
  (and (not (z0)) (not (z3)) (not (z8)) (not (z9)) (not (z11))
       (not (z12)) (not (z15)) (not (z20)) (not (z28)) (not (z32))
       (not (z34)) (not (z35)) (z39) (not (z40)) (not (z44))
       (not (z48))))
 (:action a9 :parameters () :precondition (and) :effect
  (and (not (z0)) (not (z3)) (not (z8)) (not (z11)) (not (z12))
       (not (z15)) (z18) (not (z20)) (not (z28)) (not (z32))
       (not (z34)) (not (z35)) (not (z40)) (not (z44)) (not (z48))))
 (:action a10 :parameters () :precondition (and) :effect
  (and (not (z0)) (not (z3)) (not (z8)) (not (z9)) (not (z11))
       (not (z12)) (not (z15)) (not (z20)) (not (z26)) (not (z28))
       (not (z32)) (not (z34)) (not (z35)) (not (z40)) (not (z44))
       (not (z48))))
 (:action a11 :parameters () :precondition (and) :effect
  (and (not (z0)) (not (z3)) (not (z8)) (not (z11)) (not (z12))
       (not (z15)) (not (z20)) (z22) (not (z28)) (not (z32))
       (not (z34)) (not (z35)) (not (z40)) (not (z44)) (not (z48))))
 (:action a12 :parameters () :precondition (and) :effect
  (and (not (z0)) (not (z3)) (not (z8)) (not (z11)) (not (z12))
       (not (z15)) (not (z20)) (not (z28)) (z31) (not (z32))
       (not (z34)) (not (z35)) (not (z40)) (not (z44)) (not (z48))))
 (:action a13 :parameters () :precondition (and) :effect
  (and (not (z0)) (not (z3)) (not (z8)) (not (z11)) (not (z12))
       (not (z15)) (z19) (not (z20)) (not (z32)) (not (z34))
       (not (z35)) (not (z40)) (not (z44)) (not (z48))))
 (:action a14 :parameters () :precondition (and) :effect
  (and (not (z0)) (not (z3)) (z4) (not (z8)) (not (z9)) (not (z11))
       (not (z12)) (not (z15)) (not (z20)) (z27) (not (z32))
       (not (z34)) (not (z35)) (not (z40)) (not (z44))))
 (:action a15 :parameters () :precondition (and) :effect
  (and (not (z0)) (not (z3)) (not (z8)) (not (z9)) (not (z11))
       (not (z12)) (not (z15)) (not (z20)) (not (z28)) (z29)
       (not (z32)) (not (z34)) (not (z35)) (z38) (not (z40))
       (not (z44)) (not (z48))))
 (:action a16 :parameters () :precondition (and) :effect
  (and (not (z3)) (not (z8)) (not (z10)) (not (z11)) (not (z12))
       (not (z18)) (not (z20)) (not (z28)) (z30) (not (z32))
       (not (z35)) (z39) (not (z40)) (not (z44)) (not (z46))
       (not (z48))))
 (:action a17 :parameters () :precondition (and) :effect
  (and (z0) (not (z3)) (not (z8)) (not (z10)) (not (z11)) (not (z12))
       (not (z18)) (not (z20)) (z30) (not (z32)) (not (z35))
       (not (z40)) (not (z44))))
 (:action a18 :parameters () :precondition (and) :effect
  (and (not (z3)) (not (z8)) (not (z10)) (not (z11)) (not (z12))
       (not (z14)) (not (z18)) (not (z20)) (not (z26)) (z30)
       (not (z32)) (not (z35)) (not (z40)) (not (z44))))
 (:action a19 :parameters () :precondition (and) :effect
  (and (not (z3)) (not (z8)) (not (z10)) (not (z11)) (not (z12))
       (not (z18)) (not (z20)) (z22) (z30) (not (z32)) (not (z35))
       (not (z40)) (not (z44))))
 (:action a20 :parameters () :precondition (and) :effect
  (and (not (z3)) (not (z8)) (not (z10)) (not (z11)) (not (z12))
       (not (z14)) (not (z18)) (not (z20)) (not (z28)) (z30) (z31)
       (not (z32)) (not (z35)) (not (z40)) (not (z41)) (not (z44))
       (not (z48))))
 (:action a21 :parameters () :precondition (and) :effect
  (and (not (z3)) (z7) (not (z8)) (not (z10)) (not (z11)) (not (z12))
       (not (z18)) (z19) (not (z20)) (z30) (not (z32)) (not (z35))
       (not (z40)) (not (z44))))
 (:action a22 :parameters () :precondition (and) :effect
  (and (not (z3)) (not (z8)) (not (z10)) (not (z11)) (not (z12))
       (not (z14)) (not (z18)) (not (z20)) (z27) (z30) (not (z32))
       (not (z35)) (not (z40)) (not (z44))))
 (:action a23 :parameters () :precondition (and) :effect
  (and (not (z3)) (not (z8)) (not (z10)) (not (z11)) (not (z12))
       (not (z14)) (not (z18)) (not (z20)) (z29) (z30) (not (z32))
       (not (z35)) (z38) (not (z40)) (not (z44)) (not (z46))))
 (:action a24 :parameters () :precondition (and) :effect
  (and (not (z3)) (not (z8)) (not (z11)) (not (z12)) (not (z20))
       (z26) (not (z28)) (not (z32)) (not (z35)) (z39) (not (z40))
       (not (z44)) (not (z47)) (not (z49))))
 (:action a25 :parameters () :precondition (and) :effect
  (and (z0) (not (z3)) (not (z8)) (not (z11)) (not (z12)) (not (z14))
       (not (z16)) (not (z20)) (z26) (not (z32)) (z34) (not (z35))
       (not (z40)) (not (z42)) (not (z44)) (not (z49))))
 (:action a26 :parameters () :precondition (and) :effect
  (and (not (z3)) (not (z8)) (not (z11)) (not (z12)) (not (z14))
       (z18) (not (z20)) (not (z25)) (z26) (not (z28)) (not (z32))
       (not (z35)) (not (z40)) (not (z42)) (not (z44)) (not (z47))
       (not (z49))))
 (:action a27 :parameters () :precondition (and) :effect
  (and (not (z3)) (not (z8)) (not (z11)) (not (z12)) (not (z20))
       (z22) (z26) (not (z32)) (not (z35)) (not (z40)) (not (z42))
       (not (z44)) (not (z47)) (not (z49))))
 (:action a28 :parameters () :precondition (and) :effect
  (and (not (z3)) (not (z8)) (not (z11)) (not (z12)) (not (z14))
       (not (z20)) (z26) (not (z28)) (z31) (not (z32)) (not (z35))
       (not (z40)) (not (z42)) (not (z44)) (not (z47)) (not (z49))))
 (:action a29 :parameters () :precondition (and) :effect
  (and (not (z3)) (not (z8)) (not (z11)) (not (z12)) (z19)
       (not (z20)) (z26) (not (z28)) (not (z32)) (not (z35))
       (not (z40)) (not (z41)) (not (z42)) (not (z44)) (not (z47))))
 (:action a30 :parameters () :precondition (and) :effect
  (and (not (z3)) (z4) (not (z8)) (not (z11)) (not (z12)) (not (z14))
       (not (z20)) (z26) (z27) (not (z32)) (not (z35)) (not (z40))
       (not (z42)) (not (z44)) (not (z47)) (not (z49))))
 (:action a31 :parameters () :precondition (and) :effect
  (and (not (z3)) (not (z8)) (not (z11)) (not (z12)) (not (z20))
       (z26) (not (z28)) (z29) (not (z32)) (not (z35)) (z38)
       (not (z40)) (not (z42)) (not (z44)) (not (z47))))
 (:action a32 :parameters () :precondition (and) :effect
  (and (not (z3)) (not (z6)) (not (z8)) (not (z11)) (not (z12))
       (not (z14)) (not (z20)) (not (z21)) (not (z22)) (not (z25))
       (not (z28)) (not (z32)) (not (z35)) (z39) (not (z40))
       (not (z44)) (not (z45))))
 (:action a33 :parameters () :precondition (and) :effect
  (and (not (z3)) (not (z6)) (not (z8)) (not (z11)) (not (z12))
       (not (z14)) (not (z20)) (not (z22)) (not (z25)) (not (z28))
       (not (z32)) (not (z35)) (not (z40)) (not (z44)) (not (z45))))
 (:action a34 :parameters () :precondition (and) :effect
  (and (not (z3)) (not (z6)) (not (z8)) (not (z11)) (not (z12))
       (not (z14)) (z18) (not (z20)) (not (z22)) (not (z25))
       (not (z28)) (not (z32)) (not (z35)) (not (z40)) (not (z44))
       (not (z45))))
 (:action a35 :parameters () :precondition (and) :effect
  (and (not (z3)) (not (z6)) (not (z8)) (not (z11)) (not (z12))
       (not (z20)) (not (z22)) (not (z26)) (not (z28)) (not (z32))
       (not (z35)) (not (z40)) (not (z44)) (not (z45))))
 (:action a36 :parameters () :precondition (and) :effect
  (and (not (z3)) (not (z6)) (not (z8)) (not (z11)) (not (z12))
       (not (z14)) (not (z17)) (not (z20)) (not (z22)) (not (z25))
       (not (z28)) (z31) (not (z32)) (not (z35)) (not (z40))
       (not (z44)) (not (z45))))
 (:action a37 :parameters () :precondition (and) :effect
  (and (not (z3)) (not (z6)) (not (z8)) (not (z11)) (not (z12)) (z13)
       (not (z14)) (not (z17)) (z19) (not (z20)) (not (z22))
       (not (z25)) (not (z28)) (not (z32)) (not (z35)) (not (z40))
       (not (z44))))
 (:action a38 :parameters () :precondition (and) :effect
  (and (not (z3)) (z4) (not (z6)) (not (z8)) (not (z11)) (not (z12))
       (not (z14)) (not (z16)) (not (z17)) (not (z20)) (not (z22))
       (not (z25)) (z27) (not (z32)) (not (z35)) (not (z40))
       (not (z44))))
 (:action a39 :parameters () :precondition (and) :effect
  (and (not (z3)) (not (z6)) (not (z8)) (not (z11)) (not (z12))
       (not (z20)) (not (z22)) (not (z28)) (z29) (not (z32))
       (not (z35)) (z38) (not (z40)) (not (z44)) (not (z45))))
 (:action a40 :parameters () :precondition (and) :effect
  (and (not (z1)) (not (z2)) (not (z3)) (not (z8)) (not (z11))
       (not (z12)) (not (z14)) (not (z20)) (not (z28)) (not (z31))
       (not (z32)) (not (z35)) (not (z37)) (z39) (not (z40)) (z43)
       (not (z44))))
 (:action a41 :parameters () :precondition (and) :effect
  (and (z0) (not (z1)) (not (z2)) (not (z3)) (not (z8)) (not (z11))
       (not (z12)) (not (z14)) (not (z20)) (not (z23)) (not (z28))
       (not (z31)) (not (z32)) (not (z35)) (not (z40)) (not (z44))))
 (:action a42 :parameters () :precondition (and) :effect
  (and (not (z1)) (not (z2)) (not (z3)) (not (z8)) (not (z11))
       (not (z12)) (z18) (not (z20)) (not (z28)) (not (z31))
       (not (z32)) (not (z35)) (not (z40)) (not (z41)) (not (z44))))
 (:action a43 :parameters () :precondition (and) :effect
  (and (not (z1)) (not (z2)) (not (z3)) (not (z8)) (not (z11))
       (not (z12)) (not (z20)) (not (z26)) (not (z28)) (not (z31))
       (not (z32)) (not (z35)) (not (z40)) (not (z44))))
 (:action a44 :parameters () :precondition (and) :effect
  (and (not (z1)) (not (z2)) (not (z3)) (z6) (not (z8)) (not (z11))
       (not (z12)) (not (z20)) (z22) (not (z31)) (not (z32))
       (not (z35)) (not (z36)) (not (z40)) (not (z44))))
 (:action a45 :parameters () :precondition (and) :effect
  (and (not (z1)) (not (z2)) (not (z3)) (z7) (not (z8)) (not (z11))
       (not (z12)) (z19) (not (z20)) (not (z31)) (not (z32))
       (not (z35)) (not (z40)) (not (z44))))
 (:action a46 :parameters () :precondition (and) :effect
  (and (not (z1)) (not (z2)) (not (z3)) (not (z8)) (not (z11))
       (not (z12)) (not (z20)) (z27) (not (z31)) (not (z32))
       (not (z35)) (not (z37)) (not (z40)) (not (z44))))
 (:action a47 :parameters () :precondition (and) :effect
  (and (not (z1)) (not (z2)) (not (z3)) (not (z8)) (not (z11))
       (not (z12)) (not (z20)) (z29) (not (z31)) (not (z32))
       (not (z35)) (not (z36)) (z38) (not (z40)) (not (z44))))
 (:action a48 :parameters () :precondition (and) :effect
  (and (not (z3)) (not (z4)) (not (z7)) (not (z8)) (not (z11))
       (not (z12)) (not (z13)) (not (z14)) (not (z19)) (not (z20))
       (not (z23)) (not (z28)) (not (z32)) (not (z35)) (not (z36))
       (not (z37)) (not (z40)) (not (z44)) (not (z46))))
 (:action a49 :parameters () :precondition (and) :effect
  (and (z0) (not (z3)) (not (z4)) (not (z7)) (not (z8)) (not (z11))
       (not (z12)) (not (z13)) (not (z14)) (not (z19)) (not (z20))
       (not (z28)) (not (z32)) (not (z35)) (not (z36)) (not (z37))
       (not (z40)) (not (z44))))
 (:action a50 :parameters () :precondition (and) :effect
  (and (not (z3)) (not (z4)) (not (z7)) (not (z8)) (not (z11))
       (not (z12)) (not (z13)) (not (z14)) (not (z17)) (z18)
       (not (z19)) (not (z20)) (not (z23)) (not (z28)) (not (z32))
       (not (z35)) (not (z37)) (not (z40)) (not (z44))))
 (:action a51 :parameters () :precondition (and) :effect
  (and (not (z3)) (not (z4)) (not (z7)) (not (z8)) (not (z11))
       (not (z12)) (not (z13)) (not (z14)) (not (z19)) (not (z20))
       (not (z23)) (not (z26)) (not (z28)) (not (z32)) (not (z35))
       (not (z37)) (not (z40)) (not (z44))))
 (:action a52 :parameters () :precondition (and) :effect
  (and (not (z3)) (not (z4)) (not (z7)) (not (z8)) (not (z11))
       (not (z12)) (not (z13)) (not (z19)) (not (z20)) (z22)
       (not (z23)) (not (z32)) (not (z35)) (not (z36)) (not (z37))
       (not (z40)) (not (z44))))
 (:action a53 :parameters () :precondition (and) :effect
  (and (not (z3)) (not (z4)) (not (z7)) (not (z8)) (not (z11))
       (not (z12)) (not (z13)) (not (z14)) (not (z19)) (not (z20))
       (not (z28)) (z31) (not (z32)) (not (z35)) (not (z40))
       (not (z44))))
 (:action a54 :parameters () :precondition (and) :effect
  (and (not (z3)) (not (z7)) (not (z8)) (not (z11)) (not (z12))
       (not (z13)) (not (z14)) (not (z19)) (not (z20)) (not (z23))
       (z27) (not (z32)) (not (z35)) (not (z36)) (not (z40))
       (not (z44)) (not (z46))))
 (:action a55 :parameters () :precondition (and) :effect
  (and (not (z3)) (not (z4)) (not (z7)) (not (z8)) (not (z11))
       (not (z12)) (not (z13)) (not (z17)) (not (z19)) (not (z20))
       (not (z28)) (z29) (not (z32)) (not (z35)) (not (z37))
       (not (z40)) (not (z44))))
 (:action a56 :parameters () :precondition (and) :effect
  (and (not (z3)) (not (z4)) (not (z8)) (not (z11)) (not (z12))
       (not (z20)) (not (z27)) (not (z28)) (not (z32)) (not (z33))
       (not (z35)) (z39) (not (z40)) (not (z44)) (not (z48))))
 (:action a57 :parameters () :precondition (and) :effect
  (and (z0) (not (z3)) (not (z4)) (not (z8)) (not (z11)) (not (z12))
       (not (z14)) (not (z20)) (not (z27)) (not (z28)) (not (z32))
       (not (z33)) (z34) (not (z35)) (not (z40)) (not (z44))))
 (:action a58 :parameters () :precondition (and) :effect
  (and (not (z3)) (not (z4)) (not (z8)) (not (z11)) (not (z12))
       (not (z14)) (z18) (not (z20)) (not (z27)) (not (z28))
       (not (z32)) (not (z33)) (not (z35)) (not (z40)) (not (z44))))
 (:action a59 :parameters () :precondition (and) :effect
  (and (not (z3)) (not (z4)) (not (z8)) (not (z11)) (not (z12))
       (not (z20)) (not (z26)) (not (z27)) (not (z28)) (not (z32))
       (not (z33)) (not (z35)) (not (z40)) (not (z44))))
 (:action a60 :parameters () :precondition (and) :effect
  (and (not (z3)) (not (z4)) (not (z8)) (not (z11)) (not (z12))
       (not (z20)) (z22) (not (z27)) (not (z28)) (not (z32))
       (not (z33)) (not (z35)) (not (z40)) (not (z44)) (not (z48))))
 (:action a61 :parameters () :precondition (and) :effect
  (and (not (z3)) (not (z4)) (not (z8)) (not (z11)) (not (z12))
       (not (z14)) (not (z20)) (not (z27)) (not (z28)) (z31)
       (not (z32)) (not (z33)) (not (z35)) (not (z40)) (not (z44))
       (not (z48))))
 (:action a62 :parameters () :precondition (and) :effect
  (and (not (z3)) (not (z8)) (not (z11)) (not (z12)) (z19)
       (not (z20)) (not (z27)) (not (z28)) (not (z32)) (not (z33))
       (not (z35)) (not (z40)) (not (z44)) (not (z48))))
 (:action a63 :parameters () :precondition (and) :effect
  (and (not (z3)) (not (z4)) (not (z8)) (not (z11)) (not (z12))
       (not (z20)) (not (z27)) (not (z28)) (z29) (not (z32))
       (not (z33)) (not (z35)) (not (z40)) (not (z44)) (not (z48))))
 (:action a64 :parameters () :precondition (and) :effect
  (and (not (z3)) (not (z8)) (not (z11)) (not (z12)) (not (z14))
       (not (z20)) (not (z24)) (not (z28)) (not (z29)) (not (z32))
       (not (z35)) (not (z38)) (z39) (not (z40)) (not (z44))))
 (:action a65 :parameters () :precondition (and) :effect
  (and (z0) (not (z3)) (not (z8)) (not (z11)) (not (z12)) (not (z14))
       (not (z20)) (not (z24)) (not (z29)) (not (z32)) (not (z35))
       (not (z38)) (not (z40)) (not (z44))))
 (:action a66 :parameters () :precondition (and) :effect
  (and (not (z3)) (not (z8)) (not (z9)) (not (z11)) (not (z12))
       (not (z14)) (z18) (not (z20)) (not (z24)) (not (z25))
       (not (z28)) (not (z29)) (not (z32)) (not (z35)) (not (z38))
       (not (z40)) (not (z44))))
 (:action a67 :parameters () :precondition (and) :effect
  (and (not (z3)) (not (z8)) (not (z9)) (not (z11)) (not (z12))
       (not (z14)) (not (z20)) (not (z24)) (not (z26)) (not (z28))
       (not (z29)) (not (z32)) (not (z35)) (not (z38)) (not (z40))
       (not (z44))))
 (:action a68 :parameters () :precondition (and) :effect
  (and (not (z3)) (not (z8)) (not (z11)) (not (z12)) (not (z20))
       (z22) (not (z24)) (not (z29)) (not (z32)) (not (z35))
       (not (z38)) (not (z40)) (not (z44))))
 (:action a69 :parameters () :precondition (and) :effect
  (and (not (z3)) (not (z8)) (not (z9)) (not (z11)) (not (z12))
       (not (z14)) (not (z20)) (not (z24)) (not (z25)) (not (z28))
       (not (z29)) (z31) (not (z32)) (not (z35)) (not (z38))
       (not (z40)) (not (z41)) (not (z44)) (not (z46))))
 (:action a70 :parameters () :precondition (and) :effect
  (and (not (z3)) (z7) (not (z8)) (not (z9)) (not (z11)) (not (z12))
       (z19) (not (z20)) (not (z24)) (not (z29)) (not (z32))
       (not (z35)) (not (z38)) (not (z40)) (not (z44))))
 (:action a71 :parameters () :precondition (and) :effect
  (and (not (z3)) (z4) (not (z8)) (not (z11)) (not (z12)) (not (z14))
       (not (z20)) (not (z24)) (not (z25)) (z27) (not (z29))
       (not (z32)) (not (z35)) (not (z38)) (not (z40)) (not (z44))
       (not (z46)))))
