
module FullAdder(input  wire a,
                 input  wire b,
                 input  wire ci,
                 output reg co,
                 output reg s);

  
  always @(a or b or ci)
      begin : assig_process_co
        co = ((ci | b) & (a | b)) & (a | ci);
      end
  
  always @(a or b or ci)
      begin : assig_process_s
        s = (((((~(b ^ a) | ~ci) & ((((b & ~ci) & (~(b ^ a) | ~ci)) & (((a | b) | ci) & (ci | (((~b & (a | b)) | ~a) & ~ci)))) & (~(b ^ a) | ~ci))) & (~(b ^ a) | ~ci)) & (~(b ^ a) | ~ci)) ^ ((((((((a | b) | ci) & (ci | (((~b & (a | b)) | ~a) & ~ci))) & ((~(b ^ a) | ~ci) & ((~ci & (a | b)) & a))) & (~(b ^ a) | ~ci)) & (~(b ^ a) | ~ci)) & (~(b ^ a) | ~ci)) & (~(b ^ a) | ~ci))) | (ci & (~(b ^ a) | ~ci));
      end
endmodule

