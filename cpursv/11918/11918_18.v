
module borderscan(clk,xstart,xend,realy,q);

  parameter  SCREENWIDTH = 0;
  parameter  SCREENHEIGHT = 0;
  input  clk,xstart,xend;
  input  [9:0] realy;
  output q;

  assign q = ((realy == 0) | (realy == (SCREENHEIGHT+(0-1)))) | (xend | xstart);
endmodule

