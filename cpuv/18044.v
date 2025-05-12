module ns
  (input clk,             
   input integer cyc,     
   input time in);        
   always @ (posedge clk) begin
      if (cyc == 20) begin
         $timeformat(-9, 6, "ns", 16);
         $write("%m: Input time %t %d\n", in, in);
      end
   end
endmodule