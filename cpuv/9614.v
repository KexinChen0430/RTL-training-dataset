module flpv3l_layer_ctrl_rf (
    input         RESETn,          
    input [ 71:0] ADDR_IN,        
    input [ 23:0] DATA_IN,        
    output reg [12:0] SRAM_START_ADDR, 
    output reg [17:0] FLSH_START_ADDR, 
    output reg [12:0] LENGTH,          
    output reg        IRQ_EN,          
    output reg [ 3:0] CMD,             
    output reg        GO,              
    output reg [18:0] PP_STR_LIMIT,    
    output reg        PP_STR_EN,       
    output reg [18:0] PP_LENGTH_STREAMED, 
    output reg        PP_FLAG_END_OF_FLASH, 
    output reg        PP_FLAG_STR_LIMIT,    
    output reg        PP_FLAG_COPY_LIMIT,   
    output reg [18:0] PP_LENGTH_COPIED      
);
always @ (posedge ADDR_IN[7] or negedge RESETn) begin
    if (~RESETn) SRAM_START_ADDR <= 13'h0000; 
    else         SRAM_START_ADDR <= DATA_IN[12:0]; 
end
always @ (posedge ADDR_IN[8] or negedge RESETn) begin
    if (~RESETn) FLSH_START_ADDR <= 18'h00000; 
    else         FLSH_START_ADDR <= DATA_IN[17:0]; 
end
always @ (posedge ADDR_IN[9] or negedge RESETn) begin
    if (~RESETn) LENGTH <= 13'h0000; 
    else         LENGTH <= DATA_IN[18:6]; 
end
always @ (posedge ADDR_IN[9] or negedge RESETn) begin
    if (~RESETn) IRQ_EN <= 1'h0; 
    else         IRQ_EN <= DATA_IN[5:5]; 
end
always @ (posedge ADDR_IN[9] or negedge RESETn) begin
    if (~RESETn) CMD <= 4'h0; 
    else         CMD <= DATA_IN[4:1]; 
end
always @ (posedge ADDR_IN[9] or negedge RESETn) begin
    if (~RESETn) GO <= 1'h0; 
    else         GO <= DATA_IN[0:0]; 
end
always @ (posedge ADDR_IN[19] or negedge RESETn) begin
    if (~RESETn) PP_STR_LIMIT <= 19'h00000; 
    else         PP_STR_LIMIT <= DATA_IN[19:1]; 
end
always @ (posedge ADDR_IN[19] or negedge RESETn) begin
    if (~RESETn) PP_STR_EN <= 1'h0; 
    else         PP_STR_EN <= DATA_IN[0:0]; 
end
always @ (posedge ADDR_IN[22] or negedge RESETn) begin
    if (~RESETn) PP_LENGTH_STREAMED <= 19'h00000; 
    else         PP_LENGTH_STREAMED <= DATA_IN[18:0]; 
end
always @ (posedge ADDR_IN[23] or negedge RESETn) begin
    if (~RESETn) PP_FLAG_END_OF_FLASH <= 1'h0; 
    else         PP_FLAG_END_OF_FLASH <= DATA_IN[23:23]; 
end
always @ (posedge ADDR_IN[23] or negedge RESETn) begin
    if (~RESETn) PP_FLAG_STR_LIMIT <= 1'h0; 
    else         PP_FLAG_STR_LIMIT <= DATA_IN[22:22]; 
end
always @ (posedge ADDR_IN[23] or negedge RESETn) begin
    if (~RESETn) PP_FLAG_COPY_LIMIT <= 1'h0; 
    else         PP_FLAG_COPY_LIMIT <= DATA_IN[21:21]; 
end
always @ (posedge ADDR_IN[23] or negedge RESETn) begin
    if (~RESETn) PP_LENGTH_COPIED <= 19'h00000; 
    else         PP_LENGTH_COPIED <= DATA_IN[18:0]; 
end
endmodule