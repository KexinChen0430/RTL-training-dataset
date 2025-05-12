module %(MODULE)s_w1cs1s_reg  
  #(
    parameter             WIDTH = 1,  
    parameter [WIDTH-1:0] RVAL = {(WIDTH){1'b0}}  
    )
   (
    input                  CLK,         
    input                  RSTn,        
    input                  BE,          
    input                  WE,          
    input [WIDTH-1:0]      DI,          
    input [WIDTH-1:0]      IN,          
    output reg [WIDTH-1:0] DO,          
    output                 DO_1S        
    );
   reg                     ws;  
   reg                     ws_d;  
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