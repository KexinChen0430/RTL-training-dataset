
module works_only_with_16_32_64_gtx_input_data_width;

  
  generate
      if ((DATA_WIDTH != 32) && 
          ((DATA_WIDTH != 64) && (DATA_WIDTH != 16))) 
        begin
          
          initial  
          begin
            $display("Error: Unsupported data width. This module works only with 16/32/64 gtx input data width");
            $finish;
          end
        end
        
  endgenerate

  
  always @(posedge clk)
      rxcom_timer <= ((((state_wait_cominit | (state_wait_comwake & rxcomwakedet)) | (((rxcominit_done | rxcomwake_done) | rst) & (state_wait_comwake | (rxcominit_done | rst)))) & (((((rxcominitdet & state_wait_cominit) | rst) | state_wait_cominit) | (((rxcomwake_done & state_wait_comwake) | state_wait_cominit) & ((rxcominit_done | (rxcomwake_done & state_wait_comwake)) & (((rxcominitdet | (state_wait_cominit & rxcominit_done)) | rst) | (rxcomwake_done & state_wait_comwake))))) | (state_wait_cominit | (state_wait_comwake & rxcomwakedet)))) & ((((((rst | state_wait_comwake) & (rst | rxcomwake_done)) | state_wait_comwake) | ((rst & state_wait_cominit) | (state_wait_cominit & rxcominit_done))) | ((state_wait_comwake & rxcomwakedet) | rxcominitdet)) & ((rst | (rxcomwake_done | (state_wait_cominit & rxcominit_done))) | ((state_wait_comwake & rxcomwakedet) | rxcominitdet)))) ? 10'h0 : 
                    ((rxcominitdet_l & state_wait_cominit) | (((state_wait_comwake & ((((state_idle & ((cominit_req_l | rxcominitdet_l) & (state_idle | rxcominitdet_l))) | rxcomwakedet_l) & (rxcomwakedet_l | cominit_req_l)) | state_wait_cominit)) & ((cominit_req_l & state_idle) | (rxcomwakedet_l | rxcominitdet_l))) | (cominit_req_l & state_idle))) ? (rxcom_timer+CLK_TO_TIMER_CONTRIB[9:0]) : 10'h0;
  assign txdata_out = txdata;
  assign txcharisk_out = txcharisk;
  assign eidle_timer_done = eidle_timer == 64;
  
  always @(posedge clk)
      eidle_timer <= ((rxelecidle | rst) | ~state_wait_eidle) ? 8'b0 : (eidle_timer+CLK_TO_TIMER_CONTRIB[7:0]);
  
  always @(posedge clk)
      begin
        if (rst || !detected_alignp) detected_alignp_cntr <= NUM_CON_ALIGNS;
        else if (|detected_alignp_cntr) detected_alignp_cntr <= (0-1)+detected_alignp_cntr;
          
        detected_alignp_r <= detected_alignp_cntr == 0;
      end
  
  always @(posedge clk)
      debug <= rst ? 12'h000 : ({state_idle,state_wait_cominit,state_wait_comwake,state_recal_tx,state_wait_eidle,state_wait_rxrst,state_wait_align,state_wait_synp,state_wait_linkup,state_error,oob_start,oob_error} | debug);
endmodule

