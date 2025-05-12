module reset_ctrl(
    input clk40,               
    input idelay_rst_trig,     
    input full_rst_trig,       
    output reg dcm_rst = 1'b0, 
    output reg idelay_rst = 1'b0 
);
reg rst_flag = 1'b0;
reg [23:0] rst_count = 24'd0;
always @(posedge clk40) begin
    if (rst_flag) begin
        rst_count <= rst_count + 1'd1;
        case (rst_count)
            24'd0: begin
                dcm_rst <= 1'b1;
            end
            24'd8500000: begin
                dcm_rst <= 1'b0;
            end
            24'd8500010: begin
                idelay_rst <= 1'b1;
            end
            24'd8500020: begin
                idelay_rst <= 1'b0;
                rst_flag <= 1'b0;
            end
        endcase
    end else begin
        if (idelay_rst_trig) begin
            rst_flag <= 1'b1;
            rst_count <= 24'd8500010;
        end else if (full_rst_trig) begin
            rst_flag <= 1'b1;
            rst_count <= 24'd0;
        end
    end
end
endmodule