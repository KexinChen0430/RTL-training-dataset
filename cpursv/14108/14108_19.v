
module hpdmc_busif  #(parameter  sdram_depth = 26)
  (input  sys_clk,
   input  sdram_rst,
   input  [(-1)+sdram_depth:0] fml_adr,
   input  fml_stb,
   input  fml_we,
   output fml_ack,
   output mgmt_stb,
   output mgmt_we,
   output [(-1)+(sdram_depth-3):0] mgmt_address,
   input  mgmt_ack,
   input  data_ack);

  reg  mgmt_stb_en;

  assign mgmt_stb = fml_stb & mgmt_stb_en;
  assign mgmt_we = fml_we;
  assign mgmt_address = fml_adr[(-1)+sdram_depth:3];
  assign fml_ack = data_ack;
  
  always @(posedge sys_clk)
      begin
        if (sdram_rst) mgmt_stb_en = 1'b1;
        else 
          begin
            if (mgmt_ack) mgmt_stb_en = 1'b0;
              
            if (data_ack) mgmt_stb_en = 1'b1;
              
          end
      end
endmodule

