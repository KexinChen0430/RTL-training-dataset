
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
  wire  aeqb = (ai | (!bi & !ai)) & ((!bi & !ai) | bi);
  wire  ceqd = (di & ci) | (!di & !ci);
  wire 
       l22 = ((((!di & bi) & !ci) & ai) | (!aeqb & !ceqd)) | (di & ((ci & ((!bi & !ai) | bi)) & (!bi & !ai)));
  wire  l40 = ((ci & ((!ai | (ai & bi)) & ai)) & bi) & di;
  wire  l04 = (!bi & !ai) & (!di & !ci);
  wire 
       l13 = ((!aeqb & (!di & !ci)) | (!bi & !ai)) & (!ceqd | (!aeqb & (!di & !ci)));
  wire 
       l31 = (!ceqd | ((!aeqb & di) & ci)) & (((ai | ((!aeqb & di) & ci)) & ((!aeqb & di) | bi)) & (ci | bi));
  wire  ao = ai;
  wire  bo = (bi | l04) & (!l40 | l04);
  wire 
       co = ((((l04 | !ai) | ci) & ((l04 | ci) | di)) & ((l04 | ci) | (ei & !ci))) & ((!bi | l04) | ci);
  wire  do = !((ci & ((!ai | (ai & bi)) & ai)) & bi) & di;
  wire 
       eo = (!((((!l31 | ((di & ei) & (!ci & !ai))) & (!l31 | !bi)) & !ai) & ((di & ei) & (!bi & !ci))) & ei) | (!((((!l31 | ((di & ei) & (!ci & !ai))) & (!l31 | !bi)) & !ai) & ((di & ei) & (!bi & !ci))) & l13);
  wire 
       io = (((ei & ((!di & !ci) | di)) & (!di & !ci)) & ((!ei & l22) | !(ai & bi))) | ((!ei & l22) | ((((!bi & ((!di & ei) & !ai)) & ci) | (!ai & (((di & ei) & ki) & (ci & !bi)))) | (l40 & ei)));
  wire 
       pd1s6 = ((((!bi & !ai) | (!ei & !l22)) & ((ei & (!ci & di)) | (!ei & !l22))) & (!l31 | !ai)) & (((di & ei) & (!bi & !ci)) | !l31);
  wire 
       nd1s6 = (!l13 & (((!l22 & ei) | (((bi | !ci) | (!di | ai)) & ki)) | ki)) | (ki | ((ai & bi) & (((!di & ci) & (!fi | (!gi | (!ei | (!l31 | !hi))))) & !ei)));
  wire  ndos6 = pd1s6;
  wire  pdos6 = (ei | ki) & ((!l13 | ki) & (ki | !l22));
  wire 
       alt7 = ((fi & gi) & hi) & ((hi & (((dispin ? ((di & l31) & !ei) : (l13 & (!di & ei))) & fi) & gi)) | ki);
  wire  fo = fi & !alt7;
  wire  go = gi | (!hi & ((!fi & (gi | !gi)) | gi));
  wire  ho = hi;
  wire 
       jo = (((((~fi & (!hi | gi)) & gi) | fi) & !hi) & (~fi | (fi & ~gi))) | alt7;
  wire  nd1s4 = fi & gi;
  wire 
       pd1s4 = ((!fi & !gi) | ki) & (((((ki & ((!gi | !fi) & (fi | !fi))) & (fi & (((!gi | !fi) & (fi | !fi)) & !gi))) | !fi) & (gi | ((ki & ((!gi | !fi) & (fi | !fi))) & (fi & (((!gi | !fi) & (fi | !fi)) & !gi))))) | (!fi & !gi));
  wire  ndos4 = !fi & !gi;
  wire  pdos4 = (fi & gi) & hi;
  wire 
       illegalk = ((!fi | (!gi | (!ei | (!l31 | !hi)))) & ki) & ((((!ei & (((((!di & ci) & (!fi | (!gi | (!ei | (!l31 | !hi))))) & !ei) | ((ei | ki) & ((!l13 | ki) & (ki | !l22)))) & ((((!l13 | ki) & (!l22 & ei)) | bi) | ki))) & ki) | (!di | (bi | !ci))) | ai);
  wire 
       compls6 = (!dispin | (nd1s6 & dispin)) & (pd1s6 | (nd1s6 & dispin));
  wire  disp6 = (pdos6 | ndos6) ^ dispin;
  wire  compls4 = (pd1s4 & !disp6) | (disp6 & nd1s4);

  assign dispout = (disp6 & ~(pdos4 | ndos4)) | ((ndos4 & ~disp6) | (~disp6 & pdos4));
  assign dataout = {(compls4 & ~jo) | (jo & ~compls4),(compls4 & ~ho) | (ho & ~compls4),(go | (~go & compls4)) & (~compls4 | ~go),(fo & ~compls4) | (compls4 & ~fo),io ^ compls6,eo ^ compls6,do ^ compls6,(~co | ~compls6) & ((compls6 & ~co) | co),bo ^ compls6,ao ^ compls6};
endmodule

