
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
       aeqb = (!bi & ((!ai | bi) & (ai | !ai))) | ((((!ai | bi) & (ai | !ai)) & bi) & ((ai & (!ai | bi)) & (ai | !ai)));
  wire 
       ceqd = ((ci & ((di & (!ci | di)) & (ci | !ci))) | !di) & (!ci | (ci & ((di & (!ci | di)) & (ci | !ci))));
  wire 
       l22 = ((!ceqd | ((di & (!ai & !bi)) & ((ci & (ci | !ci)) & (!ci | di)))) | (((!di & (!ci | ((ci & !ai) & di))) & ((!di & ((((!ai | bi) & (ai | !ai)) & bi) & ((ai & (!ai | bi)) & (ai | !ai)))) | ((ci & !ai) & di))) & (bi & (ai & !ci)))) & ((!aeqb | ((di & (!ai & !bi)) & ((ci & (ci | !ci)) & (!ci | di)))) | ((((di & (!ai & !bi)) & ((ci & (ci | !ci)) & (!ci | di))) | !di) & (bi & (ai & !ci))));
  wire 
       l40 = (ai & (ci & ((di & (!ci | di)) & (ci | !ci)))) & bi;
  wire 
       l04 = ((!di & !ci) & ((!ai & !bi) | ai)) & (!ai & !bi);
  wire 
       l13 = ((!ci | (!ceqd & (!ai & !bi))) & (!aeqb | (!ceqd & (!ai & !bi)))) & (!di | (!ceqd & (!ai & !bi)));
  wire 
       l31 = (((di | bi) & (((!aeqb & (l04 | ((ci | ((di & !bi) & (ei & !ci))) | (l04 | ci)))) & ci) | bi)) & (!aeqb | (ai & !ceqd))) & ((ai & !ceqd) | (ci & ((di & (!ci | di)) & (ci | !ci))));
  wire  ao = ai;
  wire  bo = (!l40 | l04) & (l04 | bi);
  wire 
       co = (((!ai | (l04 | ci)) & !bi) & ((ei & !ci) & di)) | (l04 | ci);
  wire 
       do = !(((((!ai | bi) & (ai | !ai)) & bi) & ((ai & (!ai | bi)) & (ai | !ai))) & ci) & di;
  wire 
       eo = !((((di & !bi) & ei) & !ai) & !ci) & (ei | (l13 & !((((di & !bi) & ei) & !ai) & !ci)));
  wire 
       io = (((ei & !((((!ai | bi) & (ai | !ai)) & bi) & ((ai & (!ai | bi)) & (ai | !ai)))) & (!di & !ci)) | (((l40 & ei) | !ei) & ((l40 & ei) | l22))) | ((!ai & !bi) & (((!di & ei) & (ci & (!ai & !bi))) | ((ci & ((di & (!ci | di)) & (ci | !ci))) & ((((!l22 | (ki & ((bi | !di) | (ai | !ci)))) | ki) & ei) & ki))));
  wire 
       pd1s6 = ((((((di & !bi) & ei) & !ai) & !ci) | (!ei & !l22)) & (((di & !bi) & (ei & !ci)) | !l31)) & (!l31 | !ai);
  wire 
       nd1s6 = (((!l22 & ei) & (!l13 | ki)) | ki) | ((ai & (ci | (((!l22 & ei) & (!l13 | ki)) | ki))) & ((!ei & (bi & !di)) | (((!l22 & ei) & (!l13 | ki)) | ki)));
  wire  ndos6 = pd1s6;
  wire  pdos6 = ((!l22 & ei) & (!l13 | ki)) | ki;
  wire 
       alt7 = (((dispin ? ((!ei & l31) & di) : (l13 & (!di & ei))) & gi) & (fi & hi)) | ((fi & ki) & ((hi & ((!fi & (gi | !gi)) | gi)) & gi));
  wire  fo = fi & !alt7;
  wire  go = (!hi | gi) & ((!fi & (gi | !gi)) | gi);
  wire  ho = hi;
  wire 
       jo = (alt7 | !hi) & (((~fi | (~gi & fi)) & (fi | (((~fi | (~gi & fi)) & ~fi) & gi))) | alt7);
  wire  nd1s4 = fi & gi;
  wire 
       pd1s4 = ((!gi | (ki & (!fi & gi))) & ((ki & (!fi & gi)) | (fi & ki))) | (!fi & !gi);
  wire  ndos4 = !fi & !gi;
  wire 
       pdos4 = (((fi & ki) & ((hi & ((!fi & (gi | !gi)) | gi)) & gi)) | (fi & hi)) & gi;
  wire 
       illegalk = (((((!ei | (!fi | !gi)) | (!l31 | !hi)) & ((bi | !di) | (ai | !ci))) & ((ei | (ki & ((bi | !di) | (ai | !ci)))) | ki)) & ki) | ((ki & ((!ei | (!fi | !gi)) | (!l31 | !hi))) & !ei);
  wire 
       compls6 = (((pd1s6 & !dispin) | nd1s6) & (dispin | pd1s6)) & (dispin | !dispin);
  wire 
       disp6 = ((~dispin & pdos6) | (dispin & ~(ndos6 | pdos6))) | (~dispin & ndos6);
  wire 
       compls4 = (pd1s4 | (nd1s4 & disp6)) & ((nd1s4 & disp6) | !disp6);

  assign dispout = (~disp6 | (~(ndos4 | pdos4) & disp6)) & (disp6 | (~disp6 & (ndos4 | pdos4)));
  assign dataout = {compls4 ^ jo,(((~compls4 | (compls4 & ~ho)) & ho) & ~compls4) | ((~compls4 | (compls4 & ~ho)) & compls4),go ^ compls4,fo ^ compls4,(~io & compls6) | (~compls6 & io),compls6 ^ eo,compls6 ^ do,(co & ~compls6) | ((~compls6 | ~co) & compls6),bo ^ compls6,compls6 ^ ao};
endmodule

