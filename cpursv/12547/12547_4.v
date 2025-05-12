
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
  wire  aeqb = ((!bi & !ai) | bi) & ((!bi & !ai) | ai);
  wire  ceqd = (ci & ((!di & !ci) | di)) | (!di & !ci);
  wire 
       l22 = (((((!aeqb | ((bi & (!di & !ci)) & (ai & ((bi | !ai) & (!ai | ai))))) | (((!ai | ((bi & (!di & !ci)) & (ai & ((bi | !ai) & (!ai | ai))))) & di) & ci)) & (((bi & (!di & !ci)) & (ai & ((bi | !ai) & (!ai | ai)))) | (!aeqb | !bi))) & (!ai | ((bi & (!di & !ci)) & (ai & ((bi | !ai) & (!ai | ai)))))) & ((((bi & ai) | !bi) & ((!di & !ci) | !bi)) & ((ci | ((bi & (!di & !ci)) & (ai & ((bi | !ai) & (!ai | ai))))) & (di | ((bi & (!di & !ci)) & (ai & ((bi | !ai) & (!ai | ai)))))))) | (!ceqd & !aeqb);
  wire 
       l40 = ((bi & ai) & ci) & ((di & (di | !ci)) & (ci | !ci));
  wire  l04 = (!bi & !ai) & (!di & !ci);
  wire 
       l13 = (((!ceqd & !ai) | !aeqb) & ((!di & !ci) | (!ceqd & !ai))) & (((!di & !ci) | !bi) & (!aeqb | !bi));
  wire 
       l31 = ((bi & ai) | (ci & (di & !aeqb))) & (!ceqd | (ci & (di & !aeqb)));
  wire  ao = ai;
  wire  bo = l04 | (!l40 & bi);
  wire 
       co = ((l04 | !ai) | ci) & (((l04 | ci) | ((di & ei) & !bi)) & ((l04 | ci) | !ci));
  wire  do = !((bi & ai) & ci) & di;
  wire 
       eo = (!((((di & ei) & !bi) & !ai) & !ci) & ei) | (!((((di & ei) & !bi) & !ai) & !ci) & l13);
  wire 
       io = ((((ki & ((di & ei) & (ci & !bi))) | ((!ai & (!di & ei)) & (ci & !bi))) | ((((!(bi & ai) | (((l22 & ((!di & (ei & !ci)) | !ei)) & ((!di & (ei & !ci)) | l22)) & !ei)) & (!di & !ci)) & ei) | (((l22 & ((!di & (ei & !ci)) | !ei)) & ((!di & (ei & !ci)) | l22)) & !ei))) | (l40 & ((ei | (((!(bi & ai) | (((l22 & ((!di & (ei & !ci)) | !ei)) & ((!di & (ei & !ci)) | l22)) & !ei)) & (!di & !ci)) & ei)) | (((l22 & ((!di & (ei & !ci)) | !ei)) & ((!di & (ei & !ci)) | l22)) & !ei)))) & ((!ai | ((ei & l40) | (((!di & ei) & !(bi & ai)) & !ci))) | (((l22 & ((!di & (ei & !ci)) | !ei)) & ((!di & (ei & !ci)) | l22)) & !ei));
  wire 
       pd1s6 = (((!l31 | ((ei & (!ci & di)) & !ai)) & (!l31 | !bi)) & (((!l22 & ((!gi | !hi) | ((!l31 | !ei) | !fi))) & !ei) | !ai)) & ((((di & ei) & !bi) & !ci) | ((!l22 & ((!gi | !hi) | ((!l31 | !ei) | !fi))) & !ei));
  wire 
       nd1s6 = (((ei & !l22) | ki) & (ki | !l13)) | (((bi & ai) & !ei) & (!di & ci));
  wire  ndos6 = pd1s6;
  wire  pdos6 = ((ei & !l22) | ki) & (ki | !l13);
  wire 
       alt7 = ((((gi & (fi & hi)) & fi) & ((ki & gi) & hi)) | (dispin ? ((l31 & di) & !ei) : ((ei & l13) & !di))) & (gi & (fi & hi));
  wire  fo = fi & !alt7;
  wire  go = (!gi | gi) & ((gi | !fi) & (!hi | gi));
  wire  ho = hi;
  wire 
       jo = alt7 | ((alt7 | ((~gi & fi) | ((~fi & (gi | !fi)) & gi))) & !hi);
  wire  nd1s4 = fi & gi;
  wire 
       pd1s4 = (!fi | (((fi & (((!fi & (gi | !fi)) & gi) | !gi)) | ((!fi & (gi | !fi)) & gi)) & ki)) & (!gi | (gi & (ki & !fi)));
  wire  ndos4 = !gi & !fi;
  wire  pdos4 = gi & (fi & hi);
  wire 
       illegalk = ((((((((ai | bi) & (ki | ei)) & ki) | ((ki & !ci) | (ki & !di))) | (ki & !ei)) & !l31) | (!fi | (!ei | !hi))) | !gi) & (((((ai | bi) & (ki | ei)) & ki) | ((ki & !ci) | (ki & !di))) | (ki & !ei));
  wire 
       compls6 = ((pd1s6 | nd1s6) & (!dispin | nd1s6)) & (((pd1s6 & ((pd1s6 | nd1s6) & (!dispin | nd1s6))) & ((!dispin & (!dispin | nd1s6)) & (pd1s6 | nd1s6))) | dispin);
  wire 
       disp6 = ((~dispin & ((pdos6 & ~dispin) | ndos6)) | dispin) & (~dispin | ~(pdos6 | ndos6));
  wire 
       compls4 = ((((pd1s4 | nd1s4) & (!disp6 | nd1s4)) & (pd1s4 & ((pd1s4 | nd1s4) & (!disp6 | nd1s4)))) & !disp6) | (nd1s4 & disp6);

  assign dispout = (ndos4 & ~disp6) | ((~disp6 & pdos4) | (~(pdos4 | ndos4) & disp6));
  assign dataout = {jo ^ compls4,compls4 ^ ho,go ^ compls4,compls4 ^ fo,(io & ~compls6) | (compls6 & ~io),(~eo | ~compls6) & ((compls6 & ~eo) | eo),do ^ compls6,co ^ compls6,(~bo & compls6) | (bo & ~compls6),(((compls6 & ~ao) | ~compls6) & compls6) | ((((compls6 & ~ao) | ~compls6) & ao) & ~compls6)};
endmodule

