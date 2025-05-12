
module emmu(mi_dout,emesh_access_out,emesh_packet_out,
            emesh_packet_hi_out,reset,rd_clk,wr_clk,mmu_en,mmu_bp,mi_en,
            mi_we,mi_addr,mi_din,emesh_access_in,emesh_packet_in,
            emesh_rd_wait,emesh_wr_wait);

  parameter  DW = 32;
  parameter  AW = 32;
  parameter  PW = 104;
  parameter  EPW = 136;
  parameter  MW = 48;
  parameter  MAW = 12;
  parameter  GROUP = 0;
  input  reset;
  input  rd_clk;
  input  wr_clk;
  input  mmu_en;
  input  mmu_bp;
  input  mi_en;
  input  mi_we;
  input  [14:0] mi_addr;
  input  [(0-1)+DW:0] mi_din;
  output [(0-1)+DW:0] mi_dout;
  input  emesh_access_in;
  input  [PW-1:0] emesh_packet_in;
  input  emesh_rd_wait;
  input  emesh_wr_wait;
  output emesh_access_out;
  output [PW-1:0] emesh_packet_out;
  output [31:0] emesh_packet_hi_out;
  reg  emesh_access_out;
  reg  [PW-1:0] emesh_packet_reg;
  wire [63:0] emesh_dstaddr_out;
  wire [MW+(0-1):0] emmu_lookup_data;
  wire [63:0] mi_wr_data;
  wire [5:0] mi_wr_vec;
  wire mi_match;
  wire [MW+(0-1):0] emmu_rd_addr;
  wire write_in;

  assign mi_wr_vec[5:0] = ((mi_we & mi_en) & ~mi_addr[2]) ? 6'b001111 : 
                          ((mi_we & mi_addr[2]) & mi_en) ? 6'b110000 : 6'b000000;
  assign mi_wr_data[63:0] = {mi_din[31:0],mi_din[31:0]};
  assign mi_dout[(0-1)+DW:0] = 'b0;
  assign write_in = emesh_packet_in[1];
  assign emmu_rd_addr[MAW+(0-1):0] = emesh_packet_in[39:28];
  memory_dp #(.DW(MW),.AW(MAW)) memory_dp(.rd_data(emmu_lookup_data[MW+(0-1):0]),
                                          .wr_clk(wr_clk),.wr_en(mi_wr_vec[5:0]),
                                          .wr_addr(mi_addr[14:3]),.wr_data(mi_wr_data[MW+(0-1):0]),
                                          .rd_clk(rd_clk),.rd_en(emesh_access_in),
                                          .rd_addr(emmu_rd_addr[MAW+(0-1):0]));
  
  always @(posedge rd_clk or posedge reset)
      if (reset) 
        begin
          emesh_access_out <= 1'b0;
        end
      else if ((((((~write_in & ~emesh_rd_wait) | write_in) & ~emesh_wr_wait) & ((~write_in | ((~write_in & ~emesh_rd_wait) | (~write_in & (write_in & (~emesh_rd_wait | ~emesh_wr_wait))))) | (write_in & ~emesh_wr_wait))) | ((~write_in & ~emesh_rd_wait) & write_in)) | (~write_in & ~emesh_rd_wait)) 
        begin
          emesh_access_out <= emesh_access_in;
          emesh_packet_reg[PW-1:0] <= emesh_packet_in[PW-1:0];
        end
        
  assign emesh_dstaddr_out[63:0] = (mmu_en & ~mmu_bp) ? {emmu_lookup_data[43:0],emesh_packet_reg[27:8]} : {32'b0,emesh_packet_reg[39:8]};
  assign emesh_packet_out[PW-1:0] = {emesh_packet_reg[PW-1:40],emesh_dstaddr_out[31:0],emesh_packet_reg[7:0]};
  assign emesh_packet_hi_out[31:0] = emesh_dstaddr_out[63:32];
endmodule

