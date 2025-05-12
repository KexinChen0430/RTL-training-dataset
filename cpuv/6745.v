module pci_exp_usrapp_rx                   ( 
                                           trn_rdst_rdy_n, 
                                           trn_rnp_ok_n, 
                                           trn_rd, 
                                           trn_rrem_n, 
                                           trn_rsof_n, 
                                           trn_reof_n, 
                                           trn_rsrc_rdy_n, 
                                           trn_rsrc_dsc_n, 
                                           trn_rerrfwd_n, 
                                           trn_rbar_hit_n, 
                                           trn_clk, 
                                           trn_reset_n, 
                                           trn_lnk_up_n 
                                           );
output                                     trn_rdst_rdy_n; 
output                                     trn_rnp_ok_n; 
input    [(64 - 1):0]                      trn_rd; 
input    [(8 - 1):0]                       trn_rrem_n; 
input                                      trn_rsof_n; 
input                                      trn_reof_n; 
input                                      trn_rsrc_rdy_n; 
input                                      trn_rsrc_dsc_n; 
input                                      trn_rerrfwd_n; 
input  [(7 - 1):0]                         trn_rbar_hit_n; 
input                                      trn_clk; 
input                                      trn_reset_n; 
input                                      trn_lnk_up_n; 
parameter                                   Tcq = 1; 
reg               trn_rdst_rdy_n, next_trn_rdst_rdy_n; 
reg               trn_rnp_ok_n, next_trn_rnp_ok_n; 
reg     [4:0]     trn_rx_state, next_trn_rx_state; 
reg               trn_rx_in_frame, next_trn_rx_in_frame; 
reg               trn_rx_in_channel, next_trn_rx_in_channel; 
reg     [31:0]    next_trn_rx_timeout; 
`define           TRN_RX_RESET    5'b00001 
`define           TRN_RX_DOWN     5'b00010 
`define           TRN_RX_IDLE     5'b00100 
`define           TRN_RX_ACTIVE   5'b01000 
`define           TRN_RX_SRC_DSC  5'b10000 
always @(posedge trn_clk or negedge trn_reset_n) begin 
  if (trn_reset_n == 1'b0) begin 
    trn_rx_state     <= #(Tcq)  `TRN_RX_RESET; 
  end else begin
  case (trn_rx_state) 
    `TRN_RX_RESET :  begin 
      if (trn_reset_n == 1'b0) 
        trn_rx_state <= #(Tcq) `TRN_RX_RESET; 
      else
        trn_rx_state <= #(Tcq) `TRN_RX_DOWN; 
    end
    `TRN_RX_DOWN : begin 
      if (trn_lnk_up_n == 1'b1) 
        trn_rx_state <= #(Tcq) `TRN_RX_DOWN; 
      else begin
        trn_rx_state <= #(Tcq) `TRN_RX_IDLE; 
      end
    end
    `TRN_RX_IDLE : begin 
      if (trn_reset_n == 1'b0) 
        trn_rx_state <= #(Tcq) `TRN_RX_RESET; 
      else if (trn_lnk_up_n == 1'b1) 
        trn_rx_state <= #(Tcq) `TRN_RX_DOWN; 
      else begin
        if (  (trn_rsof_n == 1'b0) && 
              (trn_rsrc_rdy_n == 1'b0) &&
               (trn_rdst_rdy_n == 1'b0)  ) begin
          board.RP.com_usrapp.TSK_READ_DATA(0, `RX_LOG, trn_rd, trn_rrem_n); 
          trn_rx_state <= #(Tcq) `TRN_RX_ACTIVE; 
        end else begin
          trn_rx_state <= #(Tcq) `TRN_RX_IDLE; 
        end
      end
    end
    `TRN_RX_ACTIVE : begin 
      if (trn_reset_n == 1'b0) 
        trn_rx_state <= #(Tcq) `TRN_RX_RESET; 
      else if (trn_lnk_up_n == 1'b1) 
        trn_rx_state <= #(Tcq) `TRN_RX_DOWN; 
      else if (  (trn_rsrc_rdy_n == 1'b0) && 
                (trn_reof_n == 1'b0) &&
                 (trn_rdst_rdy_n == 1'b0)  ) begin
        board.RP.com_usrapp.TSK_READ_DATA(1, `RX_LOG, trn_rd, trn_rrem_n); 
        board.RP.com_usrapp.TSK_PARSE_FRAME(`RX_LOG); 
        trn_rx_state <= #(Tcq) `TRN_RX_IDLE; 
      end else if (  (trn_rsrc_rdy_n == 1'b0) && 
                     (trn_rdst_rdy_n == 1'b0)  ) begin
        board.RP.com_usrapp.TSK_READ_DATA(0, `RX_LOG, trn_rd, trn_rrem_n); 
        trn_rx_state <= #(Tcq) `TRN_RX_ACTIVE; 
      end else if (  (trn_rsrc_rdy_n == 1'b0) && 
          (trn_reof_n == 1'b0) &&
          (trn_rsrc_dsc_n == 1'b0)  ) begin
        board.RP.com_usrapp.TSK_READ_DATA(1, `RX_LOG, trn_rd, trn_rrem_n); 
        board.RP.com_usrapp.TSK_PARSE_FRAME(`RX_LOG); 
        trn_rx_state <= #(Tcq) `TRN_RX_SRC_DSC; 
      end else begin
        trn_rx_state <= #(Tcq) `TRN_RX_ACTIVE; 
      end
    end
    `TRN_RX_SRC_DSC : begin 
      if (trn_reset_n == 1'b0) 
        trn_rx_state <= #(Tcq) `TRN_RX_RESET; 
      else if (trn_lnk_up_n == 1'b1) 
        trn_rx_state <= #(Tcq) `TRN_RX_DOWN; 
      else begin
        trn_rx_state <= #(Tcq) `TRN_RX_IDLE; 
      end
    end
  endcase
   end
end
reg [1:0]   trn_rdst_rdy_toggle_count; 
reg [8:0]   trn_rnp_ok_toggle_count; 
always @(posedge trn_clk or negedge trn_reset_n) begin 
   if (trn_reset_n == 1'b0) begin 
    trn_rnp_ok_n        <= #(Tcq)   1'b0; 
    trn_rdst_rdy_n      <= #(Tcq)       1'b0; 
    trn_rdst_rdy_toggle_count <= #(Tcq) $random; 
    trn_rnp_ok_toggle_count <=  #(Tcq)     $random; 
   end else begin
    if (trn_rnp_ok_toggle_count == 0) begin 
        trn_rnp_ok_n        <= #(Tcq)   !trn_rnp_ok_n; 
        trn_rnp_ok_toggle_count <=  #(Tcq)     $random; 
    end else begin
    end
    if (trn_rdst_rdy_toggle_count == 0) begin 
        trn_rdst_rdy_toggle_count <= #(Tcq) $random; 
    end else begin
    end
   end
end
reg [31:0] sim_timeout; 
initial
begin
  sim_timeout = `TRN_RX_TIMEOUT; 
end
always @(trn_clk or trn_rsof_n or trn_rsrc_rdy_n) begin 
    if (next_trn_rx_timeout == 0) begin 
        if(!`EXPECT_FINISH_CHECK) 
          $display("[%t] : TEST FAILED --- Haven't Received All Expected TLPs", $realtime); 
        $finish(2); 
    end
    if ((trn_rsof_n == 1'b0) && (trn_rsrc_rdy_n == 1'b0)) begin 
        next_trn_rx_timeout = sim_timeout; 
    end else begin
        if (trn_lnk_up_n == 1'b0) 
            next_trn_rx_timeout = next_trn_rx_timeout - 1'b1; 
    end
end
endmodule 