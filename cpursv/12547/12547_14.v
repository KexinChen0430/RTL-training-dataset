
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
  wire  aeqb = ((!ai & !bi) | ai) & (bi | (!ai & !bi));
  wire 
       ceqd = (((ci & (!ci | ci)) & (!ci | di)) & ((di & (!ci | di)) & (!ci | ci))) | ((!ci & (!di | di)) & (!di | ci));
  wire 
       l22 = (((((!di & !ci) | !bi) & ((!bi | bi) & (ai | !bi))) & (((!ai & (((ci | l04) | (di & ei)) & (!ci | (ci | l04)))) & (l04 | (ci | !bi))) & ci)) & di) | ((((!di & (((((ci & (!ci | ci)) & (!ci | di)) & ((di & (!ci | di)) & (!ci | ci))) & !ai) | ((!ci & ai) & bi))) & (!di | ((((ci & (!ci | ci)) & (!ci | di)) & ((di & (!ci | di)) & (!ci | ci))) & !ai))) & ((!ci & ai) & bi)) | (!aeqb & !ceqd));
  wire 
       l40 = (ai & (ci & bi)) & ((di & (!ci | di)) & (!ci | ci));
  wire  l04 = !di & ((!ci & !ai) & !bi);
  wire 
       l13 = (!aeqb & (!di & !ci)) | (!ai & (!bi & !ceqd));
  wire 
       l31 = ((((ci & (!ci | ci)) & (!ci | di)) & ((di & (!ci | di)) & (!ci | ci))) & !aeqb) | (ai & (bi & !ceqd));
  wire  ao = ai;
  wire  bo = (l04 | bi) & (!l40 | l04);
  wire 
       co = (((l04 | (ci | !bi)) & (!ai | (ci | l04))) & ((ci | l04) | (!ci & ei))) & ((ci | l04) | di);
  wire  do = di & !(ai & (ci & bi));
  wire 
       eo = (!((di & ei) & ((!ci & !ai) & !bi)) & l13) | (ei & !((di & ei) & ((!ci & !ai) & !bi)));
  wire 
       io = (((!ai | (((!di & !ci) & ei) & !(bi & ai))) | ((ei & l40) | (l22 & !ei))) & (((!(bi & ai) & ((l22 & !ei) | !ci)) & ((ei | (l22 & !ei)) & (!di | (l22 & !ei)))) | (((ei & l40) | (l22 & !ei)) | !bi))) & ((((ei & l40) | (l22 & !ei)) | ((((!di & !ci) & ei) & !(bi & ai)) | ((((di & ei) & (ki | !l22)) & ki) & ((ci & (bi | (!ai & !bi))) & (!ai & !bi))))) | ((!di & ci) & ei));
  wire 
       pd1s6 = (((!ci & ((di & !bi) & ei)) | !l31) & (!ai | !l31)) & (((!l22 & !ei) | ((di & !ci) & ei)) & ((!ai & !bi) | (!l22 & !ei)));
  wire 
       nd1s6 = (ai & (ki | (((!ei & (!di & ci)) & bi) | ((!l13 | ki) & (!l22 & ei))))) | ((ki | ei) & ((!l22 & !l13) | ki));
  wire  ndos6 = pd1s6;
  wire  pdos6 = (ki | ei) & ((!l22 & !l13) | ki);
  wire 
       alt7 = ((hi & fi) & gi) & (ki | (dispin ? (l31 & (di & !ei)) : ((ei & !di) & l13)));
  wire  fo = !alt7 & fi;
  wire  go = ((gi | !hi) & (gi | !gi)) & (!fi | gi);
  wire  ho = hi;
  wire 
       jo = ((~((!hi & (!fi | gi)) & gi) & (!hi & fi)) | alt7) | ((~(!hi & fi) & !hi) & gi);
  wire  nd1s4 = (fi & (gi | !gi)) & gi;
  wire 
       pd1s4 = ((((ki | !gi) & (ki | !fi)) & !fi) & !gi) | (((!gi & ((ki | !gi) & (ki | !fi))) & fi) | (((ki | !gi) & (ki | !fi)) & (((!fi | !gi) & (!fi | fi)) & gi)));
  wire  ndos4 = (((ki | !gi) & (ki | !fi)) & !fi) & !gi;
  wire  pdos4 = (hi & fi) & gi;
  wire 
       illegalk = ((ki & !ci) | ((((bi | ai) | !di) & ki) | !ei)) & (ki & ((!fi | (!gi | !ei)) | (!l31 | !hi)));
  wire 
       compls6 = ((!dispin | nd1s6) & (nd1s6 | pd1s6)) & ((pd1s6 & !dispin) | dispin);
  wire 
       disp6 = ((dispin & ~(pdos6 | ndos6)) | (pdos6 & ~dispin)) | (ndos6 & ~dispin);
  wire 
       compls4 = (((disp6 & nd1s4) | !disp6) & pd1s4) | (disp6 & nd1s4);

  assign dispout = (~(ndos4 | pdos4) | ((ndos4 | (~disp6 & pdos4)) & ~disp6)) & (disp6 | ((ndos4 | (~disp6 & pdos4)) & ~disp6));
  assign dataout = {(~compls4 | ~jo) & ((jo & ~compls4) | compls4),(~compls4 & ho) | (compls4 & (~ho | ~compls4)),go ^ compls4,((((~fo & compls4) | ~compls4) & ~compls4) & fo) | (((~fo & compls4) | ~compls4) & compls4),io ^ compls6,((eo & ~compls6) | compls6) & ((compls6 & ~eo) | ~compls6),(do & ~compls6) | ((~compls6 | (~do & compls6)) & compls6),(compls6 & ~co) | (~compls6 & co),(bo & ~compls6) | (compls6 & (~compls6 | (compls6 & ~bo))),(~ao & compls6) | (((~compls6 | ~ao) & ao) & ~compls6)};
endmodule

