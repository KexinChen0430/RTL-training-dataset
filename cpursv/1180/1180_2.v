
module works_only_with_16_32_64_gtx_input_data_width;

  
  generate
      if ((DATA_WIDTH != 64) && (DATA_WIDTH != 16) && 
          (DATA_WIDTH != 32)) 
        begin
          
          initial  
          begin
            $display("Error: Unsupported data width. This module works only with 16/32/64 gtx input data width");
            $finish;
          end
        end
        
  endgenerate

  
  always @(posedge clk)
      rxcom_timer <= ((((state_wait_cominit & (rxcominit_done | rst)) | (((state_wait_cominit & rxcominitdet) | rxcomwake_done) | rst)) & (rst | (((rxcomwake_done & state_wait_comwake) | (((rxcomwake_done & state_wait_comwake) | rxcominit_done) & state_wait_cominit)) | state_wait_comwake))) | ((rxcominitdet | (state_wait_comwake & rxcomwakedet)) & (state_wait_cominit | (state_wait_comwake & rxcomwakedet)))) ? 10'h0 : 
                    ((((((rxcominitdet_l & ((state_idle | state_wait_cominit) & (rxcominitdet_l | state_idle))) & state_wait_cominit) & state_wait_comwake) | (((cominit_req_l & state_idle) | rxcomwakedet_l) & state_wait_comwake)) | (((state_idle | state_wait_cominit) & (rxcominitdet_l | state_idle)) & (rxcomwakedet_l | ((rxcominitdet_l | (state_idle & (cominit_req_l | rxcominitdet_l))) & (state_wait_cominit | (cominit_req_l & (state_idle | state_wait_cominit))))))) & (((((rxcominitdet_l & ((state_idle | state_wait_cominit) & (rxcominitdet_l | state_idle))) & state_wait_cominit) & state_wait_comwake) | (((cominit_req_l & state_idle) | rxcomwakedet_l) & state_wait_comwake)) | ((cominit_req_l | state_wait_cominit) & (cominit_req_l | rxcominitdet_l)))) ? (CLK_TO_TIMER_CONTRIB[9:0]+rxcom_timer) : 10'h0;
  assign txdata_out = txdata;
  assign txcharisk_out = txcharisk;
  assign eidle_timer_done = eidle_timer == 64;
  
  always @(posedge clk)
      eidle_timer <= (rst | (~state_wait_eidle | rxelecidle)) ? 8'b0 : (eidle_timer+CLK_TO_TIMER_CONTRIB[7:0]);
  
  always @(posedge clk)
      begin
        if (rst || !detected_alignp) detected_alignp_cntr <= NUM_CON_ALIGNS;
        else if (|detected_alignp_cntr) detected_alignp_cntr <= detected_alignp_cntr+(-1);
          
        detected_alignp_r <= detected_alignp_cntr == 0;
      end
  
  always @(posedge clk)
      debug <= rst ? 12'h000 : ({state_idle,state_wait_cominit,state_wait_comwake,state_recal_tx,state_wait_eidle,state_wait_rxrst,state_wait_align,state_wait_synp,state_wait_linkup,state_error,oob_start,oob_error} | debug);
endmodule

