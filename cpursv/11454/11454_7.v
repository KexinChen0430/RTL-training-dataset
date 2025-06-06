
module nand4(zn,a,b,c,d);

  parameter  DELAY = 1;
  input  a,b,c,d;
  output zn;

  assign #DELAY zn = !((c & b) & (d & a));
endmodule

