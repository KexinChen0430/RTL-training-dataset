module %(MODULE)s_w1s1s_reg  
  #(
    parameter             WIDTH = 1,  
    parameter [WIDTH-1:0] RVAL  = {(WIDTH){1'b0}}  
    )
   (
    input      CLK,  
    input      RSTn, 
    input      BE,   
    input      WE,   
    input      DI,   
    input      IN,   
    output reg DO,   
    output     DO_1S 
    );
   reg         ws;  
   reg         ws_d;  
   always @(posedge CLK or %(RESET_EDGE)s RSTn) begin  
      if (%(RESET_CONDITION)sRSTn) begin  
         DO <= RVAL;  
      end else begin
         if (WE & %(BE_LEVEL)sBE) begin  
            DO <= DO | DI;  
         end else begin
            DO <= ~(IN) & DO;  
         end
      end
   end
   assign DO_1S = ws & !ws_d;  
   always @(posedge CLK or %(RESET_EDGE)s RSTn) begin  
      if (%(RESET_CONDITION)sRSTn) begin  
         ws <= 1'b0;  
         ws_d <= 1'b0;  
      end else begin
         ws <= WE & %(BE_LEVEL)sBE;  
         ws_d <= ws;  
      end
   end
endmodule  