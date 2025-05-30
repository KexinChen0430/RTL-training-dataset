module 
reg clk = 0; 
reg rst = 0; 
wire Trig; 
wire [4:0] count; 
reg [4:0] Up_Counter0_0_count_i = 0; 
reg Up_Counter0_0_Trig_i = 0; 
always @(rst, clk, Trig, count) begin: UP_COUNTERTBV_PRINT_DATA
    $write("%h", clk);
    $write(" ");
    $write("%h", rst);
    $write(" ");
    $write("%h", Trig);
    $write(" ");
    $write("%h", count);
    $write("\n");
end
always @(posedge clk, negedge rst) begin: UP_COUNTERTBV_UP_COUNTER0_0_LOGIC
    if (rst) begin 
        Up_Counter0_0_count_i <= 0;
        Up_Counter0_0_Trig_i <= 0;
    end
    else if ((((Up_Counter0_0_count_i % 17) == 0) && (Up_Counter0_0_count_i != 0))) begin 
        Up_Counter0_0_Trig_i <= 1;
        Up_Counter0_0_count_i <= 0;
    end
    else begin 
        Up_Counter0_0_count_i <= (Up_Counter0_0_count_i + 1);
    end
end
assign count = Up_Counter0_0_count_i; 
assign Trig = Up_Counter0_0_Trig_i; 
initial begin: UP_COUNTERTBV_CLK_SIGNAL
    while (1'b1) begin
        clk <= (!clk); 
        # 1; 
    end
end
initial begin: UP_COUNTERTBV_STIMULES
    integer i;
    i = 0;
    while (1'b1) begin
        case (i)
            'h1a: begin 
                rst <= 1;
            end
            (-'h1): begin 
                rst <= 0;
            end
            default: begin
            end
        endcase
        if ((i == 42)) begin 
            $finish;
        end
        i = i + 1; 
        @(posedge clk); 
    end
end
endmodule 