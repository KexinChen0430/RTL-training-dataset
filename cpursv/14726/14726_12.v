
module BRAM_TDP  #(parameter  AWIDTH = 9, DWIDTH = 32)
  (clk_a,rce_a,ra_a,rq_a,wce_a,wa_a,wd_a,clk_b,rce_b,ra_b,rq_b,
                wce_b,wa_b,wd_b);

  input  clk_a;
  input  rce_a;
  input  [(0-1)+AWIDTH:0] ra_a;
  output reg [(0-1)+DWIDTH:0] rq_a;
  input  wce_a;
  input  [(0-1)+AWIDTH:0] wa_a;
  input  [(0-1)+DWIDTH:0] wd_a;
  input  clk_b;
  input  rce_b;
  input  [(0-1)+AWIDTH:0] ra_b;
  output reg [(0-1)+DWIDTH:0] rq_b;
  input  wce_b;
  input  [(0-1)+AWIDTH:0] wa_b;
  input  [(0-1)+DWIDTH:0] wd_b;
  reg  [(0-1)+DWIDTH:0] memory[0:1<<AWIDTH-1];

  
  always @(posedge clk_a)
      begin
        if (rce_a) rq_a <= memory[ra_a];
          
        if (wce_a) memory[wa_a] <= wd_a;
          
      end
  
  always @(posedge clk_b)
      begin
        if (rce_b) rq_b <= memory[ra_b];
          
        if (wce_b) memory[wa_b] <= wd_b;
          
      end
  integer i;

  
  initial  
  begin
    for (i = 0; i < (1<<AWIDTH-1); i = i+1)
        memory[i] = 0;
  end
endmodule

