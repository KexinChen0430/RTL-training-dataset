
module main;

  reg  signed  [7:0]  val_rs = -5;
  wire [7:0]  val_w = 1+val_rs;
  wire signed  [7:0]  val_ws = 1+val_rs;

  
  initial  
  begin
    #1 $display("val_w=%d, val_ws=%d",val_w,val_ws);
    if (val_w !== 8'd252) 
      begin
        $display("FAILED -- val_w is wrong: %b",val_w);
        $finish;
      end
      
    if (val_ws !== -8'sd4) 
      begin
        $display("FAILED == val_ws is wrong: %b",val_ws);
        $finish;
      end
      
    if (val_ws > 0) 
      begin
        $display("FAILED -- signed test of val_ws failed");
        $finish;
      end
      
    if (val_w < 0) 
      begin
        $display("FAILED -- signed test of val_w failed");
        $finish;
      end
      
    $display(PASSED);
  end
endmodule

