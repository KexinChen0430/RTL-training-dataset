module fg_bd_fifo #
(
    parameter ADDR_WIDTH = 10, 
    parameter DEST_WIDTH = 8   
)
(
    input  wire                   clk,                
    input  wire                   rst,                
    input  wire                   input_bd_valid,     
    output wire                   input_bd_ready,     
    input  wire [DEST_WIDTH-1:0]  input_bd_dest,      
    input  wire [31:0]            input_bd_burst_len, 
    output wire                   output_bd_valid,    
    input  wire                   output_bd_ready,    
    output wire [DEST_WIDTH-1:0]  output_bd_dest,     
    output wire [31:0]            output_bd_burst_len,
    output wire [ADDR_WIDTH-1:0] count,              
    output wire [ADDR_WIDTH+32-1:0] byte_count       
);
reg [ADDR_WIDTH:0] wr_ptr = {ADDR_WIDTH+1{1'b0}}; 
reg [ADDR_WIDTH:0] rd_ptr = {ADDR_WIDTH+1{1'b0}}; 
reg [DEST_WIDTH-1:0] bd_dest_reg = 0;              
reg [31:0] bd_burst_len_reg = 0;                   
reg [DEST_WIDTH-1:0] bd_dest_mem[(2**ADDR_WIDTH)-1:0]; 
reg [31:0] bd_burst_len_mem[(2**ADDR_WIDTH)-1:0];      
reg output_read = 1'b0;                            
reg output_bd_valid_reg = 1'b0;                    
reg [ADDR_WIDTH-1:0] count_reg = 0;                
reg [ADDR_WIDTH+32-1:0] byte_count_reg = 0;        
wire full = ((wr_ptr[ADDR_WIDTH] != rd_ptr[ADDR_WIDTH]) &&
             (wr_ptr[ADDR_WIDTH-1:0] == rd_ptr[ADDR_WIDTH-1:0])); 
wire empty = wr_ptr == rd_ptr; 
wire write = input_bd_valid & ~full; 
wire read = (output_bd_ready | ~output_bd_valid_reg) & ~empty; 
assign output_bd_dest = bd_dest_reg;               
assign output_bd_burst_len = bd_burst_len_reg;     
assign count = count_reg;                          
assign byte_count = byte_count_reg;                
assign input_bd_ready = ~full;                     
assign output_bd_valid = output_bd_valid_reg;      
always @(posedge clk or posedge rst) begin
    if (rst) begin
        wr_ptr <= 0; 
    end else if (write) begin
        bd_dest_mem[wr_ptr[ADDR_WIDTH-1:0]] <= input_bd_dest; 
        bd_burst_len_mem[wr_ptr[ADDR_WIDTH-1:0]] <= input_bd_burst_len; 
        wr_ptr <= wr_ptr + 1; 
    end
end
always @(posedge clk or posedge rst) begin
    if (rst) begin
        rd_ptr <= 0; 
    end else if (read) begin
        bd_dest_reg <= bd_dest_mem[rd_ptr[ADDR_WIDTH-1:0]]; 
        bd_burst_len_reg <= bd_burst_len_mem[rd_ptr[ADDR_WIDTH-1:0]]; 
        rd_ptr <= rd_ptr + 1; 
    end
end
always @(posedge clk or posedge rst) begin
    if (rst) begin
        output_bd_valid_reg <= 1'b0; 
    end else if (output_bd_ready | ~output_bd_valid_reg) begin
        output_bd_valid_reg <= ~empty; 
    end else begin
        output_bd_valid_reg <= output_bd_valid_reg; 
    end
end
always @(posedge clk or posedge rst) begin
    if (rst) begin
        count_reg <= 0; 
        byte_count_reg <= 0; 
    end else if (output_bd_ready & output_bd_valid_reg & write) begin
        byte_count_reg <= byte_count_reg + input_bd_burst_len - bd_burst_len_reg; 
    end else if (output_bd_ready & output_bd_valid_reg) begin
        count_reg <= count_reg - 1; 
        byte_count_reg <= byte_count_reg - bd_burst_len_reg; 
    end else if (write) begin
        count_reg <= count_reg + 1; 
        byte_count_reg <= byte_count_reg + input_bd_burst_len; 
    end
end
endmodule 