module barshift_2d_packed_array #(parameter DEPTH = 2, localparam WIDTH = 2**DEPTH)
   (input [WIDTH-1:0] in, input [DEPTH-1:0] shift, output [WIDTH-1:0] out);
   localparam OFFSET = -2;
   reg [OFFSET:DEPTH+OFFSET][WIDTH-1:0] tmp ;
   generate
      for(genvar i = 0; i < DEPTH; ++i) begin
         always @(shift or tmp)
           if (shift[i]) begin
              tmp[i+1+OFFSET] = {tmp[i+OFFSET][(1 << i)-1:0], tmp[i+OFFSET][WIDTH-1:(2**i)]};
           end
           else begin
              tmp[i+1+OFFSET][1:0]       = tmp[i+OFFSET][1:0];
              tmp[i+1+OFFSET][WIDTH-1:2] = tmp[i+OFFSET][WIDTH-1:2];
           end
      end
   endgenerate
   assign tmp[0+OFFSET] = in;
   assign out = tmp[DEPTH+OFFSET];
endmodule