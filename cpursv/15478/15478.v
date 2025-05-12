
module top;

  wire [1:0] array1[2:1];
  wire [1:0] array2[1:0];

  assign array1[0] = 2'd0;
  assign array1[1] = 2'd1;
  assign array1[2] = 2'd2;
  assign array1[3] = 2'd3;
  assign array2[0] = 2'd0;
  assign array2[1] = 2'd1;
  assign array2['bx] = 2'd2;
  reg  failed;

  
  initial  
  begin
    #1 failed = 0; $display("array = %h %h",array1[2],array1[1]);
    if ((array1[1] !== 2'd1) || (array1[2] !== 2'd2)) failed = 1;
      
    $display("array = %h %h",array2[1],array2[0]);
    if ((array2[0] !== 2'd0) || (array2[1] !== 2'd1)) failed = 1;
      
    if (failed) 
      $display("FAILED");
    else 
      $display("PASSED");
  end
endmodule

