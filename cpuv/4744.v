module C(
   x,
   clk, a, y
   );
   input clk; 
   input a;   
   input y;   
   output reg x;
   always @(posedge clk) begin
     x <= a & y;
   end
endmodule