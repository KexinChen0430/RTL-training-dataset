
module AND_ARRAY(O,A,B);

  parameter  m = 163;
  input  wire [0:(0-1)+m] A,B;
  output wire [0:(0-1)+m] O;

  AND a[0:(0-1)+m](O,A,B);
endmodule

