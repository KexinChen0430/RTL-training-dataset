module 32
wire  [31:0] sbox     = `Sbox(addmod32); 
wire  [31:0] shift11  = {sbox[20:0],sbox[31:21]}; 
always @(posedge clk)
  if(rst)
    {b,a} <= {64{1'b0}};
  else if (pvalid && pready) 
    {b,a} <= pdata;
  else if (state == RUN)
    {b,a} <= {a, b^shift11};
always @(posedge clk)
  if (state == READY)
    cdata <= {a,b};
always @(posedge clk)
  if (state == READY)
    cvalid <= 1'b1;
  else
    cvalid <= 1'b0;
always @(posedge clk)
  if ((state == RUN) || (state == READY))
    pready <= 1'b0;
  else if (cready)
    pready <= 1'b1;
endmodule