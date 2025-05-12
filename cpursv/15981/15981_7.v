
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
  wire  aeqb = ((bi | (!ai & !bi)) & ai) | (!ai & !bi);
  wire  ceqd = (!di & !ci) | (ci & di);
  wire 
       l22 = ((((!bi | (!di & !ci)) & (bi | !bi)) & (ai | !bi)) & ((ci & di) & !ai)) | ((!aeqb & !ceqd) | (((((!bi | (!di & !ci)) & (bi | !bi)) & (ai | !bi)) & (bi & (!di & !ci))) & ai));
  wire  l40 = (ci & (di & bi)) & ai;
  wire  l04 = (!ai & !ci) & (!bi & !di);
  wire 
       l13 = (!di | ((!ai & !bi) & !ceqd)) & ((!ci & !aeqb) | ((!ai & !bi) & !ceqd));
  wire 
       l31 = (((!ceqd | ((di & !aeqb) & (((!ci | di) & (!ci | ci)) & ci))) & (((di & !aeqb) & (((!ci | di) & (!ci | ci)) & ci)) | ai)) & (bi | di)) & ((!aeqb & ci) | bi);
  wire  ao = ai;
  wire  bo = (l04 | !l40) & (l04 | bi);
  wire 
       co = (l04 | ((!ai & ((!ci & (di & ei)) | (ci | l04))) & (ci | (!bi | l04)))) | ci;
  wire  do = !((bi & ci) & (((ai & bi) | !ai) & ai)) & di;
  wire 
       eo = !(((!bi & di) & !ai) & (!ci & ei)) & (l13 | ei);
  wire 
       io = (((di & !ai) & (((!bi & ((ci | (!bi | l04)) & ((!ci & (di & ei)) | (ci | l04)))) & ci) & (ki & ei))) | ((((!di & ((!ci & ei) & !(ai & bi))) | l22) & !ei) | ((!di & ((!ci & ei) & !(ai & bi))) | (ci & ((!ai & !di) & (!bi & ei)))))) | (ei & l40);
  wire 
       pd1s6 = ((!ei | (((!bi & di) & !ai) & (!ci & ei))) & ((!ai | !l31) & (((!ci & (di & ei)) & !bi) | !l31))) & ((((!bi & di) & !ai) & (!ci & ei)) | !l22);
  wire 
       nd1s6 = ((((((ei & (!l13 & !l22)) | (ai | ki)) & (ki | !l22)) & ((((((!gi & fi) & (ki | !l22)) & ki) | ei) | ki) & (!l13 | ki))) | (ai & bi)) & (((((ei & (!l13 & !l22)) | (ai | ki)) & (ki | !l22)) & ((((((!gi & fi) & (ki | !l22)) & ki) | ei) | ki) & (!l13 | ki))) | (!ei & !di))) & (((((ei & (!l13 & !l22)) | (ai | ki)) & (ki | !l22)) & ((((((!gi & fi) & (ki | !l22)) & ki) | ei) | ki) & (!l13 | ki))) | ci);
  wire  ndos6 = pd1s6;
  wire 
       pdos6 = (((ei & (!l13 & !l22)) | (ai | ki)) & (ki | !l22)) & ((((((!gi & fi) & (ki | !l22)) & ki) | ei) | ki) & (!l13 | ki));
  wire 
       alt7 = ((dispin ? (di & (l31 & !ei)) : (l13 & (!di & ei))) | ((fi & ki) & (gi & hi))) & (gi & (fi & hi));
  wire  fo = !alt7 & fi;
  wire  go = (!hi | gi) & ((gi | !gi) & (gi | !fi));
  wire  ho = hi;
  wire 
       jo = (((~(gi & !hi) & fi) & !hi) | alt7) | ((gi & !hi) & ~(!hi & fi));
  wire  nd1s4 = gi & fi;
  wire 
       pd1s4 = (((((!gi | !fi) & (fi | !fi)) & !gi) & ((!fi & (!fi | ki)) & (!gi | ki))) | ki) & (((gi | (!gi & fi)) & !fi) | ((fi | ((((!gi | !fi) & (fi | !fi)) & !gi) & ((!fi & (!fi | ki)) & (!gi | ki)))) & !gi));
  wire 
       ndos4 = (((!gi | !fi) & (fi | !fi)) & !gi) & ((!fi & (!fi | ki)) & (!gi | ki));
  wire  pdos4 = gi & (fi & hi);
  wire 
       illegalk = (((((!l31 | !ei) | !hi) | (!gi | !fi)) & (((((ci & !di) & !ei) & bi) | ki) | ((!l13 | ki) & (ei & !l22)))) & ki) & (!ei | ((!ci | ai) | (bi | !di)));
  wire 
       compls6 = (!dispin & pd1s6) | ((dispin & (!dispin | nd1s6)) & (nd1s6 | pd1s6));
  wire  disp6 = dispin ^ (pdos6 | ndos6);
  wire 
       compls4 = (!disp6 & ((pd1s4 & (pd1s4 | nd1s4)) & (nd1s4 | !disp6))) | ((nd1s4 & (disp6 | !disp6)) & (disp6 | pd1s4));

  assign dispout = (pdos4 | ndos4) ^ disp6;
  assign dataout = {(jo | (~jo & compls4)) & ((jo & ~compls4) | ~jo),(ho & ~compls4) | (~ho & compls4),go ^ compls4,(compls4 & ~fo) | (~compls4 & fo),(io & ~compls6) | (compls6 & ~io),(((~compls6 | (compls6 & ~eo)) & eo) & ~compls6) | (compls6 & ~eo),compls6 ^ do,co ^ compls6,(~bo | ~compls6) & ((bo & ~compls6) | compls6),(compls6 | (ao & ~compls6)) & (~ao | ~compls6)};
endmodule

