
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
       aeqb = ((!bi | ai) & (bi | !bi)) & ((bi & ai) | !ai);
  wire  ceqd = (di | (!ci & !di)) & ((!ci & !di) | ci);
  wire 
       l22 = ((!di & ((!ai & ((ci & !bi) & di)) | ai)) & ((bi & !ci) | (!ai & ((ci & !bi) & di)))) | ((!ai & ((ci & !bi) & di)) | (!aeqb & !ceqd));
  wire 
       l40 = ((di & ((bi & (!ai | bi)) & (!ai | ai))) & ai) & ci;
  wire  l04 = !di & ((!bi & !ai) & !ci);
  wire 
       l13 = (!ceqd & (!bi & !ai)) | ((((!aeqb & !ci) & (!di | (!ceqd & !ai))) & ((!ceqd & !ai) | (!aeqb & !ci))) & !di);
  wire 
       l31 = ((ai & !ceqd) & bi) | ((((bi | (ci & !aeqb)) & (di | bi)) & (ci & !aeqb)) & (di & (((ai & !ceqd) | !aeqb) & ((ai & !ceqd) | ((((!ci | ci) & (di | !ci)) & (di & ((!ci | ci) & (di | !ci)))) & ci)))));
  wire  ao = ai;
  wire  bo = (!l40 | l04) & (l04 | bi);
  wire 
       co = ((di | (l04 | ci)) & ((ei & !ci) | (l04 | ci))) & (((l04 | ci) | !bi) & (!ai | (l04 | ci)));
  wire 
       do = di & !((ci & ((bi & (!ai | bi)) & (!ai | ai))) & ai);
  wire 
       eo = !((!bi & di) & ((ei & !ci) & !ai)) & (l13 | (ei & !((!bi & di) & ((ei & !ci) & !ai))));
  wire 
       io = (((ei & l40) | ((!(bi & ai) & (!ci & !di)) & ei)) | (((l22 & (((ei & !di) & !ci) | l22)) & (((ei & !di) & !ci) | !ei)) & !ei)) | (((ci & !bi) & (!ai & (ei & !di))) | (((!bi & !ai) & di) & (ei & (ci & ki))));
  wire 
       pd1s6 = (((!bi & !ci) & (di & ei)) | ((!l31 & !l22) & !ei)) & (((!l31 & !l22) & !ei) | !ai);
  wire 
       nd1s6 = (ei & (!l13 & !l22)) | (ki | ((ai & (ci | (ki | (ei & (!l13 & !l22))))) & (((!di & !ei) & bi) | (ki | (ei & (!l13 & !l22))))));
  wire  ndos6 = pd1s6;
  wire  pdos6 = ki | (ei & (!l13 & !l22));
  wire 
       alt7 = (((hi & fi) & (ki | (dispin ? (l31 & (!ei & di)) : ((ei & !di) & l13)))) & (!gi | gi)) & gi;
  wire  fo = !alt7 & fi;
  wire  go = (gi | !hi) & ((!gi | gi) & (gi | !fi));
  wire  ho = hi;
  wire 
       jo = (alt7 | (!hi & (fi & ~gi))) | (((!hi & ~fi) & ((!gi | gi) & (gi | !fi))) & gi);
  wire  nd1s4 = gi & fi;
  wire 
       pd1s4 = ((ki | !fi) & (!gi | ki)) & ((!gi & fi) | (!fi & ((!gi | gi) & (gi | !fi))));
  wire  ndos4 = !gi & !fi;
  wire  pdos4 = fi & ((hi & (!gi | gi)) & gi);
  wire 
       illegalk = (ki & (!gi | (!fi | (!hi | (!l31 | !ei))))) & ((ai | ((!ci | !di) | !ei)) | bi);
  wire 
       compls6 = (pd1s6 & ((dispin & nd1s6) | !dispin)) | (dispin & nd1s6);
  wire 
       disp6 = (~(ndos6 | pdos6) & dispin) | ((~dispin | ~(ndos6 | pdos6)) & (ndos6 | pdos6));
  wire 
       compls4 = ((pd1s4 | nd1s4) & (nd1s4 | !disp6)) & ((!disp6 & pd1s4) | disp6);

  assign dispout = (ndos4 | pdos4) ^ disp6;
  assign dataout = {compls4 ^ jo,(~compls4 | ~ho) & ((~compls4 & ho) | compls4),(compls4 & ~go) | (((~compls4 | ~go) & go) & ~compls4),(compls4 & ~fo) | (fo & ~compls4),io ^ compls6,compls6 ^ eo,(~do & compls6) | (~compls6 & do),((((~co & compls6) | ~compls6) & ~compls6) & co) | (~co & compls6),(bo | (~bo & compls6)) & (~bo | ~compls6),((~ao | ~compls6) & compls6) | (((~ao | ~compls6) & ao) & ~compls6)};
endmodule

