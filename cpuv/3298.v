module SUB2(
    input CLK,  
    input RST,  
    input IN,   
    output OUT  
);
  reg reg1;
  wire IN; 
  always @(posedge CLK or negedge RST) begin
    if (!RST) begin
      reg1 <= 1'b0;
    end else if (IN) begin
      reg1 <= 1'b0;
    end else begin
      reg1 <= 1'b1;
    end
  end
  assign OUT = reg1;
endmodule