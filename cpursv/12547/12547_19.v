
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
       aeqb = (!bi & !ai) | (((ai & (ai | !ai)) & (!ai | bi)) & bi);
  wire 
       ceqd = ((di | !di) & (ci | !di)) & ((!ci | di) & (ci | !ci));
  wire 
       l22 = ((!bi & (!di | ((!ai & ci) & (di & ((!ci | di) & (ci | !ci)))))) & (((!ai & ci) & (di & ((!ci | di) & (ci | !ci)))) | ((!ci & bi) & ((ai & (ai | !ai)) & (!ai | bi))))) | (((((!bi | (((ai & (ai | !ai)) & (!ai | bi)) & bi)) & ((!ci & !di) | !bi)) & bi) & ((ai & !ci) & !di)) | ((!ceqd & (((!ai & ci) & (di & ((!ci | di) & (ci | !ci)))) | (((((!bi | (((ai & (ai | !ai)) & (!ai | bi)) & bi)) & ((!ci & !di) | !bi)) & bi) & ((ai & !ci) & !di)) | !aeqb))) & (!aeqb | ((!bi | (((ai & (ai | !ai)) & (!ai | bi)) & bi)) & ((!ci & !di) | !bi)))));
  wire 
       l40 = ((((di | !di) & (ci | !di)) & di) & (ci & ((!ci | di) & (ci | !ci)))) & (((ai & (ai | !ai)) & (!ai | bi)) & bi);
  wire  l04 = (!ci & !bi) & (!ai & !di);
  wire 
       l13 = (((!ci & !aeqb) | !bi) & (!bi | !di)) & (((((!di & ((!ci & !aeqb) | (!ceqd & !ai))) & ((!ceqd & !ai) | !di)) & (!ci & !aeqb)) | !ceqd) & ((((!di & ((!ci & !aeqb) | (!ceqd & !ai))) & ((!ceqd & !ai) | !di)) & (!ci & !aeqb)) | !ai));
  wire 
       l31 = (di & (((((!ceqd & ai) | ((((di | !di) & (ci | !di)) & di) & (ci & ((!ci | di) & (ci | !ci))))) & ((!ceqd & ai) | !aeqb)) & ci) & !aeqb)) | ((bi & (di | (!ceqd & ai))) & ((!ceqd & ai) | (!aeqb & ci)));
  wire  ao = ai;
  wire  bo = (!l40 | l04) & (l04 | bi);
  wire 
       co = (ci | (!ai | l04)) & (((!bi & (ei & (di & !ci))) | l04) | ci);
  wire 
       do = di & !(ci & (((ai & (ai | !ai)) & (!ai | bi)) & bi));
  wire 
       eo = !((!bi & !ai) & (ei & (di & !ci))) & ((l13 & !((!bi & !ai) & (ei & (di & !ci)))) | ei);
  wire 
       io = ((((((ei & ((((!l22 & !l13) | ki) & (ei | ki)) | ((!di & !ei) & (bi & ci)))) & ki) & ((!bi & !ai) & ((((di | !di) & (ci | !di)) & di) & (ci & ((!ci | di) & (ci | !ci)))))) | (((!(((ai & (ai | !ai)) & (!ai | bi)) & bi) & !ci) & ei) & !di)) | (l22 & ((!ei & ((!di & (!ci & ei)) | !ei)) & (l22 | (!di & (!ci & ei)))))) | (ei & (((((!(((ai & (ai | !ai)) & (!ai | bi)) & bi) & !ci) & ei) & !di) | l40) | ((!ei | (((!(((ai & (ai | !ai)) & (!ai | bi)) & bi) & !ci) & ei) & !di)) & l22)))) | ((!bi & (!di & ei)) & (!ai & ci));
  wire 
       pd1s6 = ((!bi | ((!l31 & !ei) & !l22)) & ((ei & (di & !ci)) | ((!l31 & !ei) & !l22))) & (((!l31 & !ei) & !l22) | !ai);
  wire 
       nd1s6 = ((((!di & !ei) | (((!l22 & !l13) | ki) & (ei | ki))) & (ci | (((!l22 & !l13) | ki) & (ei | ki)))) & ((!l13 & (ki | (ei & !l22))) | (ki | (((ki & fi) & !gi) | ai)))) & (((!l13 & (ei & !l22)) | bi) | ki);
  wire  ndos6 = pd1s6;
  wire  pdos6 = ((!l22 & !l13) | ki) & (ei | ki);
  wire 
       alt7 = (fi & hi) & (((ki | (dispin ? (di & ((l31 & ((!hi | (!gi | (!ei | !l31))) | !fi)) & !ei)) : ((!di & l13) & ei))) & (gi | !gi)) & gi);
  wire  fo = fi & !alt7;
  wire  go = (gi | (!gi & !fi)) & (!hi | gi);
  wire  ho = hi;
  wire 
       jo = (alt7 | (~(gi & !hi) & (fi & !hi))) | (~(fi & !hi) & (gi & !hi));
  wire  nd1s4 = fi & gi;
  wire 
       pd1s4 = ((fi & ((!gi & (!fi | fi)) & (!gi | !fi))) | ((!gi & !fi) | (((((fi | (!gi & !fi)) & !gi) | !fi) & (gi | (!gi & !fi))) & gi))) & ((!gi & !fi) | ki);
  wire  ndos4 = !gi & !fi;
  wire 
       pdos4 = ((((ki & fi) & gi) & hi) | (fi & hi)) & gi;
  wire 
       illegalk = ((!hi | (!gi | (!ei | !l31))) | !fi) & (((ki & (!ci | ai)) | ((!di & ki) | (!ei & ki))) | (bi & ki));
  wire 
       compls6 = (pd1s6 & !dispin) | ((dispin & (nd1s6 | pd1s6)) & (!dispin | nd1s6));
  wire  disp6 = dispin ^ (ndos6 | pdos6);
  wire 
       compls4 = ((nd1s4 & disp6) | pd1s4) & (!disp6 | (nd1s4 & disp6));

  assign dispout = (~(ndos4 | pdos4) | ~disp6) & (((~disp6 & ndos4) | (~disp6 & pdos4)) | disp6);
  assign dataout = {((~compls4 & jo) | compls4) & (~jo | (~compls4 & jo)),(~compls4 & ho) | (compls4 & (~compls4 | (~ho & compls4))),go ^ compls4,(fo & ~compls4) | (compls4 & ((fo & ~compls4) | ~fo)),(compls6 & (~compls6 | ~io)) | (io & ~compls6),compls6 ^ eo,do ^ compls6,compls6 ^ co,((bo & ~compls6) | ~bo) & ((~bo & compls6) | bo),((ao & ~compls6) | compls6) & (~compls6 | ~ao)};
endmodule

