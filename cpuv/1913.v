module rd_rx
always @(posedge clk) begin
    if(usr_arb_rx_rd_valid) begin
        rx_data_reg     <= usr_arb_rx_data;
    end
    else begin
        rx_data_reg     <= usr_pipe_rx_data;
    end
end
always @(posedge clk) begin
    if (~rst_n | reset_interface) begin
        rx_rd_tag_reg   <= 0;
        rx_rd_valid_reg <= 0;
    end
    else begin
        if(usr_arb_rx_rd_valid) begin
            rx_rd_tag_reg   <= usr_arb_rx_rd_tag;
            rx_rd_valid_reg <= 1'b1;
        end
        else begin
            rx_rd_tag_reg   <= usr_pipe_rx_rd_tag;
            rx_rd_valid_reg <= usr_pipe_rx_rd_valid;
        end
    end
end
endmodule