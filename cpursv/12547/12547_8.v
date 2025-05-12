
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
  wire  aeqb = (!ai & !bi) | (ai & bi);
  wire  ceqd = ((!di & !ci) | ci) & ((!di & !ci) | di);
  wire 
       l22 = (!bi & ((!di | ((!ai & di) & ((ci & (ci | !ci)) & (!ci | di)))) & (((!ai & di) & ((ci & (ci | !ci)) & (!ci | di))) | ((bi & !ci) & (((ai & bi) | !ai) & ai))))) | (((!aeqb & !ceqd) | (!di & !ci)) & ((!aeqb & !ceqd) | (ai & bi)));
  wire  l40 = (ci & (ai & bi)) & di;
  wire  l04 = (!di & !ci) & (!ai & !bi);
  wire 
       l13 = (((!bi | (!di & !ci)) & (!aeqb | !bi)) & ((!ceqd & !ai) | !di)) & ((!ci & !aeqb) | (!ceqd & !ai));
  wire 
       l31 = ((ci & ((di & (!ci | di)) & (ci | !ci))) | ((!ceqd & ai) & (((ai & bi) | !ai) & bi))) & (((!ceqd & ai) & (((ai & bi) | !ai) & bi)) | !aeqb);
  wire  ao = ai;
  wire  bo = (bi | l04) & (l04 | !l40);
  wire 
       co = ((!ai | (ci | l04)) & (l04 | (((ei & !ci) & di) | ci))) & ((ci | l04) | !bi);
  wire  do = !(ci & (ai & bi)) & di;
  wire 
       eo = (ei | (l13 & !((((((!ai | (!l22 & !ei)) & ((!l22 & !ei) | (!ci & (!bi & (di & ei))))) & (bi | (!ai & !bi))) & (!ai & !bi)) & di) & (ei & !ci)))) & !((((((!ai | (!l22 & !ei)) & ((!l22 & !ei) | (!ci & (!bi & (di & ei))))) & (bi | (!ai & !bi))) & (!ai & !bi)) & di) & (ei & !ci));
  wire 
       io = (((!(ai & bi) & ((((!di & ((!(ai & bi) & !ci) & ei)) | l22) & !ei) | ei)) & ((!di & !ci) | (!ei & l22))) | (((!ai & !bi) & ((((di & ki) & ei) & ci) | (!ai & ((!bi & !di) & (ci & ei))))) | (!ei & l22))) | ((l40 & (ei | l22)) & (ei | !ei));
  wire 
       pd1s6 = ((!l31 & !ei) & !l22) | (((!ai | ((!l31 & !ei) & !l22)) & (!bi & !ci)) & (di & ei));
  wire 
       nd1s6 = ((((ki | (!l13 & (ki | (!l22 & ei)))) | ai) & ((ki | (!l13 & (ki | (!l22 & ei)))) | !di)) & ((ki | (!l13 & (ki | (!l22 & ei)))) | (ci & !ei))) & ((bi | ki) | (!l22 & (ei & !l13)));
  wire  ndos6 = pd1s6;
  wire  pdos6 = ki | (!l13 & (ki | (!l22 & ei)));
  wire 
       alt7 = ((gi & (((fi & ((ki | (ci & (bi & (!di & !ei)))) | (((ki | !l13) & !l22) & ei))) & ki) & hi)) | (dispin ? (l31 & (di & !ei)) : ((ei & !di) & l13))) & ((((fi & hi) | (gi & (((fi & ((ki | (ci & (bi & (!di & !ei)))) | (((ki | !l13) & !l22) & ei))) & ki) & hi))) & (!fi | gi)) & gi);
  wire  fo = !alt7 & fi;
  wire  go = (gi | !gi) & ((!hi | gi) & (!fi | gi));
  wire  ho = hi;
  wire 
       jo = (((~fi & (!hi | gi)) & gi) | ((~gi & fi) | alt7)) & (!hi | alt7);
  wire  nd1s4 = gi & fi;
  wire 
       pd1s4 = (((!fi & (gi | !gi)) & (gi | fi)) | (!gi & (fi | (!fi & !gi)))) & ((!fi | ki) & (!gi | ki));
  wire  ndos4 = !fi & !gi;
  wire 
       pdos4 = (((fi & hi) | (gi & (((fi & ((ki | (ci & (bi & (!di & !ei)))) | (((ki | !l13) & !l22) & ei))) & ki) & hi))) & (!fi | gi)) & gi;
  wire 
       illegalk = ((((!hi & ki) & ((!ei & (((!hi | (!gi | ((!ei | !fi) | !l31))) & (ki | (!l22 & ei))) & ki)) | ((!ci | bi) | (ai | !di)))) | (!l31 | (((!fi | (!ei | !gi)) & ki) & ((!ei & (((!hi | (!gi | ((!ei | !fi) | !l31))) & (ki | (!l22 & ei))) & ki)) | ((!ci | bi) | (ai | !di)))))) & ((!ei | ((!di & (ki | !l13)) & ki)) | ((ki & !ci) | (ki & (bi | ai))))) & ki;
  wire 
       compls6 = ((pd1s6 | nd1s6) & (!dispin | nd1s6)) & ((dispin | pd1s6) & (!dispin | dispin));
  wire 
       disp6 = ((ndos6 & ~dispin) | (~dispin & pdos6)) | (~(ndos6 | pdos6) & dispin);
  wire 
       compls4 = ((!disp6 | nd1s4) & (nd1s4 | pd1s4)) & (disp6 | ((!disp6 & ((!disp6 | nd1s4) & (nd1s4 | pd1s4))) & (pd1s4 & ((!disp6 | nd1s4) & (nd1s4 | pd1s4)))));

  assign dispout = disp6 ^ (pdos4 | ndos4);
  assign dataout = {(((((~jo & compls4) | ~compls4) & jo) & ~compls4) | compls4) & ((~jo & compls4) | ~compls4),(~compls4 & ho) | (~ho & compls4),(go & ~compls4) | ((~go | ~compls4) & compls4),(((~compls4 | ~fo) & ~compls4) & fo) | (compls4 & (~compls4 | ~fo)),((io & ~compls6) | ~io) & ((io & ~compls6) | compls6),eo ^ compls6,compls6 ^ do,compls6 ^ co,bo ^ compls6,(~compls6 & ao) | (compls6 & ~ao)};
endmodule

