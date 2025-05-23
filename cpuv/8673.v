module`
reg wr = 0;
reg fifo_full = 0;
wire [4:0] wptr;
wire fifo_we;
reg clk = 0;
reg rst_n = 0;
wire write_pointer0_0_fifo_we_i;
reg [4:0] write_pointer0_0_wptr_i = 0;
always @(wr, fifo_full, rst_n, wptr, clk, fifo_we) begin: WRITE_POINTERTBV_PRINT_DATA
    $write("%h", wr);
    $write(" ");
    $write("%h", fifo_full);
    $write(" ");
    $write("%h", wptr);
    $write(" ");
    $write("%h", fifo_we);
    $write(" ");
    $write("%h", clk);
    $write(" ");
    $write("%h", rst_n);
    $write("\n");
end
assign write_pointer0_0_fifo_we_i = ((!fifo_full) && wr);
always @(posedge clk, negedge rst_n) begin: WRITE_POINTERTBV_WRITE_POINTER0_0_POINTERUPDATE
    if (rst_n) begin
        write_pointer0_0_wptr_i <= 0;
    end
    else if (write_pointer0_0_fifo_we_i) begin
        write_pointer0_0_wptr_i <= (write_pointer0_0_wptr_i + 1);
    end
    else begin
        write_pointer0_0_wptr_i <= write_pointer0_0_wptr_i;
    end
end
assign fifo_we = write_pointer0_0_fifo_we_i;
assign wptr = write_pointer0_0_wptr_i;
initial begin: WRITE_POINTERTBV_CLK_SIGNAL
    while (1'b1) begin
        clk <= (!clk);
        # 1;
    end
end
initial begin: WRITE_POINTERTBV_STIMULES
    integer i;
    i = 0;
    while (1'b1) begin
        case (i)
            'h0: begin
                wr <= 1;
            end
            'ha: begin
                wr <= 0;
            end
            'hc: begin
                wr <= 1;
            end
            'he: begin
                fifo_full <= 1;
            end
            'h10: begin
                rst_n <= 1;
            end
            'h12: begin
                rst_n <= 0;
            end
            'h14: begin
                $finish;
            end
            default: begin
            end
        endcase
        i = i + 1;
        @(posedge clk);
    end
end
endmodule