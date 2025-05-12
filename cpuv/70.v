module jtag__scanAmp1w1648(in, out);
  input in;
  output out;
  supply1 vdd;
  supply0 gnd;
  wire net_0;
  tranif1 nmos_0(gnd, net_0, in);
  tranif1 nmos_1(gnd, out, net_0);
  tranif0 pmos_0(net_0, vdd, in);
  tranif0 pmos_1(out, vdd, net_0);
endmodule