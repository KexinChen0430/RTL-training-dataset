module main (); 
reg error; 
reg [2:0] val1,val2; 
reg [2:0] result ; 
always @( val1 or val2)
  case (val1 & val2 )
    3'b000,3'b001: result = 0; 
    3'b101: ; 
    3'b011: result = 1; 
  endcase 
initial
  begin
    error = 0; 
    val1 = 3'b0; 
    val2 = 3'b0; 
    #1 if(result !==0) 
      begin
        $display("FAILED case 3.8C - case (expr) lab1: "); 
        error = 1; 
      end
    val1 = 3'b111; 
    val2 = 3'b011; 
    #1 if(result !==1) 
      begin
        $display("FAILED case 3.8C - case (expr) lab2: "); 
        error = 1; 
      end
    val2 = 3'b101; 
    #1 if(result !==1) 
      begin
        $display("FAILED case 3.8C - case (expr) lab1: "); 
        error = 1; 
      end
    if(error == 0) 
      $display("PASSED"); 
  end 
endmodule 