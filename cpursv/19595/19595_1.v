
module main;

  wire [3:0] value1;

  
  initial  
  begin
    #15 ;
    if (value1 != 4'h5) 
      $display("FAILED - 3.1.3G always force net_lvalue = boolean_expr;\n");
    else 
      begin
        $display(PASSED\n);
        $finish;
      end
  end
  
  always   force value1 = 1'b1;
endmodule

