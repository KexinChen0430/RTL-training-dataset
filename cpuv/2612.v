module aurora_64b66b_25p4G_common_logic_cbcc #
 (
      parameter BACKWARD_COMP_MODE1 = 1'b0
 )
 (
  input start_cb_writes_in, 
  input do_rd_en_in, 
  input bit_err_chan_bond_in, 
  input final_gater_for_fifo_din_in, 
  input any_vld_btf_in, 
  input cbcc_fifo_reset_wr_clk, 
  input cbcc_fifo_reset_rd_clk, 
  output reg all_start_cb_writes_out, 
  output reg master_do_rd_en_out, 
  output reg cb_bit_err_out, 
  output reg all_vld_btf_out, 
  input rxrecclk_to_fabric, 
  input rxusrclk2_in 
 );
 reg second_cb_write_failed =1'b0;
 always @(posedge rxrecclk_to_fabric)
   begin
       if(cbcc_fifo_reset_wr_clk)
       begin
           all_start_cb_writes_out <= `DLY 1'b0;
       end
       else
       begin
           all_start_cb_writes_out <= `DLY start_cb_writes_in;
       end
   end
 always @(posedge rxrecclk_to_fabric)
   begin
       if(cbcc_fifo_reset_wr_clk)
       begin
           all_vld_btf_out <= `DLY 1'b0;
       end
       else
       begin
           all_vld_btf_out <= `DLY  any_vld_btf_in;
       end
   end
 always @(posedge rxusrclk2_in)
   begin
       if(cbcc_fifo_reset_rd_clk)
       begin
           master_do_rd_en_out <= `DLY 1'b0;
       end
       else
       begin
           master_do_rd_en_out <= `DLY  do_rd_en_in;
       end
   end
 always @(posedge rxrecclk_to_fabric)
     begin
         if(cbcc_fifo_reset_wr_clk)
             second_cb_write_failed <= `DLY 1'b0;
         else
             second_cb_write_failed <= bit_err_chan_bond_in;
       end
 always @(posedge rxrecclk_to_fabric)
     begin
         if(cbcc_fifo_reset_wr_clk)
             cb_bit_err_out <= `DLY 1'b0;
         else
             cb_bit_err_out <= (BACKWARD_COMP_MODE1) ? 1'b0 : second_cb_write_failed ;
     end
endmodule