module main ; 
wire a; 
wire [30:0] b; 
wire [14:0] c; 
reg [31:0] val; 
reg error; 
assign {b,a} = val; 
assign {c,a} = val[31:16]; 
initial 
  begin
    error = 0; 
    if(a != 1'bx) 
      begin
        $display("FAILED - assign 3.2B assign ident = expr"); 
         error = 1; 
      end
    if(b != 31'bx) 
      begin
        $display("FAILED - assign 3.2B assign ident = expr"); 
         error = 1; 
      end
    if(c != 14'bx) 
      begin
        $display("FAILED - assign 3.2B assign ident = expr"); 
         error = 1; 
      end
    #1 ; 
    val = 32'h87654321; 
    #1 ; 
    if(a != 1'b1) 
      begin
        $display("FAILED - 3.2A assign ident = expr"); 
         error = 1; 
      end
    if(b != (32'h87654321) >> 1) 
      begin
        $display("FAILED - 3.2A assign ident = expr"); 
         error = 1; 
      end
    if(c != (16'h8765) >> 1) 
      begin
        $display("FAILED - 3.2A assign ident = expr"); 
         error = 1; 
      end
    if(error == 0) 
         $display("PASSED"); 
    $finish ; 
  end
endmodule 