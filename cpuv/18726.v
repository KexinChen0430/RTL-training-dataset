module vhdl_case_multi_test;
  reg [2:0] test_vec;
  reg parity;
  vhdl_case_multi dut(test_vec, parity);
  initial begin
    test_vec = 'b101; 
    #1; 
    if(parity !== 1'b0) begin 
        $display("FAILED 1"); 
        $finish(); 
    end
    test_vec = 'b001; 
    #1; 
    if(parity !== 1'b1) begin 
        $display("FAILED 2"); 
        $finish(); 
    end
    $display("PASSED");
  end
endmodule