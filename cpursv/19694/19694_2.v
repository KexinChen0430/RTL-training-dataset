
module partsel_test003(input  [2:0] a,b,
                       input  [31:0] din,
                       output [3:0] dout);

  assign dout = din[b*a +: 2];
endmodule

