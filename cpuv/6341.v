module ram2port(
  wrCLK,    
  wren,     
  wrpage,   
  wraddr,   
  wrdata,   
  rdCLK,    
  rden,     
  rdpage,   
  rdaddr,   
  rddata    
);
parameter num_of_pages = 1;    
parameter pagesize = 1024;     
parameter data_width = 32;     
`define PAGE_WIDTH  $clog2(num_of_pages)  
`define ADDR_WIDTH  $clog2(pagesize)      
`define MEM_SPACE   num_of_pages*pagesize 
`define MEM_WIDTH   $clog2(`MEM_SPACE)    
input                   wrCLK;             
input                   wren;              
input [`PAGE_WIDTH-1:0] wrpage;            
input [`ADDR_WIDTH-1:0] wraddr;            
input [ data_width-1:0] wrdata;            
input                        rdCLK;        
input                        rden;         
input      [`PAGE_WIDTH-1:0] rdpage;       
input      [`ADDR_WIDTH-1:0] rdaddr;       
output reg [ data_width-1:0] rddata;       
reg [data_width-1:0] data_buf[0:`MEM_SPACE-1]; 
wire [31:0] wrpageoffset = (pagesize * wrpage); 
reg                    wren_r = 1'b0;           
reg [`MEM_WIDTH-1:0]  wrmem_r = {`MEM_WIDTH{1'b0}}; 
reg [data_width-1:0] wrdata_r = {data_width{1'b0}}; 
always @(posedge wrCLK) begin
  if ((wrpage < num_of_pages) && (wraddr < pagesize))
    wren_r <= wren; 
  else
    wren_r <= 1'b0;  
  wrmem_r  <= wrpageoffset[`MEM_WIDTH-1:0] + wraddr;
  wrdata_r <= wrdata;
  if (wren_r)
    data_buf[wrmem_r] <= wrdata_r;
end
wire [31:0] rdpageoffset = (pagesize * rdpage); 
reg                   rden_r = 1'b0;            
reg [`MEM_WIDTH-1:0] rdmem_r = {`MEM_WIDTH{1'b0}}; 
always @(posedge rdCLK) begin
  if ((rdpage < num_of_pages) && (rdaddr < pagesize))
    rden_r <= rden; 
  else
    rden_r <= 1'b0;  
  rdmem_r <= rdpageoffset[`MEM_WIDTH-1:0] + rdaddr;
  if (rden_r)
    rddata <= data_buf[rdmem_r];
end
endmodule