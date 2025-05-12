module blockmem_rw32_r128(
  input wire            clk,             
  input wire            api_we,          
  input wire  [07 : 0]  api_addr,        
  input wire  [31 : 0]  api_wr_data,     
  output wire [31 : 0]  api_rd_data,     
  input wire  [05  : 0] internal_addr,   
  output wire [127 : 0] internal_rd_data 
);
reg [31 : 0] mem0 [0 : 63];
reg [31 : 0] mem1 [0 : 63];
reg [31 : 0] mem2 [0 : 63];
reg [31 : 0] mem3 [0 : 63];
reg [31 : 0] muxed_api_rd_data;
reg [31 : 0] mem0_api_rd_data;
reg [31 : 0] mem1_api_rd_data;
reg [31 : 0] mem2_api_rd_data;
reg [31 : 0] mem3_api_rd_data;
reg [31 : 0] mem0_int_rd_data;
reg [31 : 0] mem1_int_rd_data;
reg [31 : 0] mem2_int_rd_data;
reg [31 : 0] mem3_int_rd_data;
reg          mem0_we;
reg          mem1_we;
reg          mem2_we;
reg          mem3_we;
assign api_rd_data      = muxed_api_rd_data;
assign internal_rd_data = {mem3_int_rd_data, mem2_int_rd_data,
                           mem1_int_rd_data, mem0_int_rd_data};
always @ (posedge clk)
  begin : reg_update_mem0
    if (mem0_we)
      mem0[api_addr[7 : 2]] <= api_wr_data; 
    mem0_api_rd_data <= mem0[api_addr[7 : 2]]; 
    mem0_int_rd_data <= mem0[internal_addr];   
  end
always @ (posedge clk)
  begin : reg_update_mem1
    if (mem1_we)
      mem1[api_addr[7 : 2]] <= api_wr_data; 
    mem1_api_rd_data <= mem1[api_addr[7 : 2]]; 
    mem1_int_rd_data <= mem1[internal_addr];   
  end
always @ (posedge clk)
  begin : reg_update_mem2
    if (mem2_we)
      mem2[api_addr[7 : 2]] <= api_wr_data; 
    mem2_api_rd_data <= mem2[api_addr[7 : 2]]; 
    mem2_int_rd_data <= mem2[internal_addr];   
  end
always @ (posedge clk)
  begin : reg_update_mem3
    if (mem3_we)
      mem3[api_addr[7 : 2]] <= api_wr_data; 
    mem3_api_rd_data <= mem3[api_addr[7 : 2]]; 
    mem3_int_rd_data <= mem3[internal_addr];   
  end
always @*
  begin : api_mux
    mem0_we = 1'b0;
    mem1_we = 1'b0;
    mem2_we = 1'b0;
    mem3_we = 1'b0;
    case (api_addr[1 : 0])
      2'b00:
        begin
          muxed_api_rd_data = mem0_api_rd_data; 
          mem0_we           = api_we;           
        end
      2'b01:
        begin
          muxed_api_rd_data = mem1_api_rd_data; 
          mem1_we           = api_we;           
        end
      2'b10:
        begin
          muxed_api_rd_data = mem2_api_rd_data; 
          mem2_we           = api_we;           
        end
      2'b11:
        begin
          muxed_api_rd_data = mem3_api_rd_data; 
          mem3_we           = api_we;           
        end
      default:
        begin
        end
    endcase 
  end 
endmodule 