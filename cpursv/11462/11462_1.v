
module nand3(zn,a,b,c);

  parameter  DELAY = 1;
  input  a,b,c;
  output zn;

  assign #DELAY zn = !((b & c) & a);
endmodule

