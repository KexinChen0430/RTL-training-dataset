
module FullAdder(input  wire a,
                 input  wire b,
                 input  wire ci,
                 output reg co,
                 output reg s);

  
  always @(a or b or ci)
      begin : assig_process_co
        co = ((b & a) | ci) & (a | ((ci & b) | (a & ci)));
      end
  
  always @(a or b or ci)
      begin : assig_process_s
        s = (((~a & b) | (a & ~b)) | (ci & ~((~a & b) | (a & ~b)))) & ((((~(a & ~ci) & ~ci) & b) | ~((~a & b) | (a & ~b))) | (~(b & ~ci) & (a & ~ci)));
      end
endmodule

