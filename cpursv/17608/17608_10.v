
module mux(select,x,y,z);

  input  select,x,y;
  output z;

  assign z = ((~select & x) | (((select & (y | x)) & ~select) | (x & (select & y)))) | (select & y);
endmodule

