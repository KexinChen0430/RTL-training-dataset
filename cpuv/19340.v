module main ();
  reg [5 * 2: 0] val1;
  reg [10'h1 * 10: 0 ] val2 ;
  initial
    begin
       val1 = 11'h1 * 5;
       val2 = 11'h2 * 4;
       if((val1 === 11'h5) && (val2 === 11'h8))
          $display("PASSED");
       else
          $display("FAILED");
    end
endmodule