module sinc3Filter
#(
    parameter OSR = 16 
)
(
    input clk,
    input en, 
    input in,
    output reg signed [3*$clog2(OSR):0] out
);
localparam ACC_UP = $clog2(OSR)-1;
wire signed [3:0] diff;
reg [(3*OSR)-1:0] shift;
reg signed [(3+1*ACC_UP):0] acc1 = 'd0;
reg signed [(3+2*ACC_UP):0] acc2 = 'd0;
integer i;
initial begin
    shift[0] = 1'b1;
    for (i=1; i<(3*OSR); i=i+1) shift[i] = ~shift[i-1];
    out = 'd0;
end
assign diff = in - 3*shift[OSR-1] + 3*shift[2*OSR-1] - shift[3*OSR-1];
always @(posedge clk) begin
    if (en) begin
        shift <= {shift[3*OSR-2:0], in};
        acc1  <= acc1 + diff;
        acc2  <= acc2 + acc1;
        out   <= out  + acc2;
    end
end
endmodule