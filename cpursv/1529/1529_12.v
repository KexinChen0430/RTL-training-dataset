
module FullAdder(input  wire a,
                 input  wire b,
                 input  wire ci,
                 output reg co,
                 output reg s);

  
  always @(a or b or ci)
      begin : assig_process_co
        co = (a | ci) & (b | ((b | ci) & a));
      end
  
  always @(a or b or ci)
      begin : assig_process_s
        s = (((b | a) | ~((a & ((b | a) & ~b)) | (~a & b))) & (~((a & ((b | a) & ~b)) | (~a & b)) | ((~a | ~b) & ~ci))) & (((~ci & a) & ~(~ci & b)) | (((~ci & b) & ~(~ci & a)) | ci));
      end
endmodule

