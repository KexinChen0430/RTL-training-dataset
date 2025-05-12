
module mux(select,x,y,z);

  input  select,x,y;
  output z;

  assign z = ((x & y) | (((((y & ~select) | (~select & x)) & ((select & y) | (~select & select))) | (x & (select & y))) | (select & y))) | ((~select & x) | ((x & (select & y)) | (x & (~select & select))));
endmodule

