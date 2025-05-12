
module mux(select,x,y,z);

  input  select,x,y;
  output z;

  assign z = ((x & ~select) | ((~select & y) & select)) | ((select | (((~select & y) & select) | (y & x))) & y);
endmodule

