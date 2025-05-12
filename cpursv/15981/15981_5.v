
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
  wire  aeqb = (ai | (!ai & !bi)) & (bi | (!ai & !bi));
  wire 
       ceqd = ((!di | di) & (!di | ci)) & (!ci | (ci & di));
  wire 
       l22 = ((!di & (((((ai | !ai) & (bi | !ai)) & ((ai & (ai | !ai)) & (bi | !ai))) & bi) & !ci)) | (!aeqb | (((!ai & !bi) & di) & (((!ci | (ci & di)) & (((di & ei) & (!ci & !bi)) | (l04 | ci))) & ci)))) & (!ceqd | (((!di | (((di & !ai) & (((di & ei) & (!ci & !bi)) | (l04 | ci))) & ci)) & ((((di & !ai) & (((di & ei) & (!ci & !bi)) | (l04 | ci))) & ci) | (((((ai | !ai) & (bi | !ai)) & ((ai & (ai | !ai)) & (bi | !ai))) & bi) & !ci))) & ((!bi | (((((ai | !ai) & (bi | !ai)) & ((ai & (ai | !ai)) & (bi | !ai))) & bi) & !ci)) & (!di | !bi))));
  wire  l40 = (ci & bi) & (ai & di);
  wire  l04 = (!ai & !di) & (!ci & !bi);
  wire 
       l13 = (!ai & (!bi & !ceqd)) | ((!di & (((!ceqd & !ai) | !ci) & ((!ceqd & !ai) | (!aeqb & !di)))) & (!aeqb & !ci));
  wire 
       l31 = (((((bi | (!aeqb & ci)) & (bi | di)) & (ci & di)) & !aeqb) | (!ceqd & bi)) & (((((bi | (!aeqb & ci)) & (bi | di)) & (ci & di)) & !aeqb) | ai);
  wire  ao = ai;
  wire  bo = (l04 | bi) & (!l40 | l04);
  wire 
       co = ((l04 | ci) | (!ci & ((di & ei) & !ai))) & ((l04 | ci) | !bi);
  wire 
       do = di & !(bi & ((ai & (((di & ei) & (!ci & !bi)) | (l04 | ci))) & ci));
  wire 
       eo = (!(((di & ei) & (!ci & !bi)) & !ai) & ei) | (!(((di & ei) & (!ci & !bi)) & !ai) & l13);
  wire 
       io = ((((!ai & (((!di & ei) & ci) & !bi)) | ((di & ei) & (ci & ki))) & (!ai & !bi)) | (l22 & !ei)) | (((l40 & ei) | ((!di & !ci) & ei)) & (!((((ai | !ai) & (bi | !ai)) & ((ai & (ai | !ai)) & (bi | !ai))) & bi) | (l40 & ei)));
  wire 
       pd1s6 = ((((!l22 & !ei) | (!ci & ((di & ei) & !ai))) & (!bi | (!l22 & !ei))) & ((!ci & ((di & ei) & !ai)) | !l31)) & (!bi | !l31);
  wire 
       nd1s6 = (ki | (((((ai | !ai) & (bi | !ai)) & ((ai & (ai | !ai)) & (bi | !ai))) & bi) & (((!di & !ei) & (((di & ei) & (!ci & !bi)) | (l04 | ci))) & ci))) | (((ki | !l13) & ei) & !l22);
  wire  ndos6 = pd1s6;
  wire  pdos6 = ki | (!l22 & (!l13 & ei));
  wire 
       alt7 = ((((dispin ? (!ei & (l31 & di)) : (l13 & (!di & ei))) | ki) & (hi & fi)) & ((!gi & !fi) | gi)) & gi;
  wire  fo = fi & !alt7;
  wire  go = ((!gi & !fi) | gi) & (!hi | gi);
  wire  ho = hi;
  wire 
       jo = (!hi | alt7) & (((alt7 | ~gi) | ~fi) & ((fi | (~fi & gi)) | alt7));
  wire  nd1s4 = fi & gi;
  wire 
       pd1s4 = ((((!fi | fi) & (!gi | !fi)) & gi) & ki) | (((fi | (!gi & !fi)) & !gi) & (ki | (!gi & !fi)));
  wire  ndos4 = !gi & !fi;
  wire  pdos4 = fi & (hi & gi);
  wire 
       illegalk = (((!ei | (!gi | !fi)) | ((!l31 & (((ai | !di) | (bi | !ci)) | !ei)) & ki)) | !hi) & (((ki & (!gi | ((!l31 | (!fi | !hi)) | !ei))) & !ei) | ((ki & ki) & (!di | ((ai | (bi | !ci)) & ki))));
  wire  compls6 = (dispin & nd1s6) | (pd1s6 & !dispin);
  wire 
       disp6 = (~(ndos6 | pdos6) & dispin) | ((ndos6 | pdos6) & (~dispin | ~(ndos6 | pdos6)));
  wire 
       compls4 = (((pd1s4 & (nd1s4 | !disp6)) & (pd1s4 | nd1s4)) & !disp6) | (nd1s4 & disp6);

  assign dispout = (disp6 & ~(pdos4 | ndos4)) | (~disp6 & (pdos4 | ndos4));
  assign dataout = {((~compls4 | ~jo) & compls4) | (~compls4 & jo),((~ho & compls4) | ~compls4) & (compls4 | (ho & ~compls4)),(go & ~compls4) | (compls4 & (~compls4 | ~go)),fo ^ compls4,(((~compls6 | ~io) & ~compls6) & io) | (~io & compls6),(compls6 & ~eo) | (~compls6 & eo),do ^ compls6,(~compls6 | (compls6 & ~co)) & ((co & ~compls6) | compls6),(~bo | ~compls6) & ((~compls6 & bo) | compls6),compls6 ^ ao};
endmodule

