module SUB2(CLK,RST,IN); 
  input CLK, RST, IN; 
  reg reg1; 
  always @(posedge CLK or negedge RST) begin
    if(RST) begin 
      reg1 <= 1'b0; 
    end else if(IN) begin 
      reg1 <= 1'b0; 
    end else begin 
      reg1 <= 1'b1; 
    end
  end
endmodule 