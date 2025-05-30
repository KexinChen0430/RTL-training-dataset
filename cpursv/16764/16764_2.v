
module MemoryHierarchy(clk,rst_n,i_acc,d_rd_acc,d_wr_acc,i_addr,d_addr,d_wrt_data,
                       stall,instr,data);

  input  clk,rst_n,i_acc,d_rd_acc,d_wr_acc;
  input  [15:0] i_addr,d_addr,d_wrt_data;
  output stall;
  output [15:0] instr,data;
  wire rd,wr;
  wire [15:0] addr;
  wire i_hit,d_hit,d_dirt_out,d_dirt_in,m_we,m_re,clean;
  wire [7:0] i_tag,d_tag;
  wire [13:0] m_addr,i_addr_ctrl,d_addr_ctrl;
  wire [63:0] i_line,d_line,m_line,i_data,d_data,m_data;

  cache icache(.clk(clk),.rst_n(rst_n),.addr(i_addr[15:2]),
               .wr_data(i_data),.we(i_we),.re(i_acc),.wdirty(clean),.hit(i_hit),
               .dirty(clean),.rd_data(i_line),.tag_out(i_tag));
  cache dcache(.clk(clk),.rst_n(rst_n),.addr(d_addr[15:2]),
               .wr_data(d_data),.wdirty(d_dirt_in),.we(d_we),.re(d_acc),.hit(d_hit),
               .dirty(dirty),.rd_data(d_line),.tag_out(d_tag));
  unified_mem main_mem(.clk(clk),.rst_n(rst_n),.re(m_re),.we(m_we),
                       .addr(m_addr),.wdata(m_data),.rd_data(m_line),.rdy(m_rdy_n));
  cache_controller controller(.clk(clk),.rst_n(rst_n),.i_hit(i_hit),
                              .d_hit(d_hit),.dirty(dirty),.mem_rdy(m_rdy_n),
                              .d_tag(d_tag),.d_line(d_line),.m_line(m_line),
                              .i_addr(i_addr),.d_addr(d_addr),.wr_data(d_wrt_data),
                              .i_acc(i_acc),.d_acc(d_acc),.read(d_rd_acc | i_acc),
                              .write(d_wr_acc),.i_we(i_we),.d_we(d_we),.d_re(d_re),
                              .m_we(m_we),.m_re(m_re),.d_dirt_in(d_dirt_in),
                              .m_addr(m_addr),.i_data(i_data),.d_data(d_data),
                              .m_data(m_data),.rdy(rdy));
  assign clean = 1'b0;
  assign d_acc = d_rd_acc | d_wr_acc;
  assign stall = rst_n & !rdy;
  assign instr = !rst_n ? 16'hB0FF : 
                 i_addr[1] ? (i_addr[0] ? i_line[63:48] : i_line[47:32]) : 
                 i_addr[0] ? i_line[31:16] : i_line[15:0];
  assign data = !rst_n ? 16'h0000 : 
                d_addr[1] ? (d_addr[0] ? d_line[63:48] : d_line[47:32]) : 
                d_addr[0] ? d_line[31:16] : d_line[15:0];
endmodule

