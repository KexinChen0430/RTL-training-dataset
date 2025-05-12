
module mod(m_src_getn,m_dst_putn,m_dst,m_dst_last,m_endn,m_cap,wb_clk_i,
           m_reset,m_enable,dc,m_src,m_src_last,m_src_almost_empty,
           m_src_empty,m_dst_almost_full,m_dst_full);

  input  wb_clk_i;
  input  m_reset;
  input  m_enable;
  wire  wb_rst_i = m_reset;
  input  [23:0] dc;
  output m_src_getn;
  input  [63:0] m_src;
  input  m_src_last;
  input  m_src_almost_empty;
  input  m_src_empty;
  output m_dst_putn;
  output [63:0] m_dst;
  output m_dst_last;
  input  m_dst_almost_full;
  input  m_dst_full;
  output m_endn;
  output [7:0] m_cap;

  pullup(m_dst_putn);
  pullup(m_src_getn);
  pullup(m_endn);
  wire  fo_full = m_dst_almost_full || m_dst_full;

  wire  src_empty = m_src_empty || m_src_almost_empty;

  wire [15:0] en_out_data,de_out_data;

  wire en_out_valid,de_out_valid;

  wire en_out_done,de_out_done;

  encode encode(.ce(m_enable && dc[5]),.fi(m_src),.clk(wb_clk_i),
                .rst(wb_rst_i),.data_o(en_out_data),.done_o(en_out_done),
                .valid_o(en_out_valid),.m_last(m_src_last),.m_src_getn(m_src_getn),
                .fo_full(fo_full),.src_empty(src_empty));
  decode decode(.ce(m_enable && dc[6]),.fi(m_src),.clk(wb_clk_i),
                .rst(wb_rst_i),.data_o(de_out_data),.done_o(de_out_done),
                .valid_o(de_out_valid),.m_last(m_src_last),.m_src_getn(m_src_getn),
                .fo_full(fo_full),.src_empty(src_empty));
  codeout codeout(.m_dst(m_dst[63:0]),.m_dst_putn(m_dst_putn),
                  .m_dst_last(m_dst_last),.m_endn(m_endn),.wb_clk_i(wb_clk_i),
                  .wb_rst_i(wb_rst_i),.dc(dc[23:0]),.en_out_data(en_out_data[15:0]),
                  .de_out_data(de_out_data[15:0]),.en_out_valid(en_out_valid),
                  .de_out_valid(de_out_valid),.en_out_done(en_out_done),
                  .de_out_done(de_out_done),.m_enable(m_enable));
  assign m_cap = {1'b1,1'b1,1'b0,1'b0,1'b0,1'b0,1'b0};
endmodule

