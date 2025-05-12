module %(MODULE)s_rold_reg
  #(
    parameter             WIDTH = 1,
    parameter [WIDTH-1:0] RVAL  = {(WIDTH){1'b0}}
    )
   (
    input                  CLK,         
    input                  RSTn,        
    input                  LD,          
    input [WIDTH-1:0]      IN,          
    output reg [WIDTH-1:0] DO           
    );
   always @(posedge CLK or %(RESET_EDGE)s RSTn) begin
      if (%(RESET_CONDITION)sRSTn) begin
         DO <= RVAL;
      end else if (LD) begin
         DO <= IN;
      end
   end
endmodule