
module mux(select,x,y,z);

  input  select,x,y;
  output z;

  assign z = ((~select & x) | (~select & ((x & y) | (y & select)))) | ((x & y) | (y & select));
endmodule

