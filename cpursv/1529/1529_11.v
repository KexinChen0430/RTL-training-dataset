
module FullAdder(input  wire a,
                 input  wire b,
                 input  wire ci,
                 output reg co,
                 output reg s);

  
  always @(a or b or ci)
      begin : assig_process_co
        co = ((~b & a) | b) & ((a | ci) & (ci | b));
      end
  
  always @(a or b or ci)
      begin : assig_process_s
        s = (~(b & ~ci) & (a & (((~b & a) | b) & ~ci))) | ((~(a & (((~b & a) | b) & ~ci)) & (b & ~ci)) | (ci & ~(((~b & a) | b) & (~a | ~b))));
      end
endmodule

