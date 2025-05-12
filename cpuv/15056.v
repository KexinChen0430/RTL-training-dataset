module %(MODULE)s_wo_reg 
  #(
    parameter             WIDTH = 1,              
    parameter [WIDTH-1:0] RVAL  = {(WIDTH){1'b0}} 
    )
   (
    input  CLK,                 
    input  RSTn,                
    input  BE,                  
    input  WE,                  
    input  [WIDTH-1:0] DI,      
    output [WIDTH-1:0] DO       
    );
   reg [WIDTH-1:0] ws;          
   reg [WIDTH-1:0] ws_d;        
   assign DO = ws & ~ws_d;      
   always @(posedge CLK or %(RESET_EDGE)s RSTn) begin
      if (%(RESET_CONDITION)sRSTn) begin 
         ws <= {WIDTH{1'b0}};            
         ws_d <= {WIDTH{1'b0}};          
      end else begin
         if (WE & %(BE_LEVEL)sBE) begin  
            ws <= DI;                    
         end else begin
            ws <= {WIDTH{1'b0}};         
         end
         ws_d <= ws;                     
      end
   end
endmodule