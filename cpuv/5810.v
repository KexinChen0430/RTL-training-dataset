module muddlib07__and2_1x(a, b, y); 
  input a; 
  input b; 
  output y; 
  supply1 vdd; 
  supply0 gnd; 
  wire net_1, net_2; 
  tranif1 nmos_0(net_1, net_2, b); 
  tranif1 nmos_1(gnd, net_1, a); 
  tranif1 nmos_2(gnd, y, net_2); 
  tranif0 pmos_0(net_2, vdd, b); 
  tranif0 pmos_1(net_2, vdd, a); 
  tranif0 pmos_2(y, vdd, net_2); 
endmodule 