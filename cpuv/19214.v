module main ; 
reg [3:0] value1 ; 
initial 
  begin
    if(value1 !== 4'hx) 
	$display("FAILED - always reg_lvalue = # delay_value constant"); 
    #15 ; 
    if(value1 !== 4'h5) 
	$display("FAILED - always reg_lvalue = # delay_value constant"); 
    else 
        begin
            $display("PASSED\n"); 
            $finish ; 
        end
   end
always value1 = # 10 4'h5 ; 
endmodule 