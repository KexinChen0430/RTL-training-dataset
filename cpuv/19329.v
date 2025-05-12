module main ; 
reg [3:0] value1 ; 
task foo ; 
  value1 = #1  1; 
endtask 
initial 
  begin 
    value1 = 0; 
    #2 ; 
    $display("value = %d",value1); 
    #1 ; 
    $finish ; 
  end 
always disable foo ; 
endmodule 