
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
       aeqb = (((bi & (ai | !ai)) & (bi | !ai)) & ai) | (!ai & !bi);
  wire  ceqd = ((ci | (!ci & !di)) & di) | (!ci & !di);
  wire 
       l22 = (!ceqd & !aeqb) | ((((ai & (ci | (!ci & !di))) & (!ci & !di)) & ((bi & (ai | !ai)) & (bi | !ai))) | (((di & !ai) & !bi) & ci));
  wire  l40 = (di & ai) & (bi & ci);
  wire  l04 = (!ci & !di) & (!ai & !bi);
  wire 
       l13 = ((!bi & ((!ceqd & !ai) | !ci)) & ((!ceqd & !ai) | (!aeqb & !di))) | (!di & (!ci & !aeqb));
  wire 
       l31 = ((((!aeqb & (ci & ((di & (!ci | ci)) & (!ci | di)))) | !ceqd) & (bi | ((!aeqb & (((l04 | ci) | (!bi & (ei & di))) & ((l04 | ci) | !ci))) & ci))) & (di | bi)) & ((!aeqb & (ci & ((di & (!ci | ci)) & (!ci | di)))) | ai);
  wire  ao = ai;
  wire  bo = (l04 | !l40) & (l04 | bi);
  wire 
       co = ((((l04 | !ai) | ci) & ((l04 | ci) | !bi)) & ((ei & !ci) | (l04 | ci))) & ((l04 | ci) | di);
  wire  do = !((bi & ci) & ai) & di;
  wire 
       eo = (ei | (l13 & !(((!ci & !bi) & !ai) & (ei & di)))) & !(((!ci & !bi) & !ai) & (ei & di));
  wire 
       io = ((((((!ei & (l22 | ((!di & ei) & (!(((bi & (ai | !ai)) & (bi | !ai)) & ai) & !ci)))) | (((!ai & ((ei & (ki | !l22)) & ki)) & (ci & (!bi & di))) | ei)) & (((((l22 & ((ei & (!ci & !di)) | l22)) & ((ei & (!ci & !di)) | !ei)) & !ei) | (((!ai & ((ei & (ki | !l22)) & ki)) & (ci & (!bi & di))) | l40)) | ((!di & ei) & (!(((bi & (ai | !ai)) & (bi | !ai)) & ai) & !ci)))) | (!di & ei)) & ((!bi & ci) | (((!ei & (l22 | ((!di & ei) & (!(((bi & (ai | !ai)) & (bi | !ai)) & ai) & !ci)))) | (((!ai & ((ei & (ki | !l22)) & ki)) & (ci & (!bi & di))) | ei)) & (((((l22 & ((ei & (!ci & !di)) | l22)) & ((ei & (!ci & !di)) | !ei)) & !ei) | (((!ai & ((ei & (ki | !l22)) & ki)) & (ci & (!bi & di))) | l40)) | ((!di & ei) & (!(((bi & (ai | !ai)) & (bi | !ai)) & ai) & !ci)))))) & (!(((bi & (ai | !ai)) & (bi | !ai)) & ai) | (!ai | ((!ei | (l40 & ei)) & ((l40 & ei) | l22))))) & ((!ai | ((!ei | (l40 & ei)) & ((l40 & ei) | l22))) | (ei & (!ci & !di)));
  wire 
       pd1s6 = ((((((!ci & !bi) & !ai) & (ei & di)) | !ei) & (!l31 | !bi)) & (((ei & (di & !ci)) & !ai) | !l31)) & ((((!ci & !bi) & !ai) & (ei & di)) | !l22);
  wire 
       nd1s6 = (ki | ((((((bi | ai) | !di) | !ci) & (ki | !l13)) & ki) | (((bi & (ci & !di)) & !ei) & ((ai & (bi | !ai)) & (ai | !ai))))) | ((ki | !l13) & (ei & !l22));
  wire  ndos6 = pd1s6;
  wire  pdos6 = ki | ((ki | !l13) & (ei & !l22));
  wire 
       alt7 = (((dispin ? ((di & !ei) & l31) : ((!di & ei) & l13)) | (((gi & (ki | !l22)) & ki) & (hi & fi))) & gi) & (hi & fi);
  wire  fo = !alt7 & fi;
  wire  go = (!fi | gi) & ((!hi | gi) & (gi | !gi));
  wire  ho = hi;
  wire 
       jo = (alt7 | (~((!hi & (!fi | gi)) & gi) & (fi & !hi))) | ((~(fi & !hi) & !hi) & gi);
  wire  nd1s4 = fi & gi;
  wire 
       pd1s4 = (((!fi & ((gi & (ki | !l22)) & ki)) | ((!gi & (ki | !l22)) & ki)) & ((!fi & ((gi & (ki | !l22)) & ki)) | fi)) | (!gi & ((!fi & (!gi | ki)) & (ki | !fi)));
  wire  ndos4 = !gi & ((!fi & (!gi | ki)) & (ki | !fi));
  wire  pdos4 = hi & (fi & gi);
  wire 
       illegalk = ((((!gi | !fi) | !ei) | (((((!ei | (((bi | ai) | !di) | !ci)) & !l31) & (ki | ei)) & ki) | !hi)) & ki) & (!di | ((!ei & (((!fi | (!ei | ((!l31 | !gi) | !hi))) & (((ki | ((ki | !l13) & (ei & !l22))) | (ki | ((bi & (ci & !di)) & !ei))) | ((!l13 & !l22) & ei))) & ki)) | (bi | (ai | !ci))));
  wire 
       compls6 = (((pd1s6 | nd1s6) & (nd1s6 | !dispin)) & dispin) | (((pd1s6 & (pd1s6 | nd1s6)) & (nd1s6 | !dispin)) & (((pd1s6 | nd1s6) & (nd1s6 | !dispin)) & !dispin));
  wire 
       disp6 = (~(pdos6 | ndos6) & dispin) | (~dispin & (pdos6 | ndos6));
  wire 
       compls4 = (nd1s4 & disp6) | (!disp6 & (pd1s4 | (nd1s4 & disp6)));

  assign dispout = (pdos4 & ~disp6) | ((~disp6 & ndos4) | (disp6 & ~(pdos4 | ndos4)));
  assign dataout = {(compls4 & ~jo) | (((~compls4 | ~jo) & ~compls4) & jo),((compls4 & ~ho) | ~compls4) & ((compls4 & ~ho) | ho),(compls4 & (~go | ~compls4)) | (go & ~compls4),fo ^ compls4,((~io & compls6) | io) & (~io | ~compls6),(~eo | ~compls6) & (eo | (~eo & compls6)),do ^ compls6,(co & ~compls6) | ((~compls6 | ~co) & compls6),((bo & ~compls6) | ~bo) & ((bo & ~compls6) | compls6),((~compls6 & ao) | compls6) & (~ao | ~compls6)};
endmodule

