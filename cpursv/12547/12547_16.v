
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
       aeqb = ((((bi & (ai | !ai)) & (bi | !ai)) & ai) | !ai) & ((((bi & (ai | !ai)) & (bi | !ai)) & ai) | !bi);
  wire  ceqd = (di & ci) | (!ci & ((di & ci) | !di));
  wire 
       l22 = (((bi & !di) & !ci) & ai) | (((!ai & di) & (ci & !bi)) | ((((!ai & di) & (ci & !bi)) | ((((bi & !di) & !ci) & ai) | !aeqb)) & !ceqd));
  wire 
       l40 = (((bi & (ai | !ai)) & (bi | !ai)) & ai) & (di & ci);
  wire 
       l04 = ((!ci & !di) & (ai | (!ai & !bi))) & (!ai & !bi);
  wire 
       l13 = (!ai & (!ceqd & !bi)) | ((!ci & !aeqb) & (!di | (!ai & (!ceqd & !bi))));
  wire 
       l31 = (((((di & !aeqb) & (ci & (!ci | (di & ci)))) | ai) & (!ceqd | ((di & !aeqb) & (ci & (!ci | (di & ci)))))) & (bi | ci)) & (bi | (di & !aeqb));
  wire  ao = ai;
  wire  bo = l04 | (!l40 & bi);
  wire 
       co = (((l04 | ci) | !ai) & ((l04 | ci) | !ci)) & ((l04 | ci) | ((di & !bi) & ei));
  wire 
       do = !(((bi & (((di & ei) & (!bi & !ci)) | (l04 | ci))) & ci) & ((ai & (bi | !ai)) & (ai | !ai))) & di;
  wire 
       eo = !(((di & ei) & (!bi & !ci)) & !ai) & ((!(((di & ei) & (!bi & !ci)) & !ai) & l13) | ei);
  wire 
       io = ((((!di & !bi) & ei) & (!ai & ci)) | (!ai & (ki & ((ci & (di & ei)) & !bi)))) | ((((ei & l40) | (!di & ei)) | (((!ei & (((!di & ei) & !ci) | l22)) & (((!di & ei) & !ci) | !ei)) & l22)) & ((!(((bi & (ai | !ai)) & (bi | !ai)) & ai) & !ci) | ((((((ki & ((ci & (di & ei)) & !bi)) | (!(((bi & (ai | !ai)) & (bi | !ai)) & ai) | (ei & l40))) | (((!ei & (((!di & ei) & !ci) | l22)) & (((!di & ei) & !ci) | !ei)) & l22)) & (((!di & ei) & !ci) | ((((!ei & (((!di & ei) & !ci) | l22)) & (((!di & ei) & !ci) | !ei)) & l22) | ((ei & l40) | (ki & ((ci & (di & ei)) & !bi)))))) & (l22 | (ei & l40))) & (!ei | (ei & l40)))));
  wire 
       pd1s6 = (((!l31 | !ai) & (((di & ei) & (!bi & !ci)) | !l31)) & (((!l22 & ((!gi | ((!ei | !fi) | !hi)) | !l31)) & !ei) | !ai)) & (((!l22 & ((!gi | ((!ei | !fi) | !hi)) | !l31)) & !ei) | ((di & ei) & (!bi & !ci)));
  wire 
       nd1s6 = (ki | ((ai & ((!di & !ei) | (ki | ((!l22 & ei) & !l13)))) & ((ki | ((!l22 & ei) & !l13)) | ((bi & (((di & ei) & (!bi & !ci)) | (l04 | ci))) & ci)))) | (((!l22 & ei) | ki) & !l13);
  wire  ndos6 = pd1s6;
  wire  pdos6 = ki | ((!l22 & ei) & !l13);
  wire 
       alt7 = (gi & (hi & fi)) & ((dispin ? ((di & !ei) & l31) : ((!di & ei) & l13)) | ki);
  wire  fo = !alt7 & fi;
  wire  go = (gi | ((gi | !gi) & !fi)) & (!hi | gi);
  wire  ho = hi;
  wire 
       jo = (alt7 | (((~fi & gi) | fi) & (~fi | ~gi))) & (alt7 | !hi);
  wire  nd1s4 = gi & fi;
  wire 
       pd1s4 = (((ki & !gi) & ((fi & (fi | !fi)) & (!fi | !gi))) | (gi & ((!fi & ((!l13 | ((ki & !gi) & ((fi & (fi | !fi)) & (!fi | !gi)))) | ki)) & ki))) | (!fi & ((!gi & (ki | !gi)) & (ki | !fi)));
  wire  ndos4 = !fi & ((!gi & (ki | !gi)) & (ki | !fi));
  wire  pdos4 = gi & (hi & fi);
  wire 
       illegalk = (!ei & ((((!gi | ((!ei | !fi) | !hi)) | !l31) & (ki | ei)) & ki)) | (((((!gi | ((!ei | !fi) | !hi)) | !l31) & (ki | ei)) & ki) & (!di | (ki & ((bi | ai) | !ci))));
  wire 
       compls6 = (pd1s6 | (dispin & nd1s6)) & ((dispin & nd1s6) | !dispin);
  wire  disp6 = (pdos6 | ndos6) ^ dispin;
  wire 
       compls4 = (!disp6 | (nd1s4 & disp6)) & (pd1s4 | (nd1s4 & disp6));

  assign dispout = ((disp6 & ~(pdos4 | ndos4)) | (~disp6 & ndos4)) | (pdos4 & ~disp6);
  assign dataout = {((~jo & compls4) | jo) & (~jo | ~compls4),(((~compls4 | (~ho & compls4)) & ho) & ~compls4) | (~ho & compls4),(compls4 & ~go) | (go & ~compls4),(~compls4 | ~fo) & ((((~compls4 | ~fo) & fo) & ~compls4) | compls4),(~compls6 & io) | (compls6 & ~io),compls6 ^ eo,(~do & compls6) | (~compls6 & do),((~co & compls6) | co) & (~compls6 | ~co),compls6 ^ bo,((ao & ~compls6) | compls6) & (~compls6 | ~ao)};
endmodule

