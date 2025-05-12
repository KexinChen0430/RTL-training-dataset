module concat_test;
  concat dut();
  initial begin
    #1;       
    if(dut.concat1 !== 2'b10)
    begin
      $display("FAILED: concat1 should be 10 but is %b", dut.concat1);
      $finish();
    end
    if(dut.concat2 !== 5'b11010)
    begin
      $display("FAILED: concat2 should be 11010 but is %b", dut.concat2);
      $finish();
    end
    $display("PASSED");
  end
endmodule