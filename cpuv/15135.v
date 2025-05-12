module %(MODULE)s_rwc_reg  
  #(
    parameter             WIDTH = 1,             
    parameter [WIDTH-1:0] RVAL  = {(WIDTH){1'b0}} 
    )
   (
    input                  CLK,  
    input                  RSTn, 
    input                  BE,   
    input                  WE,   
    input [WIDTH-1:0]      DI,   
    input [WIDTH-1:0]      IN,   
    output reg [WIDTH-1:0] DO    
    );
   always @(posedge CLK or %(RESET_EDGE)s RSTn) begin 
      if (%(RESET_CONDITION)sRSTn) begin 
         DO <= RVAL; 
      end else begin 
         if (WE & %(BE_LEVEL)sBE) begin 
            DO <= DI; 
         end else begin 
            DO <= ~(IN) & DO; 
         end
      end
   end
endmodule