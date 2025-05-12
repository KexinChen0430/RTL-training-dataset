module FiFo(
    clk,    
    din,    
    wr_en,  
    rd_en,  
    dout,   
    full,   
    empty   
);
  input clk;          
  input [7:0] din;    
  input wr_en;        
  input rd_en;        
  output [7:0] dout;  
  output full;        
  output empty;       
endmodule 