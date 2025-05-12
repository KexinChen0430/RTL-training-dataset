module const_package_test; 
  const_package dut(); 
  initial begin 
    if(dut.c_bitstring != 'b1001) begin 
      $display("FAILED 1"); 
      $finish; 
    end
    #1;   
    if(dut.c_aggregate != 'b10001000) begin 
      $display("FAILED 2"); 
      $finish; 
    end
    $display("PASSED"); 
  end 
endmodule 