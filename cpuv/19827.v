module main ; 
reg [3:0] value1 ; 
reg err ; 
initial 
	begin
           err = 0; 
           # 1; 
           if(value1 !== 4'bxxxx) 
             begin
               $display("FAILED - 3.1.4E - initial value not xxxx;\n"); 
               err = 1; 
             end
           #15 ; 
           if(value1 != 4'h5) 
             begin
               $display("FAILED - 3.1.4E - always # mintypmax_dly reg_lvalue = constant\n"); 
               err = 1; 
             end
           if (err == 0) 
             $display("PASSED\n"); 
	     $finish; 
        end
always # (3:10:15) value1 = 4'h5; 
endmodule 