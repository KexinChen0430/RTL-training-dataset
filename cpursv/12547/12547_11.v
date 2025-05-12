
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
  wire  aeqb = (ai | (!ai & !bi)) & ((!ai & !bi) | bi);
  wire  ceqd = (ci & di) | (!di & !ci);
  wire 
       l22 = ((bi & (!di & (!ci & ai))) | ((!ceqd & ((!di | (di & (ci & (!ai & !bi)))) | !aeqb)) & (((di & (ci & (!ai & !bi))) | !aeqb) | (!ci & (bi & ai))))) | (((ci & (di & !ai)) & (!bi | (bi & ai))) & (!bi | (!di & !ci)));
  wire 
       l40 = (ai & di) & ((bi & (((ei & di) | (l04 | ci)) & ((!ci & !bi) | (l04 | ci)))) & ci);
  wire  l04 = (!di & !ci) & (!ai & !bi);
  wire 
       l13 = ((!ceqd & !ai) & ((!bi | !aeqb) & (!bi | (!di & !ci)))) | (!ci & (!di & !aeqb));
  wire 
       l31 = (((!aeqb | bi) & (bi | (ci & di))) & ((!aeqb & ci) | (!ceqd & ai))) & (di | (!ceqd & ai));
  wire  ao = ai;
  wire  bo = ((!l40 | l04) & bi) | l04;
  wire 
       co = (((ei & di) | (l04 | ci)) & ((!ci & !bi) | (l04 | ci))) & (ci | (!ai | l04));
  wire 
       do = !(bi & ((ai & (((ei & di) | (l04 | ci)) & ((!ci & !bi) | (l04 | ci)))) & ci)) & di;
  wire 
       eo = (ei & !(di & ((ei & !ci) & (!ai & !bi)))) | (!(di & ((ei & !ci) & (!ai & !bi))) & l13);
  wire 
       io = (((((l40 & ei) | l22) & ((l40 & ei) | !ei)) | ((!ai & !bi) & ((ki & (ei & di)) & ci))) | ((!ai & (((((!di & (!(bi & ai) & (ei & !ci))) | (((ki & (ei & !bi)) & di) & ci)) | (!ei & ((!di & (!(bi & ai) & (ei & !ci))) | l22))) | ((ei & !di) & (!bi & ci))) | (l40 & ei))) & ((l40 & ei) | ((((((l22 | !(bi & ai)) & (!(bi & ai) | !ei)) & (((((l22 | !(bi & ai)) & (!(bi & ai) | !ei)) & l22) & ((!ei & (l22 | ((ei & !ci) & !di))) & (!ei | ((ei & !ci) & !di)))) | !ci)) & (((!ei | ei) & (l22 | ei)) & (!di | ((((l22 | !(bi & ai)) & (!(bi & ai) | !ei)) & l22) & ((!ei & (l22 | ((ei & !ci) & !di))) & (!ei | ((ei & !ci) & !di))))))) | !ai) | ((ei & !di) & (!bi & ci)))))) | (!di & (!(bi & ai) & (ei & !ci)));
  wire 
       pd1s6 = ((!l31 | !ai) & (!l31 | (((di & !bi) & ei) & !ci))) & (((!ei & !l22) | !bi) & ((!ei & !l22) | (!ai & (di & (ei & !ci)))));
  wire 
       nd1s6 = (((((!di & ci) & !ei) & ((!ai | (bi & ai)) & ai)) & bi) | ((!l13 | ki) & (ei & !l22))) | ki;
  wire  ndos6 = pd1s6;
  wire  pdos6 = (!l22 | ki) & ((ki | ei) & (!l13 | ki));
  wire 
       alt7 = (((((hi & ((ki | (!l13 | (ci & (((((!fi | (!ei | !l31)) | (!hi | !gi)) & !di) & !ei) & bi)))) & ((ci & (((((!fi | (!ei | !l31)) | (!hi | !gi)) & !di) & !ei) & bi)) | ((ki | ei) & (!l22 | ki))))) & ki) & (gi & fi)) | (dispin ? (((di & ((!fi | (!ei | !l31)) | (!hi | !gi))) & !ei) & l31) : ((ei & l13) & !di))) & (fi & hi)) & gi;
  wire  fo = !alt7 & fi;
  wire  go = gi | (((!fi & (!gi | gi)) | gi) & !hi);
  wire  ho = hi;
  wire 
       jo = (alt7 | (!hi & (fi & ~gi))) | (((~fi & !hi) & (gi | !hi)) & gi);
  wire  nd1s4 = gi & fi;
  wire 
       pd1s4 = (((((!fi & (!gi | gi)) & gi) & ((ki | ei) & (!l22 | ki))) & ki) | !gi) & ((((((!fi | fi) & (!gi | !fi)) & ki) & (((!fi | fi) & (!gi | !fi)) & fi)) & !gi) | !fi);
  wire 
       ndos4 = ((((((!fi | fi) & (!gi | !fi)) & fi) & !gi) | (((!fi & (!gi | gi)) | gi) & !fi)) & !gi) & (!fi & ((ki | !fi) & (ki | !gi)));
  wire  pdos4 = (gi & hi) & fi;
  wire 
       illegalk = (((((ki & (!ci | bi)) | (ki & !di)) | (ai & ki)) & (((!gi | !fi) | !hi) | !ei)) | (((((!gi | !fi) | !hi) | !ei) & ((((!fi | (!ei | !l31)) | (!hi | !gi)) & ((ki | ei) & (!l22 | ki))) & ki)) & !ei)) | ((!l31 & ((((!di | bi) | ai) | ((!ei & (ki | ei)) & ki)) | !ci)) & ki);
  wire 
       compls6 = (pd1s6 | (nd1s6 & dispin)) & (!dispin | (nd1s6 & dispin));
  wire  disp6 = (ndos6 | pdos6) ^ dispin;
  wire 
       compls4 = (pd1s4 & ((!disp6 & (pd1s4 | nd1s4)) & (nd1s4 | !disp6))) | ((nd1s4 & (!disp6 | disp6)) & (disp6 | pd1s4));

  assign dispout = (disp6 & ~(pdos4 | ndos4)) | ((pdos4 | ndos4) & ~disp6);
  assign dataout = {(~compls4 & jo) | (compls4 & ~jo),compls4 ^ ho,(~go & compls4) | (~compls4 & go),fo ^ compls4,(compls6 & ~io) | (~compls6 & io),(((~eo | ~compls6) & ~compls6) & eo) | (~eo & compls6),(do & ~compls6) | (compls6 & (~compls6 | (compls6 & ~do))),co ^ compls6,compls6 ^ bo,(((~compls6 | (compls6 & ~ao)) & ao) & ~compls6) | (compls6 & ~ao)};
endmodule

