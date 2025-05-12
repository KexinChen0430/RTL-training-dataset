
module main;

  reg  [3:0]  val_drv = 4'b0101;
  wire [3:0]  val = val_drv;

  
  initial  
  begin
    #50 
      if (val !== val_drv) 
        begin
          $display("FAILED -- initial val %b !== %b",val,val_drv);
          $finish;
        end
        

    force val = 4'b1010;
    #1 
      if (val !== 4'b1010) 
        begin
          $display("FAILED -- force 1010 failed, val=%b",val);
          $finish;
        end
        

    force val = 4'bzzzz;
    if (val !== 4'bzzzz) 
      begin
        $display("FAILED -- force z failed, val=%b",val);
        $finish;
      end
      
    release val;
    #1 
      if (val !== 4'b0101) 
        begin
          $display("FAILED -- unforced val = %b",val);
          $finish;
        end
        

    val_drv = 4'b1010;
    #1 
      if (val !== 4'b1010) 
        begin
          $display("FAILED -- val_drv=%b, val=%b",val_drv,val);
          $finish;
        end
        

    $display(PASSED);
  end
endmodule

