
module FullAdder(input  wire a,
                 input  wire b,
                 input  wire ci,
                 output reg co,
                 output reg s);

  
  always @(a or b or ci)
      begin : assig_process_co
        co = ((b & a) | (a & ci)) | (ci & b);
      end
  
  always @(a or b or ci)
      begin : assig_process_s
        s = (((b & (~ci & ~a)) | ci) | ((~b & ~ci) & a)) & ((((~b & a) | b) | ~(((~b & a) | b) & (~b | ~a))) & (((~ci & ~a) | ((~b & ~ci) & a)) | ~(((~b & a) | b) & (~b | ~a))));
      end
endmodule

