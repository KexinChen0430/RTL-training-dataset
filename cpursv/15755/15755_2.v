
module ISP1761_IF(csi_clk,csi_reset_n,s_cs_n,s_address,s_write_n,s_writedata,
                  s_read_n,s_readdata,s_hc_irq,s_dc_irq,s_dc_readdata,CS_N,WR_N,
                  RD_N,D,A,DC_IRQ,HC_IRQ,DC_DREQ,HC_DREQ,DC_DACK,HC_DACK);

  input  csi_clk;
  input  csi_reset_n;
  input  s_cs_n;
  input  [15:0] s_address;
  input  s_write_n;
  input  [31:0] s_writedata;
  input  s_read_n;
  output [31:0] s_readdata;
  output s_hc_irq;
  output s_dc_irq;
  output [31:0] s_dc_readdata;
  output CS_N;
  output WR_N;
  output RD_N;
  inout  [31:0] D;
  output [17:1] A;
  input  DC_IRQ;
  input  HC_IRQ;
  input  DC_DREQ;
  input  HC_DREQ;
  output DC_DACK;
  output HC_DACK;

  assign CS_N = s_cs_n;
  assign WR_N = s_write_n;
  assign RD_N = s_read_n;
  assign A = {s_address[15:0],1'b0};
  assign s_hc_irq = HC_IRQ;
  assign s_dc_irq = DC_IRQ;
  assign D = (s_read_n & !s_cs_n) ? s_writedata : 32'hzzzzzzzz;
  assign s_readdata = D;
endmodule

