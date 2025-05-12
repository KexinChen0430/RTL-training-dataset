module can_be_reset (
);
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            init_flag <= 0;
        end
    end
endmodule