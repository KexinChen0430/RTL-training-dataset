module simplifes some synthesized design
    parameter BITS = 1;
    input clk, rst, ena;
    output [BITS-1:0] q;
    reg [BITS-1:0] q;
    input [BITS-1:0] d;
    always @(posedge clk or posedge rst) begin
        if (rst == 1) begin
            q <= 0;
        end else if (ena) begin 
            q <= d;
        end else begin 
            q <= 0;
        end
    end
endmodule