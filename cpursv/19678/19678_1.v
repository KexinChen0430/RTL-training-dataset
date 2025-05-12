
module foo(in,out);

  parameter  blah = 2;
  input  in;
  output out;

  
  initial  
  begin
    if (blah != 4) 
      begin
        $display("FAILED -- parameter override of blah failed: %d",
                 blah);
        $finish;
      end
      
    $display(PASSED);
  end
endmodule

