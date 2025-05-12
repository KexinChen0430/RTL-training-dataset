module %(MODULE)s_ro1s_reg
  #(
    parameter             WIDTH = 1,          
    parameter [WIDTH-1:0] RVAL  = {(WIDTH){1'b0}} 
    )
   (
    input                  CLK,         
    input                  RSTn,        
    input                  BE,          
    input                  RD,          
    input [WIDTH-1:0]      DI,          
    output reg [WIDTH-1:0] DO,          
    output                 DO_1S        
    );
always @(posedge CLK or %(RESET_EDGE)s RSTn) begin
   if (%(RESET_CONDITION)sRSTn) begin
      DO <= RVAL; 
   end else begin
      if (WE & %(BE_LEVEL)sBE) begin
         DO <= DI; 
      end
   end
end
endmodule