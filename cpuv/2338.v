module
    reg clk = 0;
    reg rst = 0;
    reg Trig = 0;
    wire [4:0] count;
    reg [4:0] Down_Counter0_0_count_i = 17;
    always @(rst, clk, Trig, count) begin: DOWN_COUNTERTBV_PRINT_DATA
        $write("%h", clk);   
        $write(" ");
        $write("%h", rst);   
        $write(" ");
        $write("%h", Trig);  
        $write(" ");
        $write("%h", count); 
        $write("\n");        
    end
    always @(posedge clk, negedge rst) begin: DOWN_COUNTERTBV_DOWN_COUNTER0_0_LOGIC
        if (rst) begin
            Down_Counter0_0_count_i <= 17;
            Trig <= 0;
        end
        else if ((Down_Counter0_0_count_i == 0)) begin
            Trig <= 1;
            Down_Counter0_0_count_i <= 17;
        end
        else begin
            Down_Counter0_0_count_i <= (Down_Counter0_0_count_i - 1);
        end
    end
    assign count = Down_Counter0_0_count_i;
    initial begin: DOWN_COUNTERTBV_CLK_SIGNAL
        while (1'b1) begin
            clk <= (!clk); 
            # 1;           
        end
    end
    initial begin: DOWN_COUNTERTBV_STIMULES
        integer i;
        i = 0;
        while (1'b1) begin
            case (i)
                'h19: begin
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