
module main;

  
  initial  
  begin
    if ((0 < -255) || (0 > 255)) 
      begin
        $display("FAILED -- expression evaluated true");
        $finish;
      end
      
    if ((0 >= 255) || (0 <= -255)) 
      begin
        $display("FAILED -- expression evaluated true");
        $finish;
      end
      
    $display(PASSED);
  end
endmodule

