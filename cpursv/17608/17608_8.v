
module mux(select,x,y,z);

  input  select,x,y;
  output z;

  assign z = (y & select) | (((select & (x & y)) | ((~select & x) & (x & y))) | (~select & x));
endmodule

