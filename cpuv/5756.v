module muddlib07__nand2_1x(a, b, y); 
  input a; 
  input b; 
  output y; 
  supply1 vdd; 
  supply0 gnd; 
  wire net_5; 
  tranif1 nmos_0(net_5, y, b); 
  tranif1 nmos_1(gnd, net_5, a); 
  tranif0 pmos_0(y, vdd, b); 
  tranif0 pmos_1(y, vdd, a); 
endmodule 