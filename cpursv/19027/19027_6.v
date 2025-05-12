
module Test2  #(parameter  DW = 4)
  (input  wire [DW-1:0] drv_a,
   input  wire [DW-1:0] drv_b,
   input  wire [DW-1:0] drv_e,
   inout  wire [DW-1:0] drv2);

  wire [DW-1:0] drv_all;

  bufif1 bufa[DW-1:0](drv_all,drv_a,drv_e);
  bufif1 bufb[DW-1:0]({drv_all[3],drv_all[2],drv_all[1],drv_all[0]},
                      {drv_b[3],drv_b[2],drv_b[1],drv_b[0]},{~drv_e[3],~drv_e[2],~drv_e[1],~drv_e[0]});
  assign drv2 = drv_all;
endmodule

