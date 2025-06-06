module mem_16nm_ram12x73 
(
  input  wire        clk, 
  input  wire        ram_wr_en, 
  input  wire [3:0]  ram_wr_addr, 
  input  wire [72:0] ram_wr_data, 
  input  wire        ram_rd_en, 
  input  wire [3:0]  ram_rd_addr, 
  output wire [72:0] ram_rd_data, 
  input  wire        bist_clk, 
  input  wire        bist_en, 
  input  wire [3:0]  bist_addr, 
  input  wire [72:0] bist_wr_data, 
  output wire [72:0] bist_rd_data 
);
reg [72:0] memory [11:0]; 
reg [72:0] ram_rd_data_i; 
always @ (posedge clk) begin 
  if( ram_wr_en ) begin 
    memory[ram_wr_addr] <= #0 ram_wr_data; 
  end
  if( ram_rd_en ) begin 
    ram_rd_data_i <= #0 memory[ram_rd_addr]; 
  end
end
always @ (posedge clk) begin 
  ram_rd_data <= #0 ram_rd_data_i; 
end
always @ (posedge bist_clk ) begin 
  bist_rd_data <= #0 bist_wr_data; 
end
endmodule 