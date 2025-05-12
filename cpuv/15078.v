module %(MODULE)s_rcld_reg
  #(
    parameter             WIDTH = 1,             
    parameter [WIDTH-1:0] RVAL  = {(WIDTH){1'b0}} 
    )
   (
    input                  CLK,         
    input                  RSTn,        
    input                  RD,          
    input                  LD,          
    input [WIDTH-1:0]      IN,          
    output reg [WIDTH-1:0] DO           
    );
   always @(posedge CLK or %(RESET_EDGE)s RSTn) begin
      if (%(RESET_CONDITION)sRSTn) begin 
         DO <= RVAL;                     
      end else begin                     
         if (LD) begin                   
            DO <= IN;                    
         end else begin                  
            DO <= RD ? {WIDTH{1'b0}} : DO; 
         end
      end
   end
endmodule