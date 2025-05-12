
module delay_n(input  clock,
               input  in,
               output out);

  parameter  N = 2;
  reg  [N+(0-1):0]  sreg = 0;

  assign out = sreg[N+(0-1)];
  
  always @(posedge clock)
      sreg <= {sreg[(0-2)+N:0],in};
endmodule

