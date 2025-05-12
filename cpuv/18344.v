module TestAnsi (
     input clk,                
     input threeansi_t in,     
     output threeansi_t out    
     );
   always @(posedge clk) begin
      out <= ~in; 
   end
endmodule 