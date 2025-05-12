module main ; 
reg [3:0] value1,value2; 
initial 
	begin
           # 1; 
           if(value1 != 4'bxxxx) 
             $display("FAILED - 3.1.4I - initial value not xxxx;\n"); 
           value2 = 4'b1; 
           #10 ; 
           if(value1 != 4'h5) 
             $display("FAILED - 3.1.4I - always @ (event_expression) reg_lvalue = boolean_expr;\n"); 
           value2 = 4'b0; 
           #10 ; 
           if(value1 != 4'hA) 
             $display("FAILED - 3.1.4I - always @ (event_expression) reg_lvalue = boolean_expr;\n"); 
           else
              begin
                 $display("PASSED\n"); 
              end
           $finish; 
        end
always # 10 value1 = ~value1; 
endmodule 