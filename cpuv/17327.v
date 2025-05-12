module timer_tb;
    reg clk;
    always #1 clk = !clk;
    event end_trigger;
    always @(end_trigger) $finish;
`ifdef TB_VERBOSE
    initial #1 display_header();
    always @(end_trigger) display_header();
    always @(posedge clk) display_signals();
`endif
    parameter TIMEOUT = 10;
`ifdef TB_VERBOSE
    initial $display("Testbench for unit 'timer'");
`endif
    reg     rst;
    reg     up_req;
    wire    up_grant;
    wire    down_req;
    wire    down_grant;
    timer #(
        .TIMEOUT (TIMEOUT))
    uut (
        .clk       (clk),
        .rst       (rst),
        .up_req    (up_req),
        .up_grant  (up_grant),
        .up_ack    (),
        .down_req  (down_req),
        .down_grant(down_grant),
        .down_ack  ()
    );
    task display_signals;
        $display(
            "%d\t%d", 
            $time, rst,
            "\t%b\t%b", 
            up_req,
            down_req,
            "\t%b\t%b", 
            up_grant,
            down_grant,
        );
    endtask 
    task display_header;
        $display({
            "\t\ttime\trst", 
            ""});
    endtask
    assign down_grant = down_req;
    initial begin
        clk = 0;
        rst = 0;
        up_req = 1'b0;
`ifdef TB_VERBOSE
    $display("RESET");
`endif
        repeat(10) @(posedge clk);
        rst <= 1'b1;
        repeat(10) @(posedge clk);
        rst <= 1'b0;
        repeat(20) @(posedge clk);
`ifdef TB_VERBOSE
    $display("TEST different ports request priority");
`endif
        up_req = 1'b1;
        repeat(5) @(posedge clk);
        up_req = 1'b0;
        repeat(15) @(posedge clk);
        up_req = 1'b1;
        repeat(15) @(posedge clk);
        up_req = 1'b0;
        @(posedge clk);
        @(posedge clk);
`ifdef TB_VERBOSE
    $display("END");
`endif
        -> end_trigger;
    end
endmodule