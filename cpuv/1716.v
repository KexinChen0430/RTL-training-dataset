module extracts the data ready signal from the SPI bus and makes sure to
 */
assign m_sclk = s_sclk;
assign m_sdo = s_sdo;
assign m_sdo_t = s_sdo_t;
assign s_sdi = m_sdi;
assign m_cs = s_cs;
reg [$clog2(IDLE_TIMEOUT)-1:0] counter = IDLE_TIMEOUT;
reg [2:0] sdi_d = 'h00;
always @(posedge clk) begin
    if (resetn == 1'b0) begin
        counter <= IDLE_TIMEOUT;
    end else begin
        if (s_cs[CS_PIN] == 1'b0 && spi_active == 1'b0) begin
            if (counter != 'h00)
                counter <= counter - 1'b1;
        end else begin
            counter <= IDLE_TIMEOUT;
        end
    end
end
always @(posedge clk) begin
    sdi_d <= {sdi_d[1:0], m_sdi};
end
always @(posedge clk) begin
    if (counter == 'h00 && sdi_d[2] == 1'b0) begin
        data_ready <= 1'b1;
    end else begin
        data_ready <= 1'b0;
    end
end
endmodule