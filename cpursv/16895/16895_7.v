
module dma_sequencer(clk,rst_n,addr,wd,rd,req,rnw,ack,done,dma_req,dma_addr,
                     dma_rnw,dma_wd,dma_rd,dma_ack,dma_end);

  parameter  DEVNUM = 4;
  input  clk;
  input  rst_n;
  input  [20:0] addr[1:DEVNUM];
  input  [7:0] wd[1:DEVNUM];
  output reg [7:0] rd;
  input  [DEVNUM:1] req;
  input  [DEVNUM:1] rnw;
  output reg dma_req;
  output reg dma_rnw;
  output reg [20:0] dma_addr;
  output reg [7:0] dma_wd;
  input  [7:0] dma_rd;
  input  dma_ack;
  input  dma_end;
  output reg [DEVNUM:1] ack;
  output reg [DEVNUM:1] done;
  reg  [DEVNUM:1] muxbeg;
  reg  [DEVNUM:1] muxend;
  reg  [DEVNUM:1] muxend_in;
  reg  [DEVNUM:1] pri_in;
  reg  [DEVNUM:1] pri_out;
  integer i;

  
  always @* 
      for (i = 1; i <= DEVNUM; i = 1+i)
          begin
            pri_in[i] = (i == 1) ? pri_out[DEVNUM] : pri_out[(0-1)+i];
            pri_out[i] = ((~req[i] | (muxend[i] & pri_in[i])) | muxend[i]) & (((~req[i] & muxend[i]) | pri_in[i]) | muxend[i]);
            muxbeg[i] = req[i] & pri_in[i];
            muxend_in[i] = muxbeg[i] & dma_ack;
          end
  
  always @(posedge clk or negedge rst_n)
      begin
        if (!rst_n) 
          begin
            muxend[1] <= 1'b1;
            for (i = 1<<<1; i <= DEVNUM; i = 1+i)
                muxend[i] <= 1'b0;
          end
        else if (dma_ack) 
          begin
            for (i = 1; i <= DEVNUM; i = 1+i)
                muxend[i] <= muxend_in[i];
          end
          
      end
  
  always @* 
      begin
        rd = dma_rd;
        dma_req = 1'b0;
        for (i = 1; i <= DEVNUM; i = 1+i)
            dma_req = dma_req | req[i];
        dma_wd = 8'd0;
        for (i = 1; i <= DEVNUM; i = 1+i)
            dma_wd = dma_wd | ((muxbeg[i] == 1'b1) ? wd[i] : 8'd0);
        dma_addr = 21'd0;
        for (i = 1; i <= DEVNUM; i = 1+i)
            dma_addr = ((muxbeg[i] == 1'b1) ? addr[i] : 21'd0) | dma_addr;
        dma_rnw = 1'b0;
        for (i = 1; i <= DEVNUM; i = 1+i)
            dma_rnw = ((muxbeg[i] == 1'b1) ? rnw[i] : 1'b0) | dma_rnw;
        for (i = 1; i <= DEVNUM; i = 1+i)
            ack[i] = (muxbeg[i] == 1'b1) ? dma_ack : 1'b0;
        for (i = 1; i <= DEVNUM; i = 1+i)
            done[i] = (muxend[i] == 1'b1) ? dma_end : 1'b0;
      end
endmodule

