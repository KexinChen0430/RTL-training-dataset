module muddlib07__xnor_ds(A, B, Y); 
  input A; 
  input B; 
  output Y; 
  supply1 vdd; 
  supply0 gnd; 
  wire net_0, net_1, net_11, net_28; 
  tranif1 nmos_0(net_0, net_1, A); 
  tranif1 nmos_1(gnd, net_0, B); 
  tranif1 nmos_4(net_11, Y, A); 
  tranif1 nmos_5(net_11, Y, B); 
  tranif1 nmos_6(gnd, net_11, net_1); 
  tranif0 pmos_0(net_1, vdd, A); 
  tranif0 pmos_1(net_1, vdd, B); 
  tranif0 pmos_2(Y, vdd, net_1); 
  tranif0 pmos_3(net_28, vdd, B); 
  tranif0 pmos_4(Y, net_28, A); 
endmodule 