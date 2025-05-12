
module mux(select,x,y,z);

  input  select,x,y;
  output z;

  assign z = ((select & y) | (((~select & select) & (x & ~select)) | ((select & y) & (x & y)))) | ((x & ~select) | (~select & ((select & y) | (x & select))));
endmodule

