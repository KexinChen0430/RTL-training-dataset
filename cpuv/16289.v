module testr(input clk, output real out, input wire real in); 
   always @(posedge clk) 
     out <= in + 1.0; 
endmodule 