
module addr_map(input  [9:0] hcount,
                input  [9:0] vcount,
                output [16:0] addr);

  assign addr = hcount>>1+(((2**8)+(2**6))*vcount[9:1]);
endmodule

