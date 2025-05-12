
module callee(input  [7:0] port[7:0],
              output [7:0] o);

  assign o = ^{port[0],port[1],port[2],port[3],port[4],port[5],port[6],port[7]};
endmodule

