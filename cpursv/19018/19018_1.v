
module top();

  reg  [31:0] ii;
  reg  fail;
  reg  [1:0] a;
  wire [1:0]  junk = a;
  wire [1:0]  junkbus = a;

  
  initial  
  begin
    a = 2'b01;
    #5 ;
    a = 2'b10;
    #10 ;
    a = 2'b11;
  end
  
  initial  
  begin
    #2 ;
    force junk = 0;
    force junkbus[0] = 0;
    #10 ;
    release junk;
    #5 ;
    release junkbus[0];
  end
  
  initial  
  begin
    $display("");
    $display("expecting junk,junkbus to be 1 at T=1");
    $display("junkbus changes to 3 at T=17 and remains 3 from then on");
    $display("");
    for (ii = 0; ii < 20; ii = ii+1)
        begin
          #0 ;
          $display("time: %0t, a: %b, junk: %b, junkbus: %b",$time,a,
                   junk,junkbus);
          #1 ;
        end
    if (fail) 
      $display("\n\t--------- force test failed ---------\n");
    else 
      $display("\n\t--------- force test passed ---------\n");
  end
endmodule

