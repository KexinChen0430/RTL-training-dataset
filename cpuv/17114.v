module tx_fifo(
  rst,            
  wr_clk,         
  rd_clk,         
  din,            
  wr_en,          
  rd_en,          
  dout,           
  full,           
  empty,          
  rd_data_count,  
  wr_data_count   
);
input rst;                
input wr_clk;             
input rd_clk;             
input [63 : 0] din;       
input wr_en;              
input rd_en;              
output [7 : 0] dout;      
output full;              
output empty;             
output [13 : 0] rd_data_count; 
output [10 : 0] wr_data_count; 
endmodule