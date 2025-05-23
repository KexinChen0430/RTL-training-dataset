module
reg clk = 0;
reg rst_n = 0;
reg rd = 0;
reg fifo_empty = 0;
wire [4:0] rptr;
wire fifo_rd;
wire read_pointer0_0_fifo_rd_i;
reg [4:0] read_pointer0_0_rptr_i = 0;
always @(rd, fifo_rd, fifo_empty, rst_n, rptr, clk) begin: READ_POINTERTBV_PRINT_DATA
    $write("%h", rd);
    $write(" ");
    $write("%h", fifo_empty);
    $write(" ");
    $write("%h", rptr);
    $write(" ");
    $write("%h", fifo_rd);
    $write(" ");
    $write("%h", clk);
    $write(" ");
    $write("%h", rst_n);
    $write("\n");
end
assign read_pointer0_0_fifo_rd_i = ((!fifo_empty) && rd);
always @(posedge clk, negedge rst_n) begin: READ_POINTERTBV_READ_POINTER0_0_POINTERUPDATE
    if (rst_n) begin
        read_pointer0_0_rptr_i <= 0;
    end
    else if (read_pointer0_0_fifo_rd_i) begin
        read_pointer0_0_rptr_i <= (read_pointer0_0_rptr_i + 1);
    end
    else begin
        read_pointer0_0_rptr_i <= read_pointer0_0_rptr_i;
    end
end
assign fifo_rd = read_pointer0_0_fifo_rd_i;
assign rptr = read_pointer0_0_rptr_i;
initial begin: READ_POINTERTBV_CLK_SIGNAL
    while (1'b1) begin
        clk <= (!clk);
        # 1;
    end
end
initial begin: READ_POINTERTBV_STIMULES
    integer i;
    i = 0;
    while (1'b1) begin
        case (i)
            'h0: begin
                rd <= 1;
            end
            'ha: begin
                rd <= 0;
            end
            'hc: begin
                rd <= 1;
            end
            'he: begin
                fifo_empty <= 1;
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