module mux2to1 (clk, sel, d1, d0, out); 
   parameter width = 32; 
   input clk; 
   input sel; 
   input [width-1:0] d1; 
   input [width-1:0] d0; 
   output [width-1:0] out; 
   always @ (posedge clk) 
     case (sel) 
       1: out <= d1; 
       0: out <= d0; 
       default: $display("Something is awfully wrong in the mux2to1"); 
     endcase 
endmodule 