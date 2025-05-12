
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
       aeqb = ((!bi | bi) & (ai | !bi)) & ((!ai | bi) & (ai | !ai));
  wire  ceqd = (di | (!di & !ci)) & ((!di & !ci) | ci);
  wire 
       l22 = (!di & ((((!ai & (ci & !bi)) & (((ci | !ci) & (di | !ci)) & di)) | bi) & ((ai & !ci) | ((!ai & (ci & !bi)) & (((ci | !ci) & (di | !ci)) & di))))) | (((!ai & (ci & !bi)) & (((ci | !ci) & (di | !ci)) & di)) | (((!di & ((((!ai & (ci & !bi)) & (((ci | !ci) & (di | !ci)) & di)) | bi) & ((ai & !ci) | ((!ai & (ci & !bi)) & (((ci | !ci) & (di | !ci)) & di))))) | (!aeqb | ((!ai & (ci & !bi)) & (((ci | !ci) & (di | !ci)) & di)))) & !ceqd));
  wire 
       l40 = ((ci & bi) & ai) & (((ci | !ci) & (di | !ci)) & di);
  wire  l04 = (!bi & !di) & (!ci & !ai);
  wire 
       l13 = ((((((!di & !aeqb) & ((!ai & !ceqd) | !ci)) & ((!ai & !ceqd) | (!di & !aeqb))) & !ci) | !ai) & ((!bi | !aeqb) & ((!di & !ci) | !bi))) & (!ceqd | ((((!di & !aeqb) & ((!ai & !ceqd) | !ci)) & ((!ai & !ceqd) | (!di & !aeqb))) & !ci));
  wire 
       l31 = ((((ci & !aeqb) & (di | (!ceqd & ai))) & ((ci & !aeqb) | (!ceqd & ai))) & di) | ((bi & (ai | ((((ci & !aeqb) & (di | (!ceqd & ai))) & ((ci & !aeqb) | (!ceqd & ai))) & di))) & (!ceqd | ((((ci & !aeqb) & (di | (!ceqd & ai))) & ((ci & !aeqb) | (!ceqd & ai))) & di)));
  wire  ao = ai;
  wire  bo = l04 | (bi & (l04 | !l40));
  wire 
       co = (((l04 | ci) | (!ai & !bi)) & ((!ci & ei) | (l04 | ci))) & (di | (l04 | ci));
  wire  do = !((ci & bi) & ai) & di;
  wire 
       eo = !(((ei & di) & !ci) & (!ai & !bi)) & (ei | (!(((ei & di) & !ci) & (!ai & !bi)) & l13));
  wire 
       io = ((l22 & !ei) | (((!ai & !bi) & ((((di & (ki | !l22)) & ki) & (ci & ei)) | (((!ai & (ci & !di)) & !bi) & ei))) | ((ei & (!di & !ci)) & ((!(ai & bi) | !ei) & (!(ai & bi) | l22))))) | (ei & ((l22 & !ei) | (((((l22 & !ei) | !di) & ((l22 & !ei) | (!ci & ei))) & !(ai & bi)) | l40)));
  wire 
       pd1s6 = (!l22 & (!ei & !l31)) | (((ei & di) & !ci) & (!ai & !bi));
  wire 
       nd1s6 = ((((!l13 & (ki | !l22)) & (ki | ei)) | bi) | ki) & (((((ki | (((ki & ki) & (((!di | !ci) | ai) | bi)) | !l13)) & (ei & !l22)) | ki) | ai) & (((((ki | (((ki & ki) & (((!di | !ci) | ai) | bi)) | !l13)) & (ei & !l22)) | ki) | !di) & ((ci & !ei) | (((ki | (((ki & ki) & (((!di | !ci) | ai) | bi)) | !l13)) & (ei & !l22)) | ki))));
  wire  ndos6 = pd1s6;
  wire 
       pdos6 = ((ki | (((ki & ki) & (((!di | !ci) | ai) | bi)) | !l13)) & (ei & !l22)) | ki;
  wire 
       alt7 = ((hi & fi) & gi) & (ki | ((dispin ? ((di & !ei) & l31) : (l13 & (ei & !di))) | ((ki & ki) & (((!di | !ci) | ai) | bi))));
  wire  fo = fi & !alt7;
  wire  go = ((!fi & (gi | !gi)) | gi) & (gi | !hi);
  wire  ho = hi;
  wire 
       jo = ((~gi & fi) | ((gi & ~fi) | alt7)) & (!hi | alt7);
  wire  nd1s4 = gi & fi;
  wire 
       pd1s4 = ((((((ki & ki) & (((!di | !ci) | ai) | bi)) | (((!fi & (ki | !fi)) & (!gi | ki)) & !gi)) | ki) & (fi | !fi)) & (!fi | !gi)) & ((gi | (!gi & fi)) | (((!fi & (ki | !fi)) & (!gi | ki)) & !gi));
  wire  ndos4 = ((!fi & (ki | !fi)) & (!gi | ki)) & !gi;
  wire  pdos4 = (hi & fi) & gi;
  wire 
       illegalk = (((ki & !ci) | (((!di | !ei) & (ki | (((ki & ki) & (((!di | !ci) | ai) | bi)) | !l13))) & ki)) | (((ai | bi) & (ki | (((ki & ki) & (((!di | !ci) | ai) | bi)) | !l13))) & ki)) & ((!ei | !l31) | ((!hi | !gi) | !fi));
  wire 
       compls6 = ((pd1s6 | nd1s6) & (nd1s6 | !dispin)) & (dispin | (pd1s6 & !dispin));
  wire 
       disp6 = ((ndos6 & ~dispin) | (pdos6 & ~dispin)) | (((~(ndos6 | pdos6) | ~dispin) & dispin) & ~(ndos6 | pdos6));
  wire 
       compls4 = ((disp6 | !disp6) & (pd1s4 | disp6)) & ((!disp6 | nd1s4) & (nd1s4 | pd1s4));

  assign dispout = ((~(ndos4 | pdos4) & disp6) | ~disp6) & (((pdos4 & ~disp6) | (~disp6 & ndos4)) | disp6);
  assign dataout = {jo ^ compls4,ho ^ compls4,(compls4 | (~compls4 & go)) & (~compls4 | ~go),(~fo & compls4) | (~compls4 & fo),compls6 ^ io,compls6 ^ eo,(~do | ~compls6) & ((~compls6 & do) | compls6),co ^ compls6,bo ^ compls6,(((~compls6 | ~ao) & ao) & ~compls6) | (compls6 & ~ao)};
endmodule

