
module main;

  reg  globvar;
  reg  [3:0] var1,var2,var3;
  wire [3:0] var3a;
  reg  error;

  assign var3a = var2+var1;
  
  always @(var1 or var2)  var3 = var2+var1;
  
  initial  
  begin
    error = 0;
    for (var1 = 4'b0; var1 != 4'hf; var1 = 1+var1)
        for (var2 = 4'b0; var2 != 4'hf; var2 = 1+var2)
            begin
              #1 ;
              if (var3 !== var3a) error = 1;
                
              #1 ;
            end
    if (error == 0) 
      $display(PASSED);
    else 
      $display(FAILED);
  end
endmodule

