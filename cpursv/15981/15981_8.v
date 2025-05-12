
module encode_8b10b(datain,dispin,dataout,dispout);

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
       aeqb = (((bi & (ai | !ai)) & (bi | !ai)) & ai) | (!ai & !bi);
  wire  ceqd = (!di & !ci) | (di & (ci | (!di & !ci)));
  wire 
       l22 = (!ci & (!di & (((bi & (ai | !ai)) & (bi | !ai)) & ai))) | (((((!ai & ((ci & di) | !di)) & (ci & di)) & (!ci | !bi)) & ((!di & (((bi & (ai | !ai)) & (bi | !ai)) & ai)) | !bi)) | (((((!ci & (((bi & (ai | !ai)) & (bi | !ai)) & ai)) | !aeqb) | ((!ai & ci) & (!bi & di))) & (!di | (((!ai & ci) & (!bi & di)) | !aeqb))) & !ceqd));
  wire 
       l40 = di & (((ai & (l04 | ((ci | (((ei & di) & !ci) & !bi)) | (ci | l04)))) & ci) & ((bi & (ai | !ai)) & (bi | !ai)));
  wire  l04 = (!ci & !bi) & (!ai & !di);
  wire 
       l13 = ((!aeqb | !bi) & ((!di & !ci) | !bi)) & (((!ceqd & !ai) | (!aeqb & !ci)) & ((!ceqd & !ai) | !di));
  wire 
       l31 = (ai | (di & (!aeqb & ci))) & ((di & (!aeqb & ci)) | (!ceqd & bi));
  wire  ao = ai;
  wire  bo = l04 | (!l40 & bi);
  wire 
       co = ((ci | (l04 | !ai)) & (((ci | l04) | (ei & di)) & ((ci | l04) | !ci))) & (!bi | (ci | l04));
  wire 
       do = !(((ai & (l04 | ((ci | (((ei & di) & !ci) & !bi)) | (ci | l04)))) & ci) & ((bi & (ai | !ai)) & (bi | !ai))) & di;
  wire 
       eo = !(!ai & (((ei & di) & !ci) & !bi)) & (ei | (!(!ai & (((ei & di) & !ci) & !bi)) & l13));
  wire 
       io = ((((((ei & !di) & (!ci & !(((bi & (ai | !ai)) & (bi | !ai)) & ai))) | ((!bi & (!ai & ci)) & (di & ((ei & (ki | (!l22 & ei))) & ki)))) | (l22 & (((ei & !di) & (!ci & !(((bi & (ai | !ai)) & (bi | !ai)) & ai))) | !ei))) | (l40 & ei)) | !ai) & (((l40 & ei) | (((ci & !bi) & ((ei & !di) & !ai)) | (!bi & ((ei & (ci & di)) & ki)))) | ((((ei & !di) & (!ci & !(((bi & (ai | !ai)) & (bi | !ai)) & ai))) | !ei) & (l22 | ((ei & !di) & (!ci & !(((bi & (ai | !ai)) & (bi | !ai)) & ai))))));
  wire 
       pd1s6 = (((!l31 & !ei) & !l22) | ((ei & di) & !ci)) & (((!l31 & !ei) & !l22) | (!ai & !bi));
  wire 
       nd1s6 = (((!l22 & ei) | (((ai & (l04 | ((ci | (((ei & di) & !ci) & !bi)) | (ci | l04)))) & ci) & (!ei & (!di & bi)))) & ((((ai & (l04 | ((ci | (((ei & di) & !ci) & !bi)) | (ci | l04)))) & ci) & (!ei & (!di & bi))) | !l13)) | ki;
  wire  ndos6 = pd1s6;
  wire  pdos6 = (ki | (!l22 & ei)) & (!l13 | ki);
  wire 
       alt7 = (gi & (ki | ((((!di & (ki | !l22)) & ki) | (((ai | bi) | !ci) & ki)) | (dispin ? ((!ei & l31) & di) : (l13 & (ei & !di)))))) & (((ki & fi) & (gi & hi)) | (fi & hi));
  wire  fo = !alt7 & fi;
  wire  go = (((gi | !gi) & !fi) | gi) & (gi | !hi);
  wire  ho = hi;
  wire 
       jo = ((alt7 | ((~gi & fi) | ~fi)) & (alt7 | (fi | (~fi & gi)))) & (alt7 | !hi);
  wire  nd1s4 = fi & gi;
  wire 
       pd1s4 = (((((!gi | (!fi & (((gi | !gi) & !fi) | gi))) & (ki | ei)) & ki) & (((gi | !gi) & !fi) & gi)) | !gi) & (((gi & ((((((fi | gi) & (gi | !gi)) & ((!gi & (!fi | !gi)) & (!fi | fi))) & fi) | !fi) & ki)) | !fi) | (!gi & (ki & fi)));
  wire  ndos4 = !fi & !gi;
  wire  pdos4 = (fi & hi) & gi;
  wire 
       illegalk = (((((!l31 & (!l13 | ki)) & ki) & (((ai | bi) | !ci) | (!di | (!ei & ki)))) | (!fi | (!hi | (!ei | !gi)))) & ki) & (((!ci & (ki | !l22)) & ki) | ((((ai | bi) | !di) & ki) | !ei));
  wire 
       compls6 = (dispin | (((!dispin & (!dispin | nd1s6)) & (pd1s6 | nd1s6)) & (pd1s6 & ((pd1s6 | nd1s6) & (!dispin | nd1s6))))) & ((pd1s6 | nd1s6) & (!dispin | nd1s6));
  wire 
       disp6 = ((dispin & ~(pdos6 | ndos6)) | (pdos6 | ndos6)) & ((((ndos6 & ~dispin) | pdos6) & ~dispin) | ~(pdos6 | ndos6));
  wire 
       compls4 = (nd1s4 & disp6) | ((pd1s4 | (nd1s4 & disp6)) & !disp6);

  assign dispout = (disp6 & ~(pdos4 | ndos4)) | ((~disp6 | ~(pdos4 | ndos4)) & (pdos4 | ndos4));
  assign dataout = {compls4 ^ jo,((~ho & compls4) | ho) & (~compls4 | ~ho),(((~compls4 | ~go) & go) & ~compls4) | ((~compls4 | ~go) & compls4),(((compls4 & ~fo) | ~compls4) & compls4) | (~compls4 & fo),compls6 ^ io,(compls6 & ~eo) | (~compls6 & eo),(~compls6 & do) | (~do & compls6),(co & ~compls6) | (~co & compls6),((~bo & compls6) | ~compls6) & (bo | (~bo & compls6)),compls6 ^ ao};
endmodule

