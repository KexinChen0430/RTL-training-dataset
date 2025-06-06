
module main;

  reg  globvar;
  reg  [3:0] bvec,var1,var2,var3;
  reg  cond,a,b,out1,out2;
  reg  error;

  
  initial  
  begin
    error = 0;
    bvec = 4'bzx10;
    for (var1 = 0; var1 <= 3; var1 = 1+var1)
        for (var2 = 0; var2 <= 3; var2 = var2+1)
            for (var3 = 0; var3 <= 3; var3 = 1+var3)
                begin
                  cond = bvec[var1];
                  a = bvec[var2];
                  b = bvec[var3];
                  out1 = cond ? a : b;
                  if (cond) out2 = a;
                  else out2 = b;
                  if (out1 != out2) 
                    begin
                      $display("FAILED - %b %b %b %b %b",cond,a,b,
                               out1,out2);
                      error = 1;
                    end
                    
                end
    if (error == 0) 
      $display(PASSED);
      
  end
endmodule

