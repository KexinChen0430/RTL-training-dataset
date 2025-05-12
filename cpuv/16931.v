module top; 
  reg a, q, qb; 
  reg pass; 
  always_comb q = a !== 1'bx; 
  always_comb qb = a === 1'bx; 
  initial begin 
    pass = 1'b1; 
    #0; 
    #0; 
    if (q !== 1'b0) begin 
      $display("Expected q = 1'b0 with the default 1'bx input, got %b", q); 
      pass = 1'b0; 
    end
    if (qb !== 1'b1) begin 
      $display("Expected qb = 1'b1 with the default 1'bx input, got %b", qb); 
      pass = 1'b0; 
    end
    #1; 
    a = 1'b0; 
    #0; 
    if (q !== 1'b1) begin 
      $display("Expected q = 1'b1 with an explicit 1'b0 input, got %b", q); 
      pass = 1'b0; 
    end
    #1; 
    a = 1'b1; 
    #0; 
    if (q !== 1'b1) begin 
      $display("Expected q = 1'b1 with an explicit 1'b1 input, got %b", q); 
      pass = 1'b0; 
    end
    #1; 
    a = 1'bz; 
    #0; 
    if (q !== 1'b1) begin 
      $display("Expected q = 1'b1 with an explicit 1'bz input, got %b", q); 
      pass = 1'b0; 
    end
    #1; 
    a = 1'bx; 
    #0; 
    if (q !== 1'b0) begin 
      $display("Expected q = 1'b0 with an explicit 1'bx input, got %b", q); 
      pass = 1'b0; 
    end
    if (pass) $display("PASSED"); 
  end 
endmodule 