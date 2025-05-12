module top;
`ifdef SIMULATION
initial begin
    $display("Hello, World!");
    $finish;
end
`endif
endmodule