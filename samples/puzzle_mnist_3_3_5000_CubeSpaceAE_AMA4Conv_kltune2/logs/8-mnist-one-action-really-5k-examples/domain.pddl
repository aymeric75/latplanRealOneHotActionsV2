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
 (:action a0+187+248+277 :parameters () :precondition
  (and (not (z2)) (z3) (not (z12)) (z15) (not (z17)) (not (z22))
       (z23) (z25) (z27) (not (z34)) (not (z39)) (not (z50))
       (not (z54)) (z55) (not (z60)) (not (z61)) (not (z70)) (z76)
       (z83) (z87) (not (z88)) (not (z89)) (z92) (not (z98))
       (not (z100)) (not (z104)) (not (z105)) (not (z112))
       (not (z114)) (not (z118)) (z127) (not (z128)) (not (z137))
       (z141) (not (z148)) (not (z152)) (z166) (not (z173))
       (not (z175)) (not (z176)) (not (z178)) (not (z180))
       (not (z185)) (not (z186)) (not (z187)) (z192) (z203) (z207)
       (not (z208)) (not (z210)) (z211) (not (z220)) (not (z229))
       (z236) (not (z241)) (not (z245)) (not (z248)) (not (z250))
       (not (z254)) (z256) (not (z257)) (not (z260)) (not (z263))
       (not (z270)) (not (z271)) (not (z272)) (not (z273))
       (not (z277)) (not (z299)))
  :effect
  (and (not (z2)) (z3) (not (z12)) (z15) (not (z17)) (not (z22))
       (z23) (z25) (z27) (not (z34)) (not (z39)) (not (z50))
       (not (z54)) (z55) (not (z60)) (not (z61)) (not (z70)) (z76)
       (z83) (z87) (not (z88)) (not (z89)) (z92) (not (z98))
       (not (z100)) (not (z104)) (not (z105)) (not (z112))
       (not (z114)) (not (z118)) (z127) (not (z128)) (not (z137))
       (z141) (not (z148)) (not (z152)) (z166) (not (z173))
       (not (z175)) (not (z176)) (not (z178)) (not (z180))
       (not (z185)) (not (z186)) (z187) (z192) (z203) (not (z207))
       (not (z208)) (not (z210)) (z211) (not (z220)) (not (z229))
       (z236) (not (z241)) (not (z245)) (z248) (not (z250))
       (not (z254)) (z256) (not (z257)) (not (z260)) (not (z263))
       (not (z270)) (not (z271)) (not (z272)) (not (z273)) (z277)
       (not (z299))))
 (:action a0+187+248-277 :parameters () :precondition
  (and (not (z2)) (z3) (not (z12)) (z15) (not (z17)) (not (z22))
       (z23) (z25) (z27) (not (z34)) (not (z39)) (not (z50))
       (not (z54)) (z55) (not (z60)) (not (z61)) (not (z70)) (z76)
       (z83) (z87) (not (z88)) (not (z89)) (z92) (not (z98))
       (not (z100)) (not (z104)) (not (z105)) (not (z112))
       (not (z114)) (not (z118)) (z127) (not (z128)) (not (z137))
       (z141) (not (z148)) (not (z152)) (z166) (not (z173))
       (not (z175)) (not (z176)) (not (z178)) (not (z180))
       (not (z185)) (not (z186)) (not (z187)) (z192) (z203) (z207)
       (not (z208)) (not (z210)) (z211) (not (z220)) (not (z229))
       (z236) (not (z241)) (not (z245)) (not (z248)) (not (z250))
       (not (z254)) (z256) (not (z257)) (not (z260)) (not (z263))
       (not (z270)) (not (z271)) (not (z272)) (not (z273)) (z277)
       (not (z299)))
  :effect
  (and (not (z2)) (z3) (not (z12)) (z15) (not (z17)) (not (z22))
       (z23) (z25) (z27) (not (z34)) (not (z39)) (not (z50))
       (not (z54)) (z55) (not (z60)) (not (z61)) (not (z70)) (z76)
       (z83) (z87) (not (z88)) (not (z89)) (z92) (not (z98))
       (not (z100)) (not (z104)) (not (z105)) (not (z112))
       (not (z114)) (not (z118)) (z127) (not (z128)) (not (z137))
       (z141) (not (z148)) (not (z152)) (z166) (not (z173))
       (not (z175)) (not (z176)) (not (z178)) (not (z180))
       (not (z185)) (not (z186)) (z187) (z192) (z203) (not (z207))
       (not (z208)) (not (z210)) (z211) (not (z220)) (not (z229))
       (z236) (not (z241)) (not (z245)) (z248) (not (z250))
       (not (z254)) (z256) (not (z257)) (not (z260)) (not (z263))
       (not (z270)) (not (z271)) (not (z272)) (not (z273))
       (not (z277)) (not (z299))))
 (:action a0+187-248+277 :parameters () :precondition
  (and (not (z2)) (z3) (not (z12)) (z15) (not (z17)) (not (z22))
       (z23) (z25) (z27) (not (z34)) (not (z39)) (not (z50))
       (not (z54)) (z55) (not (z60)) (not (z61)) (not (z70)) (z76)
       (z83) (z87) (not (z88)) (not (z89)) (z92) (not (z98))
       (not (z100)) (not (z104)) (not (z105)) (not (z112))
       (not (z114)) (not (z118)) (z127) (not (z128)) (not (z137))
       (z141) (not (z148)) (not (z152)) (z166) (not (z173))
       (not (z175)) (not (z176)) (not (z178)) (not (z180))
       (not (z185)) (not (z186)) (not (z187)) (z192) (z203) (z207)
       (not (z208)) (not (z210)) (z211) (not (z220)) (not (z229))
       (z236) (not (z241)) (not (z245)) (z248) (not (z250))
       (not (z254)) (z256) (not (z257)) (not (z260)) (not (z263))
       (not (z270)) (not (z271)) (not (z272)) (not (z273))
       (not (z277)) (not (z299)))
  :effect
  (and (not (z2)) (z3) (not (z12)) (z15) (not (z17)) (not (z22))
       (z23) (z25) (z27) (not (z34)) (not (z39)) (not (z50))
       (not (z54)) (z55) (not (z60)) (not (z61)) (not (z70)) (z76)
       (z83) (z87) (not (z88)) (not (z89)) (z92) (not (z98))
       (not (z100)) (not (z104)) (not (z105)) (not (z112))
       (not (z114)) (not (z118)) (z127) (not (z128)) (not (z137))
       (z141) (not (z148)) (not (z152)) (z166) (not (z173))
       (not (z175)) (not (z176)) (not (z178)) (not (z180))
       (not (z185)) (not (z186)) (z187) (z192) (z203) (not (z207))
       (not (z208)) (not (z210)) (z211) (not (z220)) (not (z229))
       (z236) (not (z241)) (not (z245)) (not (z248)) (not (z250))
       (not (z254)) (z256) (not (z257)) (not (z260)) (not (z263))
       (not (z270)) (not (z271)) (not (z272)) (not (z273)) (z277)
       (not (z299))))
 (:action a0+187-248-277 :parameters () :precondition
  (and (not (z2)) (z3) (not (z12)) (z15) (not (z17)) (not (z22))
       (z23) (z25) (z27) (not (z34)) (not (z39)) (not (z50))
       (not (z54)) (z55) (not (z60)) (not (z61)) (not (z70)) (z76)
       (z83) (z87) (not (z88)) (not (z89)) (z92) (not (z98))
       (not (z100)) (not (z104)) (not (z105)) (not (z112))
       (not (z114)) (not (z118)) (z127) (not (z128)) (not (z137))
       (z141) (not (z148)) (not (z152)) (z166) (not (z173))
       (not (z175)) (not (z176)) (not (z178)) (not (z180))
       (not (z185)) (not (z186)) (not (z187)) (z192) (z203) (z207)
       (not (z208)) (not (z210)) (z211) (not (z220)) (not (z229))
       (z236) (not (z241)) (not (z245)) (z248) (not (z250))
       (not (z254)) (z256) (not (z257)) (not (z260)) (not (z263))
       (not (z270)) (not (z271)) (not (z272)) (not (z273)) (z277)
       (not (z299)))
  :effect
  (and (not (z2)) (z3) (not (z12)) (z15) (not (z17)) (not (z22))
       (z23) (z25) (z27) (not (z34)) (not (z39)) (not (z50))
       (not (z54)) (z55) (not (z60)) (not (z61)) (not (z70)) (z76)
       (z83) (z87) (not (z88)) (not (z89)) (z92) (not (z98))
       (not (z100)) (not (z104)) (not (z105)) (not (z112))
       (not (z114)) (not (z118)) (z127) (not (z128)) (not (z137))
       (z141) (not (z148)) (not (z152)) (z166) (not (z173))
       (not (z175)) (not (z176)) (not (z178)) (not (z180))
       (not (z185)) (not (z186)) (z187) (z192) (z203) (not (z207))
       (not (z208)) (not (z210)) (z211) (not (z220)) (not (z229))
       (z236) (not (z241)) (not (z245)) (not (z248)) (not (z250))
       (not (z254)) (z256) (not (z257)) (not (z260)) (not (z263))
       (not (z270)) (not (z271)) (not (z272)) (not (z273))
       (not (z277)) (not (z299))))
 (:action a0-187+248+277 :parameters () :precondition
  (and (not (z2)) (z3) (not (z12)) (z15) (not (z17)) (not (z22))
       (z23) (z25) (z27) (not (z34)) (not (z39)) (not (z50))
       (not (z54)) (z55) (not (z60)) (not (z61)) (not (z70)) (z76)
       (z83) (z87) (not (z88)) (not (z89)) (z92) (not (z98))
       (not (z100)) (not (z104)) (not (z105)) (not (z112))
       (not (z114)) (not (z118)) (z127) (not (z128)) (not (z137))
       (z141) (not (z148)) (not (z152)) (z166) (not (z173))
       (not (z175)) (not (z176)) (not (z178)) (not (z180))
       (not (z185)) (not (z186)) (z187) (z192) (z203) (z207)
       (not (z208)) (not (z210)) (z211) (not (z220)) (not (z229))
       (z236) (not (z241)) (not (z245)) (not (z248)) (not (z250))
       (not (z254)) (z256) (not (z257)) (not (z260)) (not (z263))
       (not (z270)) (not (z271)) (not (z272)) (not (z273))
       (not (z277)) (not (z299)))
  :effect
  (and (not (z2)) (z3) (not (z12)) (z15) (not (z17)) (not (z22))
       (z23) (z25) (z27) (not (z34)) (not (z39)) (not (z50))
       (not (z54)) (z55) (not (z60)) (not (z61)) (not (z70)) (z76)
       (z83) (z87) (not (z88)) (not (z89)) (z92) (not (z98))
       (not (z100)) (not (z104)) (not (z105)) (not (z112))
       (not (z114)) (not (z118)) (z127) (not (z128)) (not (z137))
       (z141) (not (z148)) (not (z152)) (z166) (not (z173))
       (not (z175)) (not (z176)) (not (z178)) (not (z180))
       (not (z185)) (not (z186)) (not (z187)) (z192) (z203)
       (not (z207)) (not (z208)) (not (z210)) (z211) (not (z220))
       (not (z229)) (z236) (not (z241)) (not (z245)) (z248)
       (not (z250)) (not (z254)) (z256) (not (z257)) (not (z260))
       (not (z263)) (not (z270)) (not (z271)) (not (z272))
       (not (z273)) (z277) (not (z299))))
 (:action a0-187+248-277 :parameters () :precondition
  (and (not (z2)) (z3) (not (z12)) (z15) (not (z17)) (not (z22))
       (z23) (z25) (z27) (not (z34)) (not (z39)) (not (z50))
       (not (z54)) (z55) (not (z60)) (not (z61)) (not (z70)) (z76)
       (z83) (z87) (not (z88)) (not (z89)) (z92) (not (z98))
       (not (z100)) (not (z104)) (not (z105)) (not (z112))
       (not (z114)) (not (z118)) (z127) (not (z128)) (not (z137))
       (z141) (not (z148)) (not (z152)) (z166) (not (z173))
       (not (z175)) (not (z176)) (not (z178)) (not (z180))
       (not (z185)) (not (z186)) (z187) (z192) (z203) (z207)
       (not (z208)) (not (z210)) (z211) (not (z220)) (not (z229))
       (z236) (not (z241)) (not (z245)) (not (z248)) (not (z250))
       (not (z254)) (z256) (not (z257)) (not (z260)) (not (z263))
       (not (z270)) (not (z271)) (not (z272)) (not (z273)) (z277)
       (not (z299)))
  :effect
  (and (not (z2)) (z3) (not (z12)) (z15) (not (z17)) (not (z22))
       (z23) (z25) (z27) (not (z34)) (not (z39)) (not (z50))
       (not (z54)) (z55) (not (z60)) (not (z61)) (not (z70)) (z76)
       (z83) (z87) (not (z88)) (not (z89)) (z92) (not (z98))
       (not (z100)) (not (z104)) (not (z105)) (not (z112))
       (not (z114)) (not (z118)) (z127) (not (z128)) (not (z137))
       (z141) (not (z148)) (not (z152)) (z166) (not (z173))
       (not (z175)) (not (z176)) (not (z178)) (not (z180))
       (not (z185)) (not (z186)) (not (z187)) (z192) (z203)
       (not (z207)) (not (z208)) (not (z210)) (z211) (not (z220))
       (not (z229)) (z236) (not (z241)) (not (z245)) (z248)
       (not (z250)) (not (z254)) (z256) (not (z257)) (not (z260))
       (not (z263)) (not (z270)) (not (z271)) (not (z272))
       (not (z273)) (not (z277)) (not (z299))))
 (:action a0-187-248+277 :parameters () :precondition
  (and (not (z2)) (z3) (not (z12)) (z15) (not (z17)) (not (z22))
       (z23) (z25) (z27) (not (z34)) (not (z39)) (not (z50))
       (not (z54)) (z55) (not (z60)) (not (z61)) (not (z70)) (z76)
       (z83) (z87) (not (z88)) (not (z89)) (z92) (not (z98))
       (not (z100)) (not (z104)) (not (z105)) (not (z112))
       (not (z114)) (not (z118)) (z127) (not (z128)) (not (z137))
       (z141) (not (z148)) (not (z152)) (z166) (not (z173))
       (not (z175)) (not (z176)) (not (z178)) (not (z180))
       (not (z185)) (not (z186)) (z187) (z192) (z203) (z207)
       (not (z208)) (not (z210)) (z211) (not (z220)) (not (z229))
       (z236) (not (z241)) (not (z245)) (z248) (not (z250))
       (not (z254)) (z256) (not (z257)) (not (z260)) (not (z263))
       (not (z270)) (not (z271)) (not (z272)) (not (z273))
       (not (z277)) (not (z299)))
  :effect
  (and (not (z2)) (z3) (not (z12)) (z15) (not (z17)) (not (z22))
       (z23) (z25) (z27) (not (z34)) (not (z39)) (not (z50))
       (not (z54)) (z55) (not (z60)) (not (z61)) (not (z70)) (z76)
       (z83) (z87) (not (z88)) (not (z89)) (z92) (not (z98))
       (not (z100)) (not (z104)) (not (z105)) (not (z112))
       (not (z114)) (not (z118)) (z127) (not (z128)) (not (z137))
       (z141) (not (z148)) (not (z152)) (z166) (not (z173))
       (not (z175)) (not (z176)) (not (z178)) (not (z180))
       (not (z185)) (not (z186)) (not (z187)) (z192) (z203)
       (not (z207)) (not (z208)) (not (z210)) (z211) (not (z220))
       (not (z229)) (z236) (not (z241)) (not (z245)) (not (z248))
       (not (z250)) (not (z254)) (z256) (not (z257)) (not (z260))
       (not (z263)) (not (z270)) (not (z271)) (not (z272))
       (not (z273)) (z277) (not (z299))))
 (:action a0-187-248-277 :parameters () :precondition
  (and (not (z2)) (z3) (not (z12)) (z15) (not (z17)) (not (z22))
       (z23) (z25) (z27) (not (z34)) (not (z39)) (not (z50))
       (not (z54)) (z55) (not (z60)) (not (z61)) (not (z70)) (z76)
       (z83) (z87) (not (z88)) (not (z89)) (z92) (not (z98))
       (not (z100)) (not (z104)) (not (z105)) (not (z112))
       (not (z114)) (not (z118)) (z127) (not (z128)) (not (z137))
       (z141) (not (z148)) (not (z152)) (z166) (not (z173))
       (not (z175)) (not (z176)) (not (z178)) (not (z180))
       (not (z185)) (not (z186)) (z187) (z192) (z203) (z207)
       (not (z208)) (not (z210)) (z211) (not (z220)) (not (z229))
       (z236) (not (z241)) (not (z245)) (z248) (not (z250))
       (not (z254)) (z256) (not (z257)) (not (z260)) (not (z263))
       (not (z270)) (not (z271)) (not (z272)) (not (z273)) (z277)
       (not (z299)))
  :effect
  (and (not (z2)) (z3) (not (z12)) (z15) (not (z17)) (not (z22))
       (z23) (z25) (z27) (not (z34)) (not (z39)) (not (z50))
       (not (z54)) (z55) (not (z60)) (not (z61)) (not (z70)) (z76)
       (z83) (z87) (not (z88)) (not (z89)) (z92) (not (z98))
       (not (z100)) (not (z104)) (not (z105)) (not (z112))
       (not (z114)) (not (z118)) (z127) (not (z128)) (not (z137))
       (z141) (not (z148)) (not (z152)) (z166) (not (z173))
       (not (z175)) (not (z176)) (not (z178)) (not (z180))
       (not (z185)) (not (z186)) (not (z187)) (z192) (z203)
       (not (z207)) (not (z208)) (not (z210)) (z211) (not (z220))
       (not (z229)) (z236) (not (z241)) (not (z245)) (not (z248))
       (not (z250)) (not (z254)) (z256) (not (z257)) (not (z260))
       (not (z263)) (not (z270)) (not (z271)) (not (z272))
       (not (z273)) (not (z277)) (not (z299)))))
