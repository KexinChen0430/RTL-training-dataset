
module ad_jesd_cntrl(input  rx_rst,
                     input  rx_clk,
                     input  [31:0] rx_data,
                     input  [3:0] rx_charisk,
                     input  [3:0] rx_disperr,
                     input  [3:0] rx_notintable,
                     input  rx_sysref,
                     input  rx_sync,
                     output rx_sysref_enb,
                     output rx_sync_enb,
                     output [4:0] mon_trigger,
                     output [55:0] mon_data);

  localparam  RX_FSM_IDLE = 4'h0;
  localparam  RX_FSM_CGS = 4'h1;
  localparam  RX_FSM_SYSREF = 4'h2;
  localparam  RX_FSM_SYNC = 4'h3;
  localparam  RX_FSM_DATA = 4'h4;
  reg   rx_sysref_enb = 'd0;
  reg   rx_sync_enb = 'd0;
  reg  [3:0]  rx_fsm = 'd0;
  wire rx_ilas_f_s;
  wire rx_ilas_q_s;
  wire rx_ilas_a_s;
  wire rx_ilas_r_s;
  wire rx_cgs_k_s;
  wire [3:0] rx_valid_k_s;
  wire rx_valid_k_1_s;

  assign mon_data[55:55] = rx_ilas_f_s;
  assign mon_data[54:54] = rx_ilas_q_s;
  assign mon_data[53:53] = rx_ilas_a_s;
  assign mon_data[52:52] = rx_ilas_r_s;
  assign mon_data[51:51] = rx_cgs_k_s;
  assign mon_data[50:50] = rx_valid_k_1_s;
  assign mon_data[49:49] = rx_sysref_enb;
  assign mon_data[48:48] = rx_sync_enb;
  assign mon_data[47:44] = rx_fsm;
  assign mon_data[43:40] = rx_charisk;
  assign mon_data[39:36] = rx_disperr;
  assign mon_data[35:32] = rx_notintable;
  assign mon_data[31:0] = rx_data;
  assign mon_trigger = {rx_valid_k_1_s,rx_fsm};
  
  always @(posedge rx_clk)
      begin
        if (rx_rst == 1'b1) 
          begin
            rx_sysref_enb <= 'd0;
            rx_sync_enb <= 'd0;
            rx_fsm <= 'd0;
          end
        else 
          begin
            case (rx_fsm)

              RX_FSM_DATA: begin
                    rx_sysref_enb <= 'd0;
                    rx_sync_enb <= 'd1;
                    if (rx_sync == 1'b0) 
                      begin
                        rx_fsm <= RX_FSM_IDLE;
                      end
                    else 
                      begin
                        rx_fsm <= RX_FSM_DATA;
                      end
                  end

              RX_FSM_SYNC: begin
                    rx_sysref_enb <= 'd0;
                    rx_sync_enb <= 'd1;
                    if (rx_sync == 1'b1) 
                      begin
                        rx_fsm <= RX_FSM_DATA;
                      end
                    else 
                      begin
                        rx_fsm <= RX_FSM_SYNC;
                      end
                  end

              RX_FSM_CGS: begin
                    rx_sysref_enb <= 'd0;
                    rx_sync_enb <= 'd0;
                    if (rx_cgs_k_s == 1'b0) 
                      begin
                        rx_fsm <= RX_FSM_SYNC;
                      end
                    else 
                      begin
                        rx_fsm <= RX_FSM_CGS;
                      end
                  end

              RX_FSM_SYSREF: begin
                    rx_sysref_enb <= 'd1;
                    rx_sync_enb <= 'd0;
                    if (rx_sysref == 1'b1) 
                      begin
                        rx_fsm <= RX_FSM_CGS;
                      end
                    else 
                      begin
                        rx_fsm <= RX_FSM_SYSREF;
                      end
                  end

              RX_FSM_IDLE: begin
                    rx_sysref_enb <= 'd0;
                    rx_sync_enb <= 'd0;
                    rx_fsm <= RX_FSM_SYSREF;
                  end

              default: begin
                    rx_sysref_enb <= 'd0;
                    rx_sync_enb <= 'd0;
                    rx_fsm <= RX_FSM_IDLE;
                  end

            endcase

          end
      end
  assign rx_ilas_f_s = (
(
((rx_valid_k_s[1] == 1'b1) || 
((rx_valid_k_s[0] == 1'b1) && (rx_data[7:0] == 8'hfc))) && 
((rx_data[15:8] == 8'hfc) || 
((rx_valid_k_s[0] == 1'b1) && (rx_data[7:0] == 8'hfc)))) || 
                       ((rx_valid_k_s[2] == 1'b1) && 
(
(
((rx_data[23:16] == 8'hfc) || (rx_data[31:24] == 8'hfc)) && (rx_valid_k_s[3] == 1'b1)) || (rx_data[23:16] == 8'hfc)) && 
(
((rx_valid_k_s[3] == 1'b1) && 
(
((rx_data[31:24] == 8'hfc) || (rx_valid_k_s[2] == 1'b1)) && 
((rx_valid_k_s[2] == 1'b1) || (rx_valid_k_s[3] == 1'b1)) && (rx_data[31:24] == 8'hfc))) || 
((rx_data[7:0] == 8'hfc) || 
((rx_valid_k_s[2] == 1'b1) && 
((rx_data[23:16] == 8'hfc) || 
((rx_valid_k_s[1] == 1'b1) && (rx_data[15:8] == 8'hfc)))) || 
((rx_valid_k_s[1] == 1'b1) && (rx_data[15:8] == 8'hfc))))) || 
                       ((rx_valid_k_s[3] == 1'b1) && 
(
((rx_data[31:24] == 8'hfc) || (rx_valid_k_s[2] == 1'b1)) && 
((rx_valid_k_s[2] == 1'b1) || (rx_valid_k_s[3] == 1'b1)) && (rx_data[31:24] == 8'hfc)))) ? 1'b1 : 1'b0;
  assign rx_ilas_q_s = (
((rx_data[31:24] == 8'h9c) && (rx_valid_k_s[3] == 1'b1)) || 
                       ((rx_data[7:0] == 8'h9c) && (rx_valid_k_s[0] == 1'b1)) || 
                       ((rx_data[15:8] == 8'h9c) && 
((rx_valid_k_s[1] == 1'b1) || 
((rx_data[7:0] == 8'h9c) && (rx_valid_k_s[0] == 1'b1)))) || 
                       (
(
((rx_valid_k_s[2] == 1'b1) && (rx_data[23:16] == 8'h9c)) || 
((rx_valid_k_s[2] == 1'b1) && 
((rx_data[31:24] == 8'h9c) && (rx_valid_k_s[3] == 1'b1)))) && 
((rx_data[7:0] == 8'h9c) || 
((rx_data[31:24] == 8'h9c) && (rx_valid_k_s[3] == 1'b1)) || 
((rx_valid_k_s[1] == 1'b1) && (rx_data[15:8] == 8'h9c)) || 
((rx_valid_k_s[2] == 1'b1) && (rx_data[23:16] == 8'h9c))))) ? 1'b1 : 1'b0;
  assign rx_ilas_a_s = (
((rx_data[31:24] == 8'h7c) && 
((rx_valid_k_s[3] == 1'b1) && 
(
((rx_valid_k_s[2] == 1'b1) || (rx_valid_k_s[3] == 1'b1)) && 
((rx_valid_k_s[2] == 1'b1) || (rx_data[31:24] == 8'h7c))))) || 
                       ((rx_valid_k_s[0] == 1'b1) && (rx_data[7:0] == 8'h7c)) || 
                       (
(
((rx_data[15:8] == 8'h7c) && 
((rx_data[7:0] == 8'h7c) || 
(
((rx_valid_k_s[1] == 1'b1) && (rx_data[15:8] == 8'h7c)) || 
(
((rx_data[31:24] == 8'h7c) || 
((rx_valid_k_s[1] == 1'b1) && (rx_data[15:8] == 8'h7c))) && (rx_valid_k_s[3] == 1'b1))) || 
(
((rx_valid_k_s[2] == 1'b1) || (rx_valid_k_s[3] == 1'b1)) && 
((rx_valid_k_s[2] == 1'b1) || (rx_data[31:24] == 8'h7c)) && (rx_data[23:16] == 8'h7c) && 
(
((rx_valid_k_s[2] == 1'b1) && (rx_data[23:16] == 8'h7c)) || 
((rx_valid_k_s[1] == 1'b1) || 
((rx_data[31:24] == 8'h7c) && 
((rx_valid_k_s[3] == 1'b1) && 
(
((rx_valid_k_s[2] == 1'b1) || (rx_valid_k_s[3] == 1'b1)) && 
((rx_valid_k_s[2] == 1'b1) || (rx_data[31:24] == 8'h7c)))))))))) || 
(
((rx_data[15:8] == 8'h7c) || 
(
((rx_valid_k_s[2] == 1'b1) || (rx_valid_k_s[3] == 1'b1)) && 
((rx_valid_k_s[2] == 1'b1) || (rx_data[31:24] == 8'h7c)) && 
((rx_data[15:8] == 8'h7c) || 
(
((rx_data[23:16] == 8'h7c) || (rx_data[31:24] == 8'h7c)) && (rx_valid_k_s[3] == 1'b1)) || (rx_data[23:16] == 8'h7c)))) && 
((rx_valid_k_s[2] == 1'b1) || (rx_valid_k_s[3] == 1'b1)) && 
((rx_valid_k_s[2] == 1'b1) || (rx_data[31:24] == 8'h7c)) && (rx_data[23:16] == 8'h7c)) || 
((rx_data[31:24] == 8'h7c) && 
((rx_valid_k_s[3] == 1'b1) && 
(
((rx_valid_k_s[2] == 1'b1) || (rx_valid_k_s[3] == 1'b1)) && 
((rx_valid_k_s[2] == 1'b1) || (rx_data[31:24] == 8'h7c)))))) && 
(
((rx_valid_k_s[2] == 1'b1) && (rx_data[23:16] == 8'h7c)) || (rx_valid_k_s[1] == 1'b1)))) ? 1'b1 : 1'b0;
  assign rx_ilas_r_s = (
((rx_data[23:16] == 8'h1c) && (rx_valid_k_s[2] == 1'b1)) || 
                       ((rx_valid_k_s[0] == 1'b1) && (rx_data[7:0] == 8'h1c)) || 
                       ((rx_data[31:24] == 8'h1c) && (rx_valid_k_s[3] == 1'b1)) || 
                       ((rx_data[15:8] == 8'h1c) && 
((rx_valid_k_s[1] == 1'b1) || 
((rx_data[23:16] == 8'h1c) && (rx_valid_k_s[2] == 1'b1)) || 
(
((rx_data[31:24] == 8'h1c) || 
((rx_data[23:16] == 8'h1c) && (rx_valid_k_s[2] == 1'b1))) && (rx_valid_k_s[3] == 1'b1))) && 
((rx_data[7:0] == 8'h1c) || 
((rx_data[31:24] == 8'h1c) && (rx_valid_k_s[3] == 1'b1)) || 
(
((rx_data[15:8] == 8'h1c) && (rx_valid_k_s[1] == 1'b1)) || 
((rx_valid_k_s[2] == 1'b1) && 
((rx_data[23:16] == 8'h1c) || 
((rx_data[15:8] == 8'h1c) && (rx_valid_k_s[1] == 1'b1)))))))) ? 1'b1 : 1'b0;
  assign rx_cgs_k_s = ((rx_valid_k_s[3] == 1'b1) && (rx_data[23:16] == 8'hbc) && 
                      (rx_valid_k_s[2] == 1'b1) && 
                      ((rx_data[31:24] == 8'hbc) && 
((rx_valid_k_s[1] == 1'b1) && 
((rx_valid_k_s[0] == 1'b1) && (rx_data[7:0] == 8'hbc)) && (rx_data[15:8] == 8'hbc)))) ? 1'b1 : 1'b0;
  assign rx_valid_k_s = ~rx_disperr & (~rx_notintable & rx_charisk);
  assign rx_valid_k_1_s = (rx_valid_k_s == 4'd0) ? 1'b0 : 1'b1;
endmodule

