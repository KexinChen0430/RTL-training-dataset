module counterselect (
    data0x,   
    data1x,   
    data2x,   
    data3x,   
    sel,      
    result    
);
input   [20:0]  data0x; 
input   [20:0]  data1x; 
input   [20:0]  data2x; 
input   [20:0]  data3x; 
input   [1:0]   sel;    
output  [20:0]  result; 
endmodule 