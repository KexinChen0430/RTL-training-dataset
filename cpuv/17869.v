module pack2unpack #(parameter WIDTH = 8)
   (input wire [WIDTH-1:0] in, output wire out [WIDTH-1:0] );
   generate
      for (genvar i = 0; i < WIDTH; ++i) begin
         assign out[i] = in[i];
      end
   endgenerate
endmodule