module Mem (Clk, DI, DO, WE, A, CS); 
input Clk; 
input WE, CS; 
input [31:0] DI; 
input [9:0] A; 
output [31:0] DO; 
reg [31:0] Mem [0:1023]; 
assign #1200 DO = Mem[A]; 
always @(posedge Clk) 
begin
   if (WE && CS) 
       Mem[A] <= #`RegDel DI; 
end
endmodule 