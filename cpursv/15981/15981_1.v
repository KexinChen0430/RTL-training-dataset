
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
  wire  aeqb = (!bi & !ai) | (bi & ((!bi & !ai) | ai));
  wire 
       ceqd = (ci & di) | ((!di & (ci | !ci)) & (!ci | di));
  wire 
       l22 = (((!ci & (((ai & bi) | !ai) & ai)) & bi) & ((di & ((ci & ((!bi & !ai) | ai)) & (!bi & !ai))) | !di)) | (((!ceqd & !aeqb) | !bi) & ((!ceqd & !aeqb) | ((!ai & ci) & di)));
  wire  l40 = (ai & bi) & (ci & di);
  wire 
       l04 = ((!bi & !ai) & (ci | (!di & !ci))) & (!di & !ci);
  wire 
       l13 = (!aeqb & (!di & !ci)) | ((((!bi | (!di & !ci)) & (!aeqb | !bi)) & !ai) & !ceqd);
  wire 
       l31 = ((di | bi) & (bi | (ci & !aeqb))) & (((ci & di) | (!ceqd & ai)) & (!aeqb | (!ceqd & ai)));
  wire  ao = ai;
  wire  bo = ((!l40 | l04) & bi) | l04;
  wire 
       co = ci | (l04 | (((!bi & !ai) & ei) & (!ci & di)));
  wire  do = !(ci & (ai & bi)) & di;
  wire 
       eo = (!(((!bi & !ai) & ei) & (!ci & di)) & l13) | (!(((!bi & !ai) & ei) & (!ci & di)) & ei);
  wire 
       io = ((ci | (((((((l22 | (ei & (!di & !ci))) & ((ei & (!di & !ci)) | !ei)) & (!gi | ((!l31 | (!hi | !fi)) | !ei))) & !ei) & l22) | ((((!ei | ei) & (l22 | ei)) & l40) | (!(ai & bi) & ((l22 | (ei & (!di & !ci))) & ((ei & (!di & !ci)) | !ei))))) | ((di & !ai) & ((!bi & ei) & (ki & ci))))) & ((((((((l22 | (ei & (!di & !ci))) & ((ei & (!di & !ci)) | !ei)) & (!gi | ((!l31 | (!hi | !fi)) | !ei))) & !ei) & l22) | ((((!ei | ei) & (l22 | ei)) & l40) | (!(ai & bi) & ((l22 | (ei & (!di & !ci))) & ((ei & (!di & !ci)) | !ei))))) | ((di & !ai) & ((!bi & ei) & (ki & ci)))) | (!bi & (ei & !di)))) & (!ai | (((((((l22 | (ei & (!di & !ci))) & ((ei & (!di & !ci)) | !ei)) & (!gi | ((!l31 | (!hi | !fi)) | !ei))) & !ei) & l22) | ((((!ei | ei) & (l22 | ei)) & l40) | (!(ai & bi) & ((l22 | (ei & (!di & !ci))) & ((ei & (!di & !ci)) | !ei))))) | ((di & !ai) & ((!bi & ei) & (ki & ci)))));
  wire 
       pd1s6 = ((!l22 & !l31) & !ei) | (((!bi & !ai) & ei) & (!ci & di));
  wire 
       nd1s6 = ((ei | ki) & ((ki | !l22) & (!l13 | ki))) | ((bi & !di) & ((ci & !ei) & ai));
  wire  ndos6 = pd1s6;
  wire  pdos6 = (ei | ki) & ((ki | !l22) & (!l13 | ki));
  wire 
       alt7 = (gi & (fi & ((dispin ? (!ei & (l31 & di)) : ((ei & !di) & l13)) | ki))) & hi;
  wire  fo = !alt7 & fi;
  wire  go = (gi | ((!gi | gi) & !fi)) & (gi | !hi);
  wire  ho = hi;
  wire 
       jo = ((~gi & (fi & !hi)) | alt7) | ((gi & ~fi) & !hi);
  wire  nd1s4 = fi & gi;
  wire 
       pd1s4 = ((((((fi | !fi) & (!gi | !fi)) & (ei | ki)) & ki) & (!gi | gi)) & gi) | (((fi & ((!gi & (fi | !fi)) & (!gi | !fi))) | (!fi & ((!gi & (!fi | ki)) & (ki | !gi)))) & ((!fi | ki) & (ki | !gi)));
  wire  ndos4 = !fi & ((!gi & (!fi | ki)) & (ki | !gi));
  wire  pdos4 = (hi & fi) & gi;
  wire 
       illegalk = (((!gi | ((!l31 | (!hi | !fi)) | !ei)) & (ei | ki)) & ki) & ((!ci | (ai | bi)) | (!di | (!ei & ki)));
  wire 
       compls6 = (((pd1s6 & (nd1s6 | !dispin)) & (pd1s6 | nd1s6)) & !dispin) | (dispin & nd1s6);
  wire 
       disp6 = (~(ndos6 | pdos6) & dispin) | ((ndos6 | pdos6) & ~dispin);
  wire 
       compls4 = (nd1s4 & ((pd1s4 & ((!disp6 & (nd1s4 | pd1s4)) & (nd1s4 | !disp6))) | disp6)) | (pd1s4 & ((!disp6 & (nd1s4 | pd1s4)) & (nd1s4 | !disp6)));

  assign dispout = ((disp6 & ~(ndos4 | pdos4)) | (~disp6 & ndos4)) | (pdos4 & ~disp6);
  assign dataout = {(~compls4 & jo) | (compls4 & ~jo),(~ho | (ho & ~compls4)) & (compls4 | (ho & ~compls4)),(~compls4 | (~go & compls4)) & ((~go & compls4) | go),((~fo & compls4) | ~compls4) & ((~fo & compls4) | fo),((~compls6 & io) | compls6) & (~io | ~compls6),((~compls6 | (~eo & compls6)) & compls6) | (eo & ~compls6),compls6 ^ do,co ^ compls6,(~compls6 | (~bo & compls6)) & ((((~compls6 | (~bo & compls6)) & ~compls6) & bo) | compls6),(((~compls6 | (compls6 & ~ao)) & ~compls6) & ao) | (compls6 & ~ao)};
endmodule

