module hi_read_rx_xcorr(
    pck0, ck_1356meg, ck_1356megb,
    pwr_lo, pwr_hi, pwr_oe1, pwr_oe2, pwr_oe3, pwr_oe4,
    adc_d, adc_clk,
    ssp_frame, ssp_din, ssp_dout, ssp_clk,
    cross_hi, cross_lo,
    dbg,
    xcorr_is_848, snoop, xcorr_quarter_freq
);
input pck0, ck_1356meg, ck_1356megb;
output pwr_lo, pwr_hi, pwr_oe1, pwr_oe2, pwr_oe3, pwr_oe4;
input [7:0] adc_d;
output adc_clk;
input ssp_dout;
output ssp_frame, ssp_din, ssp_clk;
input cross_hi, cross_lo;
output dbg;
input xcorr_is_848, snoop, xcorr_quarter_freq;
assign pwr_hi = ck_1356megb & (~snoop); 
assign pwr_oe1 = 1'b0; 
assign pwr_oe3 = 1'b0; 
assign pwr_oe4 = 1'b0; 
reg [2:0] fc_div;
always @(negedge ck_1356megb)
    fc_div <= fc_div + 1;
(* clock_signal = "yes" *) reg adc_clk; 
always @(ck_1356megb, xcorr_is_848, xcorr_quarter_freq, fc_div)
    if (xcorr_is_848 & ~xcorr_quarter_freq) 
        adc_clk <= ck_1356megb;
    else if (~xcorr_is_848 & ~xcorr_quarter_freq) 
        adc_clk <= fc_div[0];
    else if (xcorr_is_848 & xcorr_quarter_freq) 
        adc_clk <= fc_div[1];
    else 
        adc_clk <= fc_div[2];
reg after_hysteresis, after_hysteresis_prev, after_hysteresis_prev_prev;
reg [11:0] has_been_low_for;
always @(negedge adc_clk)
begin
    if(& adc_d[7:0]) after_hysteresis <= 1'b1; 
    else if(~(| adc_d[7:0])) after_hysteresis <= 1'b0; 
    if(after_hysteresis)
        has_been_low_for <= 12'b0; 
    else
    begin
        if(has_been_low_for == 12'd4095) 
        begin
            has_been_low_for <= 12'd0; 
            after_hysteresis <= 1'b1; 
        end
        else
            has_been_low_for <= has_been_low_for + 1; 
    end
end
reg [5:0] corr_i_cnt;
reg signed [13:0] corr_i_accum;
reg signed [13:0] corr_q_accum;
reg signed [7:0] corr_i_out;
reg signed [7:0] corr_q_out;
reg ssp_clk;
reg ssp_frame;
always @(negedge adc_clk)
begin
    corr_i_cnt <= corr_i_cnt + 1;
end
always @(negedge adc_clk)
begin
    if(corr_i_cnt == 6'd0)
    begin
    end
end
assign ssp_din = corr_i_out[7];
assign dbg = corr_i_cnt[3];
assign pwr_lo = 1'b0;
assign pwr_oe2 = 1'b0;
endmodule