
module top;

  parameter  pval = -2;
  reg   pass = 1'b1;
  reg  [14:-1]  big = 16'h0123;
  reg  [15:0]  big_0 = 16'h0123;
  reg  signed  [15:0] idxs[0:1];
  reg  signed  [15:0] a;
  reg  [8*4:1] res;

  
  initial  
  begin
    a = -2;
    $sformat(res,"%b",big[a +: 4]);
    if (res !== 011x) 
      begin
        $display("Failed: &PV<> check 1, expected 4'b011x, got %s.",
                 res);
        pass = 1'b0;
      end
      
    a = 0;
    idxs[0] = -1;
    $sformat(res,"%b",big_0[idxs[a] +: 4]);
    if (res !== 011x) 
      begin
        $display("Failed: &PV<> check 2, expected 4'b011x, got %s.",
                 res);
        pass = 1'b0;
      end
      
    $sformat(res,"%bx",big[1+pval +: 3]);
    if (res !== 011x) 
      begin
        $display("Failed: &PV<> check 3, expected 4'b011x, got %s.",
                 res);
        pass = 1'b0;
      end
      
    a = -1;
    $sformat(res,"%b",big_0[a +: 4]);
    if (res !== 011x) 
      begin
        $display("Failed: &PV<> check 4, expected 4'b011x, got %s.",
                 res);
        pass = 1'b0;
      end
      
    if (pass) 
      $display(PASSED);
      
  end
endmodule

