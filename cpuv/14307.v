module bug26969 (input [31:0] ad, output [15:0] regff, input [31:0] read);
   bufif0 ad_drv [31:0] (ad, {16'b0, regff}, read);
endmodule