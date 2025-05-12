module fpoint_hw_qsys_addsub_single_altbarrel_shift_44e
(
    data,       
    distance,   
    result      
) ; 
input   [25:0]  data;       
input   [4:0]   distance;   
output  [25:0]  result;     
wire  [5:0]   dir_w;        
wire  direction_w;          
wire  [15:0]  pad_w;        
wire  [155:0] sbit_w;       
wire  [4:0]   sel_w;        
wire  [129:0] smux_w;       
assign
    dir_w = {dir_w[4:0], direction_w}, 
    direction_w = 1'b1,                
    pad_w = {16{1'b0}},                
    result = sbit_w[155:130],          
    sbit_w = {smux_w[129:0], data},    
    sel_w = {distance[4:0]},           
    smux_w = {
    };
endmodule