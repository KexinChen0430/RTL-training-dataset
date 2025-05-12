
module main;

  wire a;
  wire [31:0] b;
  wire [15:0] c;
  reg  [31:0] val;
  reg  error;

  assign a = val[0];
  assign b = val;
  assign c = val[31:16];
  
  initial  
  begin
    error = 0;
    if (a != 1'bx) 
      begin
        $display("FAILED - 3.2A assign ident = expr");
        error = 1;
      end
      
    if (b != 32'bx) 
      begin
        $display("FAILED - 3.2A assign ident = expr");
        error = 1;
      end
      
    if (c != 16'bx) 
      begin
        $display("FAILED - 3.2A assign ident = expr");
        error = 1;
      end
      
    #1 ;
    val = 32'h87654321;
    #1 ;
    if (a != 1'b1) 
      begin
        $display("FAILED - 3.2A assign ident = expr");
        error = 1;
      end
      
    if (b != 32'h87654321) 
      begin
        $display("FAILED - 3.2A assign ident = expr");
        error = 1;
      end
      
    if (c != 16'h8765) 
      begin
        $display("FAILED - 3.2A assign ident = expr");
        error = 1;
      end
      
    if (error == 0) 
      $display(PASSED);
      
    $finish;
  end
endmodule

