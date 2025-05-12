module muddlib07__inv_1x(a, y);
  input a;          
  output y;         
  supply1 vdd;      
  supply0 gnd;      
  tranif1 nmos_0(gnd, y, a);
  tranif0 pmos_0(y, vdd, a);
endmodule 