module grayGap (ad, clk, read, write);
   output [31:0] ad;
   input	 clk, read, write;
   reg [15:0] regff;
   rpmos ad_drv [31:0] (ad, {16'b0, regff}, read);
   always @(posedge clk)
     if (write) regff = ad[15:0];
endmodule