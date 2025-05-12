
module main();

  reg  error;
  reg  [2:0] val1,val2;
  reg  [2:0] result;

  
  always @(val1 or val2)
      casex (val1 & val2)

        3'b000,3'b001: result = 0;

        3'b11x: result = 2;

        3'b001: result = 1;

        default: result = 3;

      endcase

  
  initial  
  begin
    error = 0;
    val1 = 3'b0;
    val2 = 3'b0;
    if (result != 0) 
      begin
        $display("FAILED casex 3.9E - default: ");
        error = 1;
      end
      
    val1 = 3'b001;
    val2 = 3'b011;
    if (result != 1) 
      begin
        $display("FAILED casex 3.9E - default: ");
        error = 1;
      end
      
    val1 = 3'b111;
    val2 = 3'b010;
    if (result != 3) 
      begin
        $display("FAILED casex 3.9E - default: ");
        error = 1;
      end
      
    if (error == 0) 
      $display(PASSED);
      
  end
endmodule

