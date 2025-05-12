
module TOP(CLK,RST,IN,IN2);

  input  CLK,RST,IN,IN2;
  reg  reg2;

  
  always @(posedge CLK or negedge RST)
      begin
        reg2 <= func1(IN,IN2);
      end
  
  function func1;
    input  bit;
    input  bit2;
    if (bit2) func1 = !bit;
    else func1 = bit;
  endfunction

endmodule

