
module mux(select,x,y,z);

  input  select,x,y;
  output z;

  assign z = ((~select & (x & y)) | (select & y)) | ((x & y) | (~select & x));
endmodule

