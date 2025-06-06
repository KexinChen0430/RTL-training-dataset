module regfile1out #(parameter WIDTH=32, parameter RSELWIDTH=4) (
    input clk,
    input we, input [RSELWIDTH-1:0] wsel, input  [WIDTH-1:0] wdata,
    input [RSELWIDTH-1:0] asel, output [WIDTH-1:0] adata
    );
reg [WIDTH-1:0] R[0:2**RSELWIDTH-1];
integer k;
initial begin
    for (k = 0; k < 2**RSELWIDTH; k = k + 1) R[k] = 0;
end
always @ (posedge clk)
begin
    if (we)
    begin
        R[wsel] <= wdata;
        $display("reg write %h data %h", wsel, wdata);
    end
end
assign adata = R[asel];
endmodule