
module mux(select,x,y,z);

  input  select,x,y;
  output z;

  assign z = ((((select & y) & ~select) | (((select & y) & ~select) | ((y & x) & (~select & x)))) | (~select & x)) | (((y & x) | (select & y)) | (~select & (x & select)));
endmodule

