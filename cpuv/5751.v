module muddlib07__nor2_1x(a, b, y); 
  input a; 
  input b; 
  output y; 
  supply1 vdd; 
  supply0 gnd; 
  wire net_9; 
  tranif1 nmos_0(gnd, y, a); 
  tranif1 nmos_1(gnd, y, b); 
  tranif0 pmos_0(y, net_9, b); 
  tranif0 pmos_1(net_9, vdd, a); 
endmodule 