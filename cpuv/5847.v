module muddlib07__nand3_1x(a, b, c, y);
  input a;
  input b;
  input c;
  output y;
  supply1 vdd;
  supply0 gnd;
  wire net_15, net_4;
  tranif1 nmos_0(net_15, net_4, b);
  tranif1 nmos_1(net_4, y, c);
  tranif1 nmos_2(gnd, net_15, a);
  tranif0 pmos_0(y, vdd, c);
  tranif0 pmos_1(y, vdd, b);
  tranif0 pmos_2(y, vdd, a);
endmodule