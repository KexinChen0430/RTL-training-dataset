
module main;

  reg  [7:0] tmp;

  
  initial  
  begin
    tmp = 8'b0;
    #1 
      if (tmp !== 8'b00000000) 
        begin
          $display("FAILED to set tmp: %b",tmp);
          $finish;
        end
        

    tmp <= ~8'b0;
    #1 
      if (tmp !== 8'b11111111) 
        begin
          $display("FAILED to set ~0: %b",tmp);
          $finish;
        end
        

    tmp <= ~tmp;
    #1 
      if (tmp !== 8'b00000000) 
        begin
          $display("FAILED to invert tmp: %b",tmp);
          $finish;
        end
        

    $display(PASSED);
  end
endmodule

