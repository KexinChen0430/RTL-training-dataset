
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
  wire  aeqb = ((!bi & !ai) | bi) & ((!bi & !ai) | ai);
  wire 
       ceqd = ((ci | !ci) & (di | !ci)) & ((ci | !di) & (di | !di));
  wire 
       l22 = (!ceqd & !aeqb) | (((ai & bi) & (!di & !ci)) | ((di & (!bi & ci)) & !ai));
  wire 
       l40 = (ci & (ai & bi)) & ((di & (di | !ci)) & (ci | !ci));
  wire  l04 = (!di & !ci) & (!bi & !ai);
  wire 
       l13 = ((!ceqd & !ai) & !bi) | ((((!ceqd & !ai) & !bi) | (!aeqb & !ci)) & !di);
  wire 
       l31 = (((!aeqb & (((((di & ei) & !ci) & !bi) | l04) | ci)) & ci) & (((ai & bi) & !ceqd) | di)) | ((ai & bi) & !ceqd);
  wire  ao = ai;
  wire  bo = (!l40 & (l04 | bi)) | l04;
  wire 
       co = (((((di & ei) & !ci) & !bi) | l04) | ci) & (!ai | (ci | l04));
  wire  do = !(ci & (ai & bi)) & di;
  wire 
       eo = (l13 & !(di & (((!ci & ei) & !ai) & !bi))) | (ei & !(di & (((!ci & ei) & !ai) & !bi)));
  wire 
       io = ((((((!ei & (((!di & !ci) & ei) | l22)) & (((!di & !ci) & ei) | !ei)) & l22) | (((!bi & !di) & (ci & ei)) & !ai)) | ((!(ai & bi) & (!di & !ci)) & ei)) | (((l40 | (((!ei & (((!di & !ci) & ei) | l22)) & (((!di & !ci) & ei) | !ei)) & l22)) | (((l22 | !(ai & bi)) & (!(ai & bi) | !ei)) & ((!di & !ci) & ei))) & ei)) | ((((ci & ((ei & !l22) | ki)) & ki) & (di & ei)) & (!bi & !ai));
  wire 
       pd1s6 = (di & (((!ci & ei) & !ai) & !bi)) | (((!l31 & ((!l31 | (!gi | (!fi | !hi))) | !ei)) & !ei) & !l22);
  wire 
       nd1s6 = ((((ci & !di) & !ei) | (((ei & !l22) | ki) & !l13)) | ki) & (((ai | ki) | ((((ki | (bi & ((ci & !di) & !ei))) | (((ei & !l22) | ki) & !l13)) & (ei & !l22)) & !l13)) & (((((ki | (bi & ((ci & !di) & !ei))) | (((ei & !l22) | ki) & !l13)) & (ei & !l22)) & !l13) | (ki | bi)));
  wire  ndos6 = pd1s6;
  wire 
       pdos6 = (((ki | (bi & ((ci & !di) & !ei))) | (((ei & !l22) | ki) & !l13)) & ((ki | !l13) & ((ki | (bi & ((ci & !di) & !ei))) | (((ei & !l22) | ki) & !l13)))) & ((ei & !l22) | ki);
  wire 
       alt7 = (((ki | (dispin ? ((di & !ei) & l31) : ((ei & l13) & !di))) & (!hi | gi)) & gi) & (hi & fi);
  wire  fo = !alt7 & fi;
  wire  go = (gi | !gi) & ((!hi | gi) & (gi | !fi));
  wire  ho = hi;
  wire 
       jo = ((~gi & (!hi & fi)) | alt7) | (!hi & ((~fi & (gi | ((gi | !gi) & !fi))) & gi));
  wire  nd1s4 = fi & gi;
  wire 
       pd1s4 = (((!gi & ki) & fi) | (((!gi & (!gi | !fi)) & (fi | !fi)) & !fi)) | (((((gi | !gi) & !fi) & gi) & (ki | !gi)) & (ki | !fi));
  wire  ndos4 = ((!gi & (!gi | !fi)) & (fi | !fi)) & !fi;
  wire  pdos4 = ((hi & fi) & (gi | !fi)) & gi;
  wire 
       illegalk = (!l31 & ((!ei & (((!l31 | (!gi | (!fi | !hi))) | !ei) & ki)) | (((ki & (!di | ((ai | !ci) | bi))) | ((((!gi | (!fi | !hi)) | ((!ei & (((!l31 | (!gi | (!fi | !hi))) | !ei) & ki)) & ((ki & !ci) | (((((bi | !di) | ai) & ((ei & !l22) | ki)) & ki) | !ei)))) & ki) & ((ki & !ci) | (((((bi | !di) | ai) & ((ei & !l22) | ki)) & ki) | !ei)))) | ((!ei & (((!l31 | (!gi | (!fi | !hi))) | !ei) & ki)) & ((ki & !ci) | (((((bi | !di) | ai) & ((ei & !l22) | ki)) & ki) | !ei)))))) | ((((!gi | (!fi | !hi)) | ((!ei & (((!l31 | (!gi | (!fi | !hi))) | !ei) & ki)) & ((ki & !ci) | (((((bi | !di) | ai) & ((ei & !l22) | ki)) & ki) | !ei)))) & ki) & ((ki & !ci) | (((((bi | !di) | ai) & ((ei & !l22) | ki)) & ki) | !ei)));
  wire 
       compls6 = ((!dispin & pd1s6) | dispin) & ((nd1s6 | !dispin) & (nd1s6 | pd1s6));
  wire  disp6 = (ndos6 | pdos6) ^ dispin;
  wire 
       compls4 = (disp6 & nd1s4) | ((!disp6 | (disp6 & nd1s4)) & pd1s4);

  assign dispout = ((~disp6 & pdos4) | (disp6 & ~(ndos4 | pdos4))) | (ndos4 & ~disp6);
  assign dataout = {(~jo & compls4) | (jo & ~compls4),ho ^ compls4,(~compls4 & go) | (~go & compls4),(((~compls4 | ~fo) & fo) & ~compls4) | (compls4 & (~compls4 | ~fo)),(io | (~io & compls6)) & (~compls6 | (~io & compls6)),(compls6 & ~eo) | (eo & ~compls6),(compls6 & (~compls6 | ~do)) | (do & ~compls6),compls6 ^ co,(bo | (compls6 & ~bo)) & (~bo | ~compls6),((~ao | (ao & ~compls6)) & compls6) | (ao & ~compls6)};
endmodule

