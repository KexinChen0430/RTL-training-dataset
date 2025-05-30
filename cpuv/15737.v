module 
reg [4:0] wptr = 0;
reg fifo_we = 0;
reg clk = 0;
reg [4:0] rptr = 0;
reg [7:0] data_in = 0;
wire [7:0] data_out;
reg clear = 0;
wire [7:0] TestData_i [0:16-1];
reg [7:0] memory_array0_0_data_out_i [0:16-1];
initial begin: INITIALIZE_MEMORY_ARRAY0_0_DATA_OUT_I
    integer i;
    for(i=0; i<16; i=i+1) begin
        memory_array0_0_data_out_i[i] = 0;
    end
end
always @(clear, data_out, data_in, rptr, wptr, clk, fifo_we) begin: MEMORY_ARRAYTBV_PRINT_DATA
    $write("%h", data_in);
    $write(" ");
    $write("%h", fifo_we);
    $write(" ");
    $write("%h", wptr);
    $write(" ");
    $write("%h", rptr);
    $write(" ");
    $write("%h", data_out);
    $write(" ");
    $write("%h", clk);
    $write(" ");
    $write("%h", clear);
    $write("\n");
end
always @(posedge clk) begin: MEMORY_ARRAYTBV_MEMORY_ARRAY0_0_UPTAKE
    if (fifo_we) begin
        memory_array0_0_data_out_i[wptr[4-1:0]] <= data_in;
    end
end
assign data_out = memory_array0_0_data_out_i[rptr[4-1:0]];
always @(negedge clear) begin: MEMORY_ARRAYTBV_MEMORY_ARRAY0_0_CLEARMEM
    integer i;
    for (i=0; i<16; i=i+1) begin
        memory_array0_0_data_out_i[i] <= 0;
    end
end
initial begin: MEMORY_ARRAYTBV_CLK_SIGNAL
    while (1'b1) begin
        clk <= (!clk);
        # 1;
    end
end
initial begin: MEMORY_ARRAYTBV_STIMULES
    integer i;
    i = 0;
    while (1'b1) begin
        case (i)
            'h0: begin
                fifo_we <= 0;
            end
            'h2: begin
                fifo_we <= 1;
            end
            'hd: begin
                clear <= 1;
            end
            'he: begin
                clear <= 0;
            end
            'h10: begin
                $finish; 
            end
            default: begin
            end
        endcase
        data_in <= TestData_i[wptr]; 
        wptr <= (wptr + 1); 
        if ((i != 0)) begin
            rptr <= (rptr + 1); 
        end
        i = i + 1; 
        @(posedge clk); 
    end
end
endmodule 