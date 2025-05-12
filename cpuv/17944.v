module ps
  (input clk,              
   input integer cyc,      
   input time in);         
   always @ (posedge clk) begin
      if (cyc == 10) begin
         $timeformat(-9, 6, "ns", 16);
         $write("%m: Input time %t %d\n", in, in);
      end
   end
endmodule