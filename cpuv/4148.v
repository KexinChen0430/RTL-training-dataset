module SRAM (
    wr_en,     
    clk_wr,    
    wr_ptr,    
    data_in,   
    rd_en,     
    clk_rd,    
    rd_ptr,    
    data_out   
);
input  [`DATA_WIDTH_M1:0] data_in; 
input                     clk_wr,  
                          clk_rd,  
                          wr_en,   
                          rd_en;   
input [`ADDR_WIDTH_M1:0]  wr_ptr,  
                          rd_ptr;  
output [`DATA_WIDTH_M1:0] data_out; 
reg [`DATA_WIDTH_M1:0]    mem_array [0:128]; 
reg [`DATA_WIDTH_M1:0]    data_out;          
wire [`DATA_WIDTH_M1:0]   data_in;           
always @(posedge clk_wr) begin 
    if (wr_en) 
        mem_array[wr_ptr] <= #1 data_in; 
end
always @(posedge clk_rd) begin 
    if (rd_en) 
        data_out <= #1 mem_array[rd_ptr]; 
end
endmodule 