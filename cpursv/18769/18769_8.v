
module main;

  reg  globvar;
  reg  [3:0] bvec,var1,var2,var3;
  reg  cond,a,b,out1,out2;
  reg  error;

  
  initial  
  begin
    error = 0;
    bvec = 4'bzx10;
    for (var1 = 0; var1 <= 3; var1 = var1+1)
        for (var2 = 0; var2 <= 3; var2 = 1+var2)
            for (var3 = 0; var3 <= 3; var3 = 1+var3)
                begin
                  if (var1 == 4'h0) cond = bvec[0];
                  else if (var1 == 4'h1) cond = bvec[1];
                  else if (var1 == 4'h2) cond = bvec[2];
                  else cond = bvec[3];
                  if (var2 == 4'h0) a = bvec[0];
                  else if (var2 == 4'h1) a = bvec[1];
                  else if (var2 == 4'h2) a = bvec[2];
                  else a = bvec[3];
                  if (var3 == 4'h0) a = bvec[0];
                  else if (var3 == 4'h1) a = bvec[1];
                  else if (var3 == 4'h2) a = bvec[2];
                  else a = bvec[3];
                  out1 = cond ? a : b;
                  if (cond) out2 = a;
                  else out2 = b;
                  if (out1 != out2) 
                    begin
                      $display("FAILED - qmark1 - %b %b %b %b %b",
                               cond,a,b,out1,out2);
                      error = 1;
                    end
                    
                end
    if (error == 0) 
      $display(PASSED);
      
  end
endmodule

