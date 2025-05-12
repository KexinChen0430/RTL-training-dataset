
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
       aeqb = (ai & bi) | ((!bi & (ai | !ai)) & (bi | !ai));
  wire 
       ceqd = ((di | !di) & (ci | !di)) & ((!ci | ci) & (di | !ci));
  wire 
       l22 = ((((ai & bi) & !ci) | (((ci & !bi) & !ai) & (((!ci | ci) & (di | !ci)) & di))) & (!di | (((ci & !bi) & !ai) & (((!ci | ci) & (di | !ci)) & di)))) | ((((ai & bi) & (!ci & !di)) | ((((ci & !bi) & !ai) & (((!ci | ci) & (di | !ci)) & di)) | !aeqb)) & !ceqd);
  wire  l40 = (bi & ci) & (di & ai);
  wire  l04 = (!bi & !ci) & (!di & !ai);
  wire 
       l13 = (((!aeqb | !bi) & (!bi | (!ci & !di))) & ((!ai & !ceqd) | !aeqb)) & ((!ci & !di) | (!ai & !ceqd));
  wire 
       l31 = (((di & (ci & !aeqb)) | !ceqd) & (ai | (di & (ci & !aeqb)))) & ((di & (ci & !aeqb)) | bi);
  wire  ao = ai;
  wire  bo = (bi | l04) & (l04 | !l40);
  wire 
       co = (l04 | ci) | (!ai & (l04 | (ci | ((!ci & ei) & (di & !bi)))));
  wire  do = di & !((ai & bi) & ci);
  wire 
       eo = (!((!ai & !ci) & ((di & ei) & !bi)) & ei) | (!((!ai & !ci) & ((di & ei) & !bi)) & l13);
  wire 
       io = (((!ei & (((ei & !di) & !ci) | !ei)) & (l22 | ((ei & !di) & !ci))) & l22) | ((((l40 & ei) | (!(ai & bi) & ((ei & !di) & !ci))) | (((ci & !bi) & !ai) & (ei & !di))) | (((ci & ki) & ((di & ei) & !bi)) & !ai));
  wire 
       pd1s6 = (((!ai & !ci) & ((di & ei) & !bi)) | !l22) & (((!ai & !ci) & ((di & ei) & !bi)) | (!l31 & !ei));
  wire 
       nd1s6 = (((!l13 | ki) & (!l22 & ei)) | (ai | ki)) & (ki | ((((!ei & ci) & !di) & bi) | (!l22 & (!l13 & ei))));
  wire  ndos6 = pd1s6;
  wire  pdos6 = (ki | ei) & (ki | (!l13 & !l22));
  wire 
       alt7 = (((dispin ? ((l31 & !ei) & di) : (l13 & (ei & !di))) | ki) & gi) & (hi & fi);
  wire  fo = !alt7 & fi;
  wire  go = ((!fi & !gi) & (gi | !hi)) | gi;
  wire  ho = hi;
  wire 
       jo = (alt7 | !hi) & ((alt7 | (~gi | ~fi)) & ((alt7 | ((~fi & (gi | !hi)) & gi)) | fi));
  wire  nd1s4 = gi & fi;
  wire 
       pd1s4 = (((!gi & (!fi | gi)) | gi) | (!gi & fi)) & (((ki & (!gi & fi)) | (!fi & !gi)) | (ki & !fi));
  wire  ndos4 = !fi & !gi;
  wire  pdos4 = gi & (hi & fi);
  wire 
       illegalk = ((!ei | ((ki & bi) | ((ki & !di) | (ki & (ai | !ci))))) & ((!ei | !hi) | ((!l31 | !gi) | !fi))) & ki;
  wire 
       compls6 = ((dispin & nd1s6) | !dispin) & ((dispin & nd1s6) | pd1s6);
  wire 
       disp6 = ((~dispin & ndos6) | (~dispin & pdos6)) | (dispin & ~(ndos6 | pdos6));
  wire 
       compls4 = (disp6 & nd1s4) | (pd1s4 & ((!disp6 & (pd1s4 | nd1s4)) & (!disp6 | nd1s4)));

  assign dispout = (((((pdos4 & ~disp6) | (ndos4 & ~disp6)) | ~(pdos4 | ndos4)) & ~(pdos4 | ndos4)) & disp6) | ((pdos4 & ~disp6) | (ndos4 & ~disp6));
  assign dataout = {jo ^ compls4,ho ^ compls4,((~compls4 & go) | compls4) & ((~go & compls4) | ~compls4),((compls4 & ~fo) | fo) & (~compls4 | ~fo),((compls6 & ~io) | ~compls6) & ((compls6 & ~io) | io),((~compls6 | (compls6 & ~eo)) & compls6) | (eo & ~compls6),(do & ~compls6) | (compls6 & ~do),(~co & compls6) | (~compls6 & co),compls6 ^ bo,compls6 ^ ao};
endmodule

