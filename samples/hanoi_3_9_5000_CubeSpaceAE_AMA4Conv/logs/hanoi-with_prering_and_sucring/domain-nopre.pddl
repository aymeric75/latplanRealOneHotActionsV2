(define (domain latent)
 (:requirements :strips :negative-preconditions)
 (:predicates (z0) (z1) (z2) (z3) (z4) (z5) (z6) (z7) (z8) (z9) (z10)
  (z11) (z12) (z13) (z14) (z15) (z16) (z17) (z18) (z19) (z20) (z21)
  (z22) (z23) (z24) (z25) (z26) (z27) (z28) (z29) (z30) (z31) (z32)
  (z33) (z34) (z35) (z36) (z37) (z38) (z39) (z40) (z41) (z42) (z43)
  (z44) (z45) (z46) (z47) (z48) (z49))
 (:action a1 :parameters () :precondition (and) :effect
  (and (not (z5)) (z9) (not (z11)) (not (z25)) (z35)))
 (:action a2 :parameters () :precondition (and) :effect
  (and (not (z5)) (z9) (not (z11)) (not (z25)) (z35)))
 (:action a3 :parameters () :precondition (and) :effect
  (and (not (z5)) (z9) (not (z11)) (not (z13)) (not (z20))
       (not (z25)) (not (z39)) (not (z44))))
 (:action a7 :parameters () :precondition (and) :effect
  (and (not (z8)) (not (z10)) (not (z11)) (z34) (not (z35))
       (not (z41)) (not (z43)) (z48)))
 (:action a11 :parameters () :precondition (and) :effect
  (and (not (z1)) (z3) (not (z11))))
 (:action a13 :parameters () :precondition (and) :effect
  (and (z5) (not (z11)) (z20) (z23) (not (z25)) (z31) (z40)
       (not (z49))))
 (:action a14 :parameters () :precondition (and) :effect
  (and (z5) (not (z11)) (not (z13)) (z20) (z23) (not (z25)) (z31)
       (z40) (not (z44))))
 (:action a15 :parameters () :precondition (and) :effect
  (and (not (z5)) (not (z11)) (not (z13)) (not (z20)) (z23)
       (not (z25)) (not (z39)) (not (z44))))
 (:action a18 :parameters () :precondition (and) :effect
  (and (not (z11)) (z22) (z39) (not (z41)) (z43)))
 (:action a19 :parameters () :precondition (and) :effect
  (and (not (z8)) (not (z10)) (not (z11)) (z21) (not (z41))
       (not (z43)) (not (z45))))
 (:action a23 :parameters () :precondition (and) :effect
  (and (not (z1)) (not (z11)) (z21) (z32) (z46)))
 (:action a25 :parameters () :precondition (and) :effect
  (and (not (z11)) (z15) (z22) (not (z25)) (z31) (z40) (z49)))
 (:action a26 :parameters () :precondition (and) :effect
  (and (not (z11)) (z15) (z22) (not (z25)) (z31) (z40) (z42) (z49)))
 (:action a27 :parameters () :precondition (and) :effect
  (and (not (z5)) (not (z11)) (not (z13)) (z15) (not (z20))
       (not (z25)) (z42) (not (z44))))
 (:action a30 :parameters () :precondition (and) :effect
  (and (z4) (not (z11)) (z12) (z16) (z20) (z26) (not (z41))))
 (:action a31 :parameters () :precondition (and) :effect
  (and (not (z8)) (not (z10)) (not (z11)) (not (z35)) (not (z41))
       (not (z43)) (not (z45))))
 (:action a35 :parameters () :precondition (and) :effect
  (and (not (z1)) (not (z11)) (z26)))
 (:action a37 :parameters () :precondition (and) :effect
  (and (z8) (not (z10)) (not (z11)) (z28) (z37) (z44) (not (z45))
       (not (z49))))
 (:action a38 :parameters () :precondition (and) :effect
  (and (z8) (not (z11)) (z28) (z37) (z44)))
 (:action a39 :parameters () :precondition (and) :effect
  (and (not (z2)) (not (z5)) (not (z11)) (not (z13)) (not (z20))
       (not (z25)) (z33) (not (z39)) (not (z44))))
 (:action a42 :parameters () :precondition (and) :effect
  (and (z6) (not (z11)) (z14) (z16) (z18) (not (z27)) (not (z41))
       (z45)))
 (:action a43 :parameters () :precondition (and) :effect
  (and (z6) (not (z8)) (not (z10)) (not (z11)) (not (z35))
       (not (z41)) (not (z43)) (not (z45))))
 (:action a47 :parameters () :precondition (and) :effect
  (and (not (z1)) (not (z11))))
 (:action a49 :parameters () :precondition (and) :effect
  (and (not (z11)) (z18) (not (z25)) (z28) (z38) (z39)))
 (:action a50 :parameters () :precondition (and) :effect
  (and (not (z11)) (z18) (not (z25)) (z28) (not (z35)) (z38) (z39)))
 (:action a51 :parameters () :precondition (and) :effect
  (and (not (z2)) (not (z5)) (not (z11)) (not (z13)) (not (z20))
       (not (z25)) (z31) (not (z39)) (not (z44))))
 (:action a54 :parameters () :precondition (and) :effect
  (and (z0) (z6) (z10) (not (z11)) (z13) (z17) (not (z41)) (z44)
       (not (z45))))
 (:action a55 :parameters () :precondition (and) :effect
  (and (not (z8)) (not (z10)) (not (z11)) (z17) (not (z35))
       (not (z41)) (not (z43)) (not (z45))))
 (:action a59 :parameters () :precondition (and) :effect
  (and (not (z1)) (z2) (not (z11))))
 (:action a61 :parameters () :precondition (and) :effect
  (and (not (z5)) (z9) (not (z11)) (not (z13)) (z14) (z16) (z19)
       (not (z20)) (not (z25)) (z38) (not (z44))))
 (:action a62 :parameters () :precondition (and) :effect
  (and (not (z5)) (z9) (not (z11)) (not (z13)) (z14) (z16) (z19)
       (not (z20)) (not (z25)) (not (z35)) (z38) (not (z44)) (z47)))
 (:action a63 :parameters () :precondition (and) :effect
  (and (not (z5)) (z9) (not (z11)) (not (z13)) (z19) (not (z20))
       (not (z25)) (z38) (not (z44))))
 (:action a67 :parameters () :precondition (and) :effect
  (and (not (z8)) (not (z10)) (not (z11)) (z30) (not (z35))
       (not (z41)) (not (z43)) (not (z45))))
 (:action a71 :parameters () :precondition (and) :effect
  (and (not (z1)) (not (z11)) (z36) (z47)))
 (:action a73 :parameters () :precondition (and) :effect
  (and (not (z11)) (z14) (not (z25)) (z37) (z42) (z45)))
 (:action a74 :parameters () :precondition (and) :effect
  (and (not (z11)) (z14) (not (z25)) (z37) (z42) (z45)))
 (:action a75 :parameters () :precondition (and) :effect
  (and (not (z5)) (not (z11)) (not (z13)) (not (z20)) (not (z25))
       (z37) (not (z44))))
 (:action a79 :parameters () :precondition (and) :effect
  (and (z4) (not (z8)) (not (z10)) (not (z11)) (z29) (not (z35))
       (not (z41)) (not (z43)) (not (z45))))
 (:action a83 :parameters () :precondition (and) :effect
  (and (z7) (not (z11))))
 (:action a85 :parameters () :precondition (and) :effect
  (and (not (z11)) (z12) (not (z25)) (z35)))
 (:action a86 :parameters () :precondition (and) :effect
  (and (not (z5)) (not (z11)) (z12) (not (z13)) (not (z20))
       (not (z25)) (not (z27)) (z35) (not (z44))))
 (:action a87 :parameters () :precondition (and) :effect
  (and (not (z5)) (not (z11)) (not (z13)) (not (z20)) (not (z25))
       (not (z35)) (not (z39)) (not (z44)) (not (z45))))
 (:action a90 :parameters () :precondition (and) :effect
  (and (z4) (z10) (not (z11)) (z30) (z39) (z43) (z46) (z49)))
 (:action a91 :parameters () :precondition (and) :effect
  (and (not (z8)) (z10) (not (z11)) (not (z35)) (not (z41))
       (not (z43)) (not (z45))))
 (:action a95 :parameters () :precondition (and) :effect
  (and (not (z1)) (not (z11)) (z24) (not (z27))))
 (:action a97 :parameters () :precondition (and) :effect
  (and (z5) (not (z9)) (not (z11)) (z13) (z20) (not (z35)) (z44)))
 (:action a98 :parameters () :precondition (and) :effect
  (and (z5) (not (z9)) (not (z11)) (z13) (z20) (z44)))
 (:action a99 :parameters () :precondition (and) :effect
  (and (not (z9)) (not (z11)) (not (z15)) (z25) (not (z35))))
 (:action a102 :parameters () :precondition (and) :effect
  (and (z8) (z10) (not (z11)) (not (z34)) (z35) (z41) (z43) (z45)
       (not (z48))))
 (:action a103 :parameters () :precondition (and) :effect
  (and (not (z4)) (not (z5)) (not (z11)) (not (z16)) (not (z34))
       (z41) (not (z43)) (not (z45)) (not (z48))))
 (:action a107 :parameters () :precondition (and) :effect
  (and (z1) (not (z3)) (not (z11))))
 (:action a110 :parameters () :precondition (and) :effect
  (and (z5) (not (z9)) (not (z11)) (not (z13)) (z20) (z23) (z31)
       (not (z35)) (z40)))
 (:action a111 :parameters () :precondition (and) :effect
  (and (not (z9)) (not (z11)) (not (z15)) (z23) (not (z35))))
 (:action a114 :parameters () :precondition (and) :effect
  (and (not (z11)) (z22) (not (z34)) (z39) (z43) (not (z48))
       (not (z49))))
 (:action a115 :parameters () :precondition (and) :effect
  (and (not (z4)) (not (z5)) (not (z11)) (not (z16)) (z21)
       (not (z34)) (not (z43)) (not (z45)) (not (z47)) (not (z48))))
 (:action a119 :parameters () :precondition (and) :effect
  (and (not (z3)) (not (z11)) (z21) (z32) (z46)))
 (:action a121 :parameters () :precondition (and) :effect
  (and (not (z9)) (not (z11)) (z15) (z22) (z31) (z40) (z49)))
 (:action a122 :parameters () :precondition (and) :effect
  (and (not (z9)) (not (z11)) (z15) (not (z16)) (z22) (z31)
       (not (z35)) (z40) (z42) (z49)))
 (:action a123 :parameters () :precondition (and) :effect
  (and (not (z9)) (not (z11)) (z15) (not (z35)) (z42)))
 (:action a126 :parameters () :precondition (and) :effect
  (and (z4) (not (z11)) (z12) (z16) (z20) (not (z34)) (not (z48))))
 (:action a127 :parameters () :precondition (and) :effect
  (and (not (z4)) (not (z11)) (not (z16)) (not (z34)) (not (z43))
       (not (z45)) (not (z48))))
 (:action a131 :parameters () :precondition (and) :effect
  (and (not (z3)) (not (z11)) (z26)))
 (:action a133 :parameters () :precondition (and) :effect
  (and (z8) (not (z9)) (not (z11)) (z25) (z28) (not (z35)) (z37)
       (z44)))
 (:action a134 :parameters () :precondition (and) :effect
  (and (z8) (not (z9)) (not (z11)) (z25) (z28) (not (z35)) (z37)
       (z44)))
 (:action a135 :parameters () :precondition (and) :effect
  (and (not (z9)) (not (z11)) (z33) (not (z35))))
 (:action a139 :parameters () :precondition (and) :effect
  (and (not (z4)) (not (z5)) (z6) (not (z11)) (not (z16)) (not (z34))
       (not (z43)) (not (z45)) (not (z47)) (not (z48))))
 (:action a143 :parameters () :precondition (and) :effect
  (and (not (z3)) (not (z11))))
 (:action a145 :parameters () :precondition (and) :effect
  (and (not (z9)) (not (z11)) (z18) (z28) (not (z35)) (z38) (z39)))
 (:action a146 :parameters () :precondition (and) :effect
  (and (not (z9)) (not (z11)) (z18) (z28) (z38) (z39) (not (z49))))
 (:action a147 :parameters () :precondition (and) :effect
  (and (not (z9)) (not (z11)) (not (z15)) (z31) (not (z35))
       (not (z49))))
 (:action a151 :parameters () :precondition (and) :effect
  (and (not (z4)) (not (z5)) (not (z11)) (not (z16)) (z17)
       (not (z34)) (not (z43)) (not (z45)) (not (z47)) (not (z48))))
 (:action a155 :parameters () :precondition (and) :effect
  (and (z2) (not (z3)) (not (z11))))
 (:action a157 :parameters () :precondition (and) :effect
  (and (not (z11)) (z14) (z16) (z19) (z38)))
 (:action a158 :parameters () :precondition (and) :effect
  (and (not (z11)) (z14) (z16) (z19) (z38)))
 (:action a159 :parameters () :precondition (and) :effect
  (and (not (z11)) (not (z15)) (z19) (not (z35)) (z38)))
 (:action a162 :parameters () :precondition (and) :effect
  (and (z4) (not (z5)) (not (z11)) (z13) (z17) (z18) (z30)
       (not (z34)) (not (z44)) (z46) (not (z48))))
 (:action a163 :parameters () :precondition (and) :effect
  (and (not (z4)) (not (z5)) (not (z11)) (not (z16)) (z30)
       (not (z34)) (not (z43)) (not (z45)) (not (z47)) (not (z48))))
 (:action a167 :parameters () :precondition (and) :effect
  (and (not (z3)) (not (z11)) (z36) (z47)))
 (:action a169 :parameters () :precondition (and) :effect
  (and (not (z9)) (not (z11)) (not (z26)) (z37) (z42) (z45)))
 (:action a170 :parameters () :precondition (and) :effect
  (and (not (z9)) (not (z11)) (z14) (not (z35)) (z37) (z42) (z45)))
 (:action a171 :parameters () :precondition (and) :effect
  (and (not (z9)) (not (z11)) (not (z35)) (z37)))
 (:action a174 :parameters () :precondition (and) :effect
  (and (not (z11)) (z20) (not (z22)) (z26) (z28) (z29) (not (z34))
       (z41) (not (z44)) (not (z48))))
 (:action a175 :parameters () :precondition (and) :effect
  (and (z4) (not (z5)) (not (z11)) (not (z16)) (z29) (not (z34))
       (not (z43)) (not (z45)) (not (z48))))
 (:action a179 :parameters () :precondition (and) :effect
  (and (z1) (not (z3)) (z7) (not (z11))))
 (:action a181 :parameters () :precondition (and) :effect
  (and (not (z9)) (not (z11)) (z12) (z35)))
 (:action a182 :parameters () :precondition (and) :effect
  (and (not (z9)) (not (z11)) (z12)))
 (:action a183 :parameters () :precondition (and) :effect
  (and (not (z9)) (not (z11)) (not (z15)) (not (z35)) (not (z49))))
 (:action a186 :parameters () :precondition (and) :effect
  (and (z4) (z10) (not (z11)) (z30) (not (z34)) (z39) (z41) (z43)
       (z46) (not (z48)) (z49)))
 (:action a187 :parameters () :precondition (and) :effect
  (and (not (z4)) (not (z5)) (z10) (not (z11)) (not (z16))
       (not (z34)) (not (z43)) (not (z45)) (not (z48))))
 (:action a191 :parameters () :precondition (and) :effect
  (and (not (z3)) (not (z11)) (z24) (not (z27))))
 (:action a193 :parameters () :precondition (and) :effect
  (and (z5) (not (z11)) (z13) (z20) (not (z23)) (not (z31))
       (not (z40)) (z44)))
 (:action a194 :parameters () :precondition (and) :effect
  (and (z5) (not (z11)) (z13) (z20) (not (z23)) (z44)))
 (:action a195 :parameters () :precondition (and) :effect
  (and (not (z5)) (not (z11)) (not (z20)) (not (z23)) (z25)
       (not (z31)) (not (z40))))
 (:action a198 :parameters () :precondition (and) :effect
  (and (z8) (z10) (not (z11)) (not (z21)) (z35) (z41) (z43) (z45)))
 (:action a199 :parameters () :precondition (and) :effect
  (and (not (z11)) (not (z21)) (not (z22)) (not (z39)) (z41)
       (not (z43))))
 (:action a203 :parameters () :precondition (and) :effect
  (and (z1) (not (z11)) (not (z21)) (not (z32)) (not (z46))))
 (:action a205 :parameters () :precondition (and) :effect
  (and (not (z5)) (z9) (not (z11)) (not (z20)) (not (z23))
       (not (z31)) (z35) (not (z40))))
 (:action a206 :parameters () :precondition (and) :effect
  (and (z9) (not (z11)) (not (z23)) (z35)))
 (:action a207 :parameters () :precondition (and) :effect
  (and (not (z5)) (z9) (not (z11)) (not (z18)) (not (z20))
       (not (z23)) (not (z31)) (not (z40))))
 (:action a210 :parameters () :precondition (and) :effect
  (and (z4) (z5) (not (z11)) (z16) (not (z21)) (z43) (z45) (z47)
       (z48)))
 (:action a211 :parameters () :precondition (and) :effect
  (and (not (z11)) (not (z21)) (not (z22)) (z34) (not (z39))
       (not (z43)) (z48)))
 (:action a215 :parameters () :precondition (and) :effect
  (and (z3) (not (z11)) (not (z21)) (not (z32)) (not (z46))))
 (:action a217 :parameters () :precondition (and) :effect
  (and (not (z11)) (not (z12)) (z15) (z22) (not (z23)) (z31) (z40)
       (z42) (not (z44)) (z49)))
 (:action a218 :parameters () :precondition (and) :effect
  (and (not (z5)) (not (z11)) (z15) (not (z20)) (z22) (not (z23))
       (z31) (not (z35)) (z40) (z42) (z49)))
 (:action a219 :parameters () :precondition (and) :effect
  (and (not (z5)) (not (z11)) (z15) (not (z18)) (not (z20))
       (not (z23)) (not (z31)) (not (z40)) (z42)))
 (:action a222 :parameters () :precondition (and) :effect
  (and (z4) (not (z11)) (z12) (z16) (z20) (not (z21))))
 (:action a223 :parameters () :precondition (and) :effect
  (and (not (z11)) (not (z21))))
 (:action a227 :parameters () :precondition (and) :effect
  (and (not (z11)) (not (z21)) (z26) (not (z32)) (not (z46))))
 (:action a229 :parameters () :precondition (and) :effect
  (and (not (z5)) (z8) (not (z11)) (not (z20)) (z21) (not (z23))
       (z25) (z28) (not (z31)) (z37) (not (z40)) (z44) (z49)))
 (:action a230 :parameters () :precondition (and) :effect
  (and (not (z5)) (z8) (not (z11)) (not (z20)) (not (z23)) (z25)
       (z28) (not (z31)) (z37) (not (z40)) (z44)))
 (:action a231 :parameters () :precondition (and) :effect
  (and (not (z5)) (not (z11)) (not (z20)) (not (z23)) (not (z31))
       (z33) (not (z40))))
 (:action a234 :parameters () :precondition (and) :effect
  (and (z6) (not (z11)) (z14) (z16) (z18) (not (z21)) (not (z27))
       (z45) (not (z49))))
 (:action a235 :parameters () :precondition (and) :effect
  (and (z6) (not (z11)) (not (z21)) (not (z22)) (not (z39))
       (not (z43))))
 (:action a239 :parameters () :precondition (and) :effect
  (and (not (z11)) (not (z21)) (not (z32)) (not (z46))))
 (:action a241 :parameters () :precondition (and) :effect
  (and (not (z11)) (z18) (not (z23)) (z28) (z38) (z39)))
 (:action a242 :parameters () :precondition (and) :effect
  (and (not (z11)) (z18) (not (z23)) (z28) (z38) (z39)))
 (:action a243 :parameters () :precondition (and) :effect
  (and (not (z5)) (not (z11)) (not (z20)) (not (z23)) (z31)
       (not (z40))))
 (:action a246 :parameters () :precondition (and) :effect
  (and (z0) (z6) (z10) (not (z11)) (z13) (z17) (not (z21)) (z44)))
 (:action a247 :parameters () :precondition (and) :effect
  (and (not (z11)) (z17) (not (z21)) (not (z39)) (not (z43))))
 (:action a251 :parameters () :precondition (and) :effect
  (and (z2) (not (z11)) (not (z21)) (not (z32)) (not (z46))))
 (:action a253 :parameters () :precondition (and) :effect
  (and (z9) (not (z11)) (z14) (z16) (z19) (not (z23)) (z38)
       (not (z49))))
 (:action a254 :parameters () :precondition (and) :effect
  (and (not (z5)) (z9) (not (z11)) (z14) (z16) (z19) (not (z23))
       (z38)))
 (:action a255 :parameters () :precondition (and) :effect
  (and (not (z5)) (z9) (not (z11)) (not (z18)) (z19) (not (z20))
       (not (z23)) (not (z31)) (z38) (not (z40))))
 (:action a258 :parameters () :precondition (and) :effect
  (and (z4) (not (z11)) (z13) (z17) (z18) (not (z21)) (z30) (z46)))
 (:action a259 :parameters () :precondition (and) :effect
  (and (not (z11)) (not (z21)) (not (z22)) (z30) (not (z39))
       (not (z43))))
 (:action a263 :parameters () :precondition (and) :effect
  (and (not (z11)) (not (z21)) (not (z32)) (z36) (not (z46)) (z47)))
 (:action a265 :parameters () :precondition (and) :effect
  (and (not (z11)) (z14) (not (z23)) (z37) (z42) (z45)))
 (:action a266 :parameters () :precondition (and) :effect
  (and (not (z5)) (not (z11)) (z14) (not (z20)) (not (z23))
       (not (z31)) (z37) (not (z40)) (z42) (z45)))
 (:action a267 :parameters () :precondition (and) :effect
  (and (not (z5)) (not (z11)) (not (z20)) (not (z23)) (not (z31))
       (z37) (not (z40))))
 (:action a270 :parameters () :precondition (and) :effect
  (and (not (z11)) (z20) (not (z21)) (z26) (z28) (z29) (z41)))
 (:action a271 :parameters () :precondition (and) :effect
  (and (z4) (not (z11)) (not (z21)) (not (z22)) (z29) (not (z43))))
 (:action a275 :parameters () :precondition (and) :effect
  (and (z1) (z7) (not (z11)) (not (z21)) (not (z32)) (not (z46))))
 (:action a278 :parameters () :precondition (and) :effect
  (and (not (z11)) (z12) (not (z16)) (not (z23)) (z35)))
 (:action a279 :parameters () :precondition (and) :effect
  (and (not (z5)) (not (z11)) (not (z20)) (not (z23)) (not (z31))
       (not (z40))))
 (:action a282 :parameters () :precondition (and) :effect
  (and (z4) (z10) (not (z11)) (not (z21)) (z30) (not (z35)) (z39)
       (z41) (z43) (z46) (z49)))
 (:action a283 :parameters () :precondition (and) :effect
  (and (z10) (not (z11)) (not (z21)) (not (z22)) (not (z43))))
 (:action a287 :parameters () :precondition (and) :effect
  (and (not (z11)) (not (z21)) (z24) (not (z27)) (not (z32))
       (not (z46))))
 (:action a289 :parameters () :precondition (and) :effect
  (and (z5) (not (z11)) (z13) (not (z15)) (z20) (not (z42)) (z44)))
 (:action a290 :parameters () :precondition (and) :effect
  (and (z5) (not (z11)) (z13) (not (z15)) (z20) (not (z22))
       (not (z31)) (not (z40)) (not (z42)) (z44) (not (z49))))
 (:action a291 :parameters () :precondition (and) :effect
  (and (not (z11)) (not (z13)) (not (z15)) (not (z22)) (z25)
       (not (z31)) (not (z38)) (not (z40)) (not (z41)) (not (z42))
       (not (z49))))
 (:action a295 :parameters () :precondition (and) :effect
  (and (not (z4)) (not (z11)) (not (z12)) (not (z16)) (not (z20))
       (z41)))
 (:action a299 :parameters () :precondition (and) :effect
  (and (z1) (not (z11)) (not (z26))))
 (:action a301 :parameters () :precondition (and) :effect
  (and (not (z5)) (z9) (not (z11)) (not (z15)) (z35) (not (z42))))
 (:action a302 :parameters () :precondition (and) :effect
  (and (z9) (not (z11)) (not (z15)) (z35) (not (z42))))
 (:action a303 :parameters () :precondition (and) :effect
  (and (z9) (not (z11)) (not (z15)) (not (z22)) (not (z31))
       (not (z40)) (not (z42)) (not (z49))))
 (:action a306 :parameters () :precondition (and) :effect
  (and (z4) (z5) (not (z11)) (z16) (z43) (z45) (z47) (z48)))
 (:action a307 :parameters () :precondition (and) :effect
  (and (not (z4)) (not (z11)) (not (z12)) (not (z16)) (not (z20))
       (z34) (z48)))
 (:action a311 :parameters () :precondition (and) :effect
  (and (z3) (not (z11)) (not (z26))))
 (:action a313 :parameters () :precondition (and) :effect
  (and (not (z11)) (not (z15)) (not (z22)) (z23) (not (z42))))
 (:action a314 :parameters () :precondition (and) :effect
  (and (z5) (not (z11)) (not (z15)) (z20) (z23) (z31) (not (z39))
       (z40) (not (z42)) (not (z44)) (z46)))
 (:action a315 :parameters () :precondition (and) :effect
  (and (not (z11)) (not (z15)) (not (z22)) (z23) (not (z31))
       (not (z38)) (not (z40)) (not (z42)) (not (z49))))
 (:action a318 :parameters () :precondition (and) :effect
  (and (not (z11)) (z22) (z39) (z43)))
 (:action a319 :parameters () :precondition (and) :effect
  (and (not (z4)) (not (z11)) (not (z12)) (not (z16)) (not (z20))
       (z21)))
 (:action a323 :parameters () :precondition (and) :effect
  (and (not (z11)) (z21) (not (z26)) (z32) (z46)))
 (:action a325 :parameters () :precondition (and) :effect
  (and (z8) (not (z11)) (not (z15)) (z21) (z25) (z28) (z37)
       (not (z42)) (z44) (z49)))
 (:action a327 :parameters () :precondition (and) :effect
  (and (not (z11)) (not (z13)) (not (z15)) (not (z22)) (not (z31))
       (z33) (not (z38)) (not (z40)) (not (z42)) (not (z49))))
 (:action a330 :parameters () :precondition (and) :effect
  (and (z6) (not (z11)) (z14) (z16) (z18) (not (z27)) (not (z35))
       (z45)))
 (:action a331 :parameters () :precondition (and) :effect
  (and (not (z4)) (z6) (not (z11)) (not (z12)) (not (z16))
       (not (z20))))
 (:action a335 :parameters () :precondition (and) :effect
  (and (not (z11)) (not (z26))))
 (:action a337 :parameters () :precondition (and) :effect
  (and (not (z11)) (not (z15)) (z18) (z28) (z38) (z39) (not (z42))))
 (:action a338 :parameters () :precondition (and) :effect
  (and (not (z11)) (not (z15)) (z18) (not (z22)) (z28) (not (z31))
       (z38) (z39) (not (z40)) (not (z42)) (not (z49))))
 (:action a339 :parameters () :precondition (and) :effect
  (and (not (z11)) (not (z13)) (not (z15)) (not (z16)) (not (z22))
       (z31) (not (z38)) (not (z40)) (not (z42)) (not (z49))))
 (:action a342 :parameters () :precondition (and) :effect
  (and (z0) (z6) (z10) (not (z11)) (z13) (z17) (z44) (not (z45))))
 (:action a343 :parameters () :precondition (and) :effect
  (and (not (z4)) (not (z11)) (not (z12)) (not (z16)) (z17)
       (not (z20))))
 (:action a347 :parameters () :precondition (and) :effect
  (and (z2) (not (z11)) (not (z26))))
 (:action a349 :parameters () :precondition (and) :effect
  (and (z9) (not (z11)) (z14) (not (z15)) (z16) (z19) (z38)
       (not (z42))))
 (:action a350 :parameters () :precondition (and) :effect
  (and (z9) (not (z11)) (z14) (not (z15)) (z16) (z19) (not (z22))
       (not (z31)) (z38) (not (z40)) (not (z42)) (z47) (not (z49))))
 (:action a351 :parameters () :precondition (and) :effect
  (and (z9) (not (z11)) (not (z13)) (not (z15)) (z19) (not (z22))
       (not (z31)) (z38) (not (z40)) (not (z42)) (not (z49))))
 (:action a354 :parameters () :precondition (and) :effect
  (and (z4) (not (z11)) (z13) (z17) (z18) (z30) (z46) (z47)))
 (:action a355 :parameters () :precondition (and) :effect
  (and (not (z4)) (not (z11)) (not (z12)) (not (z16)) (not (z20))
       (z30)))
 (:action a359 :parameters () :precondition (and) :effect
  (and (not (z11)) (not (z26)) (z36) (z47)))
 (:action a361 :parameters () :precondition (and) :effect
  (and (not (z11)) (z14) (not (z15)) (not (z16)) (not (z26))
       (not (z35)) (z37) (z45)))
 (:action a362 :parameters () :precondition (and) :effect
  (and (not (z11)) (z14) (not (z15)) (z37) (z45)))
 (:action a363 :parameters () :precondition (and) :effect
  (and (not (z11)) (not (z13)) (not (z15)) (not (z22)) (not (z31))
       (z37) (not (z38)) (not (z40)) (not (z42)) (not (z49))))
 (:action a366 :parameters () :precondition (and) :effect
  (and (not (z11)) (z20) (z26) (z28) (z29) (z41)))
 (:action a367 :parameters () :precondition (and) :effect
  (and (z4) (not (z11)) (not (z12)) (not (z16)) (not (z20)) (z29)))
 (:action a371 :parameters () :precondition (and) :effect
  (and (z1) (z7) (not (z11)) (not (z26))))
 (:action a373 :parameters () :precondition (and) :effect
  (and (not (z11)) (z12) (not (z15)) (z35) (z40) (not (z41))
       (not (z42))))
 (:action a374 :parameters () :precondition (and) :effect
  (and (not (z11)) (z12) (not (z15)) (not (z22)) (not (z27))
       (not (z31)) (z35) (not (z40)) (not (z42)) (not (z49))))
 (:action a375 :parameters () :precondition (and) :effect
  (and (not (z11)) (not (z15)) (not (z22)) (not (z31)) (not (z39))
       (not (z40)) (not (z42)) (not (z49))))
 (:action a378 :parameters () :precondition (and) :effect
  (and (not (z11)) (not (z23)) (not (z33)) (not (z35)) (not (z38))))
 (:action a379 :parameters () :precondition (and) :effect
  (and (not (z4)) (z10) (not (z11)) (not (z12))))
 (:action a383 :parameters () :precondition (and) :effect
  (and (not (z11)) (z24) (not (z26)) (not (z27))))
 (:action a385 :parameters () :precondition (and) :effect
  (and (z5) (not (z11)) (z13) (z20) (not (z33)) (not (z35)) (z44)))
 (:action a386 :parameters () :precondition (and) :effect
  (and (z5) (not (z11)) (z13) (not (z18)) (z20) (not (z33)) (z44)
       (not (z49))))
 (:action a387 :parameters () :precondition (and) :effect
  (and (not (z8)) (not (z11)) (z25) (not (z28)) (not (z33))
       (not (z35)) (not (z37)) (not (z41)) (not (z44)) (not (z45))
       (not (z49))))
 (:action a390 :parameters () :precondition (and) :effect
  (and (not (z6)) (z8) (z10) (not (z11)) (z35) (z41) (z43) (z45)))
 (:action a391 :parameters () :precondition (and) :effect
  (and (not (z6)) (not (z11)) (not (z14)) (not (z16)) (not (z18))
       (z27) (z41) (not (z45))))
 (:action a395 :parameters () :precondition (and) :effect
  (and (z1) (not (z11))))
 (:action a397 :parameters () :precondition (and) :effect
  (and (not (z5)) (z9) (not (z11)) (not (z33)) (z35)))
 (:action a398 :parameters () :precondition (and) :effect
  (and (not (z8)) (z9) (not (z11)) (not (z25)) (not (z28))
       (not (z33)) (z35) (not (z37)) (not (z44)) (not (z45))))
 (:action a399 :parameters () :precondition (and) :effect
  (and (not (z8)) (z9) (not (z11)) (not (z25)) (not (z28))
       (not (z33)) (not (z37)) (not (z44))))
 (:action a402 :parameters () :precondition (and) :effect
  (and (not (z11))))
 (:action a403 :parameters () :precondition (and) :effect
  (and (not (z6)) (not (z11)) (not (z14)) (not (z16)) (not (z18))
       (z34) (not (z45)) (z48)))
 (:action a407 :parameters () :precondition (and) :effect
  (and (z3) (not (z11))))
 (:action a409 :parameters () :precondition (and) :effect
  (and (z5) (not (z11)) (z20) (z21) (z23) (z31) (not (z33)) (z40)))
 (:action a410 :parameters () :precondition (and) :effect
  (and (z5) (not (z8)) (not (z11)) (z20) (z23) (not (z25))
       (not (z28)) (z31) (not (z33)) (not (z37)) (z40) (not (z44))))
 (:action a411 :parameters () :precondition (and) :effect
  (and (not (z8)) (not (z11)) (not (z21)) (z23) (not (z25))
       (not (z28)) (not (z33)) (not (z37)) (not (z44)) (not (z49))))
 (:action a414 :parameters () :precondition (and) :effect
  (and (not (z6)) (not (z11)) (z21) (z22) (not (z35)) (z39) (z43)))
 (:action a415 :parameters () :precondition (and) :effect
  (and (not (z6)) (not (z11)) (not (z14)) (not (z16)) (not (z18))
       (z21) (not (z45))))
 (:action a419 :parameters () :precondition (and) :effect
  (and (not (z5)) (not (z11)) (z21) (z32) (z46)))
 (:action a421 :parameters () :precondition (and) :effect
  (and (not (z11)) (z15) (z22) (z31) (not (z33)) (z40) (z49)))
 (:action a422 :parameters () :precondition (and) :effect
  (and (not (z11)) (z15) (z22) (z31) (not (z33)) (z40) (z42) (z49)))
 (:action a423 :parameters () :precondition (and) :effect
  (and (not (z11)) (z15) (not (z28)) (not (z33)) (not (z35))
       (not (z37)) (z42) (not (z49))))
 (:action a426 :parameters () :precondition (and) :effect
  (and (z4) (not (z6)) (not (z11)) (z12) (z16) (not (z18)) (z20)
       (z26)))
 (:action a427 :parameters () :precondition (and) :effect
  (and (not (z6)) (not (z11)) (not (z14)) (not (z16)) (not (z18))
       (z27) (not (z45))))
 (:action a431 :parameters () :precondition (and) :effect
  (and (not (z11)) (z26)))
 (:action a433 :parameters () :precondition (and) :effect
  (and (not (z11)) (z18) (z28) (not (z33)) (z38) (z39) (not (z44))))
 (:action a434 :parameters () :precondition (and) :effect
  (and (not (z8)) (not (z11)) (z18) (not (z25)) (z28) (not (z33))
       (not (z37)) (z38) (z39) (not (z44))))
 (:action a435 :parameters () :precondition (and) :effect
  (and (not (z8)) (not (z11)) (not (z25)) (not (z28)) (z31)
       (not (z33)) (not (z35)) (not (z37)) (not (z44)) (not (z49))))
 (:action a439 :parameters () :precondition (and) :effect
  (and (not (z6)) (not (z11)) (not (z14)) (not (z16)) (z17)
       (not (z18)) (z27) (not (z45))))
 (:action a443 :parameters () :precondition (and) :effect
  (and (z2) (not (z11))))
 (:action a445 :parameters () :precondition (and) :effect
  (and (z9) (not (z11)) (not (z13)) (z14) (z16) (z19) (not (z33))
       (not (z35)) (z38)))
 (:action a446 :parameters () :precondition (and) :effect
  (and (z9) (not (z11)) (z14) (z16) (z19) (not (z33)) (z38)))
 (:action a447 :parameters () :precondition (and) :effect
  (and (not (z8)) (z9) (not (z11)) (z19) (not (z25)) (not (z28))
       (not (z33)) (not (z37)) (z38) (not (z44))))
 (:action a450 :parameters () :precondition (and) :effect
  (and (z4) (not (z6)) (not (z11)) (z13) (z17) (z18) (z30)
       (not (z35)) (not (z44)) (z46)))
 (:action a451 :parameters () :precondition (and) :effect
  (and (not (z6)) (not (z11)) (not (z14)) (not (z16)) (not (z18))
       (z30) (not (z45))))
 (:action a455 :parameters () :precondition (and) :effect
  (and (not (z11)) (z36) (z47)))
 (:action a457 :parameters () :precondition (and) :effect
  (and (not (z10)) (not (z11)) (z14) (not (z33)) (z37) (z42) (z45)
       (not (z49))))
 (:action a458 :parameters () :precondition (and) :effect
  (and (not (z11)) (z14) (not (z33)) (z37) (z42) (z45)))
 (:action a459 :parameters () :precondition (and) :effect
  (and (not (z8)) (not (z11)) (not (z25)) (not (z28)) (not (z33))
       (z37) (not (z44))))
 (:action a462 :parameters () :precondition (and) :effect
  (and (not (z6)) (not (z10)) (not (z11)) (z20) (z26) (z28) (z29)
       (z41)))
 (:action a463 :parameters () :precondition (and) :effect
  (and (z4) (not (z6)) (not (z11)) (not (z14)) (not (z16))
       (not (z18)) (z29) (not (z45))))
 (:action a467 :parameters () :precondition (and) :effect
  (and (z1) (z7) (not (z11))))
 (:action a469 :parameters () :precondition (and) :effect
  (and (not (z8)) (not (z11)) (z12) (not (z25)) (not (z28))
       (not (z33)) (z35) (not (z37)) (not (z41)) (not (z44))))
 (:action a470 :parameters () :precondition (and) :effect
  (and (not (z8)) (not (z11)) (z12) (not (z25)) (not (z28))
       (not (z33)) (z35) (not (z37)) (not (z44))))
 (:action a471 :parameters () :precondition (and) :effect
  (and (not (z8)) (not (z10)) (not (z11)) (not (z25)) (z27)
       (not (z28)) (not (z33)) (not (z35)) (not (z37)) (not (z44))
       (not (z49))))
 (:action a474 :parameters () :precondition (and) :effect
  (and (z4) (not (z6)) (z10) (not (z11)) (z30) (z39) (z41) (z43)
       (z46) (z49)))
 (:action a475 :parameters () :precondition (and) :effect
  (and (not (z6)) (z10) (not (z11)) (not (z14)) (not (z16))
       (not (z18)) (z27) (not (z45))))
 (:action a479 :parameters () :precondition (and) :effect
  (and (not (z11)) (z24) (not (z27))))
 (:action a481 :parameters () :precondition (and) :effect
  (and (z5) (not (z11)) (z13) (z20) (not (z31)) (z44)))
 (:action a482 :parameters () :precondition (and) :effect
  (and (z5) (not (z11)) (z13) (z20) (not (z31)) (z44)))
 (:action a483 :parameters () :precondition (and) :effect
  (and (not (z11)) (not (z18)) (z25) (not (z28)) (not (z31))
       (not (z38)) (not (z39))))
 (:action a486 :parameters () :precondition (and) :effect
  (and (z8) (z10) (not (z11)) (not (z17)) (z35) (z41) (z43) (z45)))
 (:action a487 :parameters () :precondition (and) :effect
  (and (not (z0)) (not (z6)) (not (z10)) (not (z11)) (not (z13))
       (not (z17)) (z41) (not (z44))))
 (:action a491 :parameters () :precondition (and) :effect
  (and (z1) (not (z2)) (not (z11))))
 (:action a493 :parameters () :precondition (and) :effect
  (and (z9) (not (z11)) (not (z18)) (not (z28)) (not (z31)) (z35)
       (not (z38)) (not (z39))))
 (:action a494 :parameters () :precondition (and) :effect
  (and (z9) (not (z11)) (not (z31)) (z35)))
 (:action a495 :parameters () :precondition (and) :effect
  (and (z9) (not (z11)) (not (z28)) (not (z31)) (not (z38))
       (not (z39))))
 (:action a498 :parameters () :precondition (and) :effect
  (and (z4) (z5) (not (z11)) (z16) (not (z17)) (z43) (z45) (z47)
       (z48)))
 (:action a499 :parameters () :precondition (and) :effect
  (and (not (z0)) (not (z6)) (not (z10)) (not (z11)) (not (z13))
       (not (z17)) (z34) (not (z44)) (z48)))
 (:action a503 :parameters () :precondition (and) :effect
  (and (not (z2)) (z3) (not (z11))))
 (:action a505 :parameters () :precondition (and) :effect
  (and (z5) (not (z11)) (not (z14)) (not (z18)) (z20) (z23)
       (not (z28)) (z31) (not (z38)) (not (z39)) (z40) (not (z45))))
 (:action a506 :parameters () :precondition (and) :effect
  (and (z5) (not (z10)) (not (z11)) (z20) (z21) (z23) (z40)
       (not (z49))))
 (:action a507 :parameters () :precondition (and) :effect
  (and (not (z11)) (not (z18)) (z23) (not (z28)) (not (z31))
       (not (z38)) (not (z39))))
 (:action a510 :parameters () :precondition (and) :effect
  (and (not (z5)) (not (z11)) (not (z17)) (z22) (not (z35)) (z39)
       (z43) (not (z45))))
 (:action a511 :parameters () :precondition (and) :effect
  (and (not (z0)) (not (z6)) (not (z10)) (not (z11)) (not (z13))
       (not (z17)) (z21) (not (z44))))
 (:action a515 :parameters () :precondition (and) :effect
  (and (not (z2)) (not (z11)) (z21) (z32) (z46)))
 (:action a517 :parameters () :precondition (and) :effect
  (and (not (z11)) (z15) (not (z18)) (z22) (not (z28)) (z31)
       (not (z38)) (not (z39)) (z40) (not (z44)) (z49)))
 (:action a518 :parameters () :precondition (and) :effect
  (and (not (z11)) (z15) (not (z18)) (z22) (z40) (z42) (z49)))
 (:action a519 :parameters () :precondition (and) :effect
  (and (not (z11)) (z15) (not (z18)) (not (z28)) (not (z31))
       (not (z38)) (not (z39)) (z42)))
 (:action a522 :parameters () :precondition (and) :effect
  (and (z4) (not (z11)) (z12) (z16) (not (z17)) (z20)))
 (:action a523 :parameters () :precondition (and) :effect
  (and (not (z0)) (not (z6)) (not (z10)) (not (z11)) (not (z13))
       (not (z17)) (not (z44))))
 (:action a527 :parameters () :precondition (and) :effect
  (and (not (z2)) (not (z11)) (z26)))
 (:action a529 :parameters () :precondition (and) :effect
  (and (z8) (not (z11)) (not (z18)) (z25) (z28) (not (z31)) (z37)
       (not (z38)) (not (z39)) (z44)))
 (:action a530 :parameters () :precondition (and) :effect
  (and (z8) (not (z11)) (z25) (z28) (not (z31)) (z37) (z44)))
 (:action a531 :parameters () :precondition (and) :effect
  (and (not (z11)) (not (z18)) (not (z28)) (not (z31)) (z33)
       (not (z38)) (not (z39))))
 (:action a534 :parameters () :precondition (and) :effect
  (and (z6) (not (z11)) (z14) (z16) (not (z17)) (z18) (not (z27))
       (z45)))
 (:action a535 :parameters () :precondition (and) :effect
  (and (not (z0)) (z6) (not (z10)) (not (z11)) (not (z13))
       (not (z17)) (not (z44))))
 (:action a539 :parameters () :precondition (and) :effect
  (and (not (z2)) (not (z11))))
 (:action a541 :parameters () :precondition (and) :effect
  (and (z9) (not (z11)) (z14) (z16) (not (z18)) (z19) (not (z28))
       (not (z31)) (z38) (not (z39))))
 (:action a543 :parameters () :precondition (and) :effect
  (and (z9) (not (z11)) (not (z18)) (z19) (not (z28)) (not (z31))
       (z38) (not (z39))))
 (:action a546 :parameters () :precondition (and) :effect
  (and (z4) (not (z11)) (z13) (z18) (z30) (not (z45)) (z46)))
 (:action a547 :parameters () :precondition (and) :effect
  (and (not (z0)) (not (z6)) (not (z10)) (not (z11)) (not (z13))
       (not (z17)) (z30) (not (z44))))
 (:action a551 :parameters () :precondition (and) :effect
  (and (not (z2)) (not (z11)) (z36) (z47)))
 (:action a553 :parameters () :precondition (and) :effect
  (and (not (z11)) (z14) (not (z28)) (not (z31)) (z37) (z42) (z45)))
 (:action a554 :parameters () :precondition (and) :effect
  (and (not (z11)) (z14) (not (z31)) (z37) (z42) (z45)))
 (:action a555 :parameters () :precondition (and) :effect
  (and (not (z11)) (not (z28)) (not (z31)) (z37) (not (z38))
       (not (z39))))
 (:action a558 :parameters () :precondition (and) :effect
  (and (not (z11)) (not (z17)) (z20) (z26) (z28) (z29) (z41)))
 (:action a559 :parameters () :precondition (and) :effect
  (and (not (z0)) (z4) (not (z6)) (not (z10)) (not (z11)) (not (z13))
       (not (z17)) (z29) (not (z44))))
 (:action a563 :parameters () :precondition (and) :effect
  (and (z1) (not (z2)) (z7) (not (z11))))
 (:action a565 :parameters () :precondition (and) :effect
  (and (not (z11)) (z12) (not (z22)) (not (z31)) (z35) (z40)
       (not (z41))))
 (:action a566 :parameters () :precondition (and) :effect
  (and (not (z11)) (z12) (not (z18)) (not (z28)) (not (z31)) (z35)
       (not (z38)) (not (z39)) (not (z49))))
 (:action a567 :parameters () :precondition (and) :effect
  (and (not (z10)) (not (z11)) (not (z18)) (not (z28)) (not (z31))
       (not (z38)) (not (z39)) (not (z44))))
 (:action a570 :parameters () :precondition (and) :effect
  (and (z4) (z10) (not (z11)) (not (z17)) (z30) (z39) (z41) (z43)
       (z46) (z49)))
 (:action a571 :parameters () :precondition (and) :effect
  (and (not (z0)) (not (z6)) (z10) (not (z11)) (not (z13))
       (not (z17))))
 (:action a575 :parameters () :precondition (and) :effect
  (and (not (z2)) (not (z11)) (z24) (not (z27))))
 (:action a577 :parameters () :precondition (and) :effect
  (and (z5) (not (z9)) (not (z11)) (z13) (not (z19)) (z20)
       (not (z38)) (z44)))
 (:action a578 :parameters () :precondition (and) :effect
  (and (z5) (not (z9)) (not (z11)) (z13) (not (z14)) (not (z16))
       (not (z19)) (z20) (not (z38)) (z44)))
 (:action a579 :parameters () :precondition (and) :effect
  (and (not (z9)) (not (z11)) (not (z14)) (not (z16)) (not (z19))
       (z25) (not (z38))))
 (:action a582 :parameters () :precondition (and) :effect
  (and (z8) (z10) (not (z11)) (not (z14)) (not (z16)) (not (z30))
       (z35) (z41) (z43) (z45)))
 (:action a583 :parameters () :precondition (and) :effect
  (and (not (z4)) (not (z11)) (not (z13)) (not (z17)) (not (z18))
       (not (z30)) (z41)))
 (:action a587 :parameters () :precondition (and) :effect
  (and (z1) (not (z11)) (not (z36)) (not (z47))))
 (:action a589 :parameters () :precondition (and) :effect
  (and (not (z11)) (not (z14)) (not (z16)) (not (z19)) (z35)
       (not (z38)) (z47)))
 (:action a590 :parameters () :precondition (and) :effect
  (and (not (z5)) (not (z11)) (not (z14)) (not (z16)) (not (z19))
       (not (z22)) (z35) (not (z38)) (not (z44))))
 (:action a591 :parameters () :precondition (and) :effect
  (and (not (z11)) (not (z14)) (not (z16)) (not (z19)) (not (z38))))
 (:action a594 :parameters () :precondition (and) :effect
  (and (z4) (z5) (not (z11)) (z16) (not (z30)) (z43) (z45) (z47)
       (z48)))
 (:action a595 :parameters () :precondition (and) :effect
  (and (not (z4)) (not (z11)) (not (z13)) (not (z17)) (not (z18))
       (not (z30)) (z34) (not (z46)) (z48)))
 (:action a599 :parameters () :precondition (and) :effect
  (and (z3) (not (z11)) (not (z36)) (not (z47))))
 (:action a601 :parameters () :precondition (and) :effect
  (and (z5) (not (z9)) (not (z11)) (not (z19)) (z20) (z21) (z23)
       (z31) (not (z38)) (z40) (not (z44))))
 (:action a602 :parameters () :precondition (and) :effect
  (and (z5) (not (z9)) (not (z11)) (not (z14)) (not (z16))
       (not (z19)) (z20) (z23) (z31) (not (z38)) (z40)))
 (:action a603 :parameters () :precondition (and) :effect
  (and (not (z9)) (not (z11)) (not (z14)) (not (z16)) (not (z19))
       (z23) (not (z38))))
 (:action a606 :parameters () :precondition (and) :effect
  (and (not (z11)) (z22) (not (z30)) (z39) (z43) (z46)))
 (:action a607 :parameters () :precondition (and) :effect
  (and (not (z4)) (not (z11)) (not (z13)) (not (z17)) (not (z18))
       (z21) (not (z30)) (not (z46))))
 (:action a611 :parameters () :precondition (and) :effect
  (and (not (z11)) (z21) (z32) (not (z36)) (z46) (not (z47))))
 (:action a613 :parameters () :precondition (and) :effect
  (and (not (z9)) (not (z11)) (not (z14)) (z15) (not (z16))
       (not (z19)) (z22) (z31) (not (z38)) (z40) (z49)))
 (:action a614 :parameters () :precondition (and) :effect
  (and (not (z9)) (not (z11)) (z15) (not (z19)) (z22) (z31)
       (not (z38)) (z40) (z42) (z49)))
 (:action a615 :parameters () :precondition (and) :effect
  (and (not (z5)) (not (z9)) (not (z11)) (not (z12)) (not (z14))
       (z15) (not (z16)) (not (z19)) (not (z38)) (z42)))
 (:action a618 :parameters () :precondition (and) :effect
  (and (z4) (not (z11)) (z12) (z16) (z20) (not (z30))))
 (:action a619 :parameters () :precondition (and) :effect
  (and (not (z4)) (not (z11)) (not (z13)) (not (z17)) (not (z18))
       (not (z30)) (not (z46))))
 (:action a623 :parameters () :precondition (and) :effect
  (and (not (z11)) (z26) (not (z36)) (not (z47))))
 (:action a625 :parameters () :precondition (and) :effect
  (and (z8) (not (z9)) (not (z11)) (not (z19)) (z21) (z25) (z28)
       (z37) (not (z38)) (z44) (z49)))
 (:action a626 :parameters () :precondition (and) :effect
  (and (z8) (not (z9)) (not (z11)) (not (z14)) (not (z16))
       (not (z19)) (z25) (z28) (z37) (not (z38)) (z44)))
 (:action a627 :parameters () :precondition (and) :effect
  (and (not (z9)) (not (z11)) (not (z12)) (not (z14)) (not (z15))
       (not (z16)) (not (z19)) (z33) (not (z38))))
 (:action a630 :parameters () :precondition (and) :effect
  (and (z6) (not (z11)) (z14) (z16) (z18) (not (z27)) (not (z30))
       (z45)))
 (:action a631 :parameters () :precondition (and) :effect
  (and (not (z4)) (z6) (not (z11)) (not (z13)) (not (z17))
       (not (z18)) (not (z30)) (not (z46))))
 (:action a635 :parameters () :precondition (and) :effect
  (and (not (z11)) (not (z36)) (not (z47))))
 (:action a637+11 :parameters () :precondition (and (not (z11)))
  :effect
  (and (not (z0)) (not (z9)) (z11) (z18) (not (z19)) (z28) (z39)))
 (:action a637-11 :parameters () :precondition (and (z11)) :effect
  (and (not (z0)) (not (z9)) (not (z11)) (z18) (not (z19)) (z28)
       (z39)))
 (:action a638 :parameters () :precondition (and) :effect
  (and (not (z9)) (not (z11)) (z18) (not (z19)) (z28) (z39)))
 (:action a639 :parameters () :precondition (and) :effect
  (and (not (z9)) (not (z11)) (not (z14)) (not (z16)) (not (z19))
       (z31) (not (z38))))
 (:action a643 :parameters () :precondition (and) :effect
  (and (not (z4)) (not (z11)) (not (z13)) (z17) (not (z18))
       (not (z30)) (not (z46))))
 (:action a647 :parameters () :precondition (and) :effect
  (and (z2) (not (z11)) (not (z36)) (not (z47))))
 (:action a650 :parameters () :precondition (and) :effect
  (and (not (z9)) (not (z11)) (z14) (not (z19)) (z37) (not (z38))
       (z42) (z45)))
 (:action a651 :parameters () :precondition (and) :effect
  (and (not (z9)) (not (z11)) (not (z14)) (not (z16)) (not (z19))
       (z37) (not (z38))))
 (:action a654 :parameters () :precondition (and) :effect
  (and (not (z10)) (not (z11)) (z20) (z26) (z28) (z29) (not (z30))
       (z41) (not (z45)) (not (z49))))
 (:action a655 :parameters () :precondition (and) :effect
  (and (z4) (not (z11)) (not (z13)) (not (z17)) (not (z18)) (z29)
       (not (z30)) (not (z46))))
 (:action a659 :parameters () :precondition (and) :effect
  (and (z1) (z7) (not (z11)) (not (z36)) (not (z47))))
 (:action a661 :parameters () :precondition (and) :effect
  (and (not (z9)) (not (z11)) (z12) (not (z14)) (not (z16))
       (not (z19)) (z35) (not (z38))))
 (:action a662 :parameters () :precondition (and) :effect
  (and (not (z9)) (not (z11)) (z12) (not (z19)) (z35) (not (z38))))
 (:action a663 :parameters () :precondition (and) :effect
  (and (not (z9)) (not (z10)) (not (z11)) (not (z14)) (not (z15))
       (not (z16)) (not (z19)) (z27) (not (z35)) (not (z38))))
 (:action a666 :parameters () :precondition (and) :effect
  (and (z4) (z10) (not (z11)) (z39) (z41) (z43) (z46) (z49)))
 (:action a667 :parameters () :precondition (and) :effect
  (and (not (z4)) (z10) (not (z11)) (not (z13)) (not (z17))
       (not (z18)) (not (z30))))
 (:action a671 :parameters () :precondition (and) :effect
  (and (not (z11)) (z24) (not (z27)) (not (z36)) (not (z47))))
 (:action a673 :parameters () :precondition (and) :effect
  (and (z5) (not (z11)) (z13) (not (z14)) (z20) (not (z37))
       (not (z42)) (z44) (not (z45))))
 (:action a674 :parameters () :precondition (and) :effect
  (and (z5) (not (z11)) (z13) (z20) (not (z37)) (z44)))
 (:action a675 :parameters () :precondition (and) :effect
  (and (not (z11)) (not (z14)) (z25) (not (z37)) (not (z42))
       (not (z45))))
 (:action a679 :parameters () :precondition (and) :effect
  (and (not (z4)) (not (z11)) (not (z26)) (not (z29)) (z41)))
 (:action a683 :parameters () :precondition (and) :effect
  (and (not (z7)) (not (z11))))
 (:action a685 :parameters () :precondition (and) :effect
  (and (z9) (not (z11)) (not (z14)) (z35) (not (z37)) (not (z45))))
 (:action a686 :parameters () :precondition (and) :effect
  (and (z9) (not (z11)) (z35) (not (z37)) (not (z49))))
 (:action a687 :parameters () :precondition (and) :effect
  (and (z9) (not (z11)) (not (z14)) (not (z37)) (not (z42))
       (not (z44)) (not (z45))))
 (:action a690 :parameters () :precondition (and) :effect
  (and (z5) (not (z11)) (z16) (not (z29)) (z43) (z45) (z47) (z48)))
 (:action a691 :parameters () :precondition (and) :effect
  (and (not (z4)) (not (z11)) (not (z20)) (not (z28)) (not (z29))
       (z34) (not (z41)) (z48)))
 (:action a695 :parameters () :precondition (and) :effect
  (and (not (z1)) (z3) (not (z7)) (not (z11))))
 (:action a697 :parameters () :precondition (and) :effect
  (and (z5) (not (z11)) (z20) (z23) (z31) (not (z37)) (z40)))
 (:action a698 :parameters () :precondition (and) :effect
  (and (z5) (not (z11)) (not (z14)) (z20) (z21) (z23) (z31)
       (not (z37)) (z40) (not (z42)) (not (z45))))
 (:action a699 :parameters () :precondition (and) :effect
  (and (not (z11)) (not (z14)) (z23) (not (z37)) (not (z42))
       (not (z45))))
 (:action a702 :parameters () :precondition (and) :effect
  (and (not (z4)) (not (z11)) (z22) (not (z29)) (z39) (z43)))
 (:action a703 :parameters () :precondition (and) :effect
  (and (not (z4)) (not (z11)) (not (z20)) (z21) (not (z29))
       (not (z41))))
 (:action a707 :parameters () :precondition (and) :effect
  (and (not (z1)) (not (z7)) (not (z11)) (z21) (z32) (z46)))
 (:action a709 :parameters () :precondition (and) :effect
  (and (not (z11)) (not (z14)) (z15) (z22) (z31) (not (z35))
       (not (z37)) (z40) (not (z42)) (not (z45)) (z49)))
 (:action a710 :parameters () :precondition (and) :effect
  (and (not (z11)) (not (z14)) (z15) (z22) (z31) (not (z37)) (z40)
       (not (z44)) (not (z45)) (z49)))
 (:action a711 :parameters () :precondition (and) :effect
  (and (not (z11)) (not (z14)) (z15) (not (z37)) (z42) (not (z45))))
 (:action a714 :parameters () :precondition (and) :effect
  (and (not (z11)) (z12) (z16) (z20) (not (z29))))
 (:action a715 :parameters () :precondition (and) :effect
  (and (not (z4)) (not (z11)) (not (z20)) (not (z26)) (not (z28))
       (not (z29)) (not (z41))))
 (:action a719 :parameters () :precondition (and) :effect
  (and (not (z1)) (not (z7)) (not (z11)) (z26)))
 (:action a721 :parameters () :precondition (and) :effect
  (and (z8) (not (z11)) (not (z14)) (z25) (z28) (not (z42)) (z44)
       (not (z45))))
 (:action a722 :parameters () :precondition (and) :effect
  (and (z8) (not (z10)) (not (z11)) (not (z14)) (z25) (z28)
       (not (z42)) (z44) (not (z45)) (not (z49))))
 (:action a723 :parameters () :precondition (and) :effect
  (and (not (z11)) (not (z14)) (z33) (not (z37)) (not (z42))
       (not (z45))))
 (:action a726 :parameters () :precondition (and) :effect
  (and (not (z4)) (z6) (not (z11)) (z14) (z16) (z18) (not (z27))
       (not (z29)) (not (z35)) (z45)))
 (:action a727 :parameters () :precondition (and) :effect
  (and (not (z4)) (z6) (not (z11)) (not (z28)) (not (z29))
       (not (z41))))
 (:action a731 :parameters () :precondition (and) :effect
  (and (not (z1)) (not (z7)) (not (z11))))
 (:action a733 :parameters () :precondition (and) :effect
  (and (not (z11)) (not (z14)) (z18) (z28) (not (z37)) (z38) (z39)
       (not (z42)) (not (z45))))
 (:action a735 :parameters () :precondition (and) :effect
  (and (not (z11)) (not (z14)) (z31) (not (z37)) (not (z42))
       (not (z45))))
 (:action a738 :parameters () :precondition (and) :effect
  (and (z0) (not (z4)) (z6) (z10) (not (z11)) (z13) (z17) (not (z29))
       (z44)))
 (:action a739 :parameters () :precondition (and) :effect
  (and (not (z4)) (not (z11)) (z17) (not (z26)) (not (z29))
       (not (z41))))
 (:action a743 :parameters () :precondition (and) :effect
  (and (not (z1)) (z2) (not (z7)) (not (z11))))
 (:action a745 :parameters () :precondition (and) :effect
  (and (z9) (not (z11)) (z14) (z16) (z19) (not (z37)) (z38)))
 (:action a746 :parameters () :precondition (and) :effect
  (and (z9) (not (z11)) (z14) (z16) (z19) (not (z37)) (z38)
       (not (z45)) (z47)))
 (:action a747 :parameters () :precondition (and) :effect
  (and (z9) (not (z11)) (not (z14)) (z19) (not (z37)) (z38)
       (not (z42)) (not (z45))))
 (:action a750 :parameters () :precondition (and) :effect
  (and (not (z11)) (z13) (z17) (z18) (not (z29)) (z30) (z46)))
 (:action a751 :parameters () :precondition (and) :effect
  (and (not (z4)) (not (z11)) (not (z20)) (not (z28)) (not (z29))
       (z30) (not (z41))))
 (:action a755 :parameters () :precondition (and) :effect
  (and (not (z1)) (not (z7)) (not (z11)) (z36) (z47)))
 (:action a757 :parameters () :precondition (and) :effect
  (and (not (z11)) (z12) (z35) (not (z37))))
 (:action a758 :parameters () :precondition (and) :effect
  (and (not (z11)) (z12) (z35) (not (z37)) (not (z45))))
 (:action a759 :parameters () :precondition (and) :effect
  (and (not (z11)) (not (z14)) (not (z37)) (not (z42)) (not (z45))))
 (:action a762 :parameters () :precondition (and) :effect
  (and (z10) (not (z11)) (not (z29)) (z30) (z39) (z41) (z43) (z46)
       (z49)))
 (:action a763 :parameters () :precondition (and) :effect
  (and (not (z4)) (z10) (not (z11)) (not (z20)) (not (z26))
       (not (z28)) (not (z29)) (not (z41))))
 (:action a767 :parameters () :precondition (and) :effect
  (and (not (z1)) (not (z7)) (not (z11)) (z24) (not (z27))))
 (:action a769 :parameters () :precondition (and) :effect
  (and (z5) (not (z11)) (z13) (z20) (z44)))
 (:action a771 :parameters () :precondition (and) :effect
  (and (not (z11)) (not (z12)) (z25) (not (z35)) (not (z40))))
 (:action a774 :parameters () :precondition (and) :effect
  (and (z8) (not (z11)) (z35) (z41) (z43) (z45)))
 (:action a775 :parameters () :precondition (and) :effect
  (and (not (z10)) (not (z11)) (z41)))
 (:action a779 :parameters () :precondition (and) :effect
  (and (z1) (not (z11)) (not (z24)) (z27)))
 (:action a781 :parameters () :precondition (and) :effect
  (and (z9) (not (z11)) (z35)))
 (:action a782 :parameters () :precondition (and) :effect
  (and (z9) (not (z11)) (z35)))
 (:action a783 :parameters () :precondition (and) :effect
  (and (z9) (not (z11)) (not (z12)) (not (z35)) (not (z40))))
 (:action a786 :parameters () :precondition (and) :effect
  (and (z4) (z5) (not (z10)) (not (z11)) (z16) (z43) (z45) (z47)
       (z48)))
 (:action a787 :parameters () :precondition (and) :effect
  (and (not (z10)) (not (z11)) (z34) (z48)))
 (:action a791 :parameters () :precondition (and) :effect
  (and (z3) (not (z11)) (not (z24)) (z27)))
 (:action a793 :parameters () :precondition (and) :effect
  (and (not (z0)) (z5) (not (z11)) (not (z12)) (z20) (z23) (z31)
       (not (z35)) (z40)))
 (:action a794 :parameters () :precondition (and) :effect
  (and (z5) (not (z11)) (not (z12)) (z20) (z23) (z31) (z40) (z46)))
 (:action a795 :parameters () :precondition (and) :effect
  (and (not (z11)) (not (z12)) (z23) (not (z35)) (not (z40))))
 (:action a798 :parameters () :precondition (and) :effect
  (and (not (z10)) (not (z11)) (z22) (z39) (z43) (not (z44))))
 (:action a799 :parameters () :precondition (and) :effect
  (and (not (z4)) (not (z10)) (not (z11)) (z21) (not (z30))
       (not (z39)) (not (z41)) (not (z43)) (not (z46)) (not (z49))))
 (:action a803 :parameters () :precondition (and) :effect
  (and (not (z11)) (z21) (not (z24)) (z27) (z32) (z46)))
 (:action a805 :parameters () :precondition (and) :effect
  (and (not (z11)) (not (z12)) (z15) (z22) (z31) (not (z35)) (z40)
       (z49)))
 (:action a806 :parameters () :precondition (and) :effect
  (and (not (z11)) (not (z12)) (z15) (z22) (z31) (not (z35)) (z40)
       (z42) (z49)))
 (:action a807 :parameters () :precondition (and) :effect
  (and (not (z11)) (not (z12)) (z15) (not (z35)) (z42)))
 (:action a810 :parameters () :precondition (and) :effect
  (and (z4) (not (z10)) (not (z11)) (z12) (z16) (z20) (not (z35))))
 (:action a811 :parameters () :precondition (and) :effect
  (and (not (z10)) (not (z11))))
 (:action a815 :parameters () :precondition (and) :effect
  (and (not (z11)) (not (z24)) (z26) (z27)))
 (:action a817 :parameters () :precondition (and) :effect
  (and (not (z0)) (z8) (not (z11)) (not (z13)) (z21) (z28) (z37)
       (z44) (z49)))
 (:action a818 :parameters () :precondition (and) :effect
  (and (z8) (not (z11)) (z25) (z28) (z37) (z44)))
 (:action a819 :parameters () :precondition (and) :effect
  (and (not (z11)) (not (z12)) (z33) (not (z35)) (not (z40))))
 (:action a822 :parameters () :precondition (and) :effect
  (and (z6) (not (z10)) (not (z11)) (z14) (z16) (z18) (not (z27))
       (z45)))
 (:action a823 :parameters () :precondition (and) :effect
  (and (not (z4)) (z6) (not (z10)) (not (z11)) (not (z30))
       (not (z39)) (not (z41)) (not (z43)) (not (z46)) (not (z49))))
 (:action a827 :parameters () :precondition (and) :effect
  (and (not (z11)) (not (z24)) (z27)))
 (:action a829 :parameters () :precondition (and) :effect
  (and (not (z11)) (not (z12)) (z18) (z28) (z38) (z39)))
 (:action a830 :parameters () :precondition (and) :effect
  (and (not (z11)) (not (z12)) (z18) (z28) (not (z35)) (z38) (z39)))
 (:action a831 :parameters () :precondition (and) :effect
  (and (not (z11)) (not (z12)) (z31) (not (z35))))
 (:action a834 :parameters () :precondition (and) :effect
  (and (z0) (z6) (not (z11)) (z13) (z17) (z44)))
 (:action a835 :parameters () :precondition (and) :effect
  (and (not (z4)) (not (z10)) (not (z11)) (z17) (not (z30))
       (not (z39)) (not (z41)) (not (z43)) (not (z46)) (not (z49))))
 (:action a839 :parameters () :precondition (and) :effect
  (and (z2) (not (z11)) (not (z24)) (z27)))
 (:action a841 :parameters () :precondition (and) :effect
  (and (z9) (not (z11)) (not (z12)) (z14) (z16) (z19) (not (z35))
       (z38)))
 (:action a843 :parameters () :precondition (and) :effect
  (and (z9) (not (z11)) (not (z12)) (z19) (not (z35)) (z38)))
 (:action a846 :parameters () :precondition (and) :effect
  (and (z4) (not (z10)) (not (z11)) (z13) (not (z16)) (z17) (z18)
       (z30) (z46)))
 (:action a847 :parameters () :precondition (and) :effect
  (and (not (z4)) (not (z10)) (not (z11)) (z30) (not (z39))
       (not (z41)) (not (z43)) (not (z46))))
 (:action a851 :parameters () :precondition (and) :effect
  (and (not (z11)) (not (z24)) (z27) (z36) (z47)))
 (:action a853 :parameters () :precondition (and) :effect
  (and (not (z11)) (not (z26)) (z37) (z42) (z45)))
 (:action a854 :parameters () :precondition (and) :effect
  (and (not (z11)) (z14) (not (z35)) (z37) (z42) (z45)))
 (:action a855 :parameters () :precondition (and) :effect
  (and (not (z11)) (not (z12)) (not (z35)) (z37) (not (z40))))
 (:action a858 :parameters () :precondition (and) :effect
  (and (not (z10)) (not (z11)) (z20) (z26) (z28) (z29) (z41)))
 (:action a859 :parameters () :precondition (and) :effect
  (and (z4) (not (z10)) (not (z11)) (z29) (not (z30)) (not (z39))
       (not (z41)) (not (z43)) (not (z46)) (not (z49))))
 (:action a863 :parameters () :precondition (and) :effect
  (and (z1) (z7) (not (z11)) (not (z24)) (z27))))
