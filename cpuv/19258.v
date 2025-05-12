module suba
  (input logic clk,    
   input logic foo);   
   always @(posedge clk) begin
      $write("*-* All Finished *-*\n"); 
      $finish;                          
   end
endmodule 