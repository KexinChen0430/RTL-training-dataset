
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
  wire  aeqb = (bi | (!bi & !ai)) & ((!bi & !ai) | ai);
  wire  ceqd = (!di & !ci) | (ci & (di | (!di & !ci)));
  wire 
       l22 = (!aeqb & !ceqd) | (((((!ai & ci) & di) | ((bi & ai) & !di)) & (((!ai & ci) & di) | !ci)) & ((((((((!ai & ci) & di) | ((bi & ai) & !di)) & (((!ai & ci) & di) | !ci)) & (ai & !ci)) & bi) & !di) | !bi));
  wire 
       l40 = bi & (((ai & (l04 | ((l04 | ci) | (ci | ((ei & !ci) & (!bi & di)))))) & ci) & di);
  wire  l04 = (!ci & (!bi & !ai)) & !di;
  wire 
       l13 = ((!ai & !ceqd) & !bi) | ((!aeqb & !ci) & (!di | ((!ai & !ceqd) & !bi)));
  wire 
       l31 = ((di | bi) & (bi | (ci & !aeqb))) & ((!aeqb | (!ceqd & ai)) & ((!ceqd & ai) | (di & ci)));
  wire  ao = ai;
  wire  bo = l04 | (bi & (l04 | !l40));
  wire 
       co = l04 | (ci | ((!ai & (((ei & di) | (l04 | ci)) & ((l04 | ci) | !ci))) & ((ci | !bi) | l04)));
  wire 
       do = !(bi & ((ai & (l04 | ((l04 | ci) | (ci | ((ei & !ci) & (!bi & di)))))) & ci)) & di;
  wire 
       eo = (ei | l13) & !(((ei & !ci) & di) & (!bi & !ai));
  wire 
       io = (((l22 | !(bi & ai)) & (!(bi & ai) | !ei)) & (((l22 & ((((!fi | !ei) | !gi) | !hi) | !l31)) & !ei) | ((ei & l40) | ((!di & ei) & !ci)))) | (((!di & ei) & ((ci & (bi | (!bi & !ai))) & (!bi & !ai))) | (((!bi & !ai) & (ci & ((ei & di) & ki))) | (ei & l40)));
  wire 
       pd1s6 = ((!l31 | (!bi & !ai)) & (!l31 | ((ei & !ci) & di))) & ((!ei & (!l22 | (((ei & !ci) & di) & (!bi & !ai)))) | (((ei & !ci) & di) & (!bi & !ai)));
  wire 
       nd1s6 = (ki | (((bi & !di) & (((!ei & (l04 | ((l04 | ci) | (ci | ((ei & !ci) & (!bi & di)))))) & ci) & ai)) | ((fi & ki) & !gi))) | (((ei & (ki | !l22)) | ki) & !l13);
  wire  ndos6 = pd1s6;
  wire 
       pdos6 = ((!l22 & !l13) | ki) & (ki | (ei | ((fi & ki) & !gi)));
  wire 
       alt7 = (fi & (hi & gi)) & (((dispin ? (l31 & ((di & ((((!fi | !ei) | !gi) | !hi) | !l31)) & !ei)) : (l13 & (!di & ei))) | ((ki & ki) & ((bi | ai) | (!di | !ci)))) | ki);
  wire  fo = !alt7 & fi;
  wire  go = (gi | !hi) & ((gi | !fi) & (gi | !gi));
  wire  ho = hi;
  wire 
       jo = (!hi | alt7) & ((alt7 | (gi & ~fi)) | (~gi & fi));
  wire  nd1s4 = fi & gi;
  wire 
       pd1s4 = ((((fi | !fi) & (!gi | !fi)) & (ki | !gi)) & (!fi | ki)) & (((gi | !fi) & (gi | !gi)) | (fi & !gi));
  wire  ndos4 = (!gi & ((fi | !fi) & (!gi | !fi))) & !fi;
  wire  pdos4 = fi & (hi & gi);
  wire 
       illegalk = (ki & ((((!fi | !ei) | !gi) | !hi) | !l31)) & (((bi | ai) | (!di | !ci)) | !ei);
  wire 
       compls6 = (nd1s6 | (!dispin & pd1s6)) & (dispin | (!dispin & pd1s6));
  wire  disp6 = (pdos6 | ndos6) ^ dispin;
  wire 
       compls4 = (!disp6 & pd1s4) | (((nd1s4 | !disp6) & (pd1s4 | nd1s4)) & disp6);

  assign dispout = ((pdos4 | ndos4) & ~disp6) | (disp6 & ~(pdos4 | ndos4));
  assign dataout = {(~compls4 & jo) | (~jo & compls4),ho ^ compls4,(~go & compls4) | (go & ~compls4),(fo & ~compls4) | (((fo & ~compls4) | ~fo) & compls4),(~compls6 | ~io) & (compls6 | (~compls6 & io)),((((~eo & compls6) | ~compls6) & ~compls6) & eo) | (~eo & compls6),(compls6 & ((compls6 & ~do) | ~compls6)) | (do & ~compls6),co ^ compls6,(~compls6 & bo) | (compls6 & ~bo),(~compls6 & ao) | (compls6 & (~compls6 | (~ao & compls6)))};
endmodule

