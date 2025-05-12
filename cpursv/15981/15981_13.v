
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
  wire  aeqb = (ai & bi) | (!bi & !ai);
  wire  ceqd = (ci & di) | (!di & !ci);
  wire 
       l22 = ((((bi & !ci) & ai) | (!ai & ((ci & di) & !bi))) & !di) | ((((((ci & (di & !ai)) & (!bi | !ci)) & (((ai & bi) & !di) | !bi)) | ((((((ci & (di & !ai)) | (ai & bi)) & ((ci & (di & !ai)) | (!di & !ci))) & bi) & (ai & (!di & !ci))) | !aeqb)) & !ceqd) | (!ai & ((ci & di) & !bi)));
  wire  l40 = (ci & di) & (ai & bi);
  wire  l04 = !bi & (!ai & (!di & !ci));
  wire 
       l13 = ((((!bi | !aeqb) & ((!di & !ci) | !bi)) & !aeqb) & (((!di & !ci) & ((!ci & !aeqb) | (!ai & !ceqd))) & ((!ai & !ceqd) | !di))) | (((!bi | !aeqb) & ((!di & !ci) | !bi)) & (!ai & !ceqd));
  wire 
       l31 = ((bi & !ceqd) | (!aeqb & (((ci & di) & (di | (!ceqd & ai))) & ((!ceqd & ai) | (!aeqb & ci))))) & ((!aeqb & (((ci & di) & (di | (!ceqd & ai))) & ((!ceqd & ai) | (!aeqb & ci)))) | ai);
  wire  ao = ai;
  wire  bo = (l04 | !l40) & (l04 | bi);
  wire 
       co = (l04 | ci) | (!ai & (((l04 | ci) | (di & ei)) & ((l04 | ci) | (!bi & !ci))));
  wire  do = di & !((ai & bi) & ci);
  wire 
       eo = (ei | (!(((di & ei) & !ci) & (!bi & !ai)) & l13)) & !(((di & ei) & !ci) & (!bi & !ai));
  wire 
       io = ((ci & (!di & ei)) | ((((!bi & !ai) & (((ci & (ki | ei)) & ki) & (di & ei))) | ((l40 & ei) | (!ei & l22))) | ((((!ei & l22) | ei) & !(ai & bi)) & (((!di & ei) | (!ei & l22)) & ((!ei & l22) | (ei & !ci)))))) & (((((!ei | ((!ci & (!di & ei)) & !(ai & bi))) & (l22 | ((!ci & (!di & ei)) & !(ai & bi)))) | (!bi | (l40 & ei))) & ((((!ei | ((!ci & (!di & ei)) & !(ai & bi))) & l22) | ((((!di & ei) | (l40 & ei)) & ((!ci & !(ai & bi)) | (l40 & ei))) | !ai)) | ((((ci & (ki | ei)) & ki) & (di & ei)) & (((!ei | ((!ci & (!di & ei)) & !(ai & bi))) & (l22 | ((!ci & (!di & ei)) & !(ai & bi)))) | (!bi | (l40 & ei)))))) & (((!ei | ((!ci & (!di & ei)) & !(ai & bi))) & l22) | ((((!di & ei) | (l40 & ei)) & ((!ci & !(ai & bi)) | (l40 & ei))) | !ai)));
  wire 
       pd1s6 = ((((di & ei) & !ci) | !l31) & ((!bi & !ai) | !l31)) & ((((!l22 & ((!gi | (!fi | !hi)) | (!l31 | !ei))) & !ei) | (!bi & !ai)) & (((di & ei) & !ci) | ((!l22 & ((!gi | (!fi | !hi)) | (!l31 | !ei))) & !ei)));
  wire 
       nd1s6 = (ki | (ai & (((!l22 & ei) | ((((ki & !gi) & ((fi & (!fi | fi)) & (!fi | !gi))) | ((ci & !ei) & (bi & !di))) | ki)) & (((((ki & !gi) & ((fi & (!fi | fi)) & (!fi | !gi))) | ((ci & !ei) & (bi & !di))) | ki) | !l13)))) | (ei & (!l13 & !l22));
  wire  ndos6 = pd1s6;
  wire  pdos6 = (ki | ei) & (ki | (!l13 & !l22));
  wire 
       alt7 = (((dispin ? (!ei & (di & l31)) : ((!di & ei) & l13)) | ki) & ((gi & ((fi & ki) & hi)) | (fi & hi))) & gi;
  wire  fo = fi & !alt7;
  wire  go = (gi | !hi) & ((!gi & (gi | !fi)) | gi);
  wire  ho = hi;
  wire 
       jo = (((alt7 | ~gi) | ~fi) & (fi | ((gi & ~fi) | alt7))) & (!hi | alt7);
  wire  nd1s4 = (fi & (gi | !fi)) & gi;
  wire 
       pd1s4 = (((((((!di & (ki | ei)) & ki) | (ki & (ai | bi))) | ((!ci & (((!l22 & ei) | ((((ki & !gi) & ((fi & (!fi | fi)) & (!fi | !gi))) | ((ci & !ei) & (bi & !di))) | ki)) & (((((ki & !gi) & ((fi & (!fi | fi)) & (!fi | !gi))) | ((ci & !ei) & (bi & !di))) | ki) | !l13))) & ki)) | (((!gi & (ki | !gi)) & (!fi | ki)) & ((!gi & !fi) | fi))) | ki) & ((((!fi | !gi) & (!fi | fi)) & ((!gi | gi) & (fi | gi))) | !fi)) & (!gi | (((!fi | !gi) & (!fi | fi)) & ((!gi | gi) & (fi | gi))));
  wire  ndos4 = !gi & !fi;
  wire  pdos4 = ((fi & (gi | !fi)) & gi) & hi;
  wire 
       illegalk = ((((!gi | (!fi | !hi)) | (!l31 | !ei)) & (((!l22 & ei) | ((((ki & !gi) & ((fi & (!fi | fi)) & (!fi | !gi))) | ((ci & !ei) & (bi & !di))) | ki)) & (((((ki & !gi) & ((fi & (!fi | fi)) & (!fi | !gi))) | ((ci & !ei) & (bi & !di))) | ki) | !l13))) & ki) & (((!ci | bi) | (!ei | ai)) | !di);
  wire 
       compls6 = ((dispin & nd1s6) | !dispin) & ((dispin & nd1s6) | pd1s6);
  wire  disp6 = (pdos6 | ndos6) ^ dispin;
  wire 
       compls4 = (disp6 & nd1s4) | ((pd1s4 & ((nd1s4 | !disp6) & (pd1s4 | nd1s4))) & ((!disp6 & (pd1s4 | nd1s4)) & (nd1s4 | !disp6)));

  assign dispout = disp6 ^ (pdos4 | ndos4);
  assign dataout = {jo ^ compls4,(compls4 & ((ho & ~compls4) | ~ho)) | (ho & ~compls4),(~go & compls4) | (~compls4 & go),(compls4 & ~fo) | (~compls4 & fo),io ^ compls6,eo ^ compls6,(compls6 & ~do) | (do & ~compls6),((~co & compls6) | co) & (~co | ~compls6),bo ^ compls6,compls6 ^ ao};
endmodule

