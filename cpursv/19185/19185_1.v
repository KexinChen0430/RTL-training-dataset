
module main;

  reg  enable,val;
  tri0  t0 = ~enable ? 1'bz : val;

  
  initial  
  begin
    enable = 0;
    val = 0;
    #1 
      if (t0 !== 1'b0) 
        begin
          $display("FAILED -- undriven t0 == %b",t0);
          $finish;
        end
        

    enable = 1;
    #1 
      if (t0 !== 1'b0) 
        begin
          $display("FAILED -- driven-0 t0 == %b",t0);
          $finish;
        end
        

    val = 1;
    #1 
      if (t0 !== 1'b1) 
        begin
          $display("FAILED -- driven-1 t0 == %b",t0);
          $finish;
        end
        

    $display(PASSED);
  end
endmodule

