
module emmu(output [(-1)+DW:0] mi_dout,
            output emmu_access_out,
            output emmu_write_out,
            output [1:0] emmu_datamode_out,
            output [3:0] emmu_ctrlmode_out,
            output [63:0] emmu_dstaddr_out,
            output [(-1)+AW:0] emmu_srcaddr_out,
            output [(-1)+DW:0] emmu_data_out,
            input  clk,
            input  reset,
            input  mmu_en,
            input  mi_clk,
            input  mi_en,
            input  mi_we,
            input  [15:0] mi_addr,
            input  [(-1)+DW:0] mi_din,
            input  emesh_access_in,
            input  emesh_write_in,
            input  [1:0] emesh_datamode_in,
            input  [3:0] emesh_ctrlmode_in,
            input  [(-1)+AW:0] emesh_dstaddr_in,
            input  [(-1)+AW:0] emesh_srcaddr_in,
            input  [(-1)+DW:0] emesh_data_in);

  parameter  DW = 32;
  parameter  AW = 32;
  parameter  IDW = 12;
  parameter  PAW = 64;
  parameter  MW = IDW+(PAW-AW);
  parameter  RFAW = IDW+1;
  input  clk;
  input  reset;
  input  mmu_en;
  input  mi_clk;
  input  mi_en;
  input  mi_we;
  input  [15:0] mi_addr;
  input  [(-1)+DW:0] mi_din;
  output [(-1)+DW:0] mi_dout;
  input  emesh_access_in;
  input  emesh_write_in;
  input  [1:0] emesh_datamode_in;
  input  [3:0] emesh_ctrlmode_in;
  input  [(-1)+AW:0] emesh_dstaddr_in;
  input  [(-1)+AW:0] emesh_srcaddr_in;
  input  [(-1)+DW:0] emesh_data_in;
  output emmu_access_out;
  output emmu_write_out;
  output [1:0] emmu_datamode_out;
  output [3:0] emmu_ctrlmode_out;
  output [63:0] emmu_dstaddr_out;
  output [(-1)+AW:0] emmu_srcaddr_out;
  output [(-1)+DW:0] emmu_data_out;
  reg  emmu_access_out;
  reg  emmu_write_out;
  reg  [1:0] emmu_datamode_out;
  reg  [3:0] emmu_ctrlmode_out;
  reg  [(-1)+AW:0] emmu_srcaddr_out;
  reg  [(-1)+DW:0] emmu_data_out;
  reg  [(-1)+AW:0] emmu_dstaddr_reg;
  wire [47:0] emmu_lookup_data;
  wire [63:0] emmu_wr_data;
  wire emmu_write;
  wire [5:0] emmu_wr_en;

  assign emmu_write = mi_en & mi_we;
  assign emmu_wr_en[5:0] = (emmu_write & ~mi_addr[1<<1]) ? 6'b001111 : 
                           (mi_addr[1<<1] & emmu_write) ? 6'b110000 : 6'b000000;
  assign emmu_wr_data[63:0] = {mi_din[31:0],mi_din[31:0]};
  memory_dp #(.DW(48),.AW(12)) memory_dp(.rd_data(emmu_lookup_data[47:0]),
                                         .wr_clk(mi_clk),.wr_en(emmu_wr_en[5:0]),
                                         .wr_addr(mi_addr[14:3]),.wr_data(emmu_wr_data[47:0]),
                                         .rd_clk(clk),.rd_en(emesh_access_in),
                                         .rd_addr(emesh_dstaddr_in[31:20]));
  
  always @(posedge clk)
      begin
        emmu_access_out <= emesh_access_in;
      end
  
  always @(posedge clk)
      begin
        if (emesh_access_in) 
          begin
            emmu_write_out <= emesh_write_in;
            emmu_data_out[(-1)+DW:0] <= emesh_data_in[(-1)+DW:0];
            emmu_srcaddr_out[(-1)+AW:0] <= emesh_srcaddr_in[(-1)+AW:0];
            emmu_dstaddr_reg[(-1)+AW:0] <= emesh_dstaddr_in[(-1)+AW:0];
            emmu_ctrlmode_out[3:0] <= emesh_ctrlmode_in[3:0];
            emmu_datamode_out[1:0] <= emesh_datamode_in[1:0];
          end
          
      end
  assign emmu_dstaddr_out[63:0] = mmu_en ? {emmu_lookup_data[43:0],emmu_dstaddr_reg[19:0]} : {32'b0,emmu_dstaddr_reg[31:0]};
endmodule

