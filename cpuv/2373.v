module fifo_generator_1(
    clk,    
    rst,    
    din,    
    wr_en,  
    rd_en,  
    dout,   
    full,   
    empty   
);
input clk;          
input rst;          
input [93:0] din;   
input wr_en;        
input rd_en;        
output [93:0] dout; 
output full;        
output empty;       
endmodule 