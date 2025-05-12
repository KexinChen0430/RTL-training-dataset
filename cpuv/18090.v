module labeled_assign_test;
reg [7:0] in, out;
labeled_assign dut(in, out);
initial begin
  in = 8'hdd;
  #1;
  if(out !== 8'h11)
  begin
    $display("FAILED 1");
    $finish();
  end
  if(dut.test_rx !== 8'haa)
  begin
    $display("FAILED 2");
    $finish();
  end
  $display("PASSED");
end
endmodule