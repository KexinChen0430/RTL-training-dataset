module secret_other
  (
   input clk); 
   integer secret_cyc; 
   always @ (posedge clk) begin
      secret_cyc <= secret_cyc + 1; 
      if (secret_cyc==99) begin
         $finish; 
      end
   end
endmodule 