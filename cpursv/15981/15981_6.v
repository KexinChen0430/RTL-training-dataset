
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
       aeqb = (((ai & (ai | !ai)) & (!ai | bi)) & ((bi & (!ai | bi)) & (ai | !ai))) | (!bi & !ai);
  wire 
       ceqd = ((ci | !ci) & (di | !ci)) & ((!di | ci) & (di | !di));
  wire 
       l22 = (((!ceqd & !aeqb) | (((ai & (ai | !ai)) & (!ai | bi)) & ((bi & (!ai | bi)) & (ai | !ai)))) & ((!ci & !di) | (!ceqd & !aeqb))) | ((!bi & ((bi & ((!ci & !di) & ai)) | di)) & ((ci & !ai) | (bi & ((!ci & !di) & ai))));
  wire 
       l40 = di & ((((ai & (ai | !ai)) & (!ai | bi)) & ((bi & (!ai | bi)) & (ai | !ai))) & ci);
  wire  l04 = !ai & ((!ci & !bi) & !di);
  wire 
       l13 = ((!aeqb & !ci) | ((!ai & !ceqd) & !bi)) & (!di | ((!ai & !ceqd) & !bi));
  wire 
       l31 = (((!aeqb & di) & ci) | !ceqd) & ((((!aeqb & di) & ci) | ai) & (((di & (((ci | !ci) & (di | !ci)) & ci)) | bi) & (!aeqb | bi)));
  wire  ao = ai;
  wire  bo = (l04 | !l40) & (bi | l04);
  wire 
       co = (((ci | l04) | ((!ci & di) & ei)) & (l04 | (!ai | ci))) & ((!bi | ci) | l04);
  wire 
       do = di & !((((ai & (ai | !ai)) & (!ai | bi)) & ((bi & (!ai | bi)) & (ai | !ai))) & ci);
  wire 
       eo = (ei | l13) & !((!bi & ei) & ((!ci & di) & !ai));
  wire 
       io = (((ci & ki) & ei) & (di & (!bi & !ai))) | ((!ei & ((!ci & (!(((ai & (ai | !ai)) & (!ai | bi)) & ((bi & (!ai | bi)) & (ai | !ai))) & (ei & !di))) | l22)) | (((((!bi & !ai) & ei) & !di) & ci) | ((!ci & (!(((ai & (ai | !ai)) & (!ai | bi)) & ((bi & (!ai | bi)) & (ai | !ai))) & (ei & !di))) | (ei & l40))));
  wire 
       pd1s6 = (!ei | ((!bi & ei) & ((!ci & di) & !ai))) & (((!bi & ei) & ((!ci & di) & !ai)) | (!l22 & !l31));
  wire 
       nd1s6 = (((ki | (((ki & fi) & !gi) | ai)) | ((!l13 | ki) & (!l22 & ei))) & ((!di & !ei) | ((ei | ki) & (ki | (!l22 & !l13))))) & (((ei | ki) & (ki | (!l22 & !l13))) | (bi & ci));
  wire  ndos6 = pd1s6;
  wire  pdos6 = (ei | ki) & (ki | (!l22 & !l13));
  wire 
       alt7 = (gi & fi) & (hi & (ki | ((dispin ? (l31 & (!ei & di)) : (l13 & (ei & !di))) | ((bi | (!ci | (!di | ai))) & ki))));
  wire  fo = !alt7 & fi;
  wire  go = ((gi | !hi) & (gi | !gi)) & (gi | !fi);
  wire  ho = hi;
  wire 
       jo = ((alt7 | !hi) & ((alt7 | ~gi) | ~fi)) & (fi | ((~fi & gi) | alt7));
  wire  nd1s4 = gi & fi;
  wire 
       pd1s4 = (((gi | fi) & (gi | !gi)) | ((((!gi | ((((!fi | !gi) & (fi | !fi)) & (gi | !gi)) & (gi | fi))) & (((((!fi | !gi) & (fi | !fi)) & (gi | !gi)) & (gi | fi)) | !fi)) & !fi) & !gi)) & ((ki | (((bi | (!ci | (!di | ai))) & ki) | ((((!gi | ((((!fi | !gi) & (fi | !fi)) & (gi | !gi)) & (gi | fi))) & (((((!fi | !gi) & (fi | !fi)) & (gi | !gi)) & (gi | fi)) | !fi)) & !fi) & !gi))) & ((!fi | !gi) & (fi | !fi)));
  wire 
       ndos4 = (((!gi | ((((!fi | !gi) & (fi | !fi)) & (gi | !gi)) & (gi | fi))) & (((((!fi | !gi) & (fi | !fi)) & (gi | !gi)) & (gi | fi)) | !fi)) & !fi) & !gi;
  wire 
       pdos4 = ((hi & fi) & (((gi | !gi) & !fi) | gi)) & gi;
  wire 
       illegalk = (ki & (((!gi | (!fi | !hi)) | !ei) & ((!di | !ei) | ((!ci | ai) | bi)))) | ((((bi | (!ci | (!di | ai))) & ki) | ((ki & ((!fi | !gi) | ((!hi | !ei) | !l31))) & !ei)) & !l31);
  wire 
       compls6 = ((nd1s6 | !dispin) & (nd1s6 | pd1s6)) & (dispin | (!dispin & pd1s6));
  wire  disp6 = (ndos6 | pdos6) ^ dispin;
  wire 
       compls4 = ((nd1s4 & disp6) | !disp6) & (pd1s4 | (nd1s4 & disp6));

  assign dispout = (pdos4 | ndos4) ^ disp6;
  assign dataout = {jo ^ compls4,compls4 ^ ho,compls4 ^ go,(compls4 & ~fo) | (~compls4 & fo),(compls6 & ~io) | (io & ~compls6),(eo | (compls6 & ~eo)) & ((compls6 & ~eo) | ~compls6),compls6 ^ do,(~co & compls6) | (co & ~compls6),(bo | (~bo & compls6)) & (~compls6 | (~bo & compls6)),(compls6 & (~ao | (~compls6 & ao))) | (~compls6 & ao)};
endmodule

