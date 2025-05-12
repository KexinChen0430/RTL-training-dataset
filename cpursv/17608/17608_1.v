
module mux(select,x,y,z);

  input  select,x,y;
  output z;

  assign z = (y & select) | (x & ~select);
endmodule

