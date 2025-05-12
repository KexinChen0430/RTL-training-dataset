module targetmod (input clk); 
   reg	[7:0] p1; 
   reg [7:0]  p2; 
   reg [7:0]  p3; 
   parameter int param1 = 8'h21; 
   parameter int param2 = 8'h22; 
   parameter int param3 = 8'h23; 
   initial begin 
      p1 = 8'h04; 
      p2 = 8'h05; 
      p3 = 8'h06; 
   end 
endmodule 