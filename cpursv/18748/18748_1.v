
module main();

  reg  clk;
  reg  D,Q;

  
  always   #10 clk = ~clk;
  
  always @(posedge clk)  Q = D;
  
  initial  
  begin
    clk = 0;
    D = 0;
    @(negedge clk)  
      if (Q !== 1'b0) 
        begin
          $display("FAILED: %b !== %b",Q,D);
          $finish;
        end
        

    D = 1;
    @(negedge clk)  
      if (Q !== 1'b1) 
        begin
          $display("FAILED: %b !== %b",Q,D);
          $finish;
        end
        

    D = 'bx;
    @(negedge clk)  
      if (Q !== 1'bx) 
        begin
          $display("FAILED: %b !== %b",Q,D);
          $finish;
        end
        

    D = 'bz;
    @(negedge clk)  
      if (Q !== 1'bz) 
        begin
          $display("FAILED: %b !== %b",Q,D);
          $finish;
        end
        

    $display(PASSED);
    $finish;
  end
endmodule

