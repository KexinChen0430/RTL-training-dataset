
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
       aeqb = ((!bi & (bi | !ai)) & (!ai | ai)) | (ai & bi);
  wire  ceqd = (di & ci) | (!di & !ci);
  wire 
       l22 = ((ai & bi) & (!di & !ci)) | (((((ai & bi) & (!di & !ci)) | (!aeqb | (((((ai & (!ci & bi)) | !bi) & (!di | !bi)) & (di & ci)) & !ai))) & !ceqd) | (((((ci & !ai) & (di & ((ci | !ci) & (!ci | di)))) | !ci) & (((ci & !ai) & (di & ((ci | !ci) & (!ci | di)))) | ((ai & bi) & !di))) & !bi));
  wire  l40 = (ai & ci) & (di & bi);
  wire  l04 = (!ai & !ci) & (!di & !bi);
  wire 
       l13 = (((!bi | (!di & !ci)) & (!bi | !aeqb)) & (!di | (!ai & !ceqd))) & ((!aeqb & !ci) | (!ai & !ceqd));
  wire 
       l31 = ((di & !aeqb) & ((ci & (ci | !ci)) & (!ci | di))) | ((bi & !ceqd) & (ai & ((!ai | ai) & (bi | !ai))));
  wire  ao = ai;
  wire  bo = (l04 | bi) & (l04 | !l40);
  wire 
       co = (ci | (l04 | ((ei & (di & !bi)) & !ci))) & ((l04 | ci) | !ai);
  wire 
       do = di & !((ai & ci) & (bi & ((!ai | ai) & (bi | !ai))));
  wire 
       eo = !((di & !bi) & (!ai & (ei & !ci))) & (l13 | (!((di & !bi) & (!ai & (ei & !ci))) & ei));
  wire 
       io = ((((ki & ((!bi & ci) & (di & ei))) & !ai) | ((!di & !(ai & bi)) & (ei & !ci))) | (l22 & (((!di & !(ai & bi)) & (ei & !ci)) | !ei))) | ((l40 & ei) | (((!ai & !di) & ei) & (!bi & ci)));
  wire 
       pd1s6 = ((di & !bi) & (!ai & (ei & !ci))) | (!l31 & (!l22 & !ei));
  wire 
       nd1s6 = ((((ai & bi) & !di) & (ci & !ei)) | ki) | ((!l13 | ki) & (!l22 & ei));
  wire  ndos6 = pd1s6;
  wire  pdos6 = (ki | (!l13 & ei)) & (!l22 | ki);
  wire 
       alt7 = ((hi & gi) & fi) & (ki | (dispin ? ((!ei & l31) & di) : ((l13 & !di) & ei)));
  wire  fo = !alt7 & fi;
  wire  go = ((!hi | gi) & (gi | !gi)) & (!fi | gi);
  wire  ho = hi;
  wire 
       jo = (alt7 | !hi) & ((alt7 | (~fi & gi)) | (fi & ~gi));
  wire  nd1s4 = fi & gi;
  wire 
       pd1s4 = (((!fi & !gi) | ((fi & ki) & !gi)) | ((!fi & (!l22 | ki)) & ki)) & (((gi | !gi) & (gi | fi)) | (!fi & !gi));
  wire  ndos4 = !fi & !gi;
  wire  pdos4 = (hi & gi) & fi;
  wire 
       illegalk = ((((!ei | !l31) | !fi) | !hi) | !gi) & ((ki & !di) | (((((bi | !ci) | ai) & (!l13 | ki)) & ki) | ((!ei & (!l13 | ki)) & ki)));
  wire 
       compls6 = ((pd1s6 | (dispin & nd1s6)) & !dispin) | (dispin & nd1s6);
  wire 
       disp6 = (~dispin & ndos6) | ((dispin & ~(pdos6 | ndos6)) | (pdos6 & ~dispin));
  wire 
       compls4 = (((nd1s4 | pd1s4) & (!disp6 | nd1s4)) & (pd1s4 | disp6)) & (!disp6 | disp6);

  assign dispout = ((((~disp6 | ~(ndos4 | pdos4)) & disp6) & ~(ndos4 | pdos4)) | (ndos4 | pdos4)) & (~disp6 | ~(ndos4 | pdos4));
  assign dataout = {jo ^ compls4,((~compls4 | ~ho) & compls4) | (((~compls4 | ~ho) & ~compls4) & ho),(compls4 | (go & ~compls4)) & (~compls4 | ~go),(~compls4 & fo) | (~fo & compls4),compls6 ^ io,(~eo | ~compls6) & ((((~eo | ~compls6) & eo) & ~compls6) | compls6),compls6 ^ do,(compls6 | (co & ~compls6)) & (~compls6 | ~co),compls6 ^ bo,(~ao & compls6) | (ao & ~compls6)};
endmodule

