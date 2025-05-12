
module Test2(input  wire [3:0] drv_a,
             input  wire [3:0] drv_e,
             output wire [8:0] match2);

  wire [2:1] drv_all;

  bufif1 bufa[2:1](drv_all,drv_a[2:1],drv_e[2:1]);
  assign match2[0] = drv_all !== 2'b00;
  assign match2[1] = drv_all !== 2'b01;
  assign match2[2] = drv_all !== 2'b10;
  assign match2[3] = drv_all !== 2'b11;
  assign match2[4] = drv_all !== 2'bz0;
  assign match2[5] = drv_all !== 2'bz1;
  assign match2[6] = drv_all !== 2'bzz;
  assign match2[7] = drv_all !== 2'b0z;
  assign match2[8] = drv_all !== 2'b1z;
endmodule

