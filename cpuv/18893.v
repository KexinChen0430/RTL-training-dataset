module main ; 
reg [3:0] value1 ; 
task foo ; 
  value1 = #2  1; 
endtask 
initial 
  begin 
    value1 = 1'b0; 
    #5; 
    foo ; 
    #4 ; 
    if(value1 === 1'b0) 
      $display("PASSED"); 
    else 
      $display("FAILED - always3.1.9C always #2 disable foo"); 
    $finish ; 
  end 
always #6 disable foo ; 
endmodule 