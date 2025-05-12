module %(MODULE)s_rv1s_reg
  #(
    parameter             WIDTH = 1,            
    parameter [WIDTH-1:0] RVAL  = {(WIDTH){1'b0}} 
    )
   (
    input              CLK,   
    input              RSTn,  
    input              RD,    
    input [WIDTH-1:0]  IN,    
    output [WIDTH-1:0] DO,    
    output             DO_1S  
    );
   reg                 ws;    
   reg                 ws_d;  
   assign DO    = IN;
   assign DO_1S = ws & !ws_d;
   always @(posedge CLK or %(RESET_EDGE)s RSTn) begin
      if (%(RESET_CONDITION)sRSTn) begin 
         ws <= 1'b0;                     
         ws_d <= 1'b0;                   
      end else begin                     
         ws <= RD;                       
         ws_d <= ws;                     
      end
   end
endmodule