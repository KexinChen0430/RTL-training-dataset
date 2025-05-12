module has_array ( 
   input clk, 
   input logic [7:0] arri [7:0], 
   output logic [7:0] arro [7:0] 
   );
   integer cyc; initial cyc = 0; 
   always @(posedge clk) begin
      cyc <= cyc + 1; 
      if (arri[0] == 10 && cyc == 10) begin
	 $write("*-* All Finished *-*\n"); 
	 $finish; 
      end
   end
   always @(posedge clk) begin
      for (integer i = 0; i < 7; ++i) begin
	  arro[i+1] <= arro[i]; 
      end
      arro[0] = arro[0] + 2; 
   end
endmodule 