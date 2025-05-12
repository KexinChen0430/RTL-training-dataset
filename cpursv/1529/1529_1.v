
module FullAdder(input  wire a,
                 input  wire b,
                 input  wire ci,
                 output reg co,
                 output reg s);

  
  always @(a or b or ci)
      begin : assig_process_co
        co = (ci & (b | a)) | (((ci | a) & (b | ci)) & a);
      end
  
  always @(a or b or ci)
      begin : assig_process_s
        s = ((ci & ~(((~a & b) | a) & (~b | ~a))) | ((~(~ci & b) & ~ci) & a)) | (b & (~ci & ~(~ci & a)));
      end
endmodule

