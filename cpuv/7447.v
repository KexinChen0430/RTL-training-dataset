module ram16k(input clk, 
	      input [13:0] 	addr, 
	      input [15:0] 	data_in, 
	      output reg [15:0] data_out, 
	      input 		we, 
	      input 		re); 
   reg [15:0] 			RAM [0:8192-1]; 
   always @(posedge clk)
     if (re) begin
	data_out <= RAM[addr];
     end 
     else if (we) begin
	RAM[addr] <= data_in;
     end
endmodule