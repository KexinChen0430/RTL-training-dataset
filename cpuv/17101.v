module vhdl_delay_assign_test; 
logic a, b, c; 
int passed = 0; 
vhdl_delay_assign dut(a, b, c); 
always @(b) 
begin
    if($time == 10) begin 
        passed = passed + 1; 
    end else begin
        $display("FAILED 1"); 
        $finish(); 
    end
end
always @(c) 
begin
    if($time == 10) begin 
        passed = passed + 1; 
    end else begin
        $display("FAILED 2"); 
        $finish(); 
    end
end
initial begin 
    a = 1; 
    #11; 
    if(passed !== 2) begin 
        $display("FAILED 3"); 
        $finish(); 
    end
    $display("PASSED"); 
end
endmodule 