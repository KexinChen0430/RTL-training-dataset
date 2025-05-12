module cordic_stage #(parameter   stage_p = 1  
                      , parameter width_p = 12) 
   (
    input clk                                  
    ,input  [width_p+7:0] x                    
    ,input  [width_p+7:0] y                    
    ,output [width_p+7:0] x_n                  
    ,output [width_p+7:0] y_n                  
    );
   wire [width_p+7:0] x_shift = x          >>> stage_p; 
   wire [width_p+7:0] y_shift = signed'(y) >>> stage_p; 
   assign x_n = (y[width_p+7]) ? (x - y_shift) : (x +  y_shift); 
   assign y_n = (y[width_p+7]) ? (y + x_shift) : (y -  x_shift); 
endmodule