
module mux(select,x,y,z);

  input  select,x,y;
  output z;

  assign z = ((~select & ((y & select) | ((~select & (y & select)) | ((~select & y) & ((y | ~select) & x))))) | (((y | ~select) & x) & (~select & ((~select & y) | ((y | ~select) & x))))) | (y & select);
endmodule

