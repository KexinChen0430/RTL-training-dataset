module RAMConcur_TBV ();
reg [3:0] addr = 0;
wire [3:0] dout;
reg clk = 0;
reg [3:0] din = 0;
reg writeE = 0;
reg [3:0] RAMConcur0_0_1_2_memory [0:4-1];
initial begin: INITIALIZE_RAMCONCUR0_0_1_2_MEMORY
    integer i;
    for(i=0; i<4; i=i+1) begin
        RAMConcur0_0_1_2_memory[i] = 0;
    end
end
always @(posedge clk) begin: RAMCONCUR_TBV_RAMCONCUR0_0_1_2_WRITEACTION
    if (writeE) begin
        RAMConcur0_0_1_2_memory[addr] <= din; 
    end
end
assign dout = RAMConcur0_0_1_2_memory[addr];
initial begin: RAMCONCUR_TBV_CLK_SIGNAL
    while (1'b1) begin
        clk <= (!clk); 
        # 1; 
    end
end
initial begin: RAMCONCUR_TBV_STIMULES
    integer i;
    for (i=0; i<1; i=i+1) begin
        @(negedge clk);
    end
    for (i=0; i<4; i=i+1) begin
        @(posedge clk);
        writeE <= 1'b1; 
        addr <= i; 
        case (i)
            0: din <= 3;
            1: din <= 2;
            2: din <= 1;
            default: din <= 0;
        endcase
    end
    for (i=0; i<1; i=i+1) begin
        @(posedge clk);
        writeE <= 1'b0;
    end
    for (i=0; i<4; i=i+1) begin
        @(posedge clk);
        addr <= i; 
    end
    for (i=0; i<4; i=i+1) begin
        @(posedge clk);
        writeE <= 1'b1; 
        addr <= i; 
        case ((-i))
            0: din <= 3;
            1: din <= 2;
            2: din <= 1;
            default: din <= 0;
        endcase
    end
    for (i=0; i<1; i=i+1) begin
        @(posedge clk);
        writeE <= 1'b0;
    end
    for (i=0; i<4; i=i+1) begin
        @(posedge clk);
        addr <= i; 
    end
    $finish;
end
always @(posedge clk) begin: RAMCONCUR_TBV_PRINT_DATA
    $write("%h", addr);   
    $write(" ");
    $write("%h", din);    
    $write(" ");
    $write("%h", writeE); 
    $write(" ");
    $write("%h", dout);   
    $write(" ");
    $write("%h", clk);    
    $write("\n");
end
endmodule