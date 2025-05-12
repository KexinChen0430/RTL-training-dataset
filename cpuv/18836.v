module AND2I0 (
  output Q, 
  input A, B 
);
  specify
    (A => Q) = 698; 
    (B => Q) = 639; 
  endspecify 
  assign Q = A ? B : 0;
endmodule 