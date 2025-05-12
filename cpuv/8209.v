module ram_dp #
(
    parameter DATA_WIDTH = 32,
    parameter ADDR_WIDTH = 10
)
(
    input  wire                    a_clk,
    input  wire                    a_we,
    input  wire [ADDR_WIDTH-1:0]   a_addr,
    input  wire [DATA_WIDTH-1:0]   a_din,
    output wire [DATA_WIDTH-1:0]   a_dout,
    input  wire                    b_clk,
    input  wire                    b_we,
    input  wire [ADDR_WIDTH-1:0]   b_addr,
    input  wire [DATA_WIDTH-1:0]   b_din,
    output wire [DATA_WIDTH-1:0]   b_dout
);
reg [DATA_WIDTH-1:0] a_dout_reg = {DATA_WIDTH{1'b0}};
reg [DATA_WIDTH-1:0] b_dout_reg = {DATA_WIDTH{1'b0}};
reg [DATA_WIDTH-1:0] mem[(2**ADDR_WIDTH)-1:0];
assign a_dout = a_dout_reg;
assign b_dout = b_dout_reg;
integer i, j;
initial begin
    for (i = 0; i < 2**ADDR_WIDTH; i = i + 2**(ADDR_WIDTH/2)) begin
        for (j = i; j < i + 2**(ADDR_WIDTH/2); j = j + 1) begin
            mem[j] = 0;
        end
    end
end
always @(posedge a_clk) begin
    a_dout_reg <= mem[a_addr];
    if (a_we) begin
        mem[a_addr] <= a_din;
        a_dout_reg <= a_din;
    end
end
always @(posedge b_clk) begin
    b_dout_reg <= mem[b_addr];
    if (b_we) begin
        mem[b_addr] <= b_din;
        b_dout_reg <= b_din;
    end
end
endmodule