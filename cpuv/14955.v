module syscon (
   wb_clk_o, wb_rst_o, adc0_clk, adc1_clk, adc2_clk, adc3_clk,
   clk_pad_i, rst_pad_i, adc0_clk_speed_select, adc1_clk_speed_select,
   adc2_clk_speed_select, adc3_clk_speed_select
   );
   input clk_pad_i; 
   input rst_pad_i; 
   output wb_clk_o; 
   output wb_rst_o; 
   input [2:0] adc0_clk_speed_select; 
   input [2:0] adc1_clk_speed_select; 
   input [2:0] adc2_clk_speed_select; 
   input [2:0] adc3_clk_speed_select; 
   output wire adc0_clk; 
   output wire adc1_clk; 
   output wire adc2_clk; 
   output wire adc3_clk; 
   wire   locked; 
`ifdef SIM
   assign wb_clk_o = clk_pad_i;
   assign locked = 1'b1;
   adc_clk_gen adc0_clk_gen(
                            .adc_clk(adc0_clk), 
                            .wb_clk(wb_clk_o), 
                            .rst_pad_i(rst_pad_i), 
                            .clk_speed_select(adc0_clk_speed_select) 
                            );
   adc_clk_gen adc1_clk_gen(
                            .adc_clk(adc1_clk), 
                            .wb_clk(wb_clk_o), 
                            .rst_pad_i(rst_pad_i), 
                            .clk_speed_select(adc1_clk_speed_select) 
                            );
   adc_clk_gen adc2_clk_gen(
                            .adc_clk(adc2_clk), 
                            .wb_clk(wb_clk_o), 
                            .rst_pad_i(rst_pad_i), 
                            .clk_speed_select(adc2_clk_speed_select) 
                            );
   adc_clk_gen adc3_clk_gen(
                            .adc_clk(adc3_clk), 
                            .wb_clk(wb_clk_o), 
                            .rst_pad_i(rst_pad_i), 
                            .clk_speed_select(adc3_clk_speed_select) 
                            );
`else
`endif
   reg [31:0] wb_rst_shr; 
   always @(posedge wb_clk_o or posedge rst_pad_i)
	 if (rst_pad_i)
	   wb_rst_shr <= 32'hffff_ffff; 
	 else
	   wb_rst_shr <= {wb_rst_shr[30:0], ~(locked)}; 
   assign wb_rst_o = wb_rst_shr[31]; 
endmodule