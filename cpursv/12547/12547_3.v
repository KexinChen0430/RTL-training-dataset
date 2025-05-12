
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
  wire  aeqb = ((!bi & !ai) | bi) & ((!bi & !ai) | ai);
  wire 
       ceqd = ((di & (((ei & !bi) & (!ci & di)) | (l04 | ci))) & ci) | (!ci & ((!di | ci) & (!di | di)));
  wire 
       l22 = ((!ceqd | (((ci & (!ai & di)) & !bi) | !di)) & (!ceqd | ((!ci & (bi & ai)) | ((ci & (!ai & di)) & !bi)))) & ((!di & (!ci & (bi & ai))) | (!aeqb | (!bi & (((ci & (!ai & di)) | !di) & ((ci & (!ai & di)) | (!ci & (bi & ai)))))));
  wire  l40 = ci & (di & (bi & ai));
  wire  l04 = (!bi & !ci) & (!ai & !di);
  wire 
       l13 = ((!bi & ((!ai & !ceqd) | (!di & !aeqb))) & ((!ai & !ceqd) | !ci)) | ((!di & !ci) & !aeqb);
  wire 
       l31 = ((bi | ((di & (((ei & !bi) & (!ci & di)) | (l04 | ci))) & ci)) & (bi | !aeqb)) & (((ai & !ceqd) | (di & !aeqb)) & ((ai & !ceqd) | ci));
  wire  ao = ai;
  wire  bo = (!l40 & bi) | l04;
  wire 
       co = (((ei & !bi) & (!ci & di)) | (l04 | ci)) & ((!ai | l04) | ci);
  wire 
       do = !(((ai & (((ei & !bi) & (!ci & di)) | (l04 | ci))) & ci) & ((bi & (!ai | bi)) & (!ai | ai))) & di;
  wire 
       eo = !((!bi & di) & ((!ci & ei) & !ai)) & (l13 | (ei & !((!bi & di) & ((!ci & ei) & !ai))));
  wire 
       io = (((((((l22 & !ei) | (ei & l40)) | ((!ai & ((di & (!bi & ci)) & (ki & ei))) | ((!bi & ci) & (ei & !di)))) | ((!(bi & ai) & (l22 | (!ci & (ei & !di)))) & ((!ci & (ei & !di)) | !ei))) & ((!bi | (ei & l40)) | ((!(bi & ai) | (l22 & !ei)) & ((((l22 & !ei) | (ei & !di)) & ((l22 & !ei) | !ci)) | (ei & l40))))) & (((!ai | (ei & l40)) | ((!(bi & ai) | (l22 & !ei)) & ((((l22 & !ei) | (ei & !di)) & ((l22 & !ei) | !ci)) | (ei & l40)))) & ((ei & l40) | ((((ki & ei) & di) & ci) | ((!(bi & ai) | (l22 & !ei)) & (((l22 & !ei) | (ei & !di)) & ((l22 & !ei) | !ci))))))) | (ci & (ei & !di))) & (((((((l22 & !ei) | (ei & l40)) | ((!ai & ((di & (!bi & ci)) & (ki & ei))) | ((!bi & ci) & (ei & !di)))) | ((!(bi & ai) & (l22 | (!ci & (ei & !di)))) & ((!ci & (ei & !di)) | !ei))) & ((!bi | (ei & l40)) | ((!(bi & ai) | (l22 & !ei)) & ((((l22 & !ei) | (ei & !di)) & ((l22 & !ei) | !ci)) | (ei & l40))))) & (((!ai | (ei & l40)) | ((!(bi & ai) | (l22 & !ei)) & ((((l22 & !ei) | (ei & !di)) & ((l22 & !ei) | !ci)) | (ei & l40)))) & ((ei & l40) | ((((ki & ei) & di) & ci) | ((!(bi & ai) | (l22 & !ei)) & (((l22 & !ei) | (ei & !di)) & ((l22 & !ei) | !ci))))))) | (!bi & !ai));
  wire 
       pd1s6 = ((((ei & !bi) & (!ci & di)) | (!l22 & !ei)) & (!ai | (!l22 & !ei))) & ((!l31 | (di & ((!ci & ei) & !ai))) & (!bi | !l31));
  wire 
       nd1s6 = ((!l13 & (ki | !l22)) & (ki | ei)) | (ki | ((ai & ((((ki | (!l13 | ((fi & ki) & !gi))) & (ki | !l22)) & (ki | ei)) | bi)) & ((ci | (((ki | (!l13 | ((fi & ki) & !gi))) & (ki | !l22)) & (ki | ei))) & ((!di & !ei) | (((ki | (!l13 | ((fi & ki) & !gi))) & (ki | !l22)) & (ki | ei))))));
  wire  ndos6 = pd1s6;
  wire 
       pdos6 = ((ki | (!l13 | ((fi & ki) & !gi))) & (ki | !l22)) & (ki | ei);
  wire 
       alt7 = (((((dispin ? ((!ei & di) & l31) : (!di & (ei & l13))) & fi) & ((hi & (gi | !gi)) & gi)) | ki) & hi) & ((fi & (gi | ((gi | !fi) & !gi))) & gi);
  wire  fo = fi & !alt7;
  wire  go = (gi | !hi) & (gi | ((gi | !fi) & !gi));
  wire  ho = hi;
  wire 
       jo = (~(fi & !hi) & (!hi & gi)) | (alt7 | (~(!hi & gi) & (fi & !hi)));
  wire  nd1s4 = (fi & (gi | ((gi | !fi) & !gi))) & gi;
  wire 
       pd1s4 = (((!fi | ((fi & ki) & !gi)) & (((!fi & gi) & ki) | (((!gi & (!fi | !gi)) & (!fi | fi)) & fi))) & ki) | (((!gi & (!fi | !gi)) & (!fi | fi)) & !fi);
  wire  ndos4 = ((!gi & (!fi | !gi)) & (!fi | fi)) & !fi;
  wire  pdos4 = ((hi & (gi | !gi)) & gi) & fi;
  wire 
       illegalk = ((((!ei | (!fi | !gi)) | (!hi | !l31)) & (ki | !l22)) & ki) & ((((!di | bi) | !ci) | !ei) | ai);
  wire 
       compls6 = ((pd1s6 | nd1s6) & (nd1s6 | !dispin)) & (dispin | (pd1s6 & ((!dispin & (pd1s6 | nd1s6)) & (nd1s6 | !dispin))));
  wire 
       disp6 = (~(pdos6 | ndos6) | ~dispin) & (dispin | ((pdos6 | ndos6) & ~dispin));
  wire 
       compls4 = ((nd1s4 & disp6) | !disp6) & ((nd1s4 & disp6) | pd1s4);

  assign dispout = (ndos4 | pdos4) ^ disp6;
  assign dataout = {(~jo & compls4) | (~compls4 & jo),((~ho & compls4) | ~compls4) & (compls4 | (ho & ~compls4)),(go & ~compls4) | (((compls4 & ~go) | ~compls4) & compls4),(((~fo | ~compls4) & fo) & ~compls4) | (~fo & compls4),((compls6 & ~io) | io) & (~compls6 | ~io),(eo & ~compls6) | (compls6 & (~compls6 | ~eo)),do ^ compls6,(~co | (co & ~compls6)) & (co | (compls6 & ~co)),(~compls6 & bo) | (compls6 & ~bo),compls6 ^ ao};
endmodule

