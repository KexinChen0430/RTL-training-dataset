module countLED_TBV (
); 
reg clk = 0; 
reg [3:0] led = 0; 
reg [32:0] countLED0_0_counter = 0; 
always @(led, clk) begin: COUNTLED_TBV_PRINT_DATA
    $write("%h", clk); 
    $write(" "); 
    $write("%h", led); 
    $write("\n"); 
end
always @(posedge clk) begin: COUNTLED_TBV_COUNTLED0_0_LOGIC
    countLED0_0_counter <= (countLED0_0_counter + 1); 
    led[0] <= countLED0_0_counter[26]; 
    led[1] <= countLED0_0_counter[24]; 
    led[2] <= countLED0_0_counter[22]; 
    led[3] <= countLED0_0_counter[20]; 
end
initial begin: COUNTLED_TBV_CLK_SIGNAL
    while (1'b1) begin 
        clk <= (!clk); 
        # 1; 
    end
end
initial begin: COUNTLED_TBV_STIMULES
    integer i; 
    i = 0; 
    while (1'b1) begin 
        if ((i == 35'h200000000)) begin 
            $finish; 
        end
        i = i + 1; 
        @(posedge clk); 
    end
end
endmodule 