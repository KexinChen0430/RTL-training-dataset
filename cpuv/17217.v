module link_rxi_ctrl(
   lclk,           
   io_lclk,        
   rxi_cfg_reg     
   );
   parameter DW = `CFG_DW;
   input           io_lclk;    
   input [DW-1:0]  rxi_cfg_reg;
   output  lclk;   
   assign lclk   =  io_lclk;
endmodule