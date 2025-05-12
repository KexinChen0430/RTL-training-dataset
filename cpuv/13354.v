module dcm_sp_clock_divide_by_2 (clock, clock_type, clock_out, rst);
input clock;
input clock_type;
input rst;
output clock_out;
reg clock_out;
reg clock_div2;
reg [2:0] rst_reg;
wire clk_src;
initial begin
    clock_out = 1'b0;
    clock_div2 = 1'b0;
end
always @(posedge clock)
    clock_div2 <= ~clock_div2;
always @(posedge clock) begin
    rst_reg[0] <= rst;
    rst_reg[1] <= rst_reg[0] & rst;
    rst_reg[2] <= rst_reg[1] & rst_reg[0] & rst;
end
assign clk_src = (clock_type) ? clock_div2 : clock;
always @(clk_src or rst or rst_reg)
    if (rst == 1'b0)
        clock_out = clk_src;
    else if (rst == 1'b1) begin
        clock_out = 1'b0;
        @(negedge rst_reg[2]);
        if (clk_src == 1'b1)
          @(negedge clk_src);
    end
endmodule