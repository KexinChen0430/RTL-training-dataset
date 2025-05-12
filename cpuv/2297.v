module counterA
  (output logic [3:0]          cntA_reg, 
   input logic decrementA,               
   input logic dual_countA,              
   input logic cntA_en,                  
   input logic clk,                      
   input logic rst);                     
   logic [3:0] cntA;                     
   always_ff @(posedge clk)
     begin
	cntA_reg <= cntA;
     end
   always_comb
     if (rst) 
       cntA = 0;
     else  begin
        cntA = cntA_reg;              
        if (cntA_en) begin 
           if (decrementA) 
             if (dual_countA) 
               cntA -= 2;
             else 
               cntA--;
           else 
             if (dual_countA) 
               cntA += 2;
             else 
               cntA++;
        end 
     end
endmodule