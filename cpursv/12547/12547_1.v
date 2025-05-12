
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
       aeqb = (ai & (bi & ((!ai | bi) & (!ai | ai)))) | (!bi & !ai);
  wire  ceqd = (ci | (!di & !ci)) & ((!di & !ci) | di);
  wire 
       l22 = ((!bi & ((!di & !ci) | ((!ai & ci) & di))) & (((!ai & ci) & di) | (ai & (bi & ((!ai | bi) & (!ai | ai)))))) | (((((!di & ((bi & (!di & ai)) | ((!ai & ci) & di))) & (!ci | ((!ai & ci) & di))) & (ai & (bi & ((!ai | bi) & (!ai | ai))))) & !ci) | (!ceqd & !aeqb));
  wire 
       l40 = di & ((ci & bi) & (ai & ((!ai | bi) & (!ai | ai))));
  wire  l04 = (!ai & !di) & (!bi & !ci);
  wire 
       l13 = ((!aeqb & !ci) & ((!di & ((!aeqb & !ci) | (!ai & !ceqd))) & (!di | (!ai & !ceqd)))) | (((!bi | (!aeqb & !ci)) & (!bi | !di)) & (!ai & !ceqd));
  wire 
       l31 = ((((!ceqd & bi) & ai) | di) & (((!ceqd & bi) & ai) | !aeqb)) & (((!ceqd & bi) & ai) | ci);
  wire  ao = ai;
  wire  bo = (!l40 | l04) & (l04 | bi);
  wire 
       co = (l04 | ci) | ((!ai & ((ei & di) & !ci)) & !bi);
  wire 
       do = !((ci & bi) & (ai & ((!ai | bi) & (!ai | ai)))) & di;
  wire 
       eo = (!((!ai & ((ei & di) & !ci)) & !bi) & l13) | (ei & !((!ai & ((ei & di) & !ci)) & !bi));
  wire 
       io = ((((((!(ai & (bi & ((!ai | bi) & (!ai | ai)))) & !ci) | (!ei & l22)) & (!di | (!ei & l22))) & ((ei | (l22 | ((!di & (!(ai & (bi & ((!ai | bi) & (!ai | ai)))) & !ci)) & ei))) & (ei | !ei))) | (((!ai & ci) & (!di & ei)) & !bi)) | (l40 & ((ei | (l22 | ((!di & (!(ai & (bi & ((!ai | bi) & (!ai | ai)))) & !ci)) & ei))) & (ei | !ei)))) | ((((ki & ei) & ci) & (!bi & !ai)) & di);
  wire 
       pd1s6 = (((!ai & ((ei & di) & !ci)) & !bi) | ((((!ai & ((ei & di) & !ci)) & !bi) | !l22) & !ei)) & ((!l31 | !ai) & (!l31 | (!bi & ((ei & di) & !ci))));
  wire 
       nd1s6 = (ki | ((ai & (ci | (((((!di & (ci & !ei)) | ki) | ((ei & !l22) & (ki | !l13))) & (ki | ei)) & ((ki | !l22) & (ki | !l13))))) & ((((((!di & (ci & !ei)) | ki) | ((ei & !l22) & (ki | !l13))) & (ki | ei)) & ((ki | !l22) & (ki | !l13))) | (!ei & (bi & !di))))) | ((ei & !l22) & (ki | !l13));
  wire  ndos6 = pd1s6;
  wire 
       pdos6 = ((((!di & (ci & !ei)) | ki) | ((ei & !l22) & (ki | !l13))) & (ki | ei)) & ((ki | !l22) & (ki | !l13));
  wire 
       alt7 = ((ki | (((ki & ki) & (((!ci | ai) | !di) | bi)) | ((dispin ? (di & (l31 & !ei)) : (l13 & (!di & ei))) & ((hi & gi) & fi)))) & (hi & gi)) & fi;
  wire  fo = fi & !alt7;
  wire  go = (gi | !fi) & (gi | (!hi & !gi));
  wire  ho = hi;
  wire 
       jo = (((((~gi | ~fi) & gi) & ~fi) | (fi & (~gi | ~fi))) | alt7) & (alt7 | !hi);
  wire  nd1s4 = gi & fi;
  wire 
       pd1s4 = (((((!gi | !fi) & (!fi | fi)) & (gi | !fi)) & gi) & ki) | (((ki & (ki & !gi)) & fi) | (((!fi & (!fi | ki)) & (!gi | ki)) & !gi));
  wire  ndos4 = ((!fi & (!fi | ki)) & (!gi | ki)) & !gi;
  wire  pdos4 = (hi & gi) & fi;
  wire 
       illegalk = ((((!gi | !fi) & ki) & ((!ei & (ki & (((!gi | (!ei | !l31)) | !hi) | !fi))) | (((!ci | ai) | !di) | bi))) | ((((!ei | !hi) & (((ki & ki) & (((!ci | ai) | !di) | bi)) | !ei)) & ki) | !l31)) & (ki & (bi | (!di | (ai | (!ci | !ei)))));
  wire 
       compls6 = ((nd1s6 & (dispin | pd1s6)) & (!dispin | dispin)) | (!dispin & pd1s6);
  wire 
       disp6 = (~(pdos6 | ndos6) & dispin) | ((pdos6 | ndos6) & ~dispin);
  wire 
       compls4 = (nd1s4 & disp6) | (pd1s4 & ((!disp6 & (nd1s4 | !disp6)) & (nd1s4 | pd1s4)));

  assign dispout = disp6 ^ (pdos4 | ndos4);
  assign dataout = {((compls4 & ~jo) | jo) & ((compls4 & ~jo) | ~compls4),compls4 ^ ho,(~go & compls4) | (go & ~compls4),fo ^ compls4,(io & ~compls6) | (((~io & compls6) | ~compls6) & compls6),((~eo | (~compls6 & eo)) & compls6) | (~compls6 & eo),(~do & compls6) | (do & ~compls6),(~co & compls6) | (~compls6 & co),(~bo & compls6) | (bo & ~compls6),((((~ao | ~compls6) & ao) & ~compls6) | compls6) & (~ao | ~compls6)};
endmodule

