module arbiter_tb;
    reg clk;
    always #1 clk = !clk;
    event end_trigger;
    always @(end_trigger) $finish;
`ifdef TB_VERBOSE
    initial #1 display_header();
    always @(end_trigger) display_header();
    always @(posedge clk) display_signals();
`endif
    parameter NUM_PORTS = 9;
`ifdef TB_VERBOSE
    initial $display("Testbench for unit 'arbiter'");
`endif
    reg                     rst;
    reg  [NUM_PORTS-1:0]    request;
    wire [NUM_PORTS-1:0]    grant;
    wire                    active;
    arbiter #(
        .NUM_PORTS (NUM_PORTS))
    uut (
        .clk       (clk),
        .rst       (rst),
        .request   (request),
        .grant     (grant),
        .active    (active)
    );
    task display_signals;
        $display(
            "%d\t%d",
            $time, rst,
            "\t%b\t%b\t%b",
            request,
            grant,
            active,
        );
    endtask 
    task display_header;
        $display({
            "\t\ttime\trst",
            ""});
    endtask
    initial begin
        clk = 0;
        rst = 0;
        request = 1'b0;
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
        request = 9'b100000001;
        repeat(15) @(posedge clk);
        request = 9'b000000010;
        repeat(15) @(posedge clk);
        request = 9'b010000001;
        repeat(15) @(posedge clk);
        request = 9'b000000001;
        @(posedge clk);
        request = 9'b010000001;
        repeat(15) @(posedge clk);
        request = 9'b010000000;
        repeat(5) @(posedge clk);
        request = 9'b010000100;
        repeat(10) @(posedge clk);
        request = 9'b000000100;
        repeat(15) @(posedge clk);
        request = 9'b000100000;
        repeat(15) @(posedge clk);
        request = 9'b000000000;
        @(posedge clk);
        request = 9'b000100000;
        repeat(10) @(posedge clk);
`ifdef TB_VERBOSE
    $display("TEST when all ports request priority");
`endif
        request = 9'b111111111;
        repeat(10) @(posedge clk);
        request = 9'b111011111;
        @(posedge clk);
        request = 9'b111111111;
        repeat(10) @(posedge clk);
        request = 9'b110111111;
        @(posedge clk);
        request = 9'b111111111;
        repeat(10) @(posedge clk);
        request = 9'b101111111;
        @(posedge clk);
        request = 9'b111111111;
        repeat(10) @(posedge clk);
        request = 9'b011111111;
        @(posedge clk);
        request = 9'b111111111;
        repeat(10) @(posedge clk);
        @(posedge clk);
`ifdef TB_VERBOSE
    $display("END");
`endif
        -> end_trigger;
    end
endmodule