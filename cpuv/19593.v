module main ; 
reg [3:0] value1 ; 
initial 
  begin
    # 3;  
    if(value1 !== 4'hx) 
	$display("FAILED - always reg_lvalue = # (mintypmax_expression) boolean_exp \n"); 
    #12 ; 
    if(value1 != 4'b1) 
	$display("FAILED - always reg_lvalue = # (mintypmax_expression) boolean_exp \n"); 
    else
        begin
            $display("PASSED\n"); 
            $finish ; 
        end
   end
always value1 = # (2:10:17) 1'b1 && 1'b1 ; 
endmodule 