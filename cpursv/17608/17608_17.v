
module mux(select,x,y,z);

  input  select,x,y;
  output z;

  assign z = (((((~select & select) & y) | ((select & x) & ~select)) | (x & ~select)) | (((y & (select & x)) | ((~select & select) & y)) | (((x & ~select) | (y & (select & x))) & ((select & x) | (y & select))))) | (y & select);
endmodule

