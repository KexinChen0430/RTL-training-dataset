module configurable_parameters (
);
    parameter refresh_rate = 1000;
    parameter sys_clk_freq = 100000000;
    localparam clk_divider = sys_clk_freq / (refresh_rate * 3);
    reg [31:0] divider;
    reg [7:0] segments_out;
    reg [2:0] segments_enable_out;
    assign segments = ~segments_out;
    assign segments_enable = ~segments_enable_out;
    wire [7:0] high_segments;
    wire [7:0] low_segments;
    nibble_to_segments high_nib(hex_byte[7:4], high_segments);
    nibble_to_segments low_nib(hex_byte[3:0], low_segments);
    always @(posedge clk) begin
        if (divider < clk_divider) begin
            divider <= divider + 1;
        end else begin
            divider <= 0;
            case (segments_enable_out)
                3'b001: begin
                    segments_out <= 8'b00101110;
                    segments_enable_out <= 3'b100;
                end
                3'b100: begin
                    segments_out <= high_segments;
                    segments_enable_out <= 3'b010;
                end
                3'b010: begin
                    segments_out <= low_segments;
                    segments_enable_out <= 3'b001;
                end
                default: begin
                    segments_out <= 8'h00;
                    segments_enable_out <= 3'b001;
                end
            endcase
        end
    end
endmodule