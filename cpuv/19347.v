module sub; 
   parameter WIDTH = 1; 
   function [WIDTH-1:0] orer; 
      input [WIDTH-1:0] in; 
      parameter MASK_W = WIDTH - 2; 
      localparam [MASK_W-1:0] MASK = '1; 
      return in | MASK; 
   endfunction 
   function [WIDTH-1:0] orer2; 
      input [WIDTH-1:0] in; 
      parameter MASK_W = WIDTH - 3; 
      localparam [MASK_W-1:0] MASK = '1; 
      return in | MASK; 
   endfunction 
endmodule 