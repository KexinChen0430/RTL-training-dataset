
module OXIDE_DSP_REG  #(parameter  W = 18, USED = REGISTER, RESETMODE = SYNC)
  (input  CLK,
   input  CE,
   input  RST,
   input  [W+(0-1):0] D,
   output reg [W+(0-1):0] Q);

  
  generate
      if (USED == BYPASS) 
        
        always @*         Q = D;
      else if (USED == REGISTER) 
        begin
          
          initial            Q = 0;
          if (RESETMODE == ASYNC) 
            
            always @(posedge CLK or posedge RST)
                begin
                  if (RST) Q <= 0;
                  else if (CE) Q <= D;
                    
                end
          else if (RESETMODE == SYNC) 
            
            always @(posedge CLK)
                begin
                  if (RST) Q <= 0;
                  else if (CE) Q <= D;
                    
                end
            
        end
        
  endgenerate

endmodule

