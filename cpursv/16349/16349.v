
module alt5gxb_reset_controller(input  inclk,
                                input  async_reset,
                                input  test_sim,
                                input  pll_locked,
                                input  rx_pll_locked,
                                input  fifo_err,
                                input  inclk_eq_125mhz,
                                output gxb_powerdown,
                                output txdigitalreset,
                                output rxanalogreset,
                                output rxdigitalreset);

  localparam [19:0]  WS_SIM = 20'h00020;
  localparam [19:0]  WS_1MS_10000 = 20'h186a0;
  localparam [19:0]  WS_1MS_12500 = 20'h1e848;
  localparam [19:0]  WS_1MS_15625 = 20'h2625a;
  localparam [19:0]  WS_1MS_25000 = 20'h3d090;
  localparam [1:0]  idle = 0;
  localparam [1:0]  strobe_txpll_locked = 1;
  localparam [1:0]  stable_tx_pll = 2;
  localparam [1:0]  wait_state = 3;
  reg  [1:0] rst_ctrl_sm;
  reg  [19:0] waitstate_timer;
  reg  txdigitalreset_r;
  reg  rxanalogreset_r;
  reg  rxdigitalreset_r;
  reg  ws_tmr_eq_0;
  reg  ld_ws_tmr;
  reg  ld_ws_tmr_short;
  reg  [2:0] rx_pll_locked_cnt;
  reg  rx_pll_locked_r;

  assign gxb_powerdown = async_reset;
  assign txdigitalreset = txdigitalreset_r;
  assign rxanalogreset = rxanalogreset_r;
  assign rxdigitalreset = rxdigitalreset_r;
  
  always @(posedge inclk or posedge async_reset)
      begin
        if (async_reset == 1'b1) 
          begin
            txdigitalreset_r <= 1'b1;
            rxanalogreset_r <= 1'b1;
            rxdigitalreset_r <= 1'b1;
            waitstate_timer <= 20'hFFFFF;
            rst_ctrl_sm <= strobe_txpll_locked;
            ws_tmr_eq_0 <= 1'b0;
            ld_ws_tmr <= 1'b1;
            ld_ws_tmr_short <= 1'b0;
            rx_pll_locked_cnt <= 3'h0;
            rx_pll_locked_r <= 1'b0;
          end
        else 
          begin
            if (rx_pll_locked == 1'b1) rx_pll_locked_cnt <= 3'h7;
            else if (rx_pll_locked_cnt == 3'h0) rx_pll_locked_cnt <= 3'h0;
            else if (rx_pll_locked == 1'b0) rx_pll_locked_cnt <= rx_pll_locked_cnt-1;
              
            rx_pll_locked_r <= rx_pll_locked_cnt != 3'h0;
            if (ld_ws_tmr == 1'b1) 
              begin
                if (test_sim == 1'b1) 
                  begin
                    waitstate_timer <= WS_SIM;
                  end
                else if (inclk_eq_125mhz == 1'b1) 
                  begin
                    waitstate_timer <= WS_1MS_12500;
                  end
                else 
                  begin
                    waitstate_timer <= WS_1MS_25000;
                  end
              end
            else if (ld_ws_tmr_short == 1'b1) waitstate_timer <= WS_SIM;
            else if (waitstate_timer != 20'h00000) 
              begin
                waitstate_timer <= waitstate_timer-1;
              end
              
            if (ld_ws_tmr == (1'b1 | ld_ws_tmr_short)) 
              begin
                ws_tmr_eq_0 <= 1'b0;
              end
            else if (waitstate_timer == 20'h00000) 
              begin
                ws_tmr_eq_0 <= 1'b1;
              end
            else 
              begin
                ws_tmr_eq_0 <= 1'b0;
              end
            case (rst_ctrl_sm)

              idle: begin
                    if (rx_pll_locked_r == 1'b1) 
                      begin
                        if (fifo_err == 1'b1) rst_ctrl_sm <= stable_tx_pll;
                        else rst_ctrl_sm <= idle;
                      end
                    else 
                      begin
                        rst_ctrl_sm <= strobe_txpll_locked;
                        ld_ws_tmr <= 1'b1;
                      end
                  end

              strobe_txpll_locked: begin
                    ld_ws_tmr <= 1'b0;
                    if ((pll_locked == (1'b1 & ws_tmr_eq_0)) == 1'b1) 
                      begin
                        rst_ctrl_sm <= stable_tx_pll;
                        txdigitalreset_r <= 1'b0;
                        rxanalogreset_r <= 1'b0;
                        rxdigitalreset_r <= 1'b1;
                      end
                    else 
                      begin
                        rst_ctrl_sm <= strobe_txpll_locked;
                        txdigitalreset_r <= 1'b1;
                        rxanalogreset_r <= 1'b1;
                        rxdigitalreset_r <= 1'b1;
                      end
                  end

              stable_tx_pll: begin
                    if (rx_pll_locked_r == 1'b1) 
                      begin
                        rst_ctrl_sm <= wait_state;
                        txdigitalreset_r <= 1'b0;
                        rxanalogreset_r <= 1'b0;
                        rxdigitalreset_r <= 1'b1;
                        ld_ws_tmr_short <= 1'b1;
                      end
                    else 
                      begin
                        rst_ctrl_sm <= stable_tx_pll;
                        txdigitalreset_r <= 1'b0;
                        rxanalogreset_r <= 1'b0;
                        rxdigitalreset_r <= 1'b1;
                      end
                  end

              wait_state: begin
                    if (rx_pll_locked_r == 1'b1) 
                      begin
                        ld_ws_tmr_short <= 1'b0;
                        if ((ld_ws_tmr_short == (1'b0 & ws_tmr_eq_0)) == 1'b1) 
                          begin
                            rst_ctrl_sm <= idle;
                            txdigitalreset_r <= 1'b0;
                            rxanalogreset_r <= 1'b0;
                            rxdigitalreset_r <= 1'b0;
                          end
                        else 
                          begin
                            rst_ctrl_sm <= wait_state;
                            txdigitalreset_r <= 1'b0;
                            rxanalogreset_r <= 1'b0;
                            rxdigitalreset_r <= 1'b1;
                          end
                      end
                    else 
                      begin
                        rst_ctrl_sm <= stable_tx_pll;
                        txdigitalreset_r <= 1'b0;
                        rxanalogreset_r <= 1'b0;
                        rxdigitalreset_r <= 1'b1;
                      end
                  end

              default: begin
                    rst_ctrl_sm <= idle;
                    waitstate_timer <= 20'hFFFFF;
                  end

            endcase

          end
      end
endmodule

