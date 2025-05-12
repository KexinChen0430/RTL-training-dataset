
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
  wire  aeqb = (ai & bi) | (!bi & !ai);
  wire  ceqd = (ci & di) | (!di & !ci);
  wire 
       l22 = (!bi & (((di & (!ai & ci)) | (ai & (bi & !di))) & (!ci | (di & (!ai & ci))))) | ((!ceqd & !aeqb) | ((((!di & (!ci | (di & (!ai & ci)))) & ((di & (!ai & ci)) | (ai & (bi & !di)))) & (!ci & ai)) & bi));
  wire 
       l40 = ((ai & bi) & (((ci | !ci) & (!ci | di)) & di)) & ci;
  wire  l04 = ((!di & !ci) & !ai) & !bi;
  wire 
       l13 = (((!di & ((!ai & !ceqd) | (!di & !aeqb))) & ((!ai & !ceqd) | !ci)) & (!aeqb & !ci)) | ((!ai & !ceqd) & ((!bi | (!di & !aeqb)) & (!ci | !bi)));
  wire 
       l31 = ((((ai & bi) & !ceqd) | di) & (((ai & bi) & !ceqd) | !aeqb)) & (((ai & bi) & !ceqd) | ci);
  wire  ao = ai;
  wire  bo = l04 | (!l40 & (bi | l04));
  wire 
       co = (((l04 | ci) | !ai) & ((ci | !bi) | l04)) & ((l04 | ci) | (di & (!ci & ei)));
  wire  do = di & !((ai & ci) & (((ai & bi) | !ai) & bi));
  wire 
       eo = (!(((!ai & ((!l22 & !ei) | !bi)) & ((!l22 & !ei) | ((!ai & ei) & (di & !ci)))) & ((ei & (!bi & !ci)) & di)) & ei) | (!(((!ai & ((!l22 & !ei) | !bi)) & ((!l22 & !ei) | ((!ai & ei) & (di & !ci)))) & ((ei & (!bi & !ci)) & di)) & l13);
  wire 
       io = ((!ai & (ki & ((ci & !bi) & (di & ei)))) | ((((!ai & (!di & (ei & !bi))) & (l04 | ((l04 | ci) | (((ei & (!bi & !ci)) & di) | ci)))) & ci) | (l40 & ei))) | ((l22 & !ei) | ((!ci & ei) & (!(ai & bi) & !di)));
  wire 
       pd1s6 = (((!l22 & (!ei & !l31)) | ((ei & !bi) & di)) & ((!l22 & (!ei & !l31)) | !ci)) & (!ai | (!l22 & (!ei & !l31)));
  wire 
       nd1s6 = ((ai & (ki | ((ci & (!ei & !di)) | (((ki | ei) & (!l22 | ki)) & !l13)))) & (((!l22 | ki) & (ki | (!l13 & ei))) | bi)) | ((!l22 | ki) & (ki | (!l13 & ei)));
  wire  ndos6 = pd1s6;
  wire  pdos6 = (!l22 | ki) & (ki | (!l13 & ei));
  wire 
       alt7 = ((ki & ((hi & gi) & fi)) | (dispin ? (((l31 & di) & ((!gi | (!ei | (!fi | !hi))) | !l31)) & !ei) : ((ei & !di) & l13))) & ((hi & gi) & fi);
  wire  fo = !alt7 & fi;
  wire  go = (((!fi | gi) & !gi) | gi) & (!hi | gi);
  wire  ho = hi;
  wire 
       jo = ((~(fi & !hi) & !hi) & gi) | (((fi & !hi) & ~(gi & !hi)) | alt7);
  wire  nd1s4 = (fi & (!fi | gi)) & gi;
  wire 
       pd1s4 = (gi & (((!fi | !gi) & (!fi | fi)) & ki)) | ((fi | ((((!fi | !gi) & (!fi | fi)) & ((!gi & (!fi | ki)) & (ki | !gi))) & !fi)) & ((ki & !gi) | ((((!fi | !gi) & (!fi | fi)) & ((!gi & (!fi | ki)) & (ki | !gi))) & !fi)));
  wire 
       ndos4 = (((!fi | !gi) & (!fi | fi)) & ((!gi & (!fi | ki)) & (ki | !gi))) & !fi;
  wire  pdos4 = (hi & gi) & fi;
  wire 
       illegalk = ((!ci | bi) | ((!di | !ei) | ai)) & (ki & ((!gi | (!ei | (!fi | !hi))) | !l31));
  wire 
       compls6 = ((nd1s6 & dispin) | !dispin) & (pd1s6 | (nd1s6 & dispin));
  wire 
       disp6 = (dispin & ~(pdos6 | ndos6)) | ((pdos6 | ndos6) & (~(pdos6 | ndos6) | ~dispin));
  wire 
       compls4 = ((pd1s4 | nd1s4) & (nd1s4 | !disp6)) & ((disp6 | !disp6) & (pd1s4 | disp6));

  assign dispout = (~(ndos4 | pdos4) & disp6) | ((ndos4 | (~disp6 & pdos4)) & ~disp6);
  assign dataout = {((~jo & compls4) | ~compls4) & (jo | (~jo & compls4)),((ho & ~compls4) | compls4) & (~compls4 | ~ho),go ^ compls4,(~fo & compls4) | (((~compls4 | (~fo & compls4)) & ~compls4) & fo),compls6 ^ io,compls6 ^ eo,do ^ compls6,((compls6 & ~co) | ~compls6) & ((co & ~compls6) | compls6),((((~bo | ~compls6) & bo) & ~compls6) | compls6) & (~bo | ~compls6),(ao | (~ao & compls6)) & (~compls6 | ~ao)};
endmodule

