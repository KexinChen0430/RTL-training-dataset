
module t_tri3(t3,d,oe);

  output tri1 t3;
  input  d;
  input  oe;

  bufif1 (t3,d,oe);
endmodule

