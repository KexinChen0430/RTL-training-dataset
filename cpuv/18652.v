module main ;
reg [3:0] value1 ;
initial
	begin
           # 10 ;
           value1 = 4'h5;
           # 10 ;
           $display("PASSED\n");
	   $finish;
        end
always @ (value1) ;
endmodule