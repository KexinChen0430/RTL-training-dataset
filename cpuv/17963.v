module barshift_1d_packed_struct #(localparam DEPTH = 3, localparam WIDTH = 2**DEPTH)
   (input [WIDTH-1:0] in, input [DEPTH-1:0] shift, output [WIDTH-1:0] out);
   typedef struct packed {
      logic [WIDTH-1:0] v0, v1, v2, v3;
   } data_type;
   wire data_type tmp ;
   assign tmp.v0 = in;
   assign tmp.v1 = shift[0] == 1'b1 ? {tmp.v0[(1 << 0)-1:0], tmp.v0[WIDTH-1:2**0]} : tmp.v0;
   assign tmp.v2 = shift[1] == 1'b1 ? {tmp.v1[(1 << 1)-1:0], tmp.v1[WIDTH-1:2**1]} : tmp.v1;
   assign tmp.v3 = shift[2] == 1'b1 ? {tmp.v2[(1 << 2)-1:0], tmp.v2[WIDTH-1:2**2]} : tmp.v2;
   assign out = tmp.v3;
endmodule