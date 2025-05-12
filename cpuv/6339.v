module SGMII_RX (
    reset,
    ff_rx_clk,
    ff_rx_rdy,
    ff_rx_data,
    ff_rx_mod,
    ff_rx_sop,
    ff_rx_eop,
    rx_err,
    rx_err_stat,
    rx_frm_type,
    ff_rx_dsav,
    ff_rx_dval,
    ff_rx_a_full,
    ff_rx_a_empty,
    pkt_receive_add,
    pkt_discard_add,
    out_pkt_wrreq,
    out_pkt,
    out_pkt_almostfull,
    out_valid_wrreq,
    out_valid
);
input reset; 
input ff_rx_clk; 
output ff_rx_rdy; 
input [31:0] ff_rx_data; 
input [1:0] ff_rx_mod; 
input ff_rx_sop; 
input ff_rx_eop; 
input [5:0] rx_err; 
input [17:0] rx_err_stat; 
input [3:0] rx_frm_type; 
input ff_rx_dsav; 
input ff_rx_dval; 
input ff_rx_a_full; 
input ff_rx_a_empty; 
output pkt_receive_add; 
output pkt_discard_add; 
output out_pkt_wrreq; 
output [133:0] out_pkt; 
input out_pkt_almostfull; 
output out_valid_wrreq; 
output out_valid; 
reg ff_rx_rdy; 
reg pkt_receive_add; 
reg pkt_discard_add; 
reg out_pkt_wrreq; 
reg [133:0] out_pkt; 
reg out_valid_wrreq; 
reg out_valid; 
reg [2:0] current_state; 
parameter transmit_byte0_s = 3'b001, 
          transmit_byte1_s = 3'b010, 
          transmit_byte2_s = 3'b011, 
          transmit_byte3_s = 3'b100, 
          discard_s = 3'b101; 
always @(posedge ff_rx_clk or negedge reset)
    if (!reset) begin 
        ff_rx_rdy <= 1'b0;
        out_pkt_wrreq <= 1'b0;
        out_pkt <= 134'b0;
        out_valid_wrreq <= 1'b0;
        out_valid <= 1'b0;
        pkt_receive_add <= 1'b0;
        pkt_discard_add <= 1'b0;
        current_state <= transmit_byte0_s; 
    end else begin 
        ff_rx_rdy <= 1'b1; 
        case (current_state) 
            transmit_byte0_s: begin 
                out_valid_wrreq <= 1'b0;
                out_valid <= 1'b0;
                out_pkt_wrreq <= 1'b0;
                if (ff_rx_dval == 1'b1) begin 
                    out_pkt[127:96] <= ff_rx_data; 
                    if (ff_rx_sop == 1'b1) begin 
                        if (!out_pkt_almostfull) begin 
                            out_pkt[133:132] <= 2'b01; 
                            pkt_receive_add <= 1'b1; 
                            current_state <= transmit_byte1_s; 
                        end else begin
                            pkt_discard_add <= 1'b1; 
                            current_state <= discard_s; 
                        end
                    end else if (ff_rx_eop == 1'b1) begin 
                        out_pkt[133:132] <= 2'b10; 
                        out_pkt[131:128] <= {2'b11, ff_rx_mod[1:0]}; 
                        out_pkt_wrreq <= 1'b1; 
                        current_state <= transmit_byte0_s; 
                        if (rx_err == 6'b0) begin 
                            out_valid_wrreq <= 1'b1; 
                            out_valid <= 1'b1; 
                        end else begin
                            out_valid_wrreq <= 1'b1; 
                            out_valid <= 1'b0; 
                        end
                    end else begin
                        out_pkt[133:132] <= 2'b11; 
                        current_state <= transmit_byte1_s; 
                    end
                end else begin
                    current_state <= transmit_byte0_s; 
                end
            end
        endcase
    end
endmodule