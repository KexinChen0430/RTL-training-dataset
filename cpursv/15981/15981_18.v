
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
  wire  aeqb = ((!bi & !ai) | ai) & (bi | (!bi & !ai));
  wire 
       ceqd = ((!ci | di) & (!ci | ci)) & ((!di | di) & (!di | ci));
  wire 
       l22 = ((((di & !ai) & ci) & (((!ci & ((((bi | !bi) & (ai | !bi)) & bi) & ai)) | !bi) & (!di | !bi))) | (!aeqb & !ceqd)) | ((((((bi | !bi) & (ai | !bi)) & bi) & ai) & !di) & !ci);
  wire 
       l40 = (((((bi | !bi) & (ai | !bi)) & bi) & ai) & ((!ci | di) & (!ci | ci))) & ((ci & ((!ci | di) & (!ci | ci))) & (((!ci | di) & (!ci | ci)) & di));
  wire  l04 = (!ai & !ci) & (!di & !bi);
  wire 
       l13 = (((!aeqb | !bi) & (!bi | (!di & !ci))) & ((!ceqd & !ai) | !aeqb)) & ((!di & !ci) | (!ceqd & !ai));
  wire 
       l31 = (ai | (((di & ((di & !aeqb) | (!ceqd & ai))) & (ci | (!ceqd & ai))) & (!aeqb & ci))) & ((!ceqd & bi) | (((di & ((di & !aeqb) | (!ceqd & ai))) & (ci | (!ceqd & ai))) & (!aeqb & ci)));
  wire  ao = ai;
  wire  bo = (!l40 | l04) & (l04 | bi);
  wire 
       co = ((((l04 | ci) | ((!bi & ((ei & di) | (l04 | ci))) & ((l04 | ci) | !ci))) & !ai) | l04) | ci;
  wire  do = !((ci & ai) & bi) & di;
  wire 
       eo = !(!ai & ((!ci & (!bi & ei)) & di)) & (l13 | ei);
  wire 
       io = (((l22 & ((!ei & ((ei & (!di & !ci)) | !ei)) & ((ei & (!di & !ci)) | l22))) | (!di & (ei & !((((bi | !bi) & (ai | !bi)) & bi) & ai)))) & ((l22 & ((!ei & ((ei & (!di & !ci)) | !ei)) & ((ei & (!di & !ci)) | l22))) | !ci)) | (((ei & (l22 | (l40 | ((ei & (!di & !ci)) & !((((bi | !bi) & (ai | !bi)) & bi) & ai))))) & (l40 | (((ei & (!di & !ci)) & !((((bi | !bi) & (ai | !bi)) & bi) & ai)) | !ei))) | ((!bi & !ai) & ((((ei & ((l04 | ci) | ((!bi & ((ei & di) | (l04 | ci))) & ((l04 | ci) | !ci)))) & ci) & ((di & (ki | !l13)) & ki)) | ((ci & !ai) & ((!bi & ei) & !di)))));
  wire 
       pd1s6 = (!bi | (!l31 & (!l22 & !ei))) & (((di & (ei & !ci)) & !ai) | (!l31 & (!l22 & !ei)));
  wire 
       nd1s6 = (((ei & !l22) & (ki | !l13)) | (ki | (((fi & ki) & ((!gi & (!l22 | ki)) & ki)) | ai))) & ((((ei & !l22) & (ki | !l13)) | ki) | (((bi & !di) & !ei) & ci));
  wire  ndos6 = pd1s6;
  wire  pdos6 = ((ei & !l22) & (ki | !l13)) | ki;
  wire 
       alt7 = (gi & (hi & fi)) & ((((fi & ki) & ((!gi & (!l22 | ki)) & ki)) | ((((hi & fi) & (dispin ? ((!ei & di) & l31) : (l13 & (!di & ei)))) & ((!fi & (!gi | gi)) | gi)) & gi)) | ki);
  wire  fo = fi & !alt7;
  wire  go = (gi | !hi) & ((!fi & (!gi | gi)) | gi);
  wire  ho = hi;
  wire 
       jo = ((!hi | alt7) & ((fi | (~fi & gi)) | alt7)) & (~gi | (alt7 | (~fi & gi)));
  wire  nd1s4 = gi & fi;
  wire 
       pd1s4 = ((((!fi | (!gi & fi)) & ki) & ((!fi & (!gi | gi)) | gi)) & gi) | ((((!gi & !fi) | (!gi & fi)) & (!gi | ki)) & (ki | !fi));
  wire  ndos4 = !gi & !fi;
  wire  pdos4 = gi & (hi & fi);
  wire 
       illegalk = ((((!l31 | !ei) | (!hi | (!fi | !gi))) & !di) | (((!l31 | !ei) | (!hi | (!fi | !gi))) & ((!ei | ai) | (!ci | bi)))) & ki;
  wire 
       compls6 = ((nd1s6 | !dispin) & (pd1s6 | nd1s6)) & (dispin | (pd1s6 & !dispin));
  wire  disp6 = dispin ^ (pdos6 | ndos6);
  wire 
       compls4 = ((((disp6 | !disp6) & (disp6 | pd1s4)) & !disp6) & (pd1s4 & ((nd1s4 | pd1s4) & (nd1s4 | !disp6)))) | (disp6 & ((nd1s4 | pd1s4) & (nd1s4 | !disp6)));

  assign dispout = (ndos4 | pdos4) ^ disp6;
  assign dataout = {compls4 ^ jo,ho ^ compls4,go ^ compls4,((~compls4 & fo) | compls4) & (~compls4 | ~fo),(((~compls6 | ~io) & io) & ~compls6) | ((~compls6 | ~io) & compls6),(compls6 | (((~compls6 | ~eo) & eo) & ~compls6)) & (~compls6 | ~eo),do ^ compls6,(compls6 | (~compls6 & co)) & ((~compls6 & co) | ~co),(~compls6 | (~bo & compls6)) & ((~bo & compls6) | bo),ao ^ compls6};
endmodule

