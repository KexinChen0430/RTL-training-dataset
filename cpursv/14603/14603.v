
module pfpu  #(parameter  csr_addr = 4'h0)
  (input  sys_clk,
   input  sys_rst,
   input  [13:0] csr_a,
   input  csr_we,
   input  [31:0] csr_di,
   output [31:0] csr_do,
   output irq,
   output [31:0] wbm_dat_o,
   output [31:0] wbm_adr_o,
   output wbm_cyc_o,
   output wbm_stb_o,
   input  wbm_ack_i);

  wire alu_rst;
  wire [31:0] a;
  wire [31:0] b;
  wire ifb;
  wire [3:0] opcode;
  wire [31:0] r;
  wire r_valid;
  wire dma_en;
  wire err_collision;

  pfpu_alu alu(.sys_clk(sys_clk),.alu_rst(alu_rst),.a(a),.b(b),
               .ifb(ifb),.opcode(opcode),.r(r),.r_valid(r_valid),
               .dma_en(dma_en),.err_collision(err_collision));
  wire c_en;

  wire [6:0] a_addr;

  wire [6:0] b_addr;

  wire [6:0] w_addr;

  wire [6:0] cr_addr;

  wire [31:0] cr_dr;

  wire [31:0] cr_dw;

  wire cr_w_en;

  wire [31:0] r0;

  wire [31:0] r1;

  wire err_stray;

  pfpu_regf regf(.sys_clk(sys_clk),.sys_rst(sys_rst),.ifb(ifb),.a(a),
                 .b(b),.r(r),.w_en(r_valid),.a_addr(a_addr),
                 .b_addr(b_addr),.w_addr(w_addr),.c_en(c_en),.c_addr(cr_addr),
                 .c_do(cr_dr),.c_di(cr_dw),.c_w_en(cr_w_en),.r0(r0),.r1(r1),
                 .err_stray(err_stray));
  wire [28:0] dma_base;

  wire dma_busy;

  wire dma_ack;

  pfpu_dma dma(.sys_clk(sys_clk),.sys_rst(sys_rst),.dma_en(dma_en),
               .dma_base(dma_base),.x(r0[6:0]),.y(r1[6:0]),.dma_d1(a),.dma_d2(b),
               .busy(dma_busy),.ack(dma_ack),.wbm_dat_o(wbm_dat_o),
               .wbm_adr_o(wbm_adr_o),.wbm_cyc_o(wbm_cyc_o),.wbm_stb_o(wbm_stb_o),
               .wbm_ack_i(wbm_ack_i));
  wire vfirst;

  wire vnext;

  wire [6:0] hmesh_last;

  wire [6:0] vmesh_last;

  wire vlast;

  pfpu_counters counters(.sys_clk(sys_clk),.first(vfirst),
                         .next(vnext),.hmesh_last(hmesh_last),
                         .vmesh_last(vmesh_last),.r0(r0),.r1(r1),.last(vlast));
  wire pcount_rst;

  wire [1:0] cp_page;

  wire [8:0] cp_offset;

  wire [31:0] cp_dr;

  wire [31:0] cp_dw;

  wire cp_w_en;

  wire [10:0] pc;

  pfpu_prog prog(.sys_clk(sys_clk),.count_rst(pcount_rst),
                 .a_addr(a_addr),.b_addr(b_addr),.opcode(opcode),.w_addr(w_addr),
                 .c_en(c_en),.c_page(cp_page),.c_offset(cp_offset),.c_do(cp_dr),
                 .c_di(cp_dw),.c_w_en(cp_w_en),.pc(pc));
  wire start;

  wire busy;

  pfpu_seq seq(.sys_clk(sys_clk),.sys_rst(sys_rst),.alu_rst(alu_rst),
               .dma_en(dma_en),.dma_busy(dma_busy),.dma_ack(dma_ack),.vfirst(vfirst),
               .vnext(vnext),.vlast(vlast),.pcount_rst(pcount_rst),.c_en(c_en),
               .start(start),.busy(busy));
  pfpu_ctlif #(.csr_addr(csr_addr)) ctlif(.sys_clk(sys_clk),
                                          .sys_rst(sys_rst),.csr_a(csr_a),
                                          .csr_we(csr_we),.csr_di(csr_di),
                                          .csr_do(csr_do),.irq(irq),.start(start),
                                          .busy(busy),.dma_base(dma_base),
                                          .hmesh_last(hmesh_last),.vmesh_last(vmesh_last),
                                          .cr_addr(cr_addr),.cr_di(cr_dr),
                                          .cr_do(cr_dw),.cr_w_en(cr_w_en),
                                          .cp_page(cp_page),.cp_offset(cp_offset),
                                          .cp_di(cp_dr),.cp_do(cp_dw),
                                          .cp_w_en(cp_w_en),.vnext(vnext),
                                          .err_collision(err_collision),.err_stray(err_stray),
                                          .pc(pc),.wbm_adr_o(wbm_adr_o),
                                          .wbm_ack_i(wbm_ack_i));
endmodule

