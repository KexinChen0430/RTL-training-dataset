module SUB(CLK, RST, IN, OUT);
  input CLK;  
  input RST;  
  input IN;   
  output OUT; 
  reg reg1;   
  wire OUT = reg1; 
  always @(posedge CLK or negedge RST) begin
    if (RST) begin
      reg1 <= 1'b0; 
    end else begin
      reg1 <= 1'b1; 
    end
  end
endmodule