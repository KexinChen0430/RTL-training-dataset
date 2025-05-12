
module main();

  parameter  INIT_00 = 32'hffffffff;
  reg  [17:0] t;
  reg  [8:0] c;

  
  initial  
  begin
    t = {17'd0,INIT_00[0]}<<<1;
    $display("%b",t);
    if (t !== 18'b00_0000_0000_0000_0010) 
      begin
        $display(FAILED);
        $finish;
      end
      
    c = 0;
    t = {17'd0,INIT_00[c]}<<<1;
    $display("%b",t);
    if (t !== 18'b00_0000_0000_0000_0010) 
      begin
        $display(FAILED);
        $finish;
      end
      
    c = 16;
    t = {17'd0,INIT_00[c]}<<<1;
    $display("%b",t);
    if (t !== 18'b00_0000_0000_0000_0010) 
      begin
        $display(FAILED);
        $finish;
      end
      
    $display(PASSED);
  end
endmodule

