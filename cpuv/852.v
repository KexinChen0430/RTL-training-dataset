module float_add_sub_altbarrel_shift_lib (
    data,       
    distance,   
    result      
);
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
    smux_w = {((({26{(sel_w[4] & (~ dir_w[4]))}} & {sbit_w[113:104], pad_w[15:0]}) | 
               ({26{(sel_w[4] & dir_w[4])}} & {pad_w[15:0], sbit_w[129:120]})) | 
               ({26{(~ sel_w[4])}} & sbit_w[129:104])),
              };
endmodule