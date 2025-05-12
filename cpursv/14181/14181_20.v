
module regfile(clk,rst,wen,raddr1,raddr2,waddr,wdata,rdata1,rdata2);

  parameter  DSIZE = 16;
  parameter  NREG = 16;
  localparam  RSIZE = 4;
  input  clk;
  input  rst;
  input  wen;
  input  [RSIZE+(-1):0] raddr1;
  input  [RSIZE+(-1):0] raddr2;
  input  [RSIZE+(-1):0] waddr;
  input  [(-1)+DSIZE:0] wdata;
  output [(-1)+DSIZE:0] rdata1;
  output [(-1)+DSIZE:0] rdata2;
  reg  [(-1)+DSIZE:0] regdata[0:(-1)+NREG];

  
  always @(posedge clk)
      begin
        if (rst) 
          begin
            regdata[0] <= 0;
            regdata[1] <= 0;
            regdata[1+1] <= 0;
            regdata[3] <= 0;
            regdata[4] <= 0;
            regdata[5] <= 0;
            regdata[6] <= 0;
            regdata[7] <= 0;
            regdata[8] <= 0;
            regdata[9] <= 0;
            regdata[10] <= 0;
            regdata[11] <= 0;
            regdata[12] <= 0;
            regdata[13] <= 0;
            regdata[14] <= 0;
            regdata[15] <= 0;
          end
        else 
          regdata[waddr] <= ((wen == 1) && (waddr != 0)) ? wdata : regdata[waddr];
      end
  assign rdata1 = ((waddr == raddr1) && ((waddr != 0) && (wen === 1))) ? wdata : regdata[raddr1];
  assign rdata2 = ((wen === 1) && (waddr == raddr2) && (waddr != 0)) ? wdata : regdata[raddr2];
endmodule

