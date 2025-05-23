module
reg clk = 0;
reg rst = 0;
wire SerialOut;
wire [19:0] SerialInTV;
reg SerialIn = 0;
reg [3:0] SISO0_0_Buffer = 0;
assign SerialInTV = 20'd989338;
always @(rst, SerialOut, SerialIn, clk) begin: SISO_TBV_PRINT_DATA
    $write("%h", SerialIn);
    $write(" ");
    $write("%h", SerialOut);
    $write(" ");
    $write("%h", clk);
    $write(" ");
    $write("%h", rst);
    $write("\n");
end
always @(posedge clk, negedge rst) begin: SISO_TBV_SISO0_0_LOGIC
    if (rst) begin
        SISO0_0_Buffer <= 0;
    end
    else begin
        SISO0_0_Buffer <= {SISO0_0_Buffer[(4 - 1)-1:0], SerialIn};
    end
end
assign SerialOut = SISO0_0_Buffer[(4 - 1)];
initial begin: SISO_TBV_CLK_SIGNAL
    while (1'b1) begin
        clk <= (!clk);
        # 1;
    end
end
initial begin: SISO_TBV_STIMULES
    integer i;
    for (i=0; i<20; i=i+1) begin
        SerialIn <= SerialInTV[i];
        @(posedge clk);
    end
    for (i=0; i<2; i=i+1) begin
        if ((i == 0)) begin
            SerialIn <= 0;
            rst <= 1;
        end
        else begin
            rst <= 0;
        end
        @(posedge clk);
    end
    for (i=0; i<(4 + 1); i=i+1) begin
        SerialIn <= 1;
        @(posedge clk);
    end
    $finish;
end
endmodule