
module top;

  wire [1:0] array1[2:1];
  wire [1:0] array2[1:0];
  reg  [1:0] var1;

  assign array1[1] = 2'd0;
  assign array1[2] = 2'd0;
  assign array2[0] = 2'd0;
  assign array2[1] = 2'd0;
  reg  failed;

  
  initial  
  begin
    failed = 0;
    force array1[1] = 2'd1;
    #1 $display("array = %h %h",array1[2],array1[1]);
    if ((array1[2] !== 2'd0) || (array1[1] !== 2'd1)) failed = 1;
      
    release array1[1];
    force array1[2] = var1;
    var1 = 2'd1;
    #1 $display("array = %h %h",array1[2],array1[1]);
    if ((array1[2] !== 2'd1) || (array1[1] !== 2'd0)) failed = 1;
      
    var1 = 2'd2;
    #1 $display("array = %h %h",array1[2],array1[1]);
    if ((array1[2] !== 2'd2) || (array1[1] !== 2'd0)) failed = 1;
      
    release array1[2];
    if (failed) 
      $display(FAILED);
    else 
      $display(PASSED);
  end
endmodule

