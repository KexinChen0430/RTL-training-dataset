module rstdtctr
  (
   RESETn 
   );
   output reg RESETn; 
   initial begin
      RESETn <= 1'b0; 
      `RESET_TIME; 
      RESETn <= 1'b1; 
   end
endmodule