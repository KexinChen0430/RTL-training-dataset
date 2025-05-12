
module FullAdder(input  wire a,
                 input  wire b,
                 input  wire ci,
                 output reg co,
                 output reg s);

  
  always @(a or b or ci)
      begin : assig_process_co
        co = (((ci & a) | (b & a)) | b) & ((b & a) | ci);
      end
  
  always @(a or b or ci)
      begin : assig_process_s
        s = ((a ^ b) | (~(a ^ b) & ci)) & ((~(a ^ b) | ((~(a & ((a | b) & ~ci)) & b) & ~ci)) | ((~(b & ~ci) & a) & ~ci));
      end
endmodule

