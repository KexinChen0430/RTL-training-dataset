
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
  wire  aeqb = (bi | (!ai & !bi)) & ((!ai & !bi) | ai);
  wire 
       ceqd = ((ci & di) | !di) & ((ci | !ci) & (!ci | di));
  wire 
       l22 = ((!bi | ((!ci & (!di & ai)) & bi)) & ((!ai & ((ci & di) | !di)) & (ci & di))) | (((!di & (ai & bi)) | (!ceqd & !aeqb)) & (!ci | (!ceqd & !aeqb)));
  wire 
       l40 = (ai & (bi & ci)) & (((ci | !ci) & (!ci | di)) & di);
  wire  l04 = (!di & !ai) & (!ci & !bi);
  wire 
       l13 = (((!ai & !bi) & !ceqd) | !aeqb) & (((!ai & !bi) & !ceqd) | (!ci & !di));
  wire 
       l31 = ((di | bi) & (bi | (!aeqb & ci))) & (((!aeqb & di) & (ci & ((ci | !ci) & (!ci | di)))) | (ai & !ceqd));
  wire  ao = ai;
  wire  bo = (!l40 & bi) | l04;
  wire 
       co = l04 | ((!ai & (((ei & di) | (l04 | ci)) & ((l04 | ci) | (!ci & !bi)))) | ci);
  wire  do = di & !(ai & (bi & ci));
  wire 
       eo = !(((ei & !ci) & (!ai & !bi)) & di) & (l13 | ei);
  wire 
       io = (((!bi | ((((!di & !(ai & bi)) & (ei & !ci)) | ((((ei & ((((((bi & (!di & !ei)) & (((ei & di) | (l04 | ci)) & ((l04 | ci) | (!ci & !bi)))) & ci) | ki) | (((!l22 & !l13) | ki) & (ei | ki))) | (ei & (!l22 & !l13)))) & ki) & (!bi & di)) & (ci & !ai))) | ((((!(ai & bi) | !ei) & (!(ai & bi) | l22)) & ((l22 & (!ei | (ei & (!ci & !di)))) & ((ei & (!ci & !di)) | l22))) & !ei))) | (ei & l40)) & ((!ai | (((((!(ai & bi) | !ei) & (!(ai & bi) | l22)) & ((l22 & (!ei | (ei & (!ci & !di)))) & ((ei & (!ci & !di)) | l22))) & !ei) | ei)) & (!ai | (((!(ai & bi) & (((((!(ai & bi) | !ei) & (!(ai & bi) | l22)) & ((l22 & (!ei | (ei & (!ci & !di)))) & ((ei & (!ci & !di)) | l22))) & !ei) | ei)) & ((!ei | (ei & (!ci & !di))) & ((ei & (!ci & !di)) | l22))) | (l40 | ((((!(ai & bi) | !ei) & (!(ai & bi) | l22)) & ((l22 & (!ei | (ei & (!ci & !di)))) & ((ei & (!ci & !di)) | l22))) & !ei)))))) & (((!di & ci) & ei) | (((((!di & !(ai & bi)) & (ei & !ci)) | ((((ei & ((((((bi & (!di & !ei)) & (((ei & di) | (l04 | ci)) & ((l04 | ci) | (!ci & !bi)))) & ci) | ki) | (((!l22 & !l13) | ki) & (ei | ki))) | (ei & (!l22 & !l13)))) & ki) & (!bi & di)) & (ci & !ai))) | ((((!(ai & bi) | !ei) & (!(ai & bi) | l22)) & ((l22 & (!ei | (ei & (!ci & !di)))) & ((ei & (!ci & !di)) | l22))) & !ei)) | (l40 & (((((!(ai & bi) | !ei) & (!(ai & bi) | l22)) & ((l22 & (!ei | (ei & (!ci & !di)))) & ((ei & (!ci & !di)) | l22))) & !ei) | ei))));
  wire 
       pd1s6 = (((!l22 & !l31) & (!fi | (((!ei | !hi) | !gi) | !l31))) & !ei) | (((ei & !ci) & (!ai & !bi)) & di);
  wire 
       nd1s6 = ((ei & (!l22 & !l13)) | (ki | (ci & (!di & !ei)))) & ((((((!l22 & !l13) | ki) & (ei | ki)) | bi) & (ai | (!l13 | ki))) & ((ei & (ki | !l22)) | ((ai | (ki & (ai | (!ci | (!di | bi))))) | ki)));
  wire  ndos6 = pd1s6;
  wire  pdos6 = ((!l22 & !l13) | ki) & (ei | ki);
  wire 
       alt7 = (ki | (dispin ? (l31 & (!ei & di)) : (l13 & (ei & !di)))) & (hi & (gi & fi));
  wire  fo = !alt7 & fi;
  wire  go = ((gi | !gi) & (gi | !hi)) & (gi | !fi);
  wire  ho = hi;
  wire 
       jo = (!hi | alt7) & ((~gi & fi) | ((gi & ~fi) | alt7));
  wire  nd1s4 = gi & fi;
  wire 
       pd1s4 = (ki & (((!fi & (gi | !hi)) & gi) | ((((!gi & (!fi | fi)) & (!gi | !fi)) & !fi) | ((((!fi | fi) & (!gi | !fi)) & ((!gi & (!fi | fi)) & (!gi | !fi))) & fi)))) | (((!gi & (!fi | fi)) & (!gi | !fi)) & !fi);
  wire  ndos4 = ((!gi & (!fi | fi)) & (!gi | !fi)) & !fi;
  wire  pdos4 = hi & (gi & fi);
  wire 
       illegalk = ((!ei & (((!fi | (((!ei | !hi) | !gi) | !l31)) & (ki | !l22)) & ki)) | ((((!fi | (((!ei | !hi) | !gi) | !l31)) & (ki | !l22)) & ki) & (!ci | (bi | ai)))) | ((ki & !di) & (!fi | (((!ei | !hi) | !gi) | !l31)));
  wire 
       compls6 = (((dispin | !dispin) & (pd1s6 | dispin)) & (nd1s6 | !dispin)) & (pd1s6 | nd1s6);
  wire 
       disp6 = (((ndos6 | (pdos6 & ~dispin)) & ~dispin) | dispin) & (~(ndos6 | pdos6) | ((ndos6 | (pdos6 & ~dispin)) & ~dispin));
  wire  compls4 = (nd1s4 & disp6) | (pd1s4 & !disp6);

  assign dispout = disp6 ^ (ndos4 | pdos4);
  assign dataout = {(compls4 & ~jo) | (((~compls4 | ~jo) & jo) & ~compls4),compls4 ^ ho,(compls4 & ~go) | (~compls4 & go),(~fo & compls4) | (~compls4 & fo),compls6 ^ io,((compls6 & ~eo) | ~compls6) & ((~compls6 & eo) | compls6),do ^ compls6,(compls6 & ((compls6 & ~co) | ~compls6)) | (~compls6 & co),(~bo & compls6) | (bo & ~compls6),compls6 ^ ao};
endmodule

