module barshift_1d_unpacked #(parameter DEPTH = 2, localparam WIDTH = 2**DEPTH)
   (input [WIDTH-1:0] in, input [DEPTH-1:0] shift, output [WIDTH-1:0] out );
   localparam OFFSET = -3;
`ifdef TEST_ATTRIBUTES
   logic [WIDTH-1:0] tmp[DEPTH+OFFSET:OFFSET] ;
`else
   logic [WIDTH-1:0] tmp[DEPTH+OFFSET:OFFSET];
`endif
   generate
      for(genvar i = 0; i < DEPTH; ++i) begin
         always_comb
           if (shift[i]) begin
              tmp[i+1+OFFSET] = {tmp[i+OFFSET][(1 << i)-1:0], tmp[i+OFFSET][WIDTH-1:(2**i)]};
           end
           else begin
              tmp[i+1+OFFSET] = tmp[i+OFFSET];
           end
      end
   endgenerate
   assign tmp[0+OFFSET] = in;
   assign out[WIDTH-1-:WIDTH-1] = tmp[DEPTH+OFFSET][WIDTH-1:1];
   assign out[0] = tmp[DEPTH+OFFSET][0+:1];
endmodule