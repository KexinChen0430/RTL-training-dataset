
module gate_sdf(out,in);

  output out;
  input  in;
  wire out,in;

  assign out = ~in;
  
  specify
    (in => out) = (0.5,0.5);
  endspecify

endmodule

