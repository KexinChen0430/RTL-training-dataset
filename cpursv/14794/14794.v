
module top;

  reg  [1:0] array1[2:1];
  reg  [1:0] array2[1:0];
  reg  [1:0] var1;
  real  array3[2:1];
  real  array4[1:0];
  real  var2;
  reg  failed;

  
  initial  
  begin
    failed = 0;
    array1[1] = 2'd0;
    array1[2] = 2'd0;
    array2[0] = 2'd0;
    array2[1] = 2'd0;
    array3[1] = 0.;
    array3[2] = 0.;
    array4[0] = 0.;
    array4[1] = 0.;
    if (failed) 
      $display("FAILED");
    else 
      $display("PASSED");
  end
endmodule

