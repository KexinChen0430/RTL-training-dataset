
module FullAdder(input  wire a,
                 input  wire b,
                 input  wire ci,
                 output reg co,
                 output reg s);

  
  always @(a or b or ci)
      begin : assig_process_co
        co = ((b | (((b & ci) | a) & ci)) & a) | (((b & ci) | a) & ci);
      end
  
  always @(a or b or ci)
      begin : assig_process_s
        s = ((((ci | ((b & ~(a & ~ci)) & ~ci)) | (~(b & ~ci) & (a & ~ci))) & (((~(b & ~ci) & (a & ~ci)) | (~((~a & b) | (~b & a)) | ((b & ~(a & ~ci)) & ~ci))) & (((ci | ((b & ~(a & ~ci)) & ~ci)) | (~(b & ~ci) & (a & ~ci))) & (((~(b & ~ci) & (a & ~ci)) | (~((~a & b) | (~b & a)) | ((b & ~(a & ~ci)) & ~ci))) & ((((ci | ((b & ~(a & ~ci)) & ~ci)) | (~(b & ~ci) & (a & ~ci))) & (~ci & (((~(b & ~ci) & (a & ~ci)) | (~((~a & b) | (~b & a)) | ((b & ~(a & ~ci)) & ~ci))) & a))) & ((ci | ((b & ~(a & ~ci)) & ~ci)) | (~(b & ~ci) & (a & ~ci)))))))) ^ (((ci | ((b & ~(a & ~ci)) & ~ci)) | (~(b & ~ci) & (a & ~ci))) & (((~(b & ~ci) & (a & ~ci)) | (~((~a & b) | (~b & a)) | ((b & ~(a & ~ci)) & ~ci))) & (((ci | ((b & ~(a & ~ci)) & ~ci)) | (~(b & ~ci) & (a & ~ci))) & (((~(b & ~ci) & (a & ~ci)) | (~((~a & b) | (~b & a)) | ((b & ~(a & ~ci)) & ~ci))) & (((ci | ((b & ~(a & ~ci)) & ~ci)) | (~(b & ~ci) & (a & ~ci))) & ((~ci & (b & ((~(b & ~ci) & (a & ~ci)) | (~((~a & b) | (~b & a)) | ((b & ~(a & ~ci)) & ~ci))))) & ((ci | ((b & ~(a & ~ci)) & ~ci)) | (~(b & ~ci) & (a & ~ci)))))))))) | (~((~a & b) | (~b & a)) & ((ci | ((b & ~(a & ~ci)) & ~ci)) | (~(b & ~ci) & (a & ~ci))));
      end
endmodule

