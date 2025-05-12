
module test;

  reg  [1:0] sel;
  reg  [1:0] out,a,b,c,d;
  reg  error;

  
  always @* 
      case (sel)

        2'b00: out = a;

        2'b01: out = b;

        2'b10: out = c;

        2'b11: out = d;

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
        $display("FAILED - Wildcard sensitivy list a != 0(1)");
        error = 1;
      end
      
    #1 ;
    a = 1;
    #1 ;
    if (out !== 2'b01) 
      begin
        $display("FAILED - Wildcard sensitivity list a != 1 (2)");
        error = 1;
      end
      
    if (error == 0) 
      $display(PASSED);
      
  end
endmodule

