module elsif_test(); 
`define DEFINED 
`ifdef 
`ifndef 
`elsif 
`elsif DEFINED 
`else 
`endif 
integer i; 
initial begin 
  i = 0; 
`ifdef DEFINED 
  `ifdef DEFINED 
    i = i + 1; 
  `elsif DEFINED 
    i = 100; 
  `else 
    i = 110; 
  `else 
    i = 999; 
  `endif 
  if (i == 3) 
    $display("PASSED"); 
  else 
    $display("Test FAILED: %d", i); 
end 
endmodule 