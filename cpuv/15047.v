module %(MODULE)s_w1cs_reg
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
   genvar                  i;            
   generate
      for(i = 0; i < WIDTH; i = i + 1) begin : u 
         always @(posedge CLK or %(RESET_EDGE)s RSTn) begin 
            if (%(RESET_CONDITION)sRSTn) begin 
               DO[i] <= RVAL[i];               
            end else begin                     
               if (WE & %(BE_LEVEL)sBE & DI[i]) begin 
                  DO[i] <= 1'b0;                       
               end else begin                          
                  DO[i] <= IN[i] | DO[i];              
               end
            end
         end
      end
   endgenerate
endmodule