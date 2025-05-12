module Reg(
   clock,    
   reset,    
   data_i,   
   writeEn,  
   data_o    
);
   parameter Size = 8;
   input wire clock;   
   input wire reset;   
   input wire writeEn; 
   input wire [(Size - 1):0] data_i; 
   output reg [(Size - 1):0] data_o; 
   always @ (posedge clock) begin
      if (reset) begin
         data_o <= {Size{1'b0}};
      end
      else begin
         if (writeEn) begin
            data_o <= data_i;
         end
      end
   end
endmodule