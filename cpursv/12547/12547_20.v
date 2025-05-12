
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
  wire  aeqb = (bi & ai) | (!ai & !bi);
  wire 
       ceqd = ((di | !di) & (!di | ci)) & ((!ci | di) & (!ci | ci));
  wire 
       l22 = (!ceqd & ((!aeqb | ((((!ai & ((l04 | ci) | !bi)) & (ci | (l04 | ((ei & di) & !ci)))) & ci) & (!bi & di))) | ((bi & (!ci & ai)) & (!di | ((((!ai & ((l04 | ci) | !bi)) & (ci | (l04 | ((ei & di) & !ci)))) & ci) & (!bi & di)))))) | ((((!ceqd | ((!di & bi) & (!ci & ai))) | ((((!ai & ((l04 | ci) | !bi)) & (ci | (l04 | ((ei & di) & !ci)))) & ci) & (!bi & di))) & (((((!ai & ((l04 | ci) | !bi)) & (ci | (l04 | ((ei & di) & !ci)))) & ci) & (!bi & di)) | ((!di & bi) & ai))) & (!ci | ((((!ai & ((l04 | ci) | !bi)) & (ci | (l04 | ((ei & di) & !ci)))) & ci) & (!bi & di))));
  wire  l40 = (ci & ai) & (bi & di);
  wire  l04 = (!ci & !ai) & (!di & !bi);
  wire 
       l13 = (((!ceqd & !ai) | !ci) & ((!di & !aeqb) | (!ceqd & !ai))) & (!bi | (((((!ceqd & !ai) | !ci) & ((!di & !aeqb) | (!ceqd & !ai))) & (!di & (((!ceqd & !ai) | !ci) & ((!di & !aeqb) | (!ceqd & !ai))))) & (!ci & !aeqb)));
  wire 
       l31 = (di | ((ai & !ceqd) & bi)) & ((!aeqb & ci) | ((ai & !ceqd) & bi));
  wire  ao = ai;
  wire  bo = (bi | l04) & (l04 | !l40);
  wire 
       co = (((!ai & !bi) | (l04 | ci)) & ((l04 | ci) | di)) & ((l04 | ci) | (ei & !ci));
  wire  do = di & !(bi & (ci & ai));
  wire 
       eo = (ei | l13) & !((!ai & ei) & ((!bi & di) & !ci));
  wire 
       io = ((((((l22 & (((!di & (ei & !ci)) & !(bi & ai)) | !ei)) | ((ki & ((ci & !bi) & (ei & di))) | ((!di & (ei & !ci)) & !(bi & ai)))) | ((ei & (l40 | ((!di & (ei & !ci)) | (((((((!(bi & ai) | l22) & (!ei | !(bi & ai))) | ei) & (l22 | ei)) & (ei | !ei)) & !ei) & ((l22 & (l22 | (!di & (ei & !ci)))) & ((!di & (ei & !ci)) | !ei)))))) & (l40 | ((!(bi & ai) | l22) & (!ei | !(bi & ai)))))) & ((((!di & (ei & !ci)) & !(bi & ai)) | l22) | l40)) & ((((!di & (ei & !ci)) & !(bi & ai)) | !ei) | l40)) & ((((((!(bi & ai) | l22) & (!ei | !(bi & ai))) | ei) & (l22 | ei)) & (ei | !ei)) & (((l22 & (((!di & (ei & !ci)) & !(bi & ai)) | !ei)) | ((ki & ((ci & !bi) & (ei & di))) | ((!di & (ei & !ci)) & !(bi & ai)))) | ((ei & (l40 | ((!di & (ei & !ci)) | (((((((!(bi & ai) | l22) & (!ei | !(bi & ai))) | ei) & (l22 | ei)) & (ei | !ei)) & !ei) & ((l22 & (l22 | (!di & (ei & !ci)))) & ((!di & (ei & !ci)) | !ei)))))) & (l40 | ((!(bi & ai) | l22) & (!ei | !(bi & ai)))))))) | (((((ci & (!bi & ei)) & !di) & !ai) | (ki & ((ci & !bi) & (ei & di)))) & !ai);
  wire 
       pd1s6 = (((!ai & ei) & ((!bi & di) & !ci)) | !ei) & (((!ai & ei) & ((!bi & di) & !ci)) | (!l31 & !l22));
  wire 
       nd1s6 = (((ki | !l13) & ((((ki & ki) & ((ai | bi) | (!di | !ci))) | ei) | ki)) & ((((ki & ki) & ((ai | bi) | (!di | !ci))) | !l22) | ki)) | ((((ki | ai) | ((ki | !l13) & (ei & !l22))) & ci) & (!ei & (!di & bi)));
  wire  ndos6 = pd1s6;
  wire 
       pdos6 = ((ki | !l13) & ((((ki & ki) & ((ai | bi) | (!di | !ci))) | ei) | ki)) & ((((ki & ki) & ((ai | bi) | (!di | !ci))) | !l22) | ki);
  wire 
       alt7 = gi & ((hi & (ki | (dispin ? (l31 & (di & !ei)) : (!di & (l13 & ei))))) & fi);
  wire  fo = !alt7 & fi;
  wire  go = (gi | !fi) & ((!gi & !hi) | gi);
  wire  ho = hi;
  wire 
       jo = (!hi & (fi & ~gi)) | ((((~fi & !hi) & (!gi | gi)) & gi) | alt7);
  wire  nd1s4 = (fi & (!gi | gi)) & gi;
  wire 
       pd1s4 = (((!fi | ((!gi & fi) | ((((!gi | ki) & (ki | !fi)) & !gi) & ((!fi & (ki | !fi)) & (!gi | ki))))) & gi) & ((!gi | ki) & (ki | !fi))) | (((((!gi | ki) & (ki | !fi)) & !gi) & ((fi & (!gi | !fi)) & (!fi | fi))) | ((((!gi | ki) & (ki | !fi)) & !gi) & ((!fi & (ki | !fi)) & (!gi | ki))));
  wire 
       ndos4 = (((!gi | ki) & (ki | !fi)) & !gi) & ((!fi & (ki | !fi)) & (!gi | ki));
  wire  pdos4 = gi & (hi & fi);
  wire 
       illegalk = ((((!ei | ((!hi | !fi) | !l31)) | !gi) & (((((ki & ki) & ((ai | bi) | (!di | !ci))) | ei) | ki) & ((((ki & ki) & ((ai | bi) | (!di | !ci))) | !l22) | ki))) & ki) & (((!ei | (!di | !ci)) | ai) | bi);
  wire 
       compls6 = ((pd1s6 | nd1s6) & (!dispin | nd1s6)) & ((dispin | !dispin) & (pd1s6 | dispin));
  wire  disp6 = dispin ^ (ndos6 | pdos6);
  wire 
       compls4 = ((!disp6 & pd1s4) | disp6) & ((pd1s4 | nd1s4) & (nd1s4 | !disp6));

  assign dispout = disp6 ^ (ndos4 | pdos4);
  assign dataout = {(compls4 & ~jo) | (~compls4 & jo),ho ^ compls4,compls4 ^ go,compls4 ^ fo,io ^ compls6,(eo & ~compls6) | (~eo & compls6),(~compls6 | ~do) & (do | (~do & compls6)),((co & ~compls6) | compls6) & (~co | ~compls6),(compls6 | ((((~bo & compls6) | ~compls6) & ~compls6) & bo)) & ((~bo & compls6) | ~compls6),compls6 ^ ao};
endmodule

