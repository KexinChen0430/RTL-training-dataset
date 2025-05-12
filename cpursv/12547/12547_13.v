
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
  wire  aeqb = (ai & ((!ai & !bi) | bi)) | (!ai & !bi);
  wire 
       ceqd = (ci & ((di & (ci | !ci)) & (di | !ci))) | (((ci | !ci) & (di | !ci)) & !di);
  wire 
       l22 = (((((!ci | !bi) & (((!di & ai) & ((bi & (ai | !ai)) & (bi | !ai))) | !bi)) & (!ai & ci)) & di) | ((!di & ((!ci & (!ai | (ai & ((bi & (ai | !ai)) & (bi | !ai))))) & (ai & ((bi & (ai | !ai)) & (bi | !ai))))) | !ceqd)) & ((!aeqb | (((ci & !bi) & (di & !ai)) | ((!ci & (!ai | (ai & ((bi & (ai | !ai)) & (bi | !ai))))) & (ai & ((bi & (ai | !ai)) & (bi | !ai)))))) & (((ci & !bi) & (di & !ai)) | (!di | !aeqb)));
  wire 
       l40 = (ai & ((bi & (ai | !ai)) & (bi | !ai))) & (ci & ((di & (ci | !ci)) & (di | !ci)));
  wire  l04 = (!ai & !di) & (!bi & !ci);
  wire 
       l13 = (((((!ceqd & !ai) | (!aeqb & !ci)) & ((!ceqd & !ai) | !di)) & !ci) & (!di & !aeqb)) | ((!ceqd & !ai) & !bi);
  wire 
       l31 = ((bi | !aeqb) & ((ci & ((di & (ci | !ci)) & (di | !ci))) | bi)) & ((ci | (ai & !ceqd)) & ((ai & !ceqd) | (!aeqb & di)));
  wire  ao = ai;
  wire  bo = l04 | (bi & !l40);
  wire 
       co = ((((l04 | ci) | !ai) & ((ei & di) | (l04 | ci))) & (!ci | (l04 | ci))) & ((!bi | l04) | ci);
  wire 
       do = di & !((ci & (!ai | (ai & ((bi & (ai | !ai)) & (bi | !ai))))) & (ai & ((bi & (ai | !ai)) & (bi | !ai))));
  wire 
       eo = (l13 | ei) & !((!ai & ei) & (!bi & (!ci & di)));
  wire 
       io = ((((((di & !bi) & ((ei & (ki | (!l13 | ((ki & fi) & !gi)))) & ki)) & (!ai & ci)) | (!di & ((!bi & ei) & ci))) | (ei & l40)) | (((((!ei | ((ei & ((!ci & !di) | di)) & (!ci & !di))) & (l22 | ((ei & ((!ci & !di) | di)) & (!ci & !di)))) | (ei & l40)) & (l22 | !(ai & ((bi & (ai | !ai)) & (bi | !ai))))) & (!ei | !(ai & ((bi & (ai | !ai)) & (bi | !ai)))))) & (((!(ai & ((bi & (ai | !ai)) & (bi | !ai))) & (l22 | ((ei & ((!ci & !di) | di)) & (!ci & !di)))) & (!ei | ((ei & ((!ci & !di) | di)) & (!ci & !di)))) | ((ei & l40) | (!ai | (!ei & (((!ei | ((ei & ((!ci & !di) | di)) & (!ci & !di))) & (l22 | ((ei & ((!ci & !di) | di)) & (!ci & !di)))) & l22)))));
  wire 
       pd1s6 = ((!l31 & ((!ai & !bi) | (!l22 & !ei))) & ((!l22 & !ei) | ((ei & di) & !ci))) | ((!ai & ei) & (!bi & (!ci & di)));
  wire 
       nd1s6 = ((!l13 & (ki | ei)) & (!l22 | ki)) | (ki | ((ai & ((bi & (ai | !ai)) & (bi | !ai))) & ((ci & !di) & !ei)));
  wire  ndos6 = pd1s6;
  wire  pdos6 = (!l22 | ki) & ((ei & !l13) | ki);
  wire 
       alt7 = (((((dispin ? (di & (l31 & !ei)) : (l13 & (ei & !di))) & ((fi & hi) & gi)) | (ki & ((((!di & (!l22 | ki)) & ki) | (bi | ai)) | !ci))) | ki) & fi) & ((((fi & hi) & gi) & ki) | (hi & gi));
  wire  fo = !alt7 & fi;
  wire  go = (!gi | gi) & ((gi | !hi) & (gi | !fi));
  wire  ho = hi;
  wire 
       jo = ((((~fi & (gi | !hi)) & gi) | alt7) | (fi & ~gi)) & (alt7 | !hi);
  wire  nd1s4 = (fi & (gi | !fi)) & gi;
  wire 
       pd1s4 = ((((!gi & (ki | !gi)) & (!fi | ki)) & !fi) | ((!fi & ki) & gi)) | ((ki & fi) & !gi);
  wire  ndos4 = ((!gi & (ki | !gi)) & (!fi | ki)) & !fi;
  wire  pdos4 = (fi & hi) & gi;
  wire 
       illegalk = (!fi | (!ei | ((!l31 | !gi) | !hi))) & (((!di & (!l22 | ki)) & ki) | ((ki & ((!ci | bi) | ai)) | ((!ei & (!l22 | ki)) & ki)));
  wire 
       compls6 = (dispin & nd1s6) | (!dispin & ((pd1s6 & (!dispin | nd1s6)) & (pd1s6 | nd1s6)));
  wire 
       disp6 = ((dispin & ~(pdos6 | ndos6)) | (~dispin & ndos6)) | (pdos6 & ~dispin);
  wire 
       compls4 = ((!disp6 | nd1s4) & (nd1s4 | pd1s4)) & ((disp6 | pd1s4) & (disp6 | !disp6));

  assign dispout = (~(ndos4 | pdos4) & disp6) | ((~disp6 & ndos4) | (~disp6 & pdos4));
  assign dataout = {((jo & ~compls4) | compls4) & ((~jo & compls4) | ~compls4),(((~ho & compls4) | ~compls4) & compls4) | ((((~ho & compls4) | ~compls4) & ho) & ~compls4),(go & ~compls4) | (compls4 & ~go),(fo | (~fo & compls4)) & (~compls4 | (~fo & compls4)),compls6 ^ io,(~compls6 & eo) | (~eo & compls6),do ^ compls6,(~co & compls6) | (co & ~compls6),((~bo & compls6) | bo) & ((bo & ~compls6) | ~bo),(ao & ~compls6) | (compls6 & ~ao)};
endmodule

