(define (domain latent)
 (:requirements :strips :negative-preconditions)
 (:predicates (z0) (z1) (z2) (z3) (z4) (z5) (z6) (z7) (z8) (z9) (z10)
  (z11) (z12) (z13) (z14) (z15) (z16) (z17) (z18) (z19) (z20) (z21)
  (z22) (z23) (z24) (z25) (z26) (z27) (z28) (z29) (z30) (z31) (z32)
  (z33) (z34) (z35) (z36) (z37) (z38) (z39) (z40) (z41) (z42) (z43)
  (z44) (z45) (z46) (z47) (z48) (z49) (z50) (z51) (z52) (z53) (z54)
  (z55) (z56) (z57) (z58) (z59) (z60) (z61) (z62) (z63) (z64) (z65)
  (z66) (z67) (z68) (z69) (z70) (z71) (z72) (z73) (z74) (z75) (z76)
  (z77) (z78) (z79) (z80) (z81) (z82) (z83) (z84) (z85) (z86) (z87)
  (z88) (z89) (z90) (z91) (z92) (z93) (z94) (z95) (z96) (z97) (z98)
  (z99) (z100) (z101) (z102) (z103) (z104) (z105) (z106) (z107)
  (z108) (z109) (z110) (z111) (z112) (z113) (z114) (z115) (z116)
  (z117) (z118) (z119) (z120) (z121) (z122) (z123) (z124) (z125)
  (z126) (z127) (z128) (z129) (z130) (z131) (z132) (z133) (z134)
  (z135) (z136) (z137) (z138) (z139) (z140) (z141) (z142) (z143)
  (z144) (z145) (z146) (z147) (z148) (z149) (z150) (z151) (z152)
  (z153) (z154) (z155) (z156) (z157) (z158) (z159) (z160) (z161)
  (z162) (z163) (z164) (z165) (z166) (z167) (z168) (z169) (z170)
  (z171) (z172) (z173) (z174) (z175) (z176) (z177) (z178) (z179)
  (z180) (z181) (z182) (z183) (z184) (z185) (z186) (z187) (z188)
  (z189) (z190) (z191) (z192) (z193) (z194) (z195) (z196) (z197)
  (z198) (z199) (z200) (z201) (z202) (z203) (z204) (z205) (z206)
  (z207) (z208) (z209) (z210) (z211) (z212) (z213) (z214) (z215)
  (z216) (z217) (z218) (z219) (z220) (z221) (z222) (z223) (z224)
  (z225) (z226) (z227) (z228) (z229) (z230) (z231) (z232) (z233)
  (z234) (z235) (z236) (z237) (z238) (z239) (z240) (z241) (z242)
  (z243) (z244) (z245) (z246) (z247) (z248) (z249) (z250) (z251)
  (z252) (z253) (z254) (z255) (z256) (z257) (z258) (z259) (z260)
  (z261) (z262) (z263) (z264) (z265) (z266) (z267) (z268) (z269)
  (z270) (z271) (z272) (z273) (z274) (z275) (z276) (z277) (z278)
  (z279) (z280) (z281) (z282) (z283) (z284) (z285) (z286) (z287)
  (z288) (z289) (z290) (z291) (z292) (z293) (z294) (z295) (z296)
  (z297) (z298) (z299))
 (:action a0+38 :parameters () :precondition (and (not (z38)))
  :effect
  (and (not (z2)) (z6) (not (z9)) (not (z14)) (not (z15)) (not (z16))
       (not (z20)) (not (z29)) (z38) (z41) (not (z44)) (not (z47))
       (not (z49)) (not (z51)) (not (z52)) (not (z58)) (not (z64))
       (not (z66)) (not (z78)) (not (z81)) (not (z97)) (z98)
       (not (z101)) (not (z107)) (not (z108)) (not (z109))
       (not (z115)) (not (z116)) (not (z119)) (not (z122))
       (not (z126)) (not (z128)) (not (z132)) (not (z138))
       (not (z144)) (not (z145)) (not (z146)) (not (z148))
       (not (z149)) (not (z158)) (not (z161)) (not (z172))
       (not (z188)) (not (z189)) (not (z200)) (not (z207))
       (not (z212)) (not (z215)) (not (z218)) (not (z221))
       (not (z231)) (not (z244)) (not (z247)) (not (z250))
       (not (z252)) (not (z257)) (not (z265)) (not (z271))
       (not (z276)) (not (z289)) (not (z297)) (not (z299))))
 (:action a0-38 :parameters () :precondition (and (z38)) :effect
  (and (not (z2)) (z6) (not (z9)) (not (z14)) (not (z15)) (not (z16))
       (not (z20)) (not (z29)) (not (z38)) (z41) (not (z44))
       (not (z47)) (not (z49)) (not (z51)) (not (z52)) (not (z58))
       (not (z64)) (not (z66)) (not (z78)) (not (z81)) (not (z97))
       (z98) (not (z101)) (not (z107)) (not (z108)) (not (z109))
       (not (z115)) (not (z116)) (not (z119)) (not (z122))
       (not (z126)) (not (z128)) (not (z132)) (not (z138))
       (not (z144)) (not (z145)) (not (z146)) (not (z148))
       (not (z149)) (not (z158)) (not (z161)) (not (z172))
       (not (z188)) (not (z189)) (not (z200)) (not (z207))
       (not (z212)) (not (z215)) (not (z218)) (not (z221))
       (not (z231)) (not (z244)) (not (z247)) (not (z250))
       (not (z252)) (not (z257)) (not (z265)) (not (z271))
       (not (z276)) (not (z289)) (not (z297)) (not (z299))))
 (:action a1 :parameters () :precondition (and) :effect
  (and (not (z4)) (not (z9)) (not (z14)) (not (z16)) (not (z28))
       (not (z29)) (not (z30)) (not (z34)) (not (z35)) (not (z37))
       (not (z38)) (z41) (not (z46)) (not (z47)) (not (z51))
       (not (z52)) (not (z58)) (not (z63)) (not (z64)) (not (z67))
       (not (z76)) (not (z78)) (not (z84)) (not (z95)) (not (z97))
       (not (z98)) (not (z101)) (not (z112)) (not (z122)) (z123)
       (not (z128)) (not (z137)) (not (z138)) (z140) (not (z144))
       (not (z150)) (not (z155)) (not (z158)) (not (z160))
       (not (z161)) (not (z166)) (not (z185)) (not (z188))
       (not (z189)) (not (z199)) (not (z200)) (not (z201))
       (not (z218)) (not (z223)) (not (z244)) (not (z247))
       (not (z250)) (not (z266)) (not (z276)) (not (z288))
       (not (z289)) (not (z291)) (not (z297)) (not (z298))))
 (:action a2 :parameters () :precondition (and) :effect
  (and (not (z0)) (not (z1)) (not (z7)) (not (z9)) (not (z12))
       (not (z14)) (not (z16)) (not (z22)) (z23) (not (z28))
       (not (z29)) (not (z38)) (not (z40)) (z46) (not (z47))
       (not (z48)) (not (z51)) (not (z52)) (not (z54)) (not (z62))
       (not (z75)) (not (z78)) (not (z83)) (not (z84)) (not (z86))
       (not (z88)) (not (z97)) (not (z98)) (not (z101)) (not (z121))
       (not (z122)) (not (z123)) (not (z128)) (not (z138))
       (not (z143)) (z144) (not (z147)) (not (z149)) (not (z150))
       (not (z158)) (not (z159)) (not (z161)) (not (z163))
       (not (z164)) (not (z169)) (not (z177)) (not (z179))
       (not (z187)) (not (z188)) (not (z191)) (not (z200))
       (not (z205)) (z214) (not (z216)) (not (z218)) (not (z229))
       (not (z241)) (not (z244)) (not (z247)) (not (z250))
       (not (z251)) (not (z256)) (not (z272)) (not (z276))
       (not (z289)) (not (z297))))
 (:action a3 :parameters () :precondition (and) :effect
  (and (not (z6)) (not (z9)) (not (z14)) (not (z16)) (not (z25))
       (not (z29)) (not (z35)) (not (z36)) (not (z38)) (not (z39))
       (not (z41)) (z46) (not (z47)) (not (z51)) (not (z52)) (z58)
       (not (z62)) (not (z72)) (not (z74)) (not (z78)) (not (z89))
       (z95) (not (z97)) (z98) (not (z101)) (not (z102)) (not (z114))
       (not (z121)) (not (z122)) (not (z123)) (not (z128))
       (not (z135)) (not (z136)) (not (z138)) (not (z140))
       (not (z142)) (not (z144)) (not (z149)) (not (z150))
       (not (z158)) (not (z161)) (not (z170)) (not (z178))
       (not (z181)) (not (z182)) (not (z183)) (z188) (not (z189))
       (not (z191)) (not (z197)) (not (z200)) (not (z218))
       (not (z236)) (not (z239)) (not (z244)) (not (z247))
       (not (z250)) (not (z256)) (not (z264)) (not (z273))
       (not (z276)) (not (z283)) (not (z289)) (not (z293))
       (not (z297))))
 (:action a4 :parameters () :precondition (and) :effect
  (and (not (z5)) (not (z7)) (not (z9)) (not (z14)) (not (z16))
       (not (z21)) (not (z24)) (not (z27)) (z29) (not (z32))
       (not (z35)) (not (z38)) (not (z42)) (z46) (not (z47))
       (not (z50)) (not (z51)) (not (z52)) (not (z61)) (not (z62))
       (not (z64)) (not (z78)) (not (z83)) (not (z85)) (z95)
       (not (z97)) (not (z98)) (not (z99)) (not (z101)) (not (z103))
       (not (z113)) (not (z118)) (z122) (not (z123)) (not (z128))
       (z138) (not (z144)) (not (z158)) (not (z161)) (not (z173))
       (not (z186)) (not (z188)) (not (z195)) (not (z198))
       (not (z200)) (not (z218)) (not (z220)) (not (z230))
       (not (z233)) (not (z236)) (not (z239)) (z240) (not (z242))
       (not (z244)) (not (z247)) (not (z250)) (not (z272))
       (not (z276)) (not (z285)) (not (z286)) (not (z289))
       (not (z294)) (not (z297))))
 (:action a5 :parameters () :precondition (and) :effect
  (and (not (z9)) (not (z14)) (not (z16)) (not (z29)) (not (z30))
       (z33) (not (z38)) (not (z47)) (not (z51)) (not (z52))
       (not (z57)) (not (z60)) (not (z62)) (not (z68)) (not (z74))
       (not (z78)) (not (z83)) (not (z87)) (not (z97)) (not (z98))
       (not (z101)) (not (z104)) (not (z117)) (not (z120)) (z122)
       (not (z124)) (not (z128)) (not (z131)) (not (z138))
       (not (z144)) (not (z154)) (not (z156)) (not (z158))
       (not (z161)) (not (z165)) (not (z180)) (not (z184))
       (not (z187)) (not (z188)) (not (z189)) (not (z190))
       (not (z192)) (not (z194)) (not (z200)) (not (z202))
       (not (z208)) (not (z218)) (not (z219)) (z230) (not (z236))
       (not (z240)) (not (z244)) (not (z245)) (not (z247))
       (not (z249)) (not (z250)) (not (z257)) (not (z262))
       (not (z267)) (not (z272)) (not (z276)) (not (z284))
       (not (z289)) (z294) (not (z297))))
 (:action a6 :parameters () :precondition (and) :effect
  (and (not (z4)) (not (z9)) (not (z14)) (not (z16)) (not (z28))
       (not (z29)) (not (z30)) (not (z34)) (not (z35)) (not (z37))
       (not (z38)) (not (z46)) (not (z47)) (not (z51)) (not (z52))
       (not (z63)) (not (z67)) (not (z73)) (not (z76)) (not (z78))
       (not (z83)) (not (z84)) (not (z95)) (not (z97)) (not (z98))
       (not (z101)) (not (z112)) (not (z122)) (z123) (not (z128))
       (not (z137)) (not (z138)) (not (z144)) (not (z155))
       (not (z158)) (not (z160)) (not (z161)) (not (z166))
       (not (z185)) (not (z188)) (not (z199)) (not (z200))
       (not (z201)) (not (z218)) (not (z223)) (z230) (not (z240))
       (not (z244)) (not (z247)) (not (z250)) (not (z264))
       (not (z266)) (not (z267)) (not (z272)) (not (z276))
       (not (z288)) (not (z289)) (not (z291)) (z294) (not (z297))
       (not (z298))))
 (:action a7 :parameters () :precondition (and) :effect
  (and (not (z6)) (not (z9)) (not (z14)) (not (z16)) (not (z25))
       (not (z29)) (not (z36)) (not (z38)) (not (z39)) (not (z41))
       (not (z47)) (not (z51)) (not (z52)) (z58) (not (z72))
       (not (z74)) (not (z78)) (not (z89)) (not (z92)) (not (z97))
       (z98) (not (z101)) (not (z102)) (not (z114)) (not (z121))
       (not (z122)) (not (z128)) (not (z135)) (not (z136))
       (not (z138)) (not (z140)) (not (z142)) (not (z144)) (z146)
       (z148) (not (z150)) (not (z158)) (not (z161)) (not (z170))
       (not (z178)) (not (z181)) (not (z182)) (not (z183)) (z188)
       (not (z189)) (not (z197)) (not (z200)) (not (z218))
       (not (z236)) (not (z239)) (not (z244)) (not (z247))
       (not (z250)) (not (z256)) (not (z264)) (z265) (not (z273))
       (not (z276)) (not (z289)) (not (z292)) (not (z293))
       (not (z297))))
 (:action a8 :parameters () :precondition (and) :effect
  (and (not (z3)) (not (z9)) (not (z14)) (not (z16)) (not (z19))
       (not (z29)) (not (z38)) (not (z47)) (not (z51)) (not (z52))
       (not (z64)) (not (z70)) (not (z73)) (not (z75)) (not (z78))
       (not (z79)) (not (z80)) (not (z83)) (not (z84)) (not (z90))
       (not (z95)) (not (z96)) (not (z97)) (z98) (z101) (not (z111))
       (not (z122)) (not (z124)) (not (z128)) (not (z130))
       (not (z133)) (not (z134)) (not (z138)) (not (z144)) (z146)
       (z148) (not (z149)) (not (z152)) (not (z153)) (not (z158))
       (not (z161)) (not (z162)) (not (z169)) (not (z176))
       (not (z188)) (not (z200)) (not (z203)) (not (z204))
       (not (z209)) (not (z213)) (not (z218)) (not (z224))
       (not (z227)) (not (z235)) (not (z236)) (not (z237))
       (not (z244)) (not (z247)) (not (z250)) (not (z254))
       (not (z255)) (not (z258)) (not (z260)) (z265) (not (z268))
       (not (z272)) (not (z276)) (not (z284)) (not (z289))
       (not (z295)) (not (z297))))
 (:action a9 :parameters () :precondition (and) :effect
  (and (not (z0)) (not (z1)) (not (z7)) (not (z9)) (not (z12))
       (not (z14)) (not (z16)) (not (z22)) (z23) (not (z29))
       (not (z35)) (not (z38)) (not (z40)) (not (z47)) (not (z48))
       (not (z51)) (not (z52)) (not (z54)) (not (z75)) (not (z78))
       (not (z83)) (not (z86)) (not (z88)) (not (z95)) (not (z97))
       (not (z98)) (not (z101)) (not (z121)) (not (z122))
       (not (z128)) (not (z138)) (not (z143)) (z144) (z146)
       (not (z147)) (z148) (not (z150)) (not (z155)) (not (z158))
       (not (z159)) (not (z161)) (not (z163)) (not (z164))
       (not (z169)) (not (z177)) (not (z188)) (not (z189))
       (not (z191)) (not (z200)) (not (z216)) (not (z218))
       (not (z229)) (not (z238)) (not (z241)) (not (z244))
       (not (z247)) (not (z250)) (not (z251)) (not (z256)) (z265)
       (not (z276)) (not (z289)) (not (z297))))
 (:action a10 :parameters () :precondition (and) :effect
  (and (not (z4)) (not (z9)) (not (z10)) (not (z14)) (not (z16))
       (not (z23)) (not (z28)) (not (z29)) (not (z30)) (not (z34))
       (not (z37)) (not (z38)) (not (z46)) (not (z47)) (not (z51))
       (not (z52)) (not (z63)) (not (z67)) (not (z76)) (not (z78))
       (z83) (not (z84)) (not (z88)) (not (z95)) (not (z97))
       (not (z98)) (not (z101)) (not (z112)) (not (z116))
       (not (z122)) (z123) (not (z125)) (not (z128)) (not (z137))
       (not (z138)) (not (z144)) (not (z150)) (not (z158))
       (not (z160)) (not (z161)) (not (z166)) (not (z169))
       (not (z170)) (z177) (not (z185)) (not (z188)) (not (z189))
       (not (z199)) (not (z200)) (not (z201)) (not (z205))
       (not (z218)) (not (z223)) (not (z228)) (not (z244))
       (not (z247)) (not (z250)) (not (z253)) (not (z264))
       (not (z266)) (not (z267)) (not (z276)) (not (z288))
       (not (z289)) (not (z291)) (not (z297)) (not (z298))))
 (:action a11 :parameters () :precondition (and) :effect
  (and (not (z6)) (z9) (not (z14)) (not (z16)) (not (z18))
       (not (z23)) (not (z26)) (not (z29)) (not (z38)) (not (z43))
       (not (z47)) (not (z51)) (not (z52)) (not (z64)) (not (z65))
       (not (z77)) (not (z78)) (z83) (not (z90)) (not (z97))
       (not (z98)) (not (z101)) (not (z111)) (not (z117))
       (not (z122)) (not (z127)) (not (z128)) (not (z129))
       (not (z138)) (not (z139)) (not (z144)) (not (z149))
       (not (z156)) (not (z157)) (not (z158)) (not (z161))
       (not (z169)) (not (z171)) (not (z174)) (not (z188))
       (not (z193)) (not (z196)) (not (z200)) (not (z203))
       (not (z205)) (not (z206)) (not (z211)) (z217) (not (z218))
       (not (z244)) (not (z247)) (not (z248)) (not (z250))
       (not (z259)) (not (z267)) (not (z269)) (not (z272))
       (not (z276)) (not (z279)) (not (z280)) (not (z281))
       (not (z289)) (not (z297))))
 (:action a12 :parameters () :precondition (and) :effect
  (and (not (z2)) (not (z7)) (not (z9)) (not (z14)) (not (z15))
       (not (z16)) (not (z20)) (not (z23)) (not (z29)) (not (z38))
       (not (z47)) (not (z49)) (not (z51)) (not (z52)) (not (z66))
       (z75) (not (z78)) (not (z81)) (z83) (not (z97)) (z98)
       (not (z101)) (not (z107)) (not (z109)) (not (z115))
       (not (z117)) (not (z119)) (not (z122)) (not (z126))
       (not (z128)) (not (z132)) (not (z138)) (not (z144))
       (not (z145)) (not (z146)) (not (z148)) (not (z149))
       (not (z150)) (not (z158)) (not (z161)) (not (z169))
       (not (z172)) (not (z177)) (not (z187)) (not (z188))
       (not (z200)) (not (z207)) (not (z212)) (not (z215))
       (not (z218)) (not (z221)) (not (z231)) (not (z244))
       (not (z247)) (not (z250)) (not (z252)) (not (z257))
       (not (z261)) (not (z264)) (not (z265)) (not (z271))
       (not (z272)) (not (z276)) (not (z289)) (not (z297))
       (not (z299))))
 (:action a13 :parameters () :precondition (and) :effect
  (and (not (z9)) (not (z14)) (not (z16)) (not (z21)) (not (z23))
       (not (z29)) (not (z30)) (not (z38)) (not (z47)) (not (z50))
       (not (z51)) (not (z52)) (not (z57)) (not (z60)) (not (z62))
       (not (z68)) (not (z74)) (not (z78)) (z83) (not (z87))
       (not (z88)) (not (z97)) (not (z98)) (not (z101)) (not (z103))
       (not (z104)) (not (z120)) (z122) (not (z124)) (not (z128))
       (not (z131)) (not (z138)) (not (z144)) (not (z150))
       (not (z154)) (not (z156)) (not (z158)) (not (z161))
       (not (z165)) (not (z168)) (not (z169)) (z177) (not (z184))
       (not (z188)) (not (z190)) (not (z191)) (not (z192))
       (not (z194)) (not (z200)) (not (z202)) (not (z208))
       (not (z218)) (not (z219)) (not (z236)) (not (z244))
       (not (z245)) (not (z247)) (not (z249)) (not (z250))
       (not (z257)) (not (z262)) (not (z267)) (not (z272))
       (not (z274)) (not (z276)) (not (z277)) (not (z284))
       (not (z289)) (not (z297))))
 (:action a14 :parameters () :precondition (and) :effect
  (and (not (z5)) (not (z7)) (not (z9)) (not (z14)) (not (z16))
       (not (z24)) (not (z27)) (z29) (not (z32)) (not (z38))
       (not (z42)) (not (z47)) (not (z50)) (not (z51)) (not (z52))
       (z57) (not (z61)) (not (z64)) (z74) (not (z78)) (not (z83))
       (not (z85)) (not (z97)) (not (z98)) (not (z99)) (not (z101))
       (not (z110)) (not (z113)) (not (z118)) (z122) (not (z124))
       (not (z128)) (z138) (not (z144)) (z156) (not (z158))
       (not (z161)) (not (z170)) (not (z173)) (not (z186))
       (not (z188)) (not (z195)) (not (z198)) (not (z200))
       (not (z202)) (not (z218)) (not (z220)) (not (z223))
       (not (z230)) (not (z233)) (not (z236)) (not (z239)) (z240)
       (not (z242)) (not (z244)) (z245) (not (z247)) (z249)
       (not (z250)) (not (z276)) (not (z285)) (not (z286))
       (not (z289)) (not (z294)) (not (z297))))
 (:action a15 :parameters () :precondition (and) :effect
  (and (z8) (not (z9)) (not (z11)) (not (z14)) (not (z16))
       (not (z19)) (not (z21)) (not (z26)) (not (z28)) (not (z29))
       (not (z31)) (not (z38)) (not (z47)) (not (z50)) (not (z51))
       (not (z52)) (not (z53)) (not (z55)) (not (z56)) (z57)
       (not (z64)) (not (z69)) (z71) (z74) (not (z78)) (not (z81))
       (not (z82)) (not (z83)) (not (z94)) (not (z97)) (not (z98))
       (not (z100)) (not (z101)) (not (z103)) (not (z110))
       (not (z117)) (not (z122)) (not (z124)) (not (z128))
       (not (z138)) (not (z141)) (not (z144)) (z158) (not (z161))
       (not (z167)) (not (z175)) (not (z177)) (not (z188))
       (not (z190)) (not (z200)) (not (z205)) (not (z218))
       (not (z220)) (not (z225)) (not (z226)) (not (z232))
       (not (z236)) (not (z243)) (not (z244)) (z245) (not (z246))
       (not (z247)) (z249) (not (z250)) (not (z275)) (not (z276))
       (not (z278)) (not (z289)) (not (z297))))
 (:action a16 :parameters () :precondition (and) :effect
  (and (not (z0)) (not (z1)) (not (z7)) (not (z9)) (not (z12))
       (not (z14)) (not (z16)) (not (z22)) (z23) (not (z29))
       (not (z35)) (not (z38)) (not (z40)) (not (z44)) (not (z47))
       (not (z48)) (not (z51)) (not (z52)) (not (z54)) (z57) (z74)
       (not (z78)) (not (z83)) (not (z86)) (not (z88)) (not (z97))
       (not (z98)) (not (z101)) (not (z103)) (not (z121))
       (not (z122)) (not (z128)) (not (z138)) (not (z143)) (z144)
       (not (z147)) (not (z150)) (not (z155)) (not (z158))
       (not (z159)) (not (z161)) (not (z163)) (not (z164))
       (not (z169)) (not (z177)) (not (z179)) (not (z188))
       (not (z191)) (not (z200)) (not (z205)) (not (z216))
       (not (z218)) (not (z229)) (not (z234)) (not (z241))
       (not (z244)) (z245) (not (z247)) (z249) (not (z250))
       (not (z251)) (not (z256)) (not (z264)) (not (z276))
       (not (z288)) (not (z289)) (not (z297))))
 (:action a17 :parameters () :precondition (and) :effect
  (and (not (z2)) (not (z7)) (not (z9)) (not (z14)) (not (z16))
       (not (z19)) (not (z20)) (not (z29)) (not (z38)) (not (z44))
       (not (z47)) (not (z49)) (not (z51)) (not (z52)) (not (z66))
       (not (z78)) (not (z83)) (not (z91)) (not (z97)) (z98)
       (not (z101)) (not (z107)) (not (z109)) (not (z111))
       (not (z115)) (not (z119)) (not (z122)) (not (z124))
       (not (z126)) (not (z128)) (not (z132)) (not (z138))
       (not (z144)) (not (z145)) (not (z146)) (not (z148))
       (not (z149)) (not (z158)) (not (z161)) (not (z169))
       (not (z172)) (not (z187)) (not (z188)) (not (z200)) (z203)
       (not (z207)) (not (z212)) (not (z215)) (not (z218))
       (not (z221)) (not (z231)) (z237) (not (z244)) (not (z247))
       (not (z250)) (not (z252)) (not (z257)) (z258) (z260)
       (not (z261)) (not (z264)) (not (z265)) (not (z271))
       (not (z272)) (not (z276)) (not (z289)) (not (z297))
       (not (z299))))
 (:action a18 :parameters () :precondition (and) :effect
  (and (not (z6)) (z9) (not (z14)) (not (z16)) (not (z18))
       (not (z19)) (not (z26)) (not (z29)) (not (z38)) (not (z43))
       (not (z47)) (not (z50)) (not (z51)) (not (z52)) (not (z64))
       (not (z65)) (not (z75)) (not (z77)) (not (z78)) (not (z83))
       (not (z88)) (not (z97)) (not (z98)) (not (z101)) (not (z122))
       (not (z127)) (not (z128)) (not (z129)) (not (z130))
       (not (z138)) (not (z139)) (not (z144)) (not (z156))
       (not (z157)) (not (z158)) (not (z161)) (not (z171))
       (not (z174)) (not (z188)) (not (z189)) (not (z191))
       (not (z193)) (not (z196)) (not (z200)) (not (z206))
       (not (z211)) (z217) (not (z218)) (z237) (not (z244))
       (not (z247)) (not (z248)) (not (z250)) (z258) (not (z259))
       (z260) (not (z264)) (not (z267)) (not (z269)) (not (z276))
       (not (z280)) (not (z289)) (not (z297))))
 (:action a19 :parameters () :precondition (and) :effect
  (and (not (z0)) (not (z1)) (not (z7)) (not (z9)) (not (z12))
       (not (z14)) (not (z16)) (not (z22)) (z23) (not (z29))
       (not (z35)) (not (z38)) (not (z40)) (not (z47)) (not (z48))
       (not (z51)) (not (z52)) (not (z54)) (not (z62)) (not (z75))
       (not (z78)) (not (z83)) (not (z86)) (not (z93)) (not (z97))
       (not (z98)) (not (z101)) (not (z111)) (not (z121))
       (not (z122)) (not (z128)) (not (z138)) (not (z143)) (z144)
       (not (z147)) (not (z150)) (not (z155)) (not (z158))
       (not (z159)) (not (z161)) (not (z163)) (not (z164))
       (not (z169)) (not (z177)) (not (z179)) (not (z188))
       (not (z189)) (not (z200)) (not (z205)) (not (z216))
       (not (z217)) (not (z218)) (not (z229)) (not (z241))
       (not (z244)) (not (z247)) (not (z250)) (not (z251))
       (not (z256)) (not (z276)) (not (z289)) (not (z297))))
 (:action a20 :parameters () :precondition (and) :effect
  (and (not (z3)) (not (z9)) (not (z14)) (not (z15)) (not (z16))
       (not (z19)) (not (z29)) (not (z38)) (not (z47)) (not (z51))
       (not (z52)) (not (z64)) (not (z70)) (not (z73)) (not (z75))
       (not (z78)) (not (z79)) (not (z80)) (not (z83)) (not (z84))
       (not (z88)) (not (z96)) (not (z97)) (z98) (z101) (not (z122))
       (not (z124)) (not (z128)) (not (z133)) (not (z134))
       (not (z138)) (not (z144)) (not (z152)) (not (z153))
       (not (z158)) (not (z161)) (not (z162)) (not (z169))
       (not (z176)) (not (z188)) (not (z189)) (not (z200))
       (not (z204)) (not (z209)) (not (z217)) (not (z218))
       (not (z224)) (not (z227)) (not (z235)) (not (z236))
       (not (z237)) (not (z244)) (not (z247)) (not (z250))
       (not (z254)) (not (z255)) (not (z258)) (not (z260))
       (not (z268)) (not (z276)) (not (z289)) (not (z295))
       (not (z297))))
 (:action a21 :parameters () :precondition (and) :effect
  (and (z8) (not (z9)) (not (z11)) (not (z14)) (not (z16))
       (not (z19)) (not (z28)) (not (z29)) (not (z38)) (not (z47))
       (not (z51)) (not (z52)) (not (z53)) (not (z55)) (not (z64))
       (not (z69)) (z71) (not (z78)) (not (z82)) (not (z83))
       (not (z88)) (not (z94)) (not (z97)) (not (z98)) (not (z100))
       (not (z101)) (not (z110)) (not (z111)) (not (z122))
       (not (z128)) (not (z138)) (not (z141)) (not (z144))
       (not (z149)) (not (z151)) (z156) (z158) (not (z161))
       (not (z167)) (not (z175)) (not (z188)) (not (z189))
       (not (z190)) (not (z200)) (not (z202)) (not (z205))
       (not (z217)) (not (z218)) (not (z220)) (not (z225))
       (not (z226)) (not (z232)) (not (z236)) (not (z243))
       (not (z244)) (not (z246)) (not (z247)) (not (z250))
       (not (z275)) (not (z276)) (not (z278)) (not (z284))
       (not (z289)) (not (z297))))
 (:action a22 :parameters () :precondition (and) :effect
  (and (not (z8)) (not (z9)) (not (z14)) (not (z16)) (not (z19))
       (not (z21)) (not (z29)) (not (z30)) (z33) (not (z38))
       (not (z47)) (not (z50)) (not (z51)) (not (z52)) (not (z57))
       (not (z60)) (not (z62)) (not (z68)) (not (z71)) (not (z74))
       (not (z78)) (not (z83)) (not (z87)) (not (z97)) (not (z98))
       (not (z101)) (not (z103)) (not (z104)) (z110) (not (z120))
       (z122) (not (z124)) (not (z128)) (not (z131)) (not (z138))
       (not (z144)) (not (z154)) (not (z156)) (not (z158))
       (not (z161)) (not (z165)) (not (z168)) (not (z184))
       (not (z188)) (not (z189)) (not (z192)) (not (z194))
       (not (z200)) (not (z205)) (not (z208)) (not (z218))
       (not (z219)) (not (z236)) (not (z244)) (not (z245))
       (not (z247)) (not (z249)) (not (z250)) (not (z257))
       (not (z262)) (not (z267)) (not (z272)) (not (z274))
       (not (z276)) (not (z289)) (not (z297))))
 (:action a23 :parameters () :precondition (and) :effect
  (and (not (z6)) (not (z8)) (z9) (not (z14)) (not (z16)) (not (z18))
       (not (z19)) (not (z29)) (not (z38)) (not (z43)) (not (z47))
       (not (z51)) (not (z52)) (not (z64)) (not (z65)) (not (z71))
       (not (z77)) (not (z78)) (not (z83)) (not (z88)) (not (z90))
       (not (z97)) (not (z98)) (not (z101)) (z110) (not (z111))
       (not (z122)) (not (z127)) (not (z128)) (not (z129))
       (not (z138)) (not (z139)) (not (z144)) (not (z156))
       (not (z157)) (not (z158)) (not (z161)) (not (z171))
       (not (z174)) (not (z188)) (not (z191)) (not (z193))
       (not (z196)) (not (z200)) (not (z202)) (not (z205))
       (not (z206)) (not (z211)) (z217) (not (z218)) (not (z244))
       (not (z247)) (not (z248)) (not (z250)) (not (z259))
       (not (z264)) (not (z267)) (not (z269)) (not (z272))
       (not (z276)) (not (z280)) (not (z289)) (not (z297)))))
