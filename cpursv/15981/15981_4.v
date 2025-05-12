
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
       aeqb = (bi & ai) | (((!ai | bi) & (!ai | ai)) & !bi);
  wire 
       ceqd = ((!ci | di) & (!ci | ci)) & ((!di | ci) & (!di | di));
  wire 
       l22 = (((!ci & !di) | (!ceqd & !aeqb)) & ((bi & ai) | (!ceqd & !aeqb))) | ((((ai | !bi) & (bi | !bi)) & ((!ci & !di) | !bi)) & (((di & !ai) & ((l04 | ci) | (((di & !ci) & !bi) & ei))) & ci));
  wire 
       l40 = ((ci & (((!ai | bi) & (!ai | ai)) & bi)) & ai) & ((di & (!ci | ci)) & (!ci | di));
  wire 
       l04 = ((!bi & !ai) & (ci | (!ci & !di))) & (!ci & !di);
  wire 
       l13 = ((!ceqd & !bi) & !ai) | (!di & (!aeqb & !ci));
  wire 
       l31 = ((((!aeqb & ci) | bi) & (di | bi)) & (di | (!ceqd & ai))) & ((!ceqd & ai) | (!aeqb & ci));
  wire  ao = ai;
  wire  bo = ((l04 | bi) & !l40) | l04;
  wire 
       co = (((!ai & ((l04 | ci) | (ei & di))) & ((!bi & !ci) | (l04 | ci))) | l04) | ci;
  wire 
       do = di & !((ci & (((!ai | bi) & (!ai | ai)) & bi)) & ai);
  wire 
       eo = !((!bi & !ai) & (!ci & (ei & di))) & ((!((!bi & !ai) & (!ci & (ei & di))) & ei) | l13);
  wire 
       io = ((((ei & !ci) & !di) & (!(bi & ai) | l22)) & (!(bi & ai) | !ei)) | (((ei & l40) | ((((!(bi & ai) | l22) & (!(bi & ai) | !ei)) & l22) & !ei)) | (((!bi & !ai) & (ki & (ci & (ei & di)))) | ((!di & ei) & ((((!ai & ((l04 | ci) | (ei & di))) & ((!bi & !ci) | (l04 | ci))) & ci) & !bi))));
  wire 
       pd1s6 = (((!bi & !ai) & (!ci & (ei & di))) | !l31) & (((!bi & !ai) | (!l22 & !ei)) & ((!l22 & !ei) | (!ci & (ei & di))));
  wire 
       nd1s6 = ((ai & ((((!l13 & ei) & !l22) | ki) | ((!di & bi) & !ei))) & (ci | (((!l13 & ei) & !l22) | ki))) | (((!l13 & ei) & !l22) | ki);
  wire  ndos6 = pd1s6;
  wire  pdos6 = ((!l13 & ei) & !l22) | ki;
  wire 
       alt7 = ((ki | ((dispin ? ((l31 & !ei) & di) : (l13 & (!di & ei))) & (((hi & fi) & ((gi | !fi) & (!gi | gi))) & gi))) & fi) & ((hi & gi) | (gi & ((hi & fi) & ki)));
  wire  fo = fi & !alt7;
  wire  go = ((gi | !fi) & (!gi | gi)) & (!hi | gi);
  wire  ho = hi;
  wire 
       jo = (alt7 | ((~((!hi & (!hi | gi)) & gi) & !hi) & fi)) | ((~(fi & !hi) & gi) & !hi);
  wire  nd1s4 = fi & gi;
  wire 
       pd1s4 = ((((fi & ((!gi & (!fi | fi)) & (!fi | !gi))) & (ki | !fi)) & (ki | !gi)) | (!fi & ((!gi & (ki | !gi)) & (ki | !fi)))) | ((gi & !fi) & (((((!gi & ki) | (!fi & ((!gi & (ki | !gi)) & (ki | !fi)))) & (fi | (!fi & ((!gi & (ki | !gi)) & (ki | !fi))))) | (((bi | (ai | !di)) | !ci) & ki)) | ki));
  wire  ndos4 = !fi & ((!gi & (ki | !gi)) & (ki | !fi));
  wire 
       pdos4 = ((hi & fi) & ((gi | !fi) & (!gi | gi))) & gi;
  wire 
       illegalk = ((((!l31 | (!fi | !gi)) | (!ei | !hi)) & ((!l22 | (ki & (fi & ((!gi & (!fi | fi)) & (!fi | !gi))))) | ki)) & ki) & ((!ei | !ci) | (bi | (ai | !di)));
  wire 
       compls6 = (pd1s6 & !dispin) | ((dispin & (!dispin | nd1s6)) & (pd1s6 | nd1s6));
  wire 
       disp6 = ((ndos6 | pdos6) & (~dispin | ~(ndos6 | pdos6))) | (dispin & ~(ndos6 | pdos6));
  wire 
       compls4 = (((!disp6 | nd1s4) & (pd1s4 | nd1s4)) & (!disp6 | disp6)) & (disp6 | pd1s4);

  assign dispout = ((disp6 & ~(pdos4 | ndos4)) | (pdos4 | ndos4)) & (~(pdos4 | ndos4) | ~disp6);
  assign dataout = {(~compls4 | (~jo & compls4)) & ((~jo & compls4) | jo),(ho & ~compls4) | (compls4 & (~ho | ~compls4)),compls4 ^ go,(((~fo & compls4) | ~compls4) & compls4) | (~compls4 & fo),((~compls6 | (~io & compls6)) & compls6) | (io & ~compls6),(eo & ~compls6) | (compls6 & ~eo),(~compls6 | ~do) & ((~do & compls6) | do),(compls6 & ~co) | (co & ~compls6),(~compls6 & bo) | (~bo & compls6),compls6 ^ ao};
endmodule

