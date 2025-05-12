
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
       aeqb = (!ai | (bi & ai)) & ((!bi | ai) & (!bi | bi));
  wire  ceqd = (ci & di) | (!ci & !di);
  wire 
       l22 = ((!bi | ((!ci & !di) & (bi & ai))) & ((((!ci & !di) & (bi & ai)) | (di & !ai)) & (((!ci & !di) & (bi & ai)) | ci))) | (!ceqd & !aeqb);
  wire  l40 = (ci & (bi & di)) & ai;
  wire 
       l04 = ((!ci & !di) & (bi | (!ai & !bi))) & (!ai & !bi);
  wire 
       l13 = ((((!ci & !di) | !bi) & (!aeqb | !bi)) & (!ci | (!ceqd & !ai))) & ((!aeqb & !di) | (!ceqd & !ai));
  wire 
       l31 = ((!aeqb & (ci & di)) | ai) & ((bi & !ceqd) | (!aeqb & (ci & di)));
  wire  ao = ai;
  wire  bo = (!l40 & bi) | l04;
  wire 
       co = ((!ai | (ci | l04)) & (ci | (!bi | l04))) & ((!ci & (ei & di)) | (ci | l04));
  wire  do = !((bi & ai) & ci) & di;
  wire 
       eo = ((l13 & !((!ci & (ei & di)) & (!ai & !bi))) | ei) & !((!ci & (ei & di)) & (!ai & !bi));
  wire 
       io = ((((ei & !ci) & !di) & ((!ei | !(bi & ai)) & (l22 | !(bi & ai)))) | ((ei & l40) | (!ei & l22))) | (!ai & (((!bi & di) & (ci & ((ei & ((((!l13 & !l22) & ei) | ((!ei & ((!di & ((ci | (!bi | l04)) & ((!ci & (ei & di)) | (ci | l04)))) & ci)) | ki)) & (bi | (ki | ((!l13 & !l22) & ei))))) & ki))) | ((!bi & (!di & ei)) & (!ai & ci))));
  wire 
       pd1s6 = (!l31 & (!l22 & !ei)) | ((!ci & (ei & di)) & (!ai & !bi));
  wire 
       nd1s6 = ((!l13 | ki) | ((bi & ai) & (!ei & ((!di & ((ci | (!bi | l04)) & ((!ci & (ei & di)) | (ci | l04)))) & ci)))) & (((((bi & ai) & (!ei & ((!di & ((ci | (!bi | l04)) & ((!ci & (ei & di)) | (ci | l04)))) & ci))) | ki) | ei) & (((bi & ai) & (!ei & ((!di & ((ci | (!bi | l04)) & ((!ci & (ei & di)) | (ci | l04)))) & ci))) | (!l22 | ki)));
  wire  ndos6 = pd1s6;
  wire  pdos6 = ki | ((!l13 & !l22) & ei);
  wire 
       alt7 = (hi & (((ki & ((((!ci | ai) | bi) & ki) | !di)) | (dispin ? (((di & l31) & (!ei | (((!fi | !gi) | !hi) | !l31))) & !ei) : ((ei & l13) & !di))) | ki)) & ((fi & (gi | !fi)) & gi);
  wire  fo = fi & !alt7;
  wire  go = (gi | ((gi | !gi) & !fi)) & (!hi | gi);
  wire  ho = hi;
  wire 
       jo = alt7 | ((!hi & ((((~fi & (gi | ((gi | !gi) & !fi))) & gi) | alt7) | ~gi)) & ((fi | ((~fi & (gi | ((gi | !gi) & !fi))) & gi)) | alt7));
  wire  nd1s4 = (fi & (gi | !fi)) & gi;
  wire 
       pd1s4 = (((!gi & ki) | (((((fi | (gi & !fi)) & !gi) | (((gi | !gi) & !fi) & (gi | !fi))) & !fi) & !gi)) & (fi | (((((fi | (gi & !fi)) & !gi) | (((gi | !gi) & !fi) & (gi | !fi))) & !fi) & !gi))) | ((ki | (((!gi & ki) | (((((fi | (gi & !fi)) & !gi) | (((gi | !gi) & !fi) & (gi | !fi))) & !fi) & !gi)) & (fi | (((((fi | (gi & !fi)) & !gi) | (((gi | !gi) & !fi) & (gi | !fi))) & !fi) & !gi)))) & (gi & !fi));
  wire 
       ndos4 = ((((fi | (gi & !fi)) & !gi) | (((gi | !gi) & !fi) & (gi | !fi))) & !fi) & !gi;
  wire 
       pdos4 = gi & ((fi & hi) | (((fi & (gi | !fi)) & gi) & (ki & hi)));
  wire 
       illegalk = (!ei | (((!di | bi) | (!ci | ai)) & (!ei | (((!fi | !gi) | !hi) | !l31)))) & ki;
  wire 
       compls6 = (((!dispin | nd1s6) & (nd1s6 | pd1s6)) & (pd1s6 | dispin)) & (dispin | !dispin);
  wire 
       disp6 = ((~dispin & ndos6) | (pdos6 & ~dispin)) | (((~(pdos6 | ndos6) | ((~dispin & ndos6) | (pdos6 & ~dispin))) & ~(pdos6 | ndos6)) & dispin);
  wire 
       compls4 = (!disp6 | (disp6 & nd1s4)) & (pd1s4 | (disp6 & nd1s4));

  assign dispout = ((ndos4 | pdos4) & (~(ndos4 | pdos4) | ~disp6)) | (~(ndos4 | pdos4) & disp6);
  assign dataout = {(~jo | ~compls4) & (jo | (compls4 & ~jo)),(ho & ~compls4) | (~ho & compls4),(~go | ~compls4) & (compls4 | (((~go | ~compls4) & go) & ~compls4)),(~compls4 & fo) | (compls4 & ~fo),compls6 ^ io,(~compls6 & eo) | ((~eo | (~compls6 & eo)) & compls6),(compls6 | (do & ~compls6)) & (~do | ~compls6),(~co | (co & ~compls6)) & (compls6 | (co & ~compls6)),(~compls6 & bo) | (((~compls6 & bo) | ~bo) & compls6),(compls6 & ~ao) | (~compls6 & ao)};
endmodule

