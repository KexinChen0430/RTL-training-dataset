module's undeclared outputs) 
   reg clk_50m;                 
   reg locked;                  
   always @(posedge clk_in or negedge resetn) begin
      if(resetn == 1'b0) begin  
         clk_50m <= 1'h0;       
      end
      else begin                
         clk_50m <= !clk_50m;   
      end
   end
   always @(posedge clk_50m or negedge resetn) begin
      if(resetn == 1'b0) begin  
         locked = 1'h0;         
      end
      else begin                
         locked <= 1'b1;        
      end
   end
endmodule