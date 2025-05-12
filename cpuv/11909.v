module lm32_ram
  (
   read_clk,          
   write_clk,         
   reset,             
   enable_read,       
   read_address,      
   enable_write,      
   write_address,     
   write_data,        
   write_enable,      
   read_data          
   );
parameter data_width = 1;               
parameter address_width = 1;            
input read_clk;                         
input write_clk;                        
input reset;                            
input enable_read;                      
input [address_width-1:0] read_address; 
input enable_write;                     
input [address_width-1:0] write_address;
input [data_width-1:0] write_data;      
input write_enable;                     
output [data_width-1:0] read_data;      
wire   [data_width-1:0] read_data;      
reg [data_width-1:0]    mem[0:(1<<address_width)-1]; 
reg [address_width-1:0] ra; 
assign read_data = mem[ra];
always @(posedge write_clk)
  if ((write_enable == `TRUE) && (enable_write == `TRUE))
    mem[write_address] <= write_data;
always @(posedge read_clk)
  if (enable_read)
    ra <= read_address;
endmodule