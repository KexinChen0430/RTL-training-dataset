module muddlib07__o2a1i_1x(a, b, c, y);
  input a;
  input b;
  input c;
  output y;
  supply1 vdd;
  supply0 gnd;
  wire net_35, net_7;
  tranif1 nmos_0(gnd, net_7, a);
  tranif1 nmos_1(gnd, net_7, b);
  tranif1 nmos_2(net_7, y, c);
  tranif0 pmos_0(y, net_35, b);
  tranif0 pmos_1(net_35, vdd, a);
  tranif0 pmos_3(y, vdd, c);
endmodule