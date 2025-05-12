module example_tb; 
    reg clk; 
    always #1 clk = !clk; 
    event end_trigger; 
    always @(end_trigger) $finish; 
`ifdef TB_VERBOSE 
    initial #1 display_header(); 
    always @(end_trigger) display_header(); 
    always @(posedge clk) display_signals(); 
`endif
    localparam NUM_PORTS    = 3; 
    localparam TIMEOUT      = 5; 
`ifdef TB_VERBOSE 
    initial $display("Testbench for unit 'example'"); 
`endif
    reg     rst; 
    reg  [NUM_PORTS-1:0]    request; 
    wire [NUM_PORTS-1:0]    grant; 
    wire                    active; 
    example #( 
        .NUM_PORTS  (NUM_PORTS), 
        .TIMEOUT    (TIMEOUT)) 
    uut ( 
        .clk        (clk), 
        .rst        (rst), 
        .request    (request), 
        .grant      (grant), 
        .active     (active) 
    );
    task display_signals;
        $display(
            "%d\t%d",
            $time, rst,
            "\t%b\t%b",
            request,
            grant,
            "\t%b",
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
        request = 'b0; 
`ifdef TB_VERBOSE 
    $display("RESET"); 
`endif
        repeat(10) @(negedge clk); 
        rst <= 1'b1; 
        repeat(10) @(negedge clk); 
        rst <= 1'b0; 
        repeat(20) @(negedge clk); 
`ifdef TB_VERBOSE 
    $display("TEST different ports request priority"); 
`endif
        request = 3'b010; 
        repeat(15) @(negedge clk); 
        request = 3'b000; 
        repeat(15) @(negedge clk); 
        request = 3'b110; 
        repeat(15) @(negedge clk); 
        request = 3'b111; 
        repeat(25) @(negedge clk); 
        request = 3'b010; 
        repeat(15) @(negedge clk); 
        request = 3'b110; 
        repeat(15) @(negedge clk); 
        request = 3'b011; 
        repeat(15) @(negedge clk); 
        request = 3'b001; 
        repeat(15) @(negedge clk); 
        @(negedge clk); 
`ifdef TB_VERBOSE 
    $display("END"); 
`endif
        -> end_trigger; 
    end 
endmodule 