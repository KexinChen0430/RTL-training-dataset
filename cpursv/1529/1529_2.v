
module FullAdder(input  wire a,
                 input  wire b,
                 input  wire ci,
                 output reg co,
                 output reg s);

  
  always @(a or b or ci)
      begin : assig_process_co
        co = ((ci & b) | (a & b)) | (ci & (b | a));
      end
  
  always @(a or b or ci)
      begin : assig_process_s
        s = (((~ci | (~((~b & a) | (~a & b)) & ci)) & (~ci & a)) ^ ((~ci & b) & (~ci | (~((~b & a) | (~a & b)) & ci)))) | (~((~b & a) | (~a & b)) & ci);
      end
endmodule

