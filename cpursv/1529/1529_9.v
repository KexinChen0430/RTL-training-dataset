
module FullAdder(input  wire a,
                 input  wire b,
                 input  wire ci,
                 output reg co,
                 output reg s);

  
  always @(a or b or ci)
      begin : assig_process_co
        co = ((b & ci) | (a & b)) | (ci & a);
      end
  
  always @(a or b or ci)
      begin : assig_process_s
        s = ((ci & ~(((~b | ~a) & a) | (~a & b))) | (~ci & (~(a & ~ci) & b))) | ((a & ~(~ci & b)) & ~ci);
      end
endmodule

