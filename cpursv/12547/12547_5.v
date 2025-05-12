
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
  wire 
       aeqb = (!ai | ((((bi | !bi) & (!bi | ai)) & bi) & ai)) & ((bi | !bi) & (!bi | ai));
  wire 
       ceqd = ((ci | !ci) & (di | !ci)) & ((ci | !di) & (!di | di));
  wire 
       l22 = (!ceqd | ((((di & (((((!bi & (di | (l04 | ci))) & ((l04 | ci) | (!ci & ei))) | (l04 | ci)) & !ai) & ci)) | ((!di & ai) & ((bi & (ai | !ai)) & (!ai | bi)))) & ((di & (((((!bi & (di | (l04 | ci))) & ((l04 | ci) | (!ci & ei))) | (l04 | ci)) & !ai) & ci)) | !ci)) & ((!bi | ((!ci & bi) & ai)) & (!di | !bi)))) & ((((((bi | !bi) & (!bi | ai)) & bi) & ai) & (!di & !ci)) | (((!bi & ((di & (((((!bi & (di | (l04 | ci))) & ((l04 | ci) | (!ci & ei))) | (l04 | ci)) & !ai) & ci)) | ((!di & ai) & ((bi & (ai | !ai)) & (!ai | bi))))) & ((di & (((((!bi & (di | (l04 | ci))) & ((l04 | ci) | (!ci & ei))) | (l04 | ci)) & !ai) & ci)) | !ci)) | !aeqb));
  wire 
       l40 = ((((bi | !bi) & (!bi | ai)) & bi) & ai) & ((((ci | !ci) & (di | !ci)) & (ci & ((ci | !ci) & (di | !ci)))) & di);
  wire  l04 = !ci & ((!ai & !bi) & !di);
  wire 
       l13 = ((!aeqb & !di) | ((!ai & !bi) & !ceqd)) & (((!ai & !bi) & !ceqd) | !ci);
  wire 
       l31 = ((ai | (!aeqb & ((((ci | !ci) & (di | !ci)) & (ci & ((ci | !ci) & (di | !ci)))) & di))) & ((!aeqb & ((((ci | !ci) & (di | !ci)) & (ci & ((ci | !ci) & (di | !ci)))) & di)) | !ceqd)) & (bi | (!aeqb & ((((ci | !ci) & (di | !ci)) & (ci & ((ci | !ci) & (di | !ci)))) & di)));
  wire  ao = ai;
  wire  bo = (l04 | bi) & (l04 | !l40);
  wire 
       co = (((ci | (!ai | l04)) & (ci | (!bi | l04))) & ((l04 | ci) | ei)) & ((!ci & di) | (l04 | ci));
  wire 
       do = !(ci & ((((bi | !bi) & (!bi | ai)) & bi) & ai)) & di;
  wire 
       eo = ((!(!bi & (((!ci & ei) & !ai) & di)) & l13) | ei) & !(!bi & (((!ci & ei) & !ai) & di));
  wire 
       io = (((((((!di & !ci) & ei) | !ei) & (l22 | ((!di & !ci) & ei))) & !((((bi | !bi) & (!bi | ai)) & bi) & ai)) | ((((!bi & (((((!bi & (di | (l04 | ci))) & ((l04 | ci) | (!ci & ei))) | (l04 | ci)) & !ai) & ci)) & (!di & ei)) | (ei & (((((ci | !ci) & (di | !ci)) & (ci & ((ci | !ci) & (di | !ci)))) & di) & ki))) & (!ai & !bi))) | (!ei & ((l22 & (l22 | ((!di & !ci) & ei))) & (((!di & !ci) & ei) | !ei)))) | (l40 & ei);
  wire 
       pd1s6 = (!ai | ((!ei & !l22) & !l31)) & ((((!ci & di) & ei) | ((!ei & !l22) & !l31)) & (((!ei & !l22) & !l31) | !bi));
  wire 
       nd1s6 = ((((((bi & ((!di & (((!bi & (di | (l04 | ci))) & ((l04 | ci) | (!ci & ei))) | (l04 | ci))) & ci)) & ((!fi | (!hi | (!gi | !ei))) | !l31)) & !ei) & ((!ai | ((((bi | !bi) & (!bi | ai)) & bi) & ai)) & ai)) | ((((((ai | bi) | !ci) & (!l22 | ki)) & ki) | !di) & ki)) | ki) | ((!l13 & (ei | ki)) & (!l22 | ki));
  wire  ndos6 = pd1s6;
  wire  pdos6 = ((!l13 | ki) & (ei & !l22)) | ki;
  wire 
       alt7 = gi & ((ki | (dispin ? ((l31 & di) & !ei) : (l13 & (!di & ei)))) & (hi & fi));
  wire  fo = !alt7 & fi;
  wire  go = gi | ((!hi & (!gi | gi)) & (gi | !fi));
  wire  ho = hi;
  wire 
       jo = alt7 | ((fi & (alt7 | !hi)) ^ (((alt7 | !hi) & (gi | !hi)) & gi));
  wire  nd1s4 = fi & gi;
  wire 
       pd1s4 = ((ki | (!fi & !gi)) & (((!gi & fi) | (!fi & ((!gi & fi) | gi))) | !fi)) & (!gi | ((!gi & fi) | (!fi & ((!gi & fi) | gi))));
  wire  ndos4 = !fi & !gi;
  wire  pdos4 = hi & (fi & gi);
  wire 
       illegalk = ((!fi | (!hi | (!gi | !ei))) | !l31) & ((((((!fi | (!hi | (!gi | !ei))) | !l31) & ((ki | (((((((ai | bi) | !ci) & (!l22 | ki)) & ki) | !di) & ki) | (((bi & ((!di & (((!bi & (di | (l04 | ci))) & ((l04 | ci) | (!ci & ei))) | (l04 | ci))) & ci)) & ((!fi | (!hi | (!gi | !ei))) | !l31)) & !ei))) | ((!l13 | ki) & (ei & !l22)))) & ki) & !ei) | ((((((ai | bi) | !ci) & (!l22 | ki)) & ki) | !di) & ki));
  wire 
       compls6 = ((nd1s6 | pd1s6) & (!dispin | nd1s6)) & ((!dispin & pd1s6) | dispin);
  wire 
       disp6 = ((~dispin & ndos6) | (((~dispin | ~(ndos6 | pdos6)) & ~(ndos6 | pdos6)) & dispin)) | (pdos6 & ~dispin);
  wire 
       compls4 = (disp6 | (pd1s4 & !disp6)) & ((!disp6 | nd1s4) & (nd1s4 | pd1s4));

  assign dispout = ((~(pdos4 | ndos4) & disp6) | (pdos4 | ndos4)) & (~disp6 | ~(pdos4 | ndos4));
  assign dataout = {compls4 ^ jo,(ho & ~compls4) | (compls4 & ~ho),(go | (compls4 & ~go)) & (~compls4 | ~go),fo ^ compls4,compls6 ^ io,((~eo & compls6) | eo) & (~eo | ~compls6),(~compls6 & do) | (compls6 & ((~compls6 & do) | ~do)),co ^ compls6,bo ^ compls6,((compls6 & ~ao) | ao) & (~compls6 | (compls6 & ~ao))};
endmodule

