module main ; 
reg [3:0] value1 ; 
initial 
  begin
    if(value1 !== 4'hx) 
	$display("FAILED - always reg_lvalue = # delay_value boolean_expr"); 
    #15 ; 
    if(value1 != 4'b1) 
	$display("FAILED - always reg_lvalue = # delay_value boolean_expr"); 
    else 
        begin
            $display("PASSED\n"); 
            $finish ; 
        end
   end
always 
          value1 <= # 10 1'b1 && 1'b1 ; 
endmodule 