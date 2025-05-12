
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
       aeqb = (((ai & (ai | !ai)) & (bi | !ai)) & ((bi & (bi | !ai)) & (ai | !ai))) | (!ai & ((ai | !bi) & (bi | !bi)));
  wire  ceqd = (ci & (di | (!di & !ci))) | (!di & !ci);
  wire 
       l22 = ((!bi & ((((!di & ai) & !ci) & ((bi & (bi | !ai)) & (ai | !ai))) | di)) & ((ci & !ai) | (((!di & ai) & !ci) & ((bi & (bi | !ai)) & (ai | !ai))))) | ((((!di & ((ai & (ai | !ai)) & (bi | !ai))) & bi) | (!ceqd & !aeqb)) & (!ci | (!ceqd & !aeqb)));
  wire 
       l40 = ((ai & ci) & ((bi & (bi | !ai)) & (ai | !ai))) & ((di & (!ci | di)) & (ci | !ci));
  wire  l04 = (!bi & !ai) & (!di & !ci);
  wire 
       l13 = ((!di | (!bi & (!ai & !ceqd))) & (!aeqb | (!bi & (!ai & !ceqd)))) & ((!bi & (!ai & !ceqd)) | !ci);
  wire 
       l31 = (((ai & !ceqd) & (((!aeqb & ((ci | l04) | ((!ci & (ei & !bi)) & di))) & ci) | bi)) & (bi | di)) | (((((ai & !ceqd) | ((!aeqb & ((ci | l04) | ((!ci & (ei & !bi)) & di))) & ci)) & ((ai & !ceqd) | di)) & ci) & (((((ai & !ceqd) | ((!aeqb & ((ci | l04) | ((!ci & (ei & !bi)) & di))) & ci)) & ((ai & !ceqd) | di)) & !aeqb) & di));
  wire  ao = ai;
  wire  bo = l04 | ((l04 | bi) & !l40);
  wire 
       co = ((ci | l04) | (!bi & !ai)) & (((di & !ci) & ei) | (ci | l04));
  wire 
       do = di & !((ai & ci) & ((bi & (bi | !ai)) & (ai | !ai)));
  wire 
       eo = ((ei & !((ei & di) & ((!ci & ((!bi & !ai) | bi)) & (!bi & !ai)))) | l13) & !((ei & di) & ((!ci & ((!bi & !ai) | bi)) & (!bi & !ai)));
  wire 
       io = ((((!bi | ((l22 & !ei) | ((!di & (!(((ai & (ai | !ai)) & (bi | !ai)) & ((bi & (bi | !ai)) & (ai | !ai))) & (!ci & ei))) | ((!bi & (((ei & di) & ki) & ci)) & !ai)))) | (l40 & ((l22 & !ei) | ei))) & (((l40 | ((!bi & (((ei & di) & ki) & ci)) & !ai)) | !ai) | ((((l22 & !ei) | !di) & ((l22 & !ei) | ei)) & (((l22 & !ei) | !(((ai & (ai | !ai)) & (bi | !ai)) & ((bi & (bi | !ai)) & (ai | !ai)))) & ((l22 & !ei) | !ci))))) & (((l22 & !ei) | ei) | !ai)) & ((((((!bi & (((ei & di) & ki) & ci)) & !ai) | (l22 & !ei)) | (ei & l40)) | ((ei & !di) & ci)) | ((!(((ai & (ai | !ai)) & (bi | !ai)) & ((bi & (bi | !ai)) & (ai | !ai))) & ((l22 & !ei) | !ci)) & (((l22 & !ei) | !di) & ((l22 & !ei) | ei))));
  wire 
       pd1s6 = ((!l22 | ((ei & di) & ((!ci & ((!bi & !ai) | bi)) & (!bi & !ai)))) & ((!l31 | ((!ci & (ei & !bi)) & di)) & (!ai | !l31))) & (!ei | ((ei & di) & ((!ci & ((!bi & !ai) | bi)) & (!bi & !ai))));
  wire 
       nd1s6 = (((ki | ((fi & (ki & !gi)) | ei)) & (ki | !l13)) & (ki | !l22)) | ((ci & (!di & (!ei & bi))) & ai);
  wire  ndos6 = pd1s6;
  wire 
       pdos6 = ((ki | ((fi & (ki & !gi)) | ei)) & (ki | !l13)) & (ki | !l22);
  wire 
       alt7 = ((((gi & fi) & ((hi & (ki | ((fi & (ki & !gi)) | ei))) & ki)) | (dispin ? ((!ei & di) & l31) : ((l13 & ei) & !di))) & gi) & (fi & hi);
  wire  fo = !alt7 & fi;
  wire  go = ((!fi & !hi) | gi) & (!gi | gi);
  wire  ho = hi;
  wire 
       jo = ((((~fi & (gi | !fi)) & gi) | alt7) | (fi & ~gi)) & (alt7 | !hi);
  wire  nd1s4 = gi & fi;
  wire 
       pd1s4 = ((((fi & (!fi | fi)) & (!fi | !gi)) & ((!gi & (!fi | !gi)) & (!fi | fi))) | ((gi | !fi) & (!gi | gi))) & ((((!fi | ki) & (ki | !gi)) & (!fi | fi)) & (!fi | !gi));
  wire  ndos4 = !fi & (!gi & ((!fi | ki) & (ki | !gi)));
  wire  pdos4 = hi & (gi & fi);
  wire 
       illegalk = ((((bi | (ai | !di)) & ki) | !ei) | ((!ci & (ki | ((fi & (ki & !gi)) | ei))) & ki)) & (ki & ((!ei | (!hi | (!fi | !gi))) | !l31));
  wire 
       compls6 = ((dispin & nd1s6) | pd1s6) & (!dispin | (dispin & nd1s6));
  wire 
       disp6 = ((ndos6 & ~dispin) | (dispin & ~(pdos6 | ndos6))) | (~dispin & pdos6);
  wire 
       compls4 = ((disp6 | pd1s4) & (!disp6 | disp6)) & ((nd1s4 | !disp6) & (pd1s4 | nd1s4));

  assign dispout = (disp6 & ~(pdos4 | ndos4)) | ((pdos4 | ndos4) & ~disp6);
  assign dataout = {(~compls4 & jo) | (compls4 & ~jo),compls4 ^ ho,(compls4 & (~go | ~compls4)) | (go & ~compls4),(compls4 | (~compls4 & fo)) & (~fo | ~compls4),compls6 ^ io,(~eo | (eo & ~compls6)) & ((compls6 & ~eo) | eo),(~compls6 & do) | ((~compls6 | (~do & compls6)) & compls6),(compls6 | (~compls6 & co)) & (~compls6 | ~co),(bo & ~compls6) | (compls6 & ~bo),ao ^ compls6};
endmodule

