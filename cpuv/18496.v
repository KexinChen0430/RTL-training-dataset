module Test(
   result,       
   clk, cyc      
   );
   input clk;    
   input int cyc; 
   output reg [63:0] result; 
   logic [63:0] adder;       
   always @(posedge clk) begin
      adder = 0; 
      for (int i = 0; i < 1000; ++i)
        adder += {32'h0, (cyc+i)} ** 3;
      result <= adder;
   end
endmodule