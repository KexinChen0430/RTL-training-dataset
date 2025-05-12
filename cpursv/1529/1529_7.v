
module FullAdder(input  wire a,
                 input  wire b,
                 input  wire ci,
                 output reg co,
                 output reg s);

  
  always @(a or b or ci)
      begin : assig_process_co
        co = (b & ci) | (a & (ci | b));
      end
  
  always @(a or b or ci)
      begin : assig_process_s
        s = ((~ci & ~b) & a) | (((b & ~a) & ~ci) | (ci & ~((~a | (~b & a)) & (a | (b & ~a)))));
      end
endmodule

