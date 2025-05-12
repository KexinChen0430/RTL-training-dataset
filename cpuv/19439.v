module main ;
reg [3:0] value1 ;
initial
  begin
    #15; 
    if(value1 != 4'h5)
      $display("FAILED - 3.1.3D always force reg_lvalue = constant;\n");
    else
	begin
           $display("PASSED\n");
	   $finish;
        end
  end
always force value1 = 4'h5;
endmodule