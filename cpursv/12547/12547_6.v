
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
  wire  aeqb = (ai & bi) | (!ai & !bi);
  wire  ceqd = (!di & !ci) | (((!di & !ci) | di) & ci);
  wire 
       l22 = ((((((!di & ((ai | !bi) & (!bi | bi))) & (ai & bi)) | ((!ai & ci) & di)) & (!ci | ((!ai & ci) & di))) & !bi) | (!ceqd & !aeqb)) | (ai & ((!di & !ci) & bi));
  wire  l40 = ((ci & bi) & ai) & di;
  wire  l04 = (!di & !ai) & (!ci & !bi);
  wire 
       l13 = ((((!ceqd & !ai) | !di) & ((!aeqb & !ci) | (!ceqd & !ai))) & ((!di & !ci) | !bi)) & (!bi | !aeqb);
  wire 
       l31 = ((!ceqd & (ai & ((ai | !ai) & (!ai | bi)))) & bi) | ((di | ((!ceqd & (ai & ((ai | !ai) & (!ai | bi)))) & bi)) & (!aeqb & ci));
  wire  ao = ai;
  wire  bo = (bi & !l40) | l04;
  wire 
       co = l04 | ((di & ((!ci & ei) & (!ai & !bi))) | ci);
  wire  do = !((ci & bi) & ai) & di;
  wire 
       eo = !(di & ((!ci & ei) & (!ai & !bi))) & ((!(di & ((!ci & ei) & (!ai & !bi))) & l13) | ei);
  wire 
       io = ((!bi & ((((((di & (!ci | ci)) & (!ci | di)) & ci) & ((ei & (!l22 | ki)) & ki)) & !ai) | (((ci & ((!ai & !bi) | bi)) & (!ai & !bi)) & (!di & ei)))) | (!ei & l22)) | ((((!ci & ei) & !(ai & bi)) & !di) | (ei & l40));
  wire 
       pd1s6 = (((di & ei) & !ci) | (!l22 & (!ei & !l31))) & ((!ai & !bi) | (!l22 & (!ei & !l31)));
  wire 
       nd1s6 = (((ai | ((ki | !l13) & ((ei & !l22) | ki))) & (ki | (bi | ((ei & !l22) & (ki | !l13))))) & ((!di & ci) | ((ki | !l13) & ((ei & !l22) | ki)))) & (!ei | ((ki | !l13) & ((ei & !l22) | ki)));
  wire  ndos6 = pd1s6;
  wire  pdos6 = (ki | !l13) & ((ei & !l22) | ki);
  wire 
       alt7 = (hi & (((dispin ? (di & (l31 & !ei)) : (l13 & (!di & ei))) | (((!di | ((ki & (bi | !ci)) | (ki & ai))) & (ki | !l13)) & ki)) | ki)) & (fi & gi);
  wire  fo = !alt7 & fi;
  wire  go = (!hi & ((gi | !gi) & (!fi | gi))) | gi;
  wire  ho = hi;
  wire 
       jo = (((alt7 | fi) | (gi & ~fi)) & ((~gi | ~fi) | alt7)) & (!hi | alt7);
  wire  nd1s4 = fi & gi;
  wire 
       pd1s4 = ((!fi & !gi) | ((ki & fi) & (!gi & ki))) | (((ki | (!fi & !gi)) & (!gi | (((!fi & (!fi | gi)) & gi) | (!fi & !gi)))) & ((!fi & (!fi | gi)) & gi));
  wire  ndos4 = !fi & !gi;
  wire  pdos4 = fi & ((hi & (gi | !gi)) & gi);
  wire 
       illegalk = ((!ei & (ki | !l13)) & ki) | ((((!di | ((ki & (bi | !ci)) | (ki & ai))) & (ki | !l13)) & ki) & ((!l31 | !ei) | ((!gi | !hi) | !fi)));
  wire 
       compls6 = ((pd1s6 | dispin) & (!dispin | dispin)) & ((nd1s6 | !dispin) & (nd1s6 | pd1s6));
  wire  disp6 = dispin ^ (pdos6 | ndos6);
  wire 
       compls4 = (disp6 | (!disp6 & pd1s4)) & ((!disp6 & pd1s4) | nd1s4);

  assign dispout = (((((ndos4 | (pdos4 & ~disp6)) & ~disp6) | ~(pdos4 | ndos4)) & disp6) & ~(pdos4 | ndos4)) | ((pdos4 | ndos4) & (((ndos4 | (pdos4 & ~disp6)) & ~disp6) | ~(pdos4 | ndos4)));
  assign dataout = {jo ^ compls4,((((~ho | ~compls4) & ho) & ~compls4) | compls4) & (~ho | ~compls4),compls4 ^ go,compls4 ^ fo,((~io & compls6) | io) & ((~io & compls6) | ~compls6),eo ^ compls6,(do | (compls6 & ~do)) & (~compls6 | (compls6 & ~do)),(~co & compls6) | (((~compls6 | (~co & compls6)) & co) & ~compls6),compls6 ^ bo,((~compls6 & ao) | ~ao) & (ao | (compls6 & ~ao))};
endmodule

