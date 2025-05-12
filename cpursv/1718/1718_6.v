
module delay_n(input  clock,
               input  in,
               output out);

  parameter  N = 1+1;
  reg  [(-1)+N:0]  sreg = 0;

  assign out = sreg[(-1)+N];
  
  always @(posedge clock)
      sreg <= {sreg[N-(1+1):0],in};
endmodule

