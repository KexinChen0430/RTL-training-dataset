module sub1(
   input wire clk,          
   input wire [7:0] in,     
   output wire [7:0] out    
); 
   logic [7:0] ff;          
   always_ff @(posedge clk) 
       ff <= in + 1;        
   assign out = ff;         
endmodule                   