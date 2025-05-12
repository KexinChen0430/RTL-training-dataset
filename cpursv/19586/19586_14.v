
module xnor_test;

  reg  onebit1,onebit2;
  reg  [3:0] small1,small2;
  reg  [15:0] large1,large2,large3,large4;
  reg  fail;

  
  initial  
  begin
    fail = 0;
    if ((1'b0 ^~ 1'b1) === 1'b1) fail = 1;
      
    if ((1'b0 ^~ 1'b1) === 1'b1) fail = 1;
      
    if ((1'b0 ^~ 1'b0) === 1'b0) fail = 1;
      
    if ((1'b1 ^~ 1'b1) === 1'b0) fail = 1;
      
    for (small1 = 0; small1 < 15; small1 = small1+1)
        begin
          large1 = {12'b0,small1};
          large2 = small1 ^~ large1;
          if (large2 !== {16{1'b1}}) fail = 1;
            
          large2 = small1 ^~ large1;
          if (large2 !== {16{1'b1}}) fail = 1;
            
        end
    for (large1 = 0; large1 < 1000; large1 = large1+1)
        begin
          large2 = 1511+large1;
          large3 = ~((large2 & ~large1) | ((~large2 | ~large1) & large1));
          large4 = ((~large2 & large2) | (~large1 & ~large2)) | (((large2 | ~large2) & large1) & large2);
          if (large3 !== large4) 
            begin
              fail = 1;
              $display("Pattern failed: %h != %h",large3,large4);
            end
            
        end
    if (fail) 
      $display(FAILED);
    else 
      $display(PASSED);
    $finish;
  end
endmodule

