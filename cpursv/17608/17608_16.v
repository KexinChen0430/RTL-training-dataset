
module mux(select,x,y,z);

  input  select,x,y;
  output z;

  assign z = ((~select & ((~select & y) | x)) & x) | (select & y);
endmodule

