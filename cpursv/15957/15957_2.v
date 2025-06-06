
module fifo4(clk,rst,clr,din,we,dout,re,full,empty);

  parameter  dw = 8;
  input  clk,rst;
  input  clr;
  input  [dw:1] din;
  input  we;
  output [dw:1] dout;
  input  re;
  output full,empty;
  reg  [dw:1] mem[0:3];
  reg  [1:0]  wp = 0;
  reg  [1:0]  rp = 0;
  wire [1:0] wp_p1;
  wire [1:0] wp_p2;
  wire [1:0] rp_p1;
  wire full,empty;
  reg   gb = 0;

  
  always @(posedge clk or negedge rst)
      if (!rst) wp <= #1 2'h0;
      else if (clr) wp <= #1 2'h0;
      else if (we) wp <= #1 wp_p1;
        
  assign wp_p1 = 2'h1+wp;
  assign wp_p2 = wp+2'h2;
  
  always @(posedge clk or negedge rst)
      if (!rst) rp <= #1 2'h0;
      else if (clr) rp <= #1 2'h0;
      else if (re) rp <= #1 rp_p1;
        
  assign rp_p1 = 2'h1+rp;
  assign dout = mem[rp];
  
  always @(posedge clk)
      if (we) mem[wp] <= #1 din;
        
  assign empty = (wp == rp) & !gb;
  assign full = gb & (wp == rp);
  
  always @(posedge clk)
      if (!rst) gb <= #1 1'b0;
      else if (clr) gb <= #1 1'b0;
      else if (we & (wp_p1 == rp)) gb <= #1 1'b1;
      else if (re) gb <= #1 1'b0;
        
endmodule

