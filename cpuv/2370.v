module counterB
  (
   output logic [3:0] cntB_reg, 
   input logic decrementB,      
   input logic dual_countB,     
   input logic cntB_en,         
   input logic clk,             
   input logic rst              
  );
  always_ff @(posedge clk) begin
    if (rst)
      cntB_reg <= 0; 
    else
      if (cntB_en) begin
        if (decrementB)
          if (dual_countB)
            cntB_reg <= cntB_reg - 2; 
          else
            cntB_reg <= cntB_reg - 1; 
        else
          if (dual_countB)
            cntB_reg <= cntB_reg + 2; 
          else
            cntB_reg <= cntB_reg + 1; 
      end
  end 
endmodule 