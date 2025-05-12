module mux4to1 (clk, sel, d3, d2, d1, d0, out); 
   parameter width = 32; 
   input clk; 
   input [1:0] sel; 
   input [width-1:0] d3; 
   input [width-1:0] d2; 
   input [width-1:0] d1; 
   input [width-1:0] d0; 
   output [width-1:0] out; 
   always @ (posedge clk) 
     case (sel) 
       3: out <= d3; 
       2: out <= d2; 
       1: out <= d1; 
       0: out <= d0; 
       default: $display("Something is awfully wrong in the mux4to1"); 
     endcase 
endmodule 