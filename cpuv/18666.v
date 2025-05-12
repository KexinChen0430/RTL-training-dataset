module main ; 
reg [3:0] value1 ; 
initial 
  begin
    # 3;  
    if(value1 !== 4'hx) 
	$display("FAILED - always reg_lvalue <= # (mintypmax_expression) boolean_expr \n"); 
    #12 ; 
    if(value1 != 4'h5) 
	$display("FAILED - always reg_lvalue <= # (mintypmax_expression) boolean_expr \n"); 
    else 
        begin
            $display("PASSED\n"); 
            $finish ; 
        end
   end
always value1 <= # (2:10:17) 1'b1 && 1'b1  ; 
endmodule 