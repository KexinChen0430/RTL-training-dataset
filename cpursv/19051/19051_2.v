
module main();

  reg  error;
  reg  [2:0] val1,val2;
  reg  [2:0] result;

  
  always @(val1 or val2)
      casex (val1 & val2)

        3'b000: result = 0;

        3'b0x1: result = 1;

        3'b010: result = 2;

      endcase

  
  initial  
  begin
    error = 0;
    val1 = 3'b0;
    val2 = 3'b0;
    if (result != 0) 
      begin
        $display("FAILED casex 3.9C - label w/ x: ");
        error = 1;
      end
      
    val1 = 3'b001;
    val2 = 3'b011;
    if (result != 1) 
      begin
        $display("FAILED casex 3.9C - label w/ x: ");
        error = 1;
      end
      
    val1 = 3'b111;
    if (result != 1) 
      begin
        $display("FAILED casex 3.9C - label w/ x ");
        error = 1;
      end
      
    if (error == 0) 
      $display(PASSED);
      
  end
endmodule

