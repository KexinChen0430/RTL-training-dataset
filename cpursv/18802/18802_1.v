
module test;

  reg  [1:0] sel;
  reg  [1:0] out,a,b,c,d;
  reg  error;

  
  always @(sel)
      case (sel)

        2'b00: assign out = a;

        2'b01: assign out = b;

        2'b10: assign out = c;

        2'b11: assign out = d;

      endcase

  
  initial  
  begin
    error = 0;
    #1 ;
    sel = 0;
    a = 0;
    #1 ;
    if (out !== 2'b00) 
      begin
        $display("FAILED - Procedural assignment out != 0 (1)");
        error = 1;
      end
      
    #1 ;
    a = 1;
    #1 ;
    if (out !== 2'b01) 
      begin
        $display("FAILED - Procedural assignment out != 1 (2)");
        error = 1;
      end
      
    if (error == 0) 
      $display(PASSED);
      
  end
endmodule

