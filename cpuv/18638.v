module main ; 
reg [3:0] value1,value2 ; 
initial 
	begin
           # 1; 
           if(value1 != 4'bxxxx)
             $display("FAILED - 3.1.4H - initial value not xxxx;\n");
           value2 = 4'h1;	
           #15 ; 
           if(value1 != 4'h5)
             $display("FAILED - 3.1.4H - always @ (event_expression) reg_lvalue = constant ;\n");
           else
              begin
		 $display("PASSED\n"); 
		 $finish; 
              end
        end
always @ (value2) value1 = ~value1; 
endmodule 