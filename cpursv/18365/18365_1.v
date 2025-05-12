
module mem2reg_test5(input  ctrl,
                     output out);

  wire foo[0:0];
  wire bar[0:1];

  assign foo[0] = ctrl;
  assign bar[0] = 0,
         bar[1] = 1;
  assign out = bar[foo[0]];
endmodule

