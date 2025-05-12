module main ; 
reg [3:0] value1 ; 
initial 
	begin
           # 1; 
           if(value1 != 4'bxxxx)
             $display("FAILED - 3.1.4F - initial value not xxxx;\n");
           #10 ; 
           if(value1 != 4'h5)
             $display("FAILED - 3.1.4F - always # (mintypmax_dly)  reg_lvalue = boolean_expr\n");
           #10 ; 
           if(value1 != 4'hA)
             $display("FAILED - 3.1.4F - always # (mintypmax_dly)  reg_lvalue = boolean_expr\n");
           else
              begin
                 $display("PASSED\n");
              end
           $finish; 
        end
always # 10 value1 = ~value1; 
endmodule 