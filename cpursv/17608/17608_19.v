
module mux(select,x,y,z);

  input  select,x,y;
  output z;

  assign z = ((((~select & (select & y)) | (x & y)) | ((~select & (x & select)) | (select & y))) | ((~select & (select & y)) | (~select & (x & y)))) | (x & ~select);
endmodule

