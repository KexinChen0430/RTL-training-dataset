
module mux(select,x,y,z);

  input  select,x,y;
  output z;

  assign z = (y & select) | ((~select & x) | ((select & (~select & x)) | (~select & (y & select))));
endmodule

