module shifter_test;
reg signed [7:0] inp, out_srl, out_sll, out_sra, out_sla;
shifter dut(inp, out_srl, out_sll, out_sra, out_sla);
initial begin
  inp = 8'b11101100;
  #1;       
  if(out_srl !== 8'b01110110)
  begin
    $display("FAILED 1");
    $finish();
  end
  if(out_sll !== 8'b11011000)
  begin
    $display("FAILED 2");
    $finish();
  end
  if(out_sra !== 8'b11110110)
  begin
    $display("FAILED 3");
    $finish();
  end
  if(out_sla !== 8'b11011000)
  begin
    $display("FAILED 4");
    $finish();
  end
  $display("PASSED");
end
endmodule