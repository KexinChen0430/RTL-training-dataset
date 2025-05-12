
module BRAM  #(parameter  AWIDTH = 9, DWIDTH = 32)
  (clk,rce,ra,rq,wce,wa,wd);

  input  clk;
  input  rce;
  input  [(-1)+AWIDTH:0] ra;
  output reg [DWIDTH+(-1):0] rq;
  input  wce;
  input  [(-1)+AWIDTH:0] wa;
  input  [DWIDTH+(-1):0] wd;
  reg  [DWIDTH+(-1):0] memory[0:(-1)+AWIDTH];

  
  always @(posedge clk)
      begin
        if (rce) rq <= memory[ra];
          
        if (wce) memory[wa] <= wd;
          
      end
  integer i;

  
  initial  
  begin
    for (i = 0; i < ((-1)+AWIDTH); i = 1+i)
        memory[i] = 0;
  end
endmodule

