module main ; 
reg [3:0] value1 ; 
initial 
  begin
    # 3;  
    if(value1 !== 4'hx) 
	$display("FAILED - always reg_lvalue <= # (mintypmax_expression) constant \n");
    #12 ; 
    if(value1 != 4'h5) 
	$display("FAILED - always reg_lvalue <= # (mintypmax_expression) constant \n");
    else
        begin
            $display("PASSED\n"); 
            $finish ; 
        end
   end
always value1 <= # (2:10:17) 4'h5 ; 
endmodule 