module dcfifo_32in_32out_32kb(
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
  input [31:0]din;         
  input wr_en;             
  input rd_en;             
  output [31:0]dout;       
  output full;             
  output empty;            
  output [2:0]rd_data_count; 
  output [1:0]wr_data_count; 
endmodule