
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
    assign array1[1] = 2'd1;
    #1 $display("array = %h %h",array1[2],array1[1]);
    if ((array1[1] !== 2'd1) || (array1[2] !== 2'd0)) failed = 1;
      
    deassign array1[1];
    assign array1[2] = var1;
    var1 = 2'd1;
    #1 $display("array = %h %h",array1[2],array1[1]);
    if ((array1[1] !== 2'd0) || (array1[2] !== 2'd1)) failed = 1;
      
    var1 = 2'd2;
    #1 $display("array = %h %h",array1[2],array1[1]);
    if ((array1[1] !== 2'd0) || (array1[2] !== 2'd2)) failed = 1;
      
    deassign array1[2];
    array3[1] = 0.;
    array3[2] = 0.;
    array4[0] = 0.;
    array4[1] = 0.;
    assign array3[1] = 1.;
    #1 $display("array = %0g %0g",array3[2],array3[1]);
    if ((array3[1] != 1.) || (array3[2] != 0.)) failed = 1;
      
    deassign array3[1];
    assign array3[2] = var2;
    var2 = 1.;
    #1 $display("array = %0g %0g",array3[2],array3[1]);
    if ((array3[1] != 0.) || (array3[2] != 1.)) failed = 1;
      
    var2 = 2.;
    #1 $display("array = %0g %0g",array3[2],array3[1]);
    if ((array3[1] != 0.) || (array3[2] != 2.)) failed = 1;
      
    deassign array3[2];
    if (failed) 
      $display(FAILED);
    else 
      $display(PASSED);
  end
endmodule

