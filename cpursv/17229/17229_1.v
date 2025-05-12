
module main();

  reg  [34:0] my_reg;
  reg  error;
  reg  [34:0] ref_val;
  reg  [34:0] ref_val2;
  reg  [7:0] count;

  
  initial  
  begin
    error = 0;
    ref_val = 0;
    ref_val[0] = 1;
    ref_val[34] = 1;
    $display("*:%d",ref_val);
    ref_val2 = 35'h7ffffffff;
    $display("*:%d",ref_val2);
    my_reg = 100;
    if (my_reg != 'h64) 
      begin
        error = 1;
        $display("Error: expected 100");
      end
      
    my_reg = 17179869185;
    $display("1:%d",my_reg);
    if (my_reg != 1) 
      begin
        error = 1;
        $display("Error: expected 1");
      end
      
    my_reg = 'd17179869184;
    $display("2:%d",my_reg);
    if (my_reg != 0) 
      begin
        error = 1;
        $display("Error: expected 1");
      end
      
    my_reg = 35'sd17179869185;
    $display("3:%d",my_reg);
    if (my_reg != ref_val) 
      begin
        error = 1;
        $display("Error: expected 17179869185");
      end
      
    my_reg = 35'd17179869185;
    $display("4:%d",my_reg);
    if (my_reg != ref_val) 
      begin
        error = 1;
        $display("Error: expected 17179869185");
      end
      
    my_reg = 35'd34359738369;
    $display("5:%d",my_reg);
    if (my_reg != 1) 
      begin
        error = 1;
        $display("Error: expected 1");
      end
      
    my_reg = 35'd34359738367;
    $display("6:%d",my_reg);
    if (my_reg != ref_val2) 
      begin
        error = 1;
        $display("Error: expected 34359738367");
      end
      
    my_reg = 17179869183;
    $display("7:%d",my_reg);
    if (my_reg != ref_val2) 
      begin
        error = 1;
        $display("Error: expected 34359738367");
      end
      
    my_reg = 'd17179869183;
    $display("8:%d",my_reg);
    if (my_reg != 'd4294967295) 
      begin
        error = 1;
        $display("Error: expected 4294967295");
      end
      
    if (error == 1) 
      begin
        $display(FAILED);
      end
    else 
      begin
        $display(PASSED);
      end
    $finish;
  end
endmodule

