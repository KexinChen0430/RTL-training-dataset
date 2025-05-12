
module BFM_AHBSLAVE(HCLK,HRESETN,HSEL,HWRITE,HADDR,HWDATA,HRDATA,HREADYIN,
                    HREADYOUT,HTRANS,HSIZE,HBURST,HMASTLOCK,HPROT,HRESP);

  parameter  AWIDTH = 10;
  parameter  DEPTH = 256;
  parameter  INITFILE = " ";
  parameter  ID = 0;
  parameter  ENFUNC = 0;
  parameter  TPD = 1;
  parameter  DEBUG = 1;
  localparam  ENFIFO = 0;
  localparam  EXT_SIZE = 1<<<1;
  input  HCLK;
  input  HRESETN;
  input  HSEL;
  input  HWRITE;
  input  [AWIDTH-1:0] HADDR;
  input  [31:0] HWDATA;
  output [31:0] HRDATA;
  input  HREADYIN;
  output HREADYOUT;
  input  [1:0] HTRANS;
  input  [1<<<1:0] HSIZE;
  input  [1<<<1:0] HBURST;
  input  HMASTLOCK;
  input  [3:0] HPROT;
  output HRESP;
  wire EXT_EN;
  wire EXT_WR;
  wire EXT_RD;
  wire [AWIDTH-1:0] EXT_ADDR;
  wire [31:0] EXT_DATA;

  assign EXT_EN = 1'b0;
  assign EXT_WR = 1'b0;
  assign EXT_RD = 1'b0;
  assign EXT_ADDR = 0;
  assign EXT_DATA = {32{1'bZ}};
  BFM_AHBSLAVEEXT #(.AWIDTH(AWIDTH),.DEPTH(DEPTH),.EXT_SIZE(EXT_SIZE),
.INITFILE(INITFILE),.ID(ID),.ENFUNC(ENFUNC),.ENFIFO(ENFIFO),.TPD(TPD),.DEBUG(DEBUG)) BFMA1OI1II(.HCLK(HCLK),
                                                                                                                                                                       .HRESETN(HRESETN),.HSEL(HSEL),
                                                                                                                                                                       .HWRITE(HWRITE),.HADDR(HADDR),
                                                                                                                                                                       .HWDATA(HWDATA),.HRDATA(HRDATA),
                                                                                                                                                                       .HREADYIN(HREADYIN),.HREADYOUT(HREADYOUT),
                                                                                                                                                                       .HTRANS(HTRANS),.HSIZE(HSIZE),
                                                                                                                                                                       .HBURST(HBURST),.HMASTLOCK(HMASTLOCK),
                                                                                                                                                                       .HPROT(HPROT),.HRESP(HRESP),
                                                                                                                                                                       .TXREADY(BFMA1II1II),.RXREADY(BFMA1II1II),
                                                                                                                                                                       .EXT_EN(EXT_EN),.EXT_WR(EXT_WR),
                                                                                                                                                                       .EXT_RD(EXT_RD),.EXT_ADDR(EXT_ADDR),
                                                                                                                                                                       .EXT_DATA(EXT_DATA));
endmodule

