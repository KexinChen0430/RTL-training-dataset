module main ; 
reg [3:0] value1 ; 
initial 
    if(value1 != 4'h5) 
	$display("FAILED - 3.1.2A always reg_lvalue = constant\n"); 
    else 
	begin
           $display("PASSED\n"); 
	   $finish; 
        end
always value1 <= 4'h5 ; 
endmodule 