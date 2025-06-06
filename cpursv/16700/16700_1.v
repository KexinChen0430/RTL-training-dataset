
module blockmem_rw32_r128(input  wire clk,
                          input  wire api_we,
                          input  wire [7:0] api_addr,
                          input  wire [31:0] api_wr_data,
                          output wire [31:0] api_rd_data,
                          input  wire [4:0] internal_addr,
                          output wire [255:0] internal_rd_data);

  reg  [31:0] mem0[0:31];
  reg  [31:0] mem1[0:31];
  reg  [31:0] mem2[0:31];
  reg  [31:0] mem3[0:31];
  reg  [31:0] mem4[0:31];
  reg  [31:0] mem5[0:31];
  reg  [31:0] mem6[0:31];
  reg  [31:0] mem7[0:31];
  reg  [31:0] muxed_api_rd_data;
  reg  [31:0] mem0_api_rd_data;
  reg  [31:0] mem1_api_rd_data;
  reg  [31:0] mem2_api_rd_data;
  reg  [31:0] mem3_api_rd_data;
  reg  [31:0] mem4_api_rd_data;
  reg  [31:0] mem5_api_rd_data;
  reg  [31:0] mem6_api_rd_data;
  reg  [31:0] mem7_api_rd_data;
  reg  [31:0] mem0_int_rd_data;
  reg  [31:0] mem1_int_rd_data;
  reg  [31:0] mem2_int_rd_data;
  reg  [31:0] mem3_int_rd_data;
  reg  [31:0] mem4_int_rd_data;
  reg  [31:0] mem5_int_rd_data;
  reg  [31:0] mem6_int_rd_data;
  reg  [31:0] mem7_int_rd_data;
  reg  mem0_we;
  reg  mem1_we;
  reg  mem2_we;
  reg  mem3_we;
  reg  mem4_we;
  reg  mem5_we;
  reg  mem6_we;
  reg  mem7_we;

  assign api_rd_data = muxed_api_rd_data;
  assign internal_rd_data = {mem7_int_rd_data,mem6_int_rd_data,mem5_int_rd_data,mem4_int_rd_data,mem3_int_rd_data,mem2_int_rd_data,mem1_int_rd_data,mem0_int_rd_data};
  
  always @(posedge clk)
      begin : reg_update_mem0
        if (mem0_we) mem0[api_addr[7:3]] <= api_wr_data;
          
        mem0_api_rd_data <= mem0[api_addr[7:3]];
        mem0_int_rd_data <= mem0[internal_addr];
      end
  
  always @* 
      begin : api_mux
        mem0_we = 1'b0;
        mem1_we = 1'b0;
        mem2_we = 1'b0;
        mem3_we = 1'b0;
        mem4_we = 1'b0;
        mem5_we = 1'b0;
        mem6_we = 1'b0;
        mem7_we = 1'b0;
        case (api_addr[2:0])

          0: begin
                muxed_api_rd_data = mem0_api_rd_data;
                mem0_we = api_we;
              end

          default: begin

              end

        endcase

      end
endmodule

