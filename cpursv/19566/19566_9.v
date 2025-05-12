
module main();

  wire a,b;
  reg  [1:0] c;
  reg  working;

  assign {a,b} = c;
  
  initial  
  begin
    working = 1;
    c = 2'b00;
    #1 
      if ((b !== 0) & (a !== 0)) 
        begin
          $display("FAILED - {a,b} Expected 2'b00 - received %b%b",a,
                   b);
          working = 0;
        end
        

    c = 2'b01;
    #1 
      if ((a !== 0) & (b !== 1)) 
        begin
          $display("FAILED {a,b} Expected 2'b01 - received %b%b",a,b);
          working = 0;
        end
        

    c = 2'b10;
    #1 
      if ((b !== 0) & (a !== 1)) 
        begin
          $display("FAILED {a,b} Expected 2'b10 - received %b%b",a,b);
          working = 0;
        end
        

    c = 2'b11;
    #1 
      if ((b !== 1) & (a !== 1)) 
        begin
          $display("FAILED {a,b} Expected 2'b11 - received %b%b",a,b);
          working = 0;
        end
        

    #1 
      if (working) 
        $display(PASSED\n);
        

  end
endmodule

