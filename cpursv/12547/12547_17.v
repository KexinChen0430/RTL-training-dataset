
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
       aeqb = (!bi & !ai) | ((((!ai | ai) & (bi | !ai)) & bi) & ai);
  wire 
       ceqd = ((!ci | ci) & (di | !ci)) & ((ci | !di) & (di | !di));
  wire 
       l22 = (((((!ai & (ci & !bi)) & di) | (!aeqb | ((!di & !ci) & ((((!ai | ai) & (bi | !ai)) & bi) & ai)))) & !ceqd) | ((!ai & (ci & !bi)) & di)) | ((((!ai & (ci & !bi)) & di) | !di) & ((!ci & ai) & bi));
  wire 
       l40 = ((bi & di) & (((!ai | ai) & (bi | !ai)) & ai)) & ((ci & (!ci | ci)) & (di | !ci));
  wire  l04 = (!di & (!bi & !ai)) & !ci;
  wire 
       l13 = ((!ai | (!aeqb & (!di & !ci))) & ((!aeqb & (!di & !ci)) | !ceqd)) & (((!aeqb & !di) | !bi) & (!bi | !ci));
  wire 
       l31 = ((!ceqd & (((!ai | ai) & (bi | !ai)) & ai)) & bi) | ((!aeqb & ci) & (di | ((!ceqd & (((!ai | ai) & (bi | !ai)) & ai)) & bi)));
  wire  ao = ai;
  wire  bo = (bi | l04) & (!l40 | l04);
  wire 
       co = ((((l04 | ci) | !ai) & ((l04 | ci) | (!ci & ei))) & (di | (l04 | ci))) & ((!bi | ci) | l04);
  wire  do = !(bi & (ci & ai)) & di;
  wire 
       eo = !(!ai & ((!bi & di) & (!ci & ei))) & (ei | l13);
  wire 
       io = ((((((ki & ei) & (((((!ci & ei) & di) | ci) | l04) & ((!bi | ci) | l04))) & ci) & (!bi & (!ai & di))) | (!ai & ((!di & (!bi & ei)) & ci))) | ((l40 | ((((l22 & (((!ci & ei) & !di) | !ei)) & (l22 | ((!ci & ei) & !di))) & (!l31 | (!hi | (!fi | (!gi | !ei))))) & !ei)) | ((!ci & !((((!ai | ai) & (bi | !ai)) & bi) & ai)) & (ei & !di)))) & (((((ki & ei) & (((((!ci & ei) & di) | ci) | l04) & ((!bi | ci) | l04))) & ci) & (!bi & (!ai & di))) | (ei | ((((l22 & (((!ci & ei) & !di) | !ei)) & (l22 | ((!ci & ei) & !di))) & (!l31 | (!hi | (!fi | (!gi | !ei))))) & !ei)));
  wire 
       pd1s6 = (((!ci & ei) & di) | (!l31 & (!ei & !l22))) & ((!l31 & (!ei & !l22)) | (!bi & !ai));
  wire 
       nd1s6 = (((((!l22 | (((!ci | ai) | (bi | !di)) & ki)) | ki) & ((ei & !l13) | ki)) | ((((!ai | ai) & (bi | !ai)) & bi) & ai)) & ((((!l22 | (((!ci | ai) | (bi | !di)) & ki)) | ki) & ((ei & !l13) | ki)) | (!di & !ei))) & ((((!l22 | (((!ci | ai) | (bi | !di)) & ki)) | ki) & ((ei & !l13) | ki)) | ci);
  wire  ndos6 = pd1s6;
  wire 
       pdos6 = ((!l22 | (((!ci | ai) | (bi | !di)) & ki)) | ki) & ((ei & !l13) | ki);
  wire 
       alt7 = (((ki & (hi & fi)) & (!fi | gi)) & gi) | (((dispin ? ((!ei & di) & l31) : ((ei & !di) & l13)) & fi) & ((((ki & (hi & fi)) & (!fi | gi)) & gi) | (hi & gi)));
  wire  fo = fi & !alt7;
  wire  go = (gi | !gi) & (gi | (!fi & !hi));
  wire  ho = hi;
  wire 
       jo = ((fi & ~gi) | (alt7 | (((~gi | ~fi) & gi) & ~fi))) & (!hi | alt7);
  wire  nd1s4 = gi & fi;
  wire 
       pd1s4 = (((!fi & !gi) | fi) & ((!fi & !gi) | (!gi & ki))) | (gi & ((!fi | (fi & !gi)) & ki));
  wire  ndos4 = !fi & !gi;
  wire  pdos4 = hi & (gi & fi);
  wire 
       illegalk = (((ai | bi) & ki) | ((((!ei & (((fi & (!gi & ki)) | !l13) | ki)) & ki) | (((!hi | (!fi | (!gi | !ei))) & ki) & ((!ci | bi) | ((!di | !ei) | ai)))) | ((!ci | !di) & ki))) & (!l31 | (!hi | (!fi | (!gi | !ei))));
  wire  compls6 = (pd1s6 & !dispin) | (dispin & nd1s6);
  wire 
       disp6 = (~dispin | (~(ndos6 | pdos6) & dispin)) & (dispin | ((ndos6 | pdos6) & ~dispin));
  wire 
       compls4 = ((nd1s4 & disp6) | pd1s4) & ((nd1s4 & disp6) | !disp6);

  assign dispout = (~(pdos4 | ndos4) | ((~disp6 & pdos4) | (ndos4 & ~disp6))) & ((pdos4 | ndos4) | (((~(pdos4 | ndos4) | ((~disp6 & pdos4) | (ndos4 & ~disp6))) & disp6) & ~(pdos4 | ndos4)));
  assign dataout = {((((~compls4 | ~jo) & jo) & ~compls4) | compls4) & (~compls4 | ~jo),(compls4 & ~ho) | (ho & ~compls4),(~go | ~compls4) & (go | (compls4 & ~go)),(~compls4 & fo) | ((~fo | (~compls4 & fo)) & compls4),io ^ compls6,(~eo | ~compls6) & ((compls6 & ~eo) | eo),do ^ compls6,compls6 ^ co,(bo | (compls6 & ~bo)) & ((compls6 & ~bo) | ~compls6),(compls6 | (~compls6 & ao)) & (~ao | ~compls6)};
endmodule

