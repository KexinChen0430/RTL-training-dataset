module is_reset_after;
always @(negedge i2c_clk_in) begin
    if (reset == 1) begin
        i2c_reset <= 1;
    end else begin
        i2c_reset <= 0;
    end
end 
endmodule