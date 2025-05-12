module main();
reg [3:0] global_reg;
task dec_glob;
begin
  global_reg = global_reg - 1;
end
endtask 
initial
begin
  global_reg = 2;
  dec_glob;
  if(global_reg != 1)
    begin
      $display("FAILED - task didn't modify global_reg\n");
      $finish;
    end
  $display("PASSED\n");
  $finish;
end
endmodule 