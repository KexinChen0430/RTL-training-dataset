
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
  wire  aeqb = (!ai & !bi) | ((bi | (!ai & !bi)) & ai);
  wire 
       ceqd = ((ci | !di) & (di | !di)) & ((!ci | di) & (!ci | ci));
  wire 
       l22 = (((((!ai & !bi) & (ci & di)) | !di) & (bi & !ci)) & ai) | (((!ai & !bi) & (ci & di)) | (!ceqd & ((((((!ai & !bi) & (ci & di)) | (((bi & (ai | !ai)) & (!ai | bi)) & ai)) & (!ci | ((!ai & !bi) & (ci & di)))) | !aeqb) & (((!ai & !bi) & (ci & di)) | (!aeqb | !di)))));
  wire 
       l40 = (((bi & (ai | !ai)) & (!ai | bi)) & ai) & (ci & di);
  wire  l04 = (!ai & !bi) & (!ci & !di);
  wire 
       l13 = ((!aeqb & ((!ci & !di) | ci)) & (!ci & !di)) | ((!ceqd & (bi | (!ai & !bi))) & (!ai & !bi));
  wire 
       l31 = (((!aeqb & ((l04 | (ci | !bi)) & ((!ci & (ei & di)) | (l04 | ci)))) & ci) & (di | ((!ceqd & ai) & bi))) | ((!ceqd & ai) & bi);
  wire  ao = ai;
  wire  bo = l04 | ((bi | l04) & !l40);
  wire 
       co = (((l04 | ci) | !ai) & ((!ci & !bi) | (l04 | ci))) & ((ei & di) | (l04 | ci));
  wire 
       do = di & !((bi & ci) & (ai & ((!ai | bi) & (ai | !ai))));
  wire 
       eo = ((!(((!bi & (ei & di)) & !ai) & !ci) & l13) | ei) & !(((!bi & (ei & di)) & !ai) & !ci);
  wire 
       io = ((((!di & ei) | (((((!(((bi & (ai | !ai)) & (!ai | bi)) & ai) & (!di & ei)) & !ci) | (ei & l40)) | (((!ai & !bi) & ((ci & di) & ki)) & ei)) | (!ei & (l22 | ((!(((bi & (ai | !ai)) & (!ai | bi)) & ai) & (!di & ei)) & !ci))))) & ((!bi & ci) | (((((!(((bi & (ai | !ai)) & (!ai | bi)) & ai) & (!di & ei)) & !ci) | (ei & l40)) | (((!ai & !bi) & ((ci & di) & ki)) & ei)) | (!ei & (l22 | ((!(((bi & (ai | !ai)) & (!ai | bi)) & ai) & (!di & ei)) & !ci)))))) & (((!ei & l22) | ((ei & l40) | ((!di & ei) & !ci))) | !ai)) & ((((!(((bi & (ai | !ai)) & (!ai | bi)) & ai) | !ei) & (l22 | !(((bi & (ai | !ai)) & (!ai | bi)) & ai))) | !ai) | (ei & l40));
  wire 
       pd1s6 = ((!l22 | (((!bi & (ei & di)) & !ai) & !ci)) & ((!l31 | (!ai & (!ci & (ei & di)))) & (!l31 | !bi))) & (!ei | (((!bi & (ei & di)) & !ai) & !ci));
  wire 
       nd1s6 = ki | ((((ki | !l13) & ei) & !l22) | ((ai & (((((ki | !l13) & (!l22 | ki)) & (ki | ei)) | ci) & ((((ki | !l13) & (!l22 | ki)) & (ki | ei)) | (!ei & !di)))) & ((ki | bi) | (((ei & !l22) | ki) & !l13))));
  wire  ndos6 = pd1s6;
  wire  pdos6 = ((ki | !l13) & (!l22 | ki)) & (ki | ei);
  wire 
       alt7 = (((ki | (dispin ? (l31 & (di & !ei)) : ((!di & ei) & l13))) & (!hi | gi)) & gi) & (((((ki & (gi | !gi)) & gi) & fi) & hi) | (fi & hi));
  wire  fo = !alt7 & fi;
  wire  go = ((!hi & !fi) | gi) & (gi | !gi);
  wire  ho = hi;
  wire 
       jo = (alt7 | ((fi & ~gi) & !hi)) | (((~fi & (gi | !gi)) & gi) & !hi);
  wire  nd1s4 = gi & fi;
  wire 
       pd1s4 = ((!gi & !fi) | ki) & (((!fi & (!fi | gi)) & gi) | (!gi & ((!gi & !fi) | fi)));
  wire  ndos4 = !gi & !fi;
  wire  pdos4 = gi & (fi & hi);
  wire 
       illegalk = (((!fi | !gi) & (!ei | ((!di | ((ai | bi) | !ci)) & ki))) & ki) | ((ki & (!l31 & (((!ei | !di) | (!ci | ai)) | bi))) | ((((!di | ((ai | bi) | !ci)) | ((!ei & ((ei & !l22) | ki)) & ki)) & ki) & (!ei | !hi)));
  wire 
       compls6 = (dispin & nd1s6) | (pd1s6 & ((dispin & nd1s6) | !dispin));
  wire  disp6 = dispin ^ (ndos6 | pdos6);
  wire 
       compls4 = (((!disp6 | disp6) & (pd1s4 | disp6)) & (!disp6 | nd1s4)) & (nd1s4 | pd1s4);

  assign dispout = (~(pdos4 | ndos4) & disp6) | ((pdos4 & ~disp6) | (~disp6 & ndos4));
  assign dataout = {(jo & ~compls4) | (~jo & compls4),(~ho & compls4) | (ho & ~compls4),compls4 ^ go,(fo & ~compls4) | ((~fo | ~compls4) & compls4),(io | (compls6 & ~io)) & (~compls6 | ~io),(eo & ~compls6) | (compls6 & ~eo),(~do & compls6) | (do & ~compls6),(co & ~compls6) | (compls6 & ~co),bo ^ compls6,(~compls6 | (~ao & compls6)) & ((~ao & compls6) | ao)};
endmodule

