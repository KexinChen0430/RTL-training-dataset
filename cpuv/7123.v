module muddlib07__a2o1_1x(a, b, c, y); 
  input a; 
  input b; 
  input c; 
  output y; 
  supply1 vdd; 
  supply0 gnd; 
  wire net_0, net_11, net_19; 
  tranif1 nmos_0(gnd, net_19, a); 
  tranif1 nmos_1(net_19, net_0, b); 
  tranif1 nmos_2(gnd, net_0, c); 
  tranif1 nmos_3(gnd, y, net_0); 
  tranif0 pmos_0(net_0, net_11, c); 
  tranif0 pmos_1(net_11, vdd, b); 
  tranif0 pmos_2(net_11, vdd, a); 
  tranif0 pmos_3(y, vdd, net_0); 
endmodule 