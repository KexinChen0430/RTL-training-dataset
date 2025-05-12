module main ; 
reg [3:0] value1 ; 
reg err ; 
initial 
	begin
           err = 0; 
           # 1; 
           if(value1 !== 4'bxxxx) 
             begin
               $display("FAILED - 3.1.4C - initial value not xxxx;\n"); 
               err = 1; 
             end
           #10 ; 
           if(value1 != 4'h5) 
             begin
               $display("FAILED - 3.1.4C - always # delay_value reg_lvalue = boolean_expr\n"); 
               err = 1; 
             end
           #10 ; 
           if(value1 != 4'hA) 
             begin
               $display("FAILED - 3.1.4C - always # delay_value reg_lvalue = boolean_expr\n"); 
               err = 1; 
             end
           if (err == 0) 
             $display("PASSED\n"); 
           $finish; 
        end
always # 10 value1 = ~value1; 
endmodule 