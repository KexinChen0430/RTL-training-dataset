
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
  wire  aeqb = (((!bi & !ai) | bi) & ai) | (!bi & !ai);
  wire  ceqd = (ci | (!di & !ci)) & (di | (!di & !ci));
  wire 
       l22 = ((!ceqd & !aeqb) | (((!ci & ai) & bi) & !di)) | ((ci & (di & ((ci | !ci) & (!ci | di)))) & (!bi & !ai));
  wire 
       l40 = bi & (ai & (ci & (di & ((ci | !ci) & (!ci | di)))));
  wire  l04 = (!ai & (!ci & !bi)) & !di;
  wire 
       l13 = ((((!di & !ci) | (!ai & !ceqd)) & (!aeqb | (!ai & !ceqd))) & (!bi | !di)) & (!bi | (!aeqb & !ci));
  wire 
       l31 = (((!aeqb & di) | bi) & (ci | bi)) & (((!ceqd & ai) | ci) & ((!ceqd & ai) | (!aeqb & di)));
  wire  ao = ai;
  wire  bo = (!l40 | l04) & (l04 | bi);
  wire 
       co = ((((!bi & (di & ei)) & !ci) | ci) | l04) & ((ci | l04) | !ai);
  wire  do = di & !(ai & (bi & ci));
  wire 
       eo = !(((((!bi & (di & ei)) & !ci) & (!bi | (!l22 & !ei))) & ((!l22 & !ei) | ((ei & (!ci & di)) & !ai))) & !ai) & (ei | l13);
  wire 
       io = (!ai & ((((!bi & !ai) & ei) & (ci & !di)) | (ci & (!bi & (ki & (di & ei)))))) | (((((!di & !((((!bi | ai) & (bi | !bi)) & bi) & ai)) & ei) & !ci) | ((l22 & ((!ei & (l22 | ((!ci & ei) & !di))) & (((!ci & ei) & !di) | !ei))) | l40)) & (((!ei | ei) & (ei | l22)) | (!ai & ((((!bi & !ai) & ei) & (ci & !di)) | (ci & (!bi & (ki & (di & ei))))))));
  wire 
       pd1s6 = ((ei & (!ci & di)) | ((!l22 & !ei) & !l31)) & (((!l22 & !ei) & !l31) | (!bi & !ai));
  wire 
       nd1s6 = ((((ai & (!ei & (bi & ci))) & !di) | (ki & (bi | (ai | (!ci | !di))))) | ki) | ((!l13 | ki) & (!l22 & ei));
  wire  ndos6 = pd1s6;
  wire  pdos6 = ((!l13 | ki) & (!l22 | ki)) & (ei | ki);
  wire 
       alt7 = (((dispin ? ((l31 & di) & !ei) : ((ei & !di) & l13)) & fi) & (hi & gi)) | ((gi & ki) & (fi & hi));
  wire  fo = fi & !alt7;
  wire  go = (!gi | gi) & (gi | (!fi & !hi));
  wire  ho = hi;
  wire 
       jo = (((~(fi & !hi) & gi) & !hi) | alt7) | ((~((!hi & (!gi | gi)) & gi) & fi) & !hi);
  wire  nd1s4 = gi & fi;
  wire 
       pd1s4 = (ki & ((gi & !fi) | (((!gi & ((!gi | !fi) & (!fi | fi))) & !fi) | ((((!gi | !fi) & (!fi | fi)) & fi) & (!gi & ((!gi | !fi) & (!fi | fi))))))) | ((!gi & ((!gi | !fi) & (!fi | fi))) & !fi);
  wire  ndos4 = (!gi & ((!gi | !fi) & (!fi | fi))) & !fi;
  wire  pdos4 = (hi & gi) & fi;
  wire 
       illegalk = (((bi | (ai | (!ci | !di))) & ((!l31 | !ei) | ((!gi | !hi) | !fi))) & ki) | (!ei & ((((!l31 | !ei) | ((!gi | !hi) | !fi)) & (!l22 | ki)) & ki));
  wire 
       compls6 = ((nd1s6 & dispin) | !dispin) & ((nd1s6 & dispin) | pd1s6);
  wire 
       disp6 = (dispin | ((pdos6 & ~dispin) | (~dispin & ndos6))) & (~dispin | (dispin & ~(ndos6 | pdos6)));
  wire 
       compls4 = (((pd1s4 & (pd1s4 | nd1s4)) & (nd1s4 | !disp6)) & !disp6) | (((!disp6 | disp6) & (disp6 | pd1s4)) & nd1s4);

  assign dispout = ((ndos4 | pdos4) & ~disp6) | (((~(ndos4 | pdos4) | ~disp6) & disp6) & ~(ndos4 | pdos4));
  assign dataout = {(((compls4 & ~jo) | ~compls4) & compls4) | (jo & ~compls4),(compls4 | (~compls4 & ho)) & (~compls4 | ~ho),(go | (compls4 & ~go)) & (~compls4 | (compls4 & ~go)),(compls4 & (~compls4 | ~fo)) | (~compls4 & fo),io ^ compls6,compls6 ^ eo,compls6 ^ do,((~co & compls6) | co) & (~compls6 | ~co),((~bo & compls6) | ~compls6) & ((~bo & compls6) | bo),(~compls6 & ao) | ((~ao | ~compls6) & compls6)};
endmodule

