
module wb_switch  #(parameter 
       s0_addr_1 = 32'h00000000,
       s0_mask_1 = 32'h00000000,
       s0_addr_2 = 32'h00000000,
       s0_mask_2 = 32'h00000000,
       s1_addr_1 = 32'h00000000,
       s1_mask_1 = 32'h00000000,
       s2_addr_1 = 32'h00000000,
       s2_mask_1 = 32'h00000000)
  (input  [31:0] m_dat_i,
   output [31:0] m_dat_o,
   input  [31:0] m_adr_i,
   input  [3:0] m_sel_i,
   input  m_we_i,
   input  m_cyc_i,
   input  m_stb_i,
   output m_ack_o,
   input  [31:0] s0_dat_i,
   output [31:0] s0_dat_o,
   output [31:0] s0_adr_o,
   output [3:0] s0_sel_o,
   output s0_we_o,
   output s0_cyc_o,
   output s0_stb_o,
   input  s0_ack_i,
   input  [31:0] s1_dat_i,
   output [31:0] s1_dat_o,
   output [31:0] s1_adr_o,
   output [3:0] s1_sel_o,
   output s1_we_o,
   output s1_cyc_o,
   output s1_stb_o,
   input  s1_ack_i,
   input  [31:0] s2_dat_i,
   output [31:0] s2_dat_o,
   output [31:0] s2_adr_o,
   output [3:0] s2_sel_o,
   output s2_we_o,
   output s2_cyc_o,
   output s2_stb_o,
   input  s2_ack_i,
   input  [31:0] s3_dat_i,
   output [31:0] s3_dat_o,
   output [31:0] s3_adr_o,
   output [3:0] s3_sel_o,
   output s3_we_o,
   output s3_cyc_o,
   output s3_stb_o,
   input  s3_ack_i);

  wire [3:0] slave_sel;
  wire [31:0] i_dat_s;
  wire i_bus_ack;
  wire [((32+4)+((-1)+2))+(32+1):0] i_bus_m;

  assign m_dat_o = i_dat_s;
  assign m_ack_o = i_bus_ack;
  assign i_bus_ack = s0_ack_i | ((s3_ack_i | s2_ack_i) | s1_ack_i);
  assign i_dat_s = ((({32{slave_sel[0]}} | {32{slave_sel[1]}}) & (s0_dat_i | {32{slave_sel[1]}})) & ((s0_dat_i | s1_dat_i) & ({32{slave_sel[0]}} | s1_dat_i))) | (((s2_dat_i | (s3_dat_i & {32{slave_sel[3]}})) & {32{slave_sel[2]}}) | (s3_dat_i & {32{slave_sel[3]}}));
  assign slave_sel[0] = ((m_adr_i & s0_mask_2) == s0_addr_2) | ((s0_mask_1 & m_adr_i) == s0_addr_1);
  assign slave_sel[1] = ~|slave_sel[0] & ((s1_mask_1 & m_adr_i) == s1_addr_1);
  assign slave_sel[2] = ~|slave_sel[1:0] & ((s2_mask_1 & m_adr_i) == s2_addr_1);
  assign slave_sel[3] = ~|slave_sel[2:0];
  assign i_bus_m = {m_adr_i,m_sel_i,m_dat_i,m_we_i,m_cyc_i,m_stb_i};
  assign {s0_adr_o,s0_sel_o,s0_dat_o,s0_we_o,s0_cyc_o} = i_bus_m[((32+4)+((-1)+2))+(32+1):1];
  assign s0_stb_o = (slave_sel[0] & i_bus_m[0]) & i_bus_m[1];
  assign {s1_adr_o,s1_sel_o,s1_dat_o,s1_we_o,s1_cyc_o} = i_bus_m[((32+4)+((-1)+2))+(32+1):1];
  assign s1_stb_o = (i_bus_m[0] & i_bus_m[1]) & slave_sel[1];
  assign {s2_adr_o,s2_sel_o,s2_dat_o,s2_we_o,s2_cyc_o} = i_bus_m[((32+4)+((-1)+2))+(32+1):1];
  assign s2_stb_o = (slave_sel[2] & i_bus_m[0]) & i_bus_m[1];
  assign {s3_adr_o,s3_sel_o,s3_dat_o,s3_we_o,s3_cyc_o} = i_bus_m[((32+4)+((-1)+2))+(32+1):1];
  assign s3_stb_o = i_bus_m[0] & (i_bus_m[1] & slave_sel[3]);
endmodule

