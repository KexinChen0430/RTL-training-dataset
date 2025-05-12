
module Test2  #(parameter  DW = 4)
  (input  wire [(0-1)+DW:0] drv_a,
   input  wire [(0-1)+DW:0] drv_b,
   input  wire [(0-1)+DW:0] drv_e,
   inout  wire [(0-1)+DW:0] drv2);

  wire [(0-1)+DW:0] drv_all;

  bufif1 bufa[(0-1)+DW:0](drv_all,drv_a,drv_e);
  bufif1 bufb[(0-1)+DW:0]({drv_all[3],drv_all[1<<1],drv_all[1],drv_all[0]},
                          {drv_b[3],drv_b[1<<1],drv_b[1],drv_b[0]},{~drv_e[3],~drv_e[1<<1],~drv_e[1],~drv_e[0]});
  assign drv2 = drv_all;
endmodule

