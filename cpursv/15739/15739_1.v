
module top;

  reg  pass;
  reg  [7:0] in;
  reg  [3:0] out;

  
  initial  
  begin
    pass = 1'b1;
    in = 8'b10100101;
    out = 4'bxxxx;
    if (out !== 4'bxxxx) 
      begin
        $display("FAILED: part select LSB is X, expected 4'bxxxx, got %b",
                 out);
        pass = 1'b0;
      end
      
    out = 4'bxxxx;
    if (out !== 4'bxxxx) 
      begin
        $display("FAILED: part select MSB is X, expected 4'bxxxx, got %b",
                 out);
        pass = 1'b0;
      end
      
    out = 4'b0000;
    out[0] = 1'bx;
    if (out !== 4'b000x) 
      begin
        $display("FAILED: bit select is X, expected 4'b000x, got %b",
                 out);
        pass = 1'b0;
      end
      
    out = 4'bxxxx;
    if (out !== 4'bxxxx) 
      begin
        $display("FAILED: part select LSB is Z, expected 4'bxxxx, got %b",
                 out);
        pass = 1'b0;
      end
      
    out = 4'bxxxx;
    if (out !== 4'bxxxx) 
      begin
        $display("FAILED: part select MSB is Z, expected 4'bxxxx, got %b",
                 out);
        pass = 1'b0;
      end
      
    out = 4'b0000;
    out[0] = 1'bx;
    if (out !== 4'b000x) 
      begin
        $display("FAILED: bit select is Z, expected 4'b000x, got %b",
                 out);
        pass = 1'b0;
      end
      
    if (pass) 
      $display(PASSED);
      
  end
endmodule

