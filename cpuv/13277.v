module
    always @(posedge USB_CLK) begin
        if (0 <= counter_usb_clk && counter_usb_clk < (`USB_CLK_DIV/2)) begin
            CIS_CLK <= 'b1;
        end else begin
            CIS_CLK <= 'b0;
        end
        if (counter_usb_clk == (`USB_CLK_DIV-1)) begin
            counter_usb_clk <= 'd0;
        end else begin
            counter_usb_clk <= counter_usb_clk + 'd1;
        end
    end
    always @(negedge USB_CLK) begin
        if (`ADC_CLK_DELAY <= counter_usb_clk && counter_usb_clk < (`ADC_CLK_DELAY+`USB_CLK_DIV/2)) begin
            ADC_CLK <= 'b1;
        end else begin
            ADC_CLK <= 'b0;
        end
        if (counter_usb_clk == `WR_PULSE_DELAY) begin
            USB_WR_L <= 'b0;
        end else begin
            USB_WR_L <= 'b1;
        end
    end
    always @(posedge CIS_CLK) begin
        if (counter_cis_clk == `CIS_LED_OFF) begin
            CIS_LED_BLUE <= 'b0;
            CIS_LED_GREEN <= 'b0;
            CIS_LED_RED <= 'b0;
        end else if (counter_cis_clk == `CIS_LED_ON) begin
            CIS_LED_BLUE <= 'b1;
            CIS_LED_GREEN <= 'b1;
            CIS_LED_RED <= 'b1;
        end
        if (counter_cis_clk == `CIS_CLK_PER_LINE) begin
            counter_cis_clk <= 'd1;
            CIS_SP <= 'b1;
        end else begin
            counter_cis_clk <= counter_cis_clk + 'd1;
            CIS_SP <= 'b0;
        end
        if (counter_cis_clk == `SCOPE_SYNC_POS) begin
            SCOPE_SYNC <= 1'b1;
        end else begin
            SCOPE_SYNC <= 1'b0;
        end
    end
endmodule