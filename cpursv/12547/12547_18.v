
module encode(datain,dispin,dataout,dispout);

  input  [8:0] datain;
  input  dispin;
  output [9:0] dataout;
  output dispout;
  wire  ai = datain[0];
  wire  bi = datain[1];
  wire  ci = datain[2];
  wire  di = datain[3];
  wire  ei = datain[4];
  wire  fi = datain[5];
  wire  gi = datain[6];
  wire  hi = datain[7];
  wire  ki = datain[8];
  wire  aeqb = (bi | (!ai & !bi)) & ((!ai & !bi) | ai);
  wire  ceqd = ((!ci & !di) | ci) & ((!ci & !di) | di);
  wire 
       l22 = ((((!ai & !bi) & ci) & ((di & (di | !ci)) & (!ci | ci))) | (!ceqd & ((!aeqb | ((((ci & di) & !ai) & (!bi | (!ci & !di))) & (!bi | (((ai & (ai | !ai)) & (bi | !ai)) & bi)))) | (!ci & ((((ai & (ai | !ai)) & (bi | !ai)) & bi) & !di))))) | (!ci & ((((ai & (ai | !ai)) & (bi | !ai)) & bi) & !di));
  wire 
       l40 = ((((ai & (ai | !ai)) & (bi | !ai)) & bi) & ci) & ((di & (di | !ci)) & (!ci | ci));
  wire  l04 = (!ci & !ai) & (!di & !bi);
  wire 
       l13 = ((((!ceqd & ((!ai & !bi) | ai)) & (!ai & !bi)) | !di) & (!ci & !aeqb)) | ((!ceqd & ((!ai & !bi) | ai)) & (!ai & !bi));
  wire 
       l31 = (ai | (di & (!aeqb & ci))) & ((!ceqd & bi) | (di & (!aeqb & ci)));
  wire  ao = ai;
  wire  bo = (l04 | bi) & (!l40 | l04);
  wire 
       co = ((!ai | (l04 | ci)) & ((l04 | ci) | (ei & di))) & ((!ci & !bi) | (l04 | ci));
  wire 
       do = !((((ai & (ai | !ai)) & (bi | !ai)) & bi) & ci) & di;
  wire 
       eo = ((l13 & !(((!ai & !bi) & ei) & (di & !ci))) | ei) & !(((!ai & !bi) & ei) & (di & !ci));
  wire 
       io = (((ei & l40) | ((!di & ci) & (ei & !bi))) | (((!(((ai & (ai | !ai)) & (bi | !ai)) & bi) & (((ei & (!ci & !di)) | !ei) & (l22 | (ei & (!ci & !di))))) | (!ai & (((((ei & di) & (((di | !ci) & (!ci | ci)) & ci)) & !bi) & (!l13 | ki)) & ki))) | (((((ei & (!ci & !di)) | !ei) & (l22 | (ei & (!ci & !di)))) & l22) & (!ei & (((ei & (!ci & !di)) | !ei) & (l22 | (ei & (!ci & !di)))))))) & (((((ei & l40) | ((!ai & !di) & (ei & (ci & !bi)))) | ((!ci & ei) & (!di & !(((ai & (ai | !ai)) & (bi | !ai)) & bi)))) | (((((ei & (!ci & !di)) | !ei) & (l22 | (ei & (!ci & !di)))) & l22) & (!ei & (((ei & (!ci & !di)) | !ei) & (l22 | (ei & (!ci & !di))))))) | !ai);
  wire 
       pd1s6 = (((!l31 | (!ci & (ei & di))) & (!l31 | (!ai & !bi))) & ((((ei & di) & !bi) & !ci) | (!ei & !l22))) & (!ai | (!ei & !l22));
  wire 
       nd1s6 = ((ai | (ki | ((ei & (!l22 & !l13)) | (ki & (((bi | !di) | ai) | !ci))))) & ((ki | ((ei & (!l22 & !l13)) | (ki & (((bi | !di) | ai) | !ci)))) | ((!di & ((!gi | (!fi | (!ei | !l31))) | !hi)) & !ei))) & ((bi & ci) | (ki | ((ei & (!l22 & !l13)) | (ki & (((bi | !di) | ai) | !ci)))));
  wire  ndos6 = pd1s6;
  wire 
       pdos6 = ki | ((ei & (!l22 & !l13)) | (ki & (((bi | !di) | ai) | !ci)));
  wire 
       alt7 = hi & ((ki | ((dispin ? ((!ei & l31) & di) : (l13 & (ei & !di))) | (ki & (!gi & fi)))) & ((fi & (gi | !fi)) & gi));
  wire  fo = !alt7 & fi;
  wire  go = (gi | !fi) & ((gi | !gi) & (!hi | gi));
  wire  ho = hi;
  wire  jo = alt7 | (((~fi & gi) | (~gi & fi)) & !hi);
  wire  nd1s4 = (fi & (gi | !fi)) & gi;
  wire 
       pd1s4 = (((gi & ((ki | (ci & ((bi & !ei) & !di))) | ((!l13 | ki) & (ei & !l22)))) & ki) | (((!gi & !fi) | fi) & ((!gi & !fi) | (ki & !gi)))) & (!fi | (((!gi & !fi) | fi) & ((!gi & !fi) | (ki & !gi))));
  wire  ndos4 = !gi & !fi;
  wire  pdos4 = (hi & gi) & fi;
  wire 
       illegalk = ((((!gi | !fi) & ki) & ((((bi | !di) | ai) | !ci) | (!ei & ki))) | ((!hi & ((!ei | ((!ci | !di) & ki)) | ((bi | ai) & ki))) & ki)) | ((((!l31 & (!ei | (((bi | !di) | ai) | !ci))) & (ki | !l22)) & ki) | ((!ei & ki) & ((((bi | !di) | ai) | !ci) | (!ei & ki))));
  wire 
       compls6 = ((pd1s6 | dispin) & (!dispin | dispin)) & ((nd1s6 | pd1s6) & (nd1s6 | !dispin));
  wire 
       disp6 = (((ndos6 & ~dispin) | pdos6) & ~dispin) | (~(pdos6 | ndos6) & dispin);
  wire 
       compls4 = (nd1s4 & disp6) | ((pd1s4 | (nd1s4 & disp6)) & !disp6);

  assign dispout = ((pdos4 | ndos4) & (~(pdos4 | ndos4) | ~disp6)) | (disp6 & ~(pdos4 | ndos4));
  assign dataout = {(compls4 & ~jo) | (~compls4 & jo),ho ^ compls4,((~go & compls4) | go) & ((~go & compls4) | ~compls4),(compls4 | (~compls4 & fo)) & (~fo | ~compls4),(compls6 & (~io | ~compls6)) | (~compls6 & io),(~eo & compls6) | (~compls6 & eo),(~do | ~compls6) & (do | (compls6 & ~do)),(~compls6 & co) | (compls6 & ((compls6 & ~co) | ~compls6)),(compls6 & ~bo) | (bo & ~compls6),(~compls6 & ao) | (compls6 & ((compls6 & ~ao) | ~compls6))};
endmodule

