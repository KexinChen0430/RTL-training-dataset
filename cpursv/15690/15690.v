
module top;

  reg  array1[2:1];
  reg  array2[1:0];
  real  array3[2:1];
  real  array4[1:0];
  integer index;
  reg  failed;

  
  initial  
  begin
    failed = 0;
    array1[1] <= 1'b0;
    array1[2] <= 1'b0;
    array1[0] <= 1'b1;
    #1 $display("array = %b %b",array1[2],array1[1]);
    if ((array1[1] !== 1'b0) || (array1[2] !== 1'b0)) failed = 1;
      
    if (failed) 
      $display("FAILED");
    else 
      $display("PASSED");
  end
endmodule

