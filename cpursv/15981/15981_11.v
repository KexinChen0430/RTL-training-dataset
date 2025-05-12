
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
  wire  aeqb = (!ai & !bi) | (bi & ai);
  wire  ceqd = (!ci & !di) | (ci & di);
  wire 
       l22 = ((!aeqb & !ceqd) | (((!bi | (!ci & !di)) & ((bi | !bi) & (!bi | ai))) & (di & (!ai & ci)))) | ((bi & ai) & (!ci & !di));
  wire  l40 = ((bi & ai) & ((!ci | (ci & di)) & di)) & ci;
  wire  l04 = (!ai & !di) & (!ci & !bi);
  wire 
       l13 = ((((!ai & !ceqd) | (!ci & !aeqb)) & (!di | (!ai & !ceqd))) & (!bi | !di)) & (!bi | (!ci & !aeqb));
  wire 
       l31 = ((bi | (!aeqb & ci)) & (bi | di)) & (((ci & di) | (ai & !ceqd)) & ((ai & !ceqd) | !aeqb));
  wire  ao = ai;
  wire  bo = (!l40 | l04) & (l04 | bi);
  wire 
       co = (ci | l04) | (!ai & (((!ci & !bi) & (di & ei)) | (ci | l04)));
  wire  do = di & !((ci & ai) & bi);
  wire 
       eo = ((ei & !(!ai & ((!ci & !bi) & (di & ei)))) | l13) & !(!ai & ((!ci & !bi) & (di & ei)));
  wire 
       io = (((!ei & l22) | (ei | ((((!(bi & ai) | l22) & (!(bi & ai) | !ei)) & (!ci & !di)) & ei))) & (((!ei | ((ei & !(bi & ai)) & (!ci & !di))) & l22) | (l40 | ((ei & !(bi & ai)) & (!ci & !di))))) | (!ai & ((!ai & ((ci & (!bi & ei)) & !di)) | (((ei & (di & !bi)) & ci) & ki)));
  wire 
       pd1s6 = ((!l31 & ((!ai & !bi) | (!l22 & !ei))) & ((di & (!ci & ei)) | (!l22 & !ei))) | (!ai & ((!ci & !bi) & (di & ei)));
  wire 
       nd1s6 = ((ki | (ei | (ki & ((ki & (!ci | (ai | bi))) | !di)))) & ((!l22 | ki) & ((!l13 | (ki & ((ki & (!ci | (ai | bi))) | !di))) | ki))) | ((ai & !di) & (!ei & (ci & bi)));
  wire  ndos6 = pd1s6;
  wire 
       pdos6 = (ki | (ei | (ki & ((ki & (!ci | (ai | bi))) | !di)))) & ((!l22 | ki) & ((!l13 | (ki & ((ki & (!ci | (ai | bi))) | !di))) | ki));
  wire 
       alt7 = gi & (fi & ((((dispin ? ((di & l31) & !ei) : (ei & (l13 & !di))) | (ki & ((ki & (!ci | (ai | bi))) | !di))) | ki) & hi));
  wire  fo = fi & !alt7;
  wire  go = ((gi | !hi) & (gi | !fi)) & (!gi | gi);
  wire  ho = hi;
  wire 
       jo = ((!hi | alt7) & (~fi | (alt7 | ~gi))) & (fi | (((~fi & (!gi | gi)) & gi) | alt7));
  wire  nd1s4 = fi & gi;
  wire 
       pd1s4 = ((((!gi | gi) & !fi) & gi) & (ki | (!fi & ((!gi & (ki | !gi)) & (ki | !fi))))) | (((!fi & ((!gi & (ki | !gi)) & (ki | !fi))) | fi) & ((!fi & ((!gi & (ki | !gi)) & (ki | !fi))) | ((!gi & (ki | (ei | (ki & ((ki & (!ci | (ai | bi))) | !di))))) & ki)));
  wire  ndos4 = !fi & ((!gi & (ki | !gi)) & (ki | !fi));
  wire  pdos4 = gi & (fi & hi);
  wire 
       illegalk = (ki & ((ki & ((ki & (!ci | (ai | bi))) | !di)) | !ei)) & ((!l31 | ((!ei | !hi) | !fi)) | !gi);
  wire 
       compls6 = ((nd1s6 & dispin) | pd1s6) & (!dispin | (nd1s6 & dispin));
  wire 
       disp6 = (pdos6 & ~dispin) | ((~dispin & ndos6) | (~(pdos6 | ndos6) & dispin));
  wire 
       compls4 = ((((disp6 | !disp6) & (pd1s4 | disp6)) & !disp6) & pd1s4) | (((!disp6 | nd1s4) & (pd1s4 | nd1s4)) & disp6);

  assign dispout = (~disp6 | ~(ndos4 | pdos4)) & ((ndos4 | pdos4) | (disp6 & ~(ndos4 | pdos4)));
  assign dataout = {(jo | (~jo & compls4)) & (~compls4 | ~jo),compls4 ^ ho,compls4 ^ go,((compls4 & ~fo) | ~compls4) & ((compls4 & ~fo) | fo),compls6 ^ io,compls6 ^ eo,do ^ compls6,co ^ compls6,(~bo & compls6) | (bo & ~compls6),ao ^ compls6};
endmodule

