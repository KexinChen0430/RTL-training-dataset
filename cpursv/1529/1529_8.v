
module FullAdder(input  wire a,
                 input  wire b,
                 input  wire ci,
                 output reg co,
                 output reg s);

  
  always @(a or b or ci)
      begin : assig_process_co
        co = (b | (a & ci)) & (a | ci);
      end
  
  always @(a or b or ci)
      begin : assig_process_s
        s = ((ci | ((b & ~ci) & ~a)) | (~ci & (~b & a))) & (~ci | (~((a | b) & (~b | ~a)) & ci));
      end
endmodule

