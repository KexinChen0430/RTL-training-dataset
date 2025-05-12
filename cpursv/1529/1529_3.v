
module FullAdder(input  wire a,
                 input  wire b,
                 input  wire ci,
                 output reg co,
                 output reg s);

  
  always @(a or b or ci)
      begin : assig_process_co
        co = (ci & b) | (a & (ci | (b & (a | ci))));
      end
  
  always @(a or b or ci)
      begin : assig_process_s
        s = ((((~ci & ~(~ci & b)) & a) | ~((a | b) & (~b | ~a))) | ((~ci & ~(~ci & a)) & b)) & (((a | b) & (~b | ~a)) | (~((a | b) & (~b | ~a)) & ci));
      end
endmodule

