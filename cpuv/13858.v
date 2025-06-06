module 
reg clk = 0; 
reg rst = 0; 
wire [3:0] q; 
reg [1:0] Dir = 2'b10; 
wire [3:0] seed; 
reg [3:0] RingCounter0_0_q_i = 3; 
assign seed = 4'd3; 
always @(q, rst, Dir, clk, seed) begin: RINGCOUNTER_TBV_PRINT_DATA
    $write("%h", seed); 
    $write(" ");
    $write("%h", Dir); 
    $write(" ");
    $write("%h", q); 
    $write(" ");
    $write("%h", clk); 
    $write(" ");
    $write("%h", rst); 
    $write("\n"); 
end
always @(posedge clk, negedge rst) begin: RINGCOUNTER_TBV_RINGCOUNTER0_0_RCSTATEMACHINE
    if (rst) begin
        RingCounter0_0_q_i <= seed; 
    end
    else if ((Dir == 2'b00)) begin
        RingCounter0_0_q_i <= {RingCounter0_0_q_i[(4 - 1)-1:0], RingCounter0_0_q_i[(4 - 1)]};
    end
    else if ((Dir == 2'b01)) begin
        RingCounter0_0_q_i <= RingCounter0_0_q_i;
    end
    else if ((Dir == 2'b10)) begin
        RingCounter0_0_q_i <= {RingCounter0_0_q_i[0], RingCounter0_0_q_i[4-1:1]};
    end
end
assign q = RingCounter0_0_q_i;
initial begin: RINGCOUNTER_TBV_CLK_SIGNAL
    while (1'b1) begin
        clk <= (!clk); 
        # 1; 
    end
end
initial begin: RINGCOUNTER_TBV_STIMULES
    integer i;
    i = 0;
    while (1'b1) begin
        if ((i == (2 * 4))) begin
            Dir <= 2'b00; 
        end
        else if ((i == (3 * 4))) begin
            rst <= 1; 
        end
        else if ((i == ((3 * 4) + 1))) begin
            rst <= 0; 
        end
        else if ((i == ((3 * 4) + 2))) begin
            Dir <= 2'b01; 
        end
        if ((i == (5 * 4))) begin
            $finish; 
        end
        i = i + 1; 
        @(posedge clk); 
    end
end
endmodule 