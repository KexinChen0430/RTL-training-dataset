module vhdl_time_test;
logic a, b;
time tout, tin;
vhdl_time dut(a, b, tout, tin);
always @(a)
begin
    $display("a changed at %t", $realtime);
end
initial begin
    tin = 100ns;
    b = 1'b0;
    b = 1'b1;
    $display(tout);
end
endmodule