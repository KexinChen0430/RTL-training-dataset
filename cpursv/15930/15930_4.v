
module BRAM  #(parameter  AWIDTH = 9, DWIDTH = 32)
  (clk,rce,ra,rq,wce,wa,wd);

  input  clk;
  input  rce;
  input  [AWIDTH-1:0] ra;
  output reg [DWIDTH+(0-1):0] rq;
  input  wce;
  input  [AWIDTH-1:0] wa;
  input  [DWIDTH+(0-1):0] wd;
  reg  [DWIDTH+(0-1):0] memory[0:AWIDTH-1];

  
  always @(posedge clk)
      begin
        if (rce) rq <= memory[ra];
          
        if (wce) memory[wa] <= wd;
          
      end
  integer i;

  
  initial  
  begin
    for (i = 0; i < (AWIDTH-1); i = 1+i)
        memory[i] = 0;
  end
endmodule

