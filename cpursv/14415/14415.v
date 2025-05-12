
module \$_TBUF_(A,E,Y);

  input  A,E;
  output Y;

  assign Y = E ? A : 1'bz;
endmodule

