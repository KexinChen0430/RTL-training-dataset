module scorecopymux (
    data0x,  
    data1x,  
    data2x,  
    data3x,  
    sel,     
    result   
);
    input  [3:0] data0x; 
    input  [3:0] data1x; 
    input  [3:0] data2x; 
    input  [3:0] data3x; 
    input  [1:0] sel;    
    output [3:0] result; 
endmodule 