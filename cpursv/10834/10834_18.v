
module addr_map(input  [9:0] hcount,
                input  [9:0] vcount,
                output [16:0] addr);

  assign addr = (((2**6)*vcount[9:1])+hcount>>1)+(vcount[9:1]*(2**8));
endmodule

