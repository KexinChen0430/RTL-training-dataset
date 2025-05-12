module muddlib07__o22a2i_1x(a, b, c, d, y); 
  input a; 
  input b; 
  input c; 
  input d; 
  output y; 
  supply1 vdd; 
  supply0 gnd; 
  wire net_34, net_35, net_7; 
  tranif1 nmos_0(gnd, net_7, a); 
  tranif1 nmos_1(gnd, net_7, b); 
  tranif1 nmos_2(net_7, y, c); 
  tranif1 nmos_3(net_7, y, d); 
  tranif0 pmos_0(y, net_35, b); 
  tranif0 pmos_1(net_35, vdd, a); 
  tranif0 pmos_2(y, net_34, d); 
  tranif0 pmos_3(net_34, vdd, c); 
endmodule 