
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
    assign array1[0] = 2'd1;
    #1 $display("array = %h %h",array1[2],array1[1]);
    if ((array1[1] !== 2'd0) || (array1[2] !== 2'd0)) failed = 1;
      
    deassign array1[0];
    assign array1[3] = var1;
    #1 $display("array = %h %h",array1[2],array1[1]);
    if ((array1[1] !== 2'd0) || (array1[2] !== 2'd0)) failed = 1;
      
    deassign array1[3];
    assign array2['bx] = 2'd1;
    #1 $display("array = %h %h",array2[1],array2[0]);
    if ((array2[0] !== 2'd0) || (array2[1] !== 2'd0)) failed = 1;
      
    deassign array2['bx];
    array3[1] = 0.;
    array3[2] = 0.;
    array4[0] = 0.;
    array4[1] = 0.;
    assign array3[0] = 1.;
    #1 $display("array = %0g %0g",array3[2],array3[1]);
    if ((array3[2] != 0.) || (array3[1] != 0.)) failed = 1;
      
    deassign array3[0];
    assign array3[3] = var2;
    #1 $display("array = %0g %0g",array3[2],array3[1]);
    if ((array3[2] != 0.) || (array3[1] != 0.)) failed = 1;
      
    deassign array3[3];
    assign array4['bx] = 1.;
    #1 $display("array = %0g %0g",array4[1],array4[0]);
    if ((array4[0] != 0.) || (array4[1] != 0.)) failed = 1;
      
    deassign array4['bx];
    if (failed) 
      $display(FAILED);
    else 
      $display(PASSED);
  end
endmodule

