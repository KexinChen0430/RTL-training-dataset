
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
       aeqb = (!bi & !ai) | ((((!ai | bi) & (ai | !ai)) & ai) & (bi & ((!ai | bi) & (ai | !ai))));
  wire 
       ceqd = (!di & !ci) | (((di & (!ci | di)) & (ci | !ci)) & (((ci | !ci) & (!ci | di)) & ci));
  wire 
       l22 = (((ci & (!bi & !ai)) & ((di & (!ci | di)) & (ci | !ci))) | ((!di & (((ci & (!bi & !ai)) & ((di & (!ci | di)) & (ci | !ci))) | (bi & !ci))) & (((ci & (!bi & !ai)) & ((di & (!ci | di)) & (ci | !ci))) | ai))) | (!ceqd & !aeqb);
  wire 
       l40 = ((((!ai | bi) & (ai | !ai)) & ai) & (bi & ((!ai | bi) & (ai | !ai)))) & (((di & (!ci | di)) & (ci | !ci)) & (((ci | !ci) & (!ci | di)) & ci));
  wire  l04 = (!di & !bi) & (!ai & !ci);
  wire 
       l13 = ((((!ceqd & !ai) | (!aeqb & !ci)) & (!di | (!ceqd & !ai))) & (!bi | (!aeqb & !ci))) & (!di | !bi);
  wire 
       l31 = (((!ceqd & ((((!ai | bi) & (ai | !ai)) & ai) & (bi & ((!ai | bi) & (ai | !ai))))) | di) & ((!ceqd & ((((!ai | bi) & (ai | !ai)) & ai) & (bi & ((!ai | bi) & (ai | !ai))))) | !aeqb)) & ((!ceqd & ((((!ai | bi) & (ai | !ai)) & ai) & (bi & ((!ai | bi) & (ai | !ai))))) | ci);
  wire  ao = ai;
  wire  bo = (bi & (!l40 | l04)) | l04;
  wire 
       co = (((ci | l04) | (!ci & di)) & ((ci | l04) | ei)) & ((!ai | (ci | l04)) & (!bi | (ci | l04)));
  wire  do = di & !((ai & ci) & bi);
  wire 
       eo = (l13 & !((!bi & !ai) & (!ci & (ei & di)))) | (ei & !((!bi & !ai) & (!ci & (ei & di))));
  wire 
       io = ((ei & !bi) & (!ai & (ci & !di))) | (((((l22 | ((!di & !ci) & ei)) & (!ei | ((!di & !ci) & ei))) | ((ci & (!bi & !ai)) & (ki & (ei & di)))) & ((((!ei & (l22 | ((!di & !ci) & ei))) & (!ei | ((!di & !ci) & ei))) & l22) | (((ci & (!bi & !ai)) & (ki & (ei & di))) | !((((!ai | bi) & (ai | !ai)) & ai) & (bi & ((!ai | bi) & (ai | !ai))))))) | (((!ei & (l22 | ((!ci & ei) & (!((((!ai | bi) & (ai | !ai)) & ai) & (bi & ((!ai | bi) & (ai | !ai)))) & !di)))) | ei) & l40));
  wire 
       pd1s6 = ((!bi & !ai) & (!ci & (ei & di))) | (!l31 & (!l22 & !ei));
  wire 
       nd1s6 = (((!di & !ei) & ((((!ai | bi) & (ai | !ai)) & ai) & (bi & ((!ai | bi) & (ai | !ai))))) & ci) | (((!l13 & !l22) | ki) & (ei | ki));
  wire  ndos6 = pd1s6;
  wire  pdos6 = ((!l13 & !l22) | ki) & (ei | ki);
  wire 
       alt7 = (hi & (ki | ((dispin ? (di & (!ei & l31)) : ((ei & !di) & l13)) | ((fi & !gi) & ki)))) & (fi & gi);
  wire  fo = fi & !alt7;
  wire  go = ((!fi & (!gi | gi)) | gi) & (!hi | gi);
  wire  ho = hi;
  wire 
       jo = ((!hi | alt7) & (alt7 | (fi | ((~fi & (!hi | gi)) & gi)))) & (alt7 | (~gi | ~fi));
  wire  nd1s4 = fi & gi;
  wire 
       pd1s4 = ((!fi & !gi) | (((fi & !gi) & ki) | (!fi & ki))) & (((fi & !gi) | gi) | (!fi & !gi));
  wire  ndos4 = !fi & !gi;
  wire  pdos4 = fi & (gi & hi);
  wire 
       illegalk = ((((((((!di | !ei) | !ci) | ai) | bi) & !l31) & ki) | ((!ei | !hi) | (!fi | !gi))) & (!ei | ((ki & !ci) | ((((bi | ai) & (ei | ki)) & ki) | (!di & ki))))) & ki;
  wire 
       compls6 = (((nd1s6 & dispin) | pd1s6) & !dispin) | (nd1s6 & dispin);
  wire  disp6 = (ndos6 | pdos6) ^ dispin;
  wire 
       compls4 = (nd1s4 | (pd1s4 & !disp6)) & ((pd1s4 & !disp6) | disp6);

  assign dispout = (disp6 & ~(ndos4 | pdos4)) | ((~disp6 & ndos4) | (~disp6 & pdos4));
  assign dataout = {jo ^ compls4,ho ^ compls4,go ^ compls4,((fo & ~compls4) | compls4) & (~compls4 | (compls4 & ~fo)),(((~io | ~compls6) & io) & ~compls6) | (~io & compls6),eo ^ compls6,(~compls6 & do) | (~do & compls6),compls6 ^ co,(~bo | ~compls6) & ((((~bo | ~compls6) & ~compls6) & bo) | compls6),(~ao | (ao & ~compls6)) & ((ao & ~compls6) | compls6)};
endmodule

