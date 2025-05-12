module demoscene_counter(input wire clk,
        input wire [DIN_N-1:0] din, output wire [DOUT_N-1:0] dout);
    parameter DIN_N = `DIN_N;
    parameter DOUT_N = `DOUT_N;
    reg [26:0] div;
    always @(posedge clk) begin
        div <= div + 1'b1;
    end
    assign dout = div[26:19];
endmodule