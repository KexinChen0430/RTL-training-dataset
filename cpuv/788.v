module D2STR_H#
    (
    parameter integer len = 16 
    )
    (
        input wire GCLK,
        output reg [127:0] str = "????????????????",
        input wire [4*len-1:0] d
    );
    genvar i;
    generate
    for (i = 0; i < len; i = i + 1) begin: test
        always @(posedge GCLK) begin
            case (d[4*i+3:4*i])
            4'd0: str[8*i+7:8*i] <= "0";
            4'd1: str[8*i+7:8*i] <= "1";
            4'd10: str[8*i+7:8*i] <= "A";
            default: str[8*i+7:8*i] <= " ";
            endcase
        end
    end
    for (i = len; i < 16; i = i + 1) begin
        always @(posedge GCLK) begin
            str[8*i+7:8*i] <= " ";
        end
    end
    endgenerate
endmodule