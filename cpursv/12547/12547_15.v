
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
  wire  aeqb = (ai & bi) | (!bi & !ai);
  wire  ceqd = ((!ci & !di) | di) & ((!ci & !di) | ci);
  wire 
       l22 = (((!bi | (((bi & ((!ci & !di) | di)) & (!ci & !di)) & ((ai & (bi | !ai)) & (ai | !ai)))) & (ci & ((di & (di | !ci)) & (!ci | ci)))) & !ai) | ((((bi & ((!ci & !di) | di)) & (!ci & !di)) & ((ai & (bi | !ai)) & (ai | !ai))) | (!ceqd & !aeqb));
  wire 
       l40 = ai & ((ci & bi) & ((di & (di | !ci)) & (!ci | ci)));
  wire  l04 = (!di & !ai) & (!bi & !ci);
  wire 
       l13 = (((!ceqd & !ai) | (!aeqb & !di)) & (!ci | (!ceqd & !ai))) & ((!aeqb | !bi) & ((!ci & !di) | !bi));
  wire 
       l31 = (((ci | bi) & (bi | (!aeqb & di))) & ((ci & ((di & (di | !ci)) & (!ci | ci))) | (ai & !ceqd))) & ((ai & !ceqd) | !aeqb);
  wire  ao = ai;
  wire  bo = ((l04 | !l40) & bi) | l04;
  wire 
       co = ((ci | ((ei & !ci) & (di & !bi))) | l04) & (l04 | (ci | !ai));
  wire  do = !(ai & (ci & bi)) & di;
  wire 
       eo = (l13 & !((!bi & (!ai & di)) & (ei & !ci))) | (!((!bi & (!ai & di)) & (ei & !ci)) & ei);
  wire 
       io = ((!ai & ((di & !bi) & (ci & ((ei & (ki | ei)) & ki)))) | ((ci & !bi) & (!ai & (!di & ei)))) | (((l22 & (((ei & (!ci & !(ai & bi))) & !di) | !ei)) | ((ei & (!ci & !(ai & bi))) & !di)) | (l40 & ei));
  wire 
       pd1s6 = ((!bi & (!ai & di)) & (ei & !ci)) | ((!l22 & !ei) & !l31);
  wire 
       nd1s6 = ((ki | !l13) | (((ai & !ei) & !di) & (ci & bi))) & (ki | (((!l22 & ei) | (((ai & !ei) & !di) & (ci & bi))) | (((!di | ((ai | !ci) | bi)) & ((((((((!fi | !gi) & (!fi | fi)) & (ki | !l22)) & ki) & (fi & !gi)) | ((ci & bi) & (!di & !ei))) | ki) | ((ei & !l13) & !l22))) & ki)));
  wire  ndos6 = pd1s6;
  wire  pdos6 = (ki | ei) & ((ki | !l13) & (ki | !l22));
  wire 
       alt7 = fi & (gi & ((ki | ((((((!fi | !gi) & (!fi | fi)) & (ki | !l22)) & ki) & (fi & !gi)) | (dispin ? (((di & l31) & ((!l31 | (!fi | !gi)) | (!hi | !ei))) & !ei) : ((l13 & !di) & ei)))) & hi));
  wire  fo = !alt7 & fi;
  wire  go = (gi | !fi) & ((!gi | gi) & (gi | !hi));
  wire  ho = hi;
  wire 
       jo = (((gi & ~fi) | fi) & (!hi & (~fi | ~gi))) | alt7;
  wire  nd1s4 = fi & gi;
  wire 
       pd1s4 = ((ki | (!gi & !fi)) & (((fi & !gi) | gi) | (!gi & !fi))) & ((!fi | !gi) & (!fi | fi));
  wire  ndos4 = !gi & !fi;
  wire 
       pdos4 = (((gi & ki) & (fi & hi)) | (fi & hi)) & gi;
  wire 
       illegalk = ((!l31 | (!fi | !gi)) | (!hi | !ei)) & (((((ai | bi) & ((!l22 & ei) | ki)) & ki) | (ki & (!di | !ei))) | (ki & !ci));
  wire 
       compls6 = ((dispin | pd1s6) & (!dispin | dispin)) & ((pd1s6 & !dispin) | nd1s6);
  wire  disp6 = dispin ^ (pdos6 | ndos6);
  wire 
       compls4 = (pd1s4 & (!disp6 | (disp6 & nd1s4))) | (disp6 & nd1s4);

  assign dispout = ((ndos4 & ~disp6) | (pdos4 & ~disp6)) | (disp6 & ~(pdos4 | ndos4));
  assign dataout = {(~compls4 | (compls4 & ~jo)) & ((compls4 & ~jo) | jo),(compls4 & ~ho) | (((~compls4 | ~ho) & ho) & ~compls4),compls4 ^ go,((~fo & compls4) | fo) & (~fo | ~compls4),compls6 ^ io,(~eo & compls6) | (~compls6 & eo),compls6 ^ do,compls6 ^ co,(bo & ~compls6) | (compls6 & ~bo),(~compls6 & ao) | (~ao & compls6)};
endmodule

