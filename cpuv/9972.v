module `DEMUX1_4_B`
reg x = 0;
reg y0 = 0;
reg y1 = 0;
reg s0 = 0;
reg s1 = 0;
reg y2 = 0;
reg y3 = 0;
wire [17:0] xTV;
wire [17:0] s0TV;
wire [17:0] s1TV;
assign xTV = 18'd87399;
assign s0TV = 18'd52982;
assign s1TV = 18'd16277;
always @(x, y0, s1, s0, y3, y2, y1) begin: DEMUX1_4_B_TBV_PRINT_DATA
    $write("%h", x);
    $write(" ");
    $write("%h", s0);
    $write(" ");
    $write("%h", s1);
    $write(" ");
    $write("%h", y0);
    $write(" ");
    $write("%h", y1);
    $write(" ");
    $write("%h", y2);
    $write(" ");
    $write("%h", y3);
    $write("\n");
end
always @(x, s1, s0) begin: DEMUX1_4_B_TBV_DEMUX1_4_B0_0_LOGIC
    if (((s0 == 0) && (s1 == 0))) begin
        y0 = x;
        y1 = 0;
        y2 = 0;
        y3 = 0;
    end
    else if (((s0 == 1) && (s1 == 0))) begin
        y0 = 0;
        y1 = x;
        y2 = 0;
        y3 = 0;
    end
    else if (((s0 == 0) && (s1 == 1))) begin
        y0 = 0;
        y1 = 0;
        y2 = x;
        y3 = 0;
    end
    else begin
        y0 = 0;
        y1 = 0;
        y2 = 0;
        y3 = x;
    end
end
initial begin: DEMUX1_4_B_TBV_STIMULES
    integer i;
    for (i=0; i<18; i=i+1) begin
        x <= xTV[i];
        s0 <= s0TV[i];
        s1 <= s1TV[i];
        # 1;
    end
    $finish;
end
endmodule