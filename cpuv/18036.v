module barshift_bitslice #(parameter DEPTH = 2, localparam WIDTH = 2**DEPTH)
   (input [WIDTH-1:0] in, input [DEPTH-1:0] shift, output [WIDTH-1:0] out);
   wire [0:WIDTH*(DEPTH+1) - 1] tmp ;
   generate
      for(genvar i = 0; i < DEPTH; ++i) begin
         always_comb
           if (shift[i]) begin
              tmp[WIDTH*(i+1):WIDTH*(i+1+1)-1] = {tmp[WIDTH*(i+1)-(1<<i):WIDTH*(i+1)-1], tmp[WIDTH*i:WIDTH*i+((WIDTH-1) - (2**i))]};
           end
           else begin
              tmp[WIDTH*(i+1):WIDTH*(i+1+1)-1] = tmp[WIDTH*i:WIDTH*(i+1)-1];
           end
      end
   endgenerate
   assign tmp[WIDTH*0:WIDTH*(0+1)-1] = in;
   assign out = tmp[WIDTH*DEPTH:WIDTH*(DEPTH+1)-1];
endmodule