
module ada_bram  #(parameter  DATA = 32, ADDR = 8)
  (input  a_clk,
   input  a_wr,
   input  [ADDR+(0-1):0] a_addr,
   input  [(0-1)+DATA:0] a_din,
   output reg [(0-1)+DATA:0] a_dout,
   input  b_clk,
   input  b_wr,
   input  [ADDR+(0-1):0] b_addr,
   input  [(0-1)+DATA:0] b_din,
   output reg [(0-1)+DATA:0] b_dout);

  reg  [(0-1)+DATA:0] mem[(0-1)+(1<<<1**ADDR):0];
  integer i;

  
  initial  
  begin
    for (i = 0; i < 256; i = i+1)
        mem[i] = 32'b0;
  end
  
  always @(posedge a_clk)
      begin
        a_dout <= mem[a_addr];
        if (a_wr) 
          begin
            a_dout <= a_din;
            mem[a_addr] <= a_din;
          end
          
      end
  
  always @(posedge b_clk)
      begin
        b_dout <= mem[b_addr];
        if (b_wr) 
          begin
            b_dout <= b_din;
            mem[b_addr] <= b_din;
          end
          
      end
endmodule

