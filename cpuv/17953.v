module barshift_2d_packed_array_le #(parameter DEPTH = 2, localparam WIDTH = 2**DEPTH)
   (input [WIDTH-1:0] in, input [DEPTH-1:0] shift, output [WIDTH-1:0] out);
   localparam OFFSET = -2;
   reg [OFFSET:DEPTH+OFFSET][OFFSET:WIDTH-1+OFFSET] tmp ;
   generate
      for(genvar i = 0; i < DEPTH; ++i) begin
         always_comb
           if (shift[i]) begin
              tmp[i+1+OFFSET] = {tmp[i+OFFSET][WIDTH-(2**i)+OFFSET:WIDTH-1+OFFSET], tmp[i+OFFSET][OFFSET:WIDTH-(2**i)-1+OFFSET]};
           end
           else begin  
              tmp[i+1+OFFSET][0+OFFSET:2+OFFSET]  = tmp[i+OFFSET][0+OFFSET:2+OFFSET];
              tmp[i+1+OFFSET][3+OFFSET]           = tmp[i+OFFSET][3+OFFSET];
              {tmp[i+1+OFFSET][4+OFFSET],tmp[i+1+OFFSET][5+OFFSET]} = {tmp[i+OFFSET][4+OFFSET], tmp[i+OFFSET][5+OFFSET]};
              {tmp[i+1+OFFSET][7+OFFSET],tmp[i+1+OFFSET][6+OFFSET]} = {tmp[i+OFFSET][7+OFFSET], tmp[i+OFFSET][6+OFFSET]};
           end
      end
   endgenerate
   assign tmp[0+OFFSET] = in;
   assign out = tmp[DEPTH+OFFSET];
endmodule