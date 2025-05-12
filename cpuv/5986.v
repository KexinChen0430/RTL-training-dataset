module Test (
   out,
   in
   );
   input [15:0] in;
   output reg   out;
   always_comb begin
      out = 0;
      for (int i=0; i<16; i=i+1) begin
         if (in[i]) begin
            out = 1;
         end
      end
   end
endmodule