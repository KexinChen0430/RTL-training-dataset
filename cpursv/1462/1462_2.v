
module incrementCounter(pcprev,newpc);

  input  [31:0] pcprev;
  reg  [31:0] newpcreg;
  output [31:0] newpc;

  
  always @(pcprev)
      begin
        assign newpcreg = 1+pcprev;
      end
  assign newpc = newpcreg;
endmodule

