module testi(input clk, output int out, input wire int in); 
   always @(posedge clk) 
     out <= in + 1; 
endmodule 