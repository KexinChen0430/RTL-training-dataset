
module and3(z,a,b,c);

  parameter  DELAY = 1;
  input  a,b,c;
  output z;

  assign #DELAY z = (a & b) & c;
endmodule

