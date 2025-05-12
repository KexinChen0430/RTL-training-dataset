
module mux(select,x,y,z);

  input  select,x,y;
  output z;

  assign z = (((~select & select) & y) | (~select & x)) | ((select & y) | (((~select & select) & y) | ((y & ~select) & x)));
endmodule

