module aurora_64b66b_25p4G_CH_BOND_MASTER # 
 (
   parameter CHAN_BOND_MODE=2'b01, 
   parameter CHAN_BOND_MAX_SKEW=2'b10 
 )
 (
   enchansync, 
   CB_enb_stop, 
   CB_enb_stop_dlyd, 
   CB_align_ver, 
   ch_bond_m, 
   rxchanisaligned, 
   underflow_rd_clk, 
   hold_rd_ptr, 
   rd_clk, 
   overflow_rd_clk, 
   reset, 
   rxdatavalid, 
   rxdatavalid_lookahead 
 );
     input enchansync; 
     input CB_enb_stop; 
     input CB_enb_stop_dlyd; 
     input CB_align_ver; 
     input rd_clk; 
     input reset; 
     input overflow_rd_clk; 
     input underflow_rd_clk; 
     input rxdatavalid; 
     input rxdatavalid_lookahead; 
     output [1:0]ch_bond_m; 
     output hold_rd_ptr; 
     output rxchanisaligned; 
     reg rxchanisaligned; 
     reg hold_rd_ptr; 
     reg alignment_done_r; 
     reg [2:0]count_maxskew_load; 
     reg [2:0]cb_rxdatavalid_cnt; 
     wire CB_enb_stop_dlyd5; 
     wire i_am_master= CHAN_BOND_MODE[0]; 
     always @(posedge rd_clk or posedge reset) 
     begin
           if(reset) 
                      rxchanisaligned <=  `DLY 1'b0; 
           else if(overflow_rd_clk) 
                      rxchanisaligned <=  `DLY 1'b0; 
           else if(underflow_rd_clk) 
                      rxchanisaligned <=  `DLY 1'b0; 
           else 
                      rxchanisaligned <=  `DLY 1'b1; 
     end
     always @(posedge rd_clk or posedge reset) 
     begin
           if(reset) 
                      alignment_done_r   <=  `DLY 1'b0; 
           else if (count_maxskew_load ==CHAN_BOND_MAX_SKEW+2) 
                      alignment_done_r   <=  `DLY 1'b1; 
           else if(!enchansync) 
                      alignment_done_r   <=  `DLY 1'b0; 
     end
     always @(posedge rd_clk or posedge reset) 
     begin
           if(reset) 
                   cb_rxdatavalid_cnt <=  `DLY 3'b000; 
           else if(CB_enb_stop & !rxdatavalid_lookahead & enchansync) 
                   cb_rxdatavalid_cnt <=  `DLY 3'b110; 
           else if(CB_enb_stop_dlyd & !rxdatavalid & enchansync) 
                   cb_rxdatavalid_cnt <=  `DLY 3'b110; 
           else if(CB_enb_stop & enchansync) 
                   cb_rxdatavalid_cnt <=  `DLY 3'b111; 
           else if((cb_rxdatavalid_cnt==7) && !rxdatavalid_lookahead) 
                   cb_rxdatavalid_cnt <=  `DLY cb_rxdatavalid_cnt - 2; 
           else if((cb_rxdatavalid_cnt>1) && rxdatavalid) 
                   cb_rxdatavalid_cnt <=  `DLY cb_rxdatavalid_cnt - 1; 
           else if((cb_rxdatavalid_cnt>4) && !rxdatavalid) 
                   cb_rxdatavalid_cnt <=  `DLY cb_rxdatavalid_cnt - 2; 
           else if((cb_rxdatavalid_cnt==4) && !rxdatavalid) 
                   cb_rxdatavalid_cnt <=  `DLY cb_rxdatavalid_cnt - 1; 
           else 
                   cb_rxdatavalid_cnt <=  `DLY 3'b000; 
     end
     assign CB_enb_stop_dlyd5 = (cb_rxdatavalid_cnt==3)?1'b1:1'b0; 
     always @(posedge rd_clk or posedge reset) 
     begin
           if(reset) 
                      count_maxskew_load <=  `DLY 3'b0; 
           else if(CB_enb_stop_dlyd5 & enchansync & !alignment_done_r) 
                      count_maxskew_load <=  `DLY CHAN_BOND_MAX_SKEW+2 ; 
           else if(count_maxskew_load>0) 
                      count_maxskew_load <=  `DLY count_maxskew_load -1; 
           else 
                      count_maxskew_load <=  `DLY 3'b0; 
     end
     always @(posedge rd_clk or posedge reset) 
     begin
           if(reset) 
                     hold_rd_ptr        <=  `DLY 1'b0; 
           else if(CB_enb_stop_dlyd5 & enchansync & !alignment_done_r) 
                     hold_rd_ptr        <=  `DLY 1'b1; 
           else if(count_maxskew_load<=CHAN_BOND_MAX_SKEW+2 & count_maxskew_load>0) 
                     hold_rd_ptr        <=  `DLY 1'b1; 
           else 
                     hold_rd_ptr        <=  `DLY 1'b0; 
     end
     wire  master_align_done = (count_maxskew_load==CHAN_BOND_MAX_SKEW)?1'b1:1'b0; 
     wire  master_detect_cb = CB_align_ver & !enchansync; 
     wire   CB_enb_stop_i = CB_enb_stop & enchansync & !alignment_done_r; 
     assign ch_bond_m = master_align_done?2'b11:master_detect_cb?2'b01:CB_enb_stop_i?2'b10:2'b00; 
 endmodule 