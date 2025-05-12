module t ( 
   clk 
   );
   input clk; 
   integer cyc; initial cyc=1; 
   Test test (
	      .clk			(clk)); 
   always @ (posedge clk) begin
      if (cyc!=0) begin 
         cyc <= cyc + 1; 
         if (cyc==10) begin 
            $write("*-* All Finished *-*\n"); 
            $finish; 
         end
      end
   end
endmodule 