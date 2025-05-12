module vhdl_while_test;
logic start;
int out;
vhdl_while dut(start, out);
initial begin
    start = 1;
    #1;
    if(out !== 10) begin
        $display("FAILED");
        $finish();
    end
    $display("PASSED");
end
endmodule