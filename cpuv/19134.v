module range_func_test; 
range_func dut(); 
initial begin 
  #1; 
  if(dut.neg_out !== 4'b0011) 
  begin
    $display("FAILED 1"); 
    $finish(); 
  end
  if(dut.rev_out !== 4'b0001) 
  begin
    $display("FAILED 2"); 
    $finish(); 
  end
  $display("PASSED"); 
end 
endmodule 