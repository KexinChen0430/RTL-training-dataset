module
reg clk = 0;
wire rst;
reg SerialIn = 0;
wire [3:0] BusOut;
wire [11:0] SerialVals;
reg [3:0] SIPO0_0_Buffer = 0;
assign rst = 1'd0;
assign SerialVals = 12'd3024;
always @(rst, BusOut, SerialIn, clk) begin: SIPO_TBV_PRINT_DATA
    $write("%h", SerialIn);
    $write(" ");
    $write("%h", BusOut);
    $write(" ");
    $write("%h", clk);
    $write(" ");
    $write("%h", rst);
    $write("\n");
end
always @(posedge clk, negedge rst) begin: SIPO_TBV_SIPO0_0_LOGIC
    if (rst) begin
        SIPO0_0_Buffer <= 0;
    end
    else begin
        SIPO0_0_Buffer <= {SIPO0_0_Buffer[4-1:0], SerialIn};
    end
end
assign BusOut = SIPO0_0_Buffer;
initial begin: SIPO_TBV_CLK_SIGNAL
    while (1'b1) begin
        clk <= (!clk);
        # 1;
    end
end
initial begin: SIPO_TBV_STIMULES
    integer i;
    i = 0;
    while (1'b1) begin
        if ((i < 12)) begin
            SerialIn <= SerialVals[i];
        end
        else if ((i == 12)) begin
        end
        else if ((i > 12)) begin
            $finish;
        end
        i = i + 1;
        @(posedge clk);
    end
    $finish;
end
endmodule