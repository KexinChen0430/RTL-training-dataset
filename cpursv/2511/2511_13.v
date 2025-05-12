
module jt_sfg01(input  rst,
                output [7:0] sfg_dbi,
                input  [7:0] sfg_dbo,
                input  [15:0] addr,
                input  clk,
                input  wr_n,
                input  rd_n,
                input  slt3_n,
                input  iorq_n,
                input  mi,
                output int_n,
                output wait_n,
                output oe_n,
                output [15:0] left,
                output [15:0] right);

  wire  ce_n = &addr[13:7];
  wire  ic106_4 = ~(ce_n & addr[6]);
  wire  ic106_2 = ~(addr[5] & addr[4]);
  wire  ic107_3 = ~(~ic106_4 & ~ic106_2);
  wire  ic107_4 = ~(~addr[3] & ~ic107_3);
  wire  cs_n = ~(~ic107_4 & ~slt3_n);

  assign busdir_n = ~(~mi & ~iorq_n);
  assign wait_n = 1'b1;
  wire  opm_n = !((addr[2:1] == 2'b00) && !cs_n);

  assign oe_n = !(!ce_n && !slt3_n);
  jt51(.clk(clk),.rst(rst),.cs_n(opm_n),.wr_n(wr_n),.a0(addr[0]),
       .d_in(sfg_dbo),.d_out(sfg_dbi),.irq_n(int_n),.left(left),.right(right));
endmodule

