
module addr_map(input  [9:0] hcount,
                input  [9:0] vcount,
                output [16:0] addr);

  assign addr = vcount[9:1]<<<6+(vcount[9:1]<<<8+hcount>>1);
endmodule

