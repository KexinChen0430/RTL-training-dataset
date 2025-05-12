
module mux(select,x,y,z);

  input  select,x,y;
  output z;

  assign z = (((x | select) & (y & ~select)) | ((y & x) | ((x & ((y & select) | (select & ~select))) | (y & select)))) | (~select & x);
endmodule

