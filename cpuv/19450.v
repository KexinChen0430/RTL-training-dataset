module test(input wire load, in,  
            output reg out1, out2); 
   (* ivl_combinational *)
   always @* begin
      out1 = 0; 
      if (load) begin
         out1 = in; 
         out2 = in; 
      end else begin
         out2 = ~in; 
      end
   end
endmodule 