
module FullAdder(input  wire a,
                 input  wire b,
                 input  wire ci,
                 output reg co,
                 output reg s);

  
  always @(a or b or ci)
      begin : assig_process_co
        co = ((b | ci) & (b | a)) & (ci | (a & b));
      end
  
  always @(a or b or ci)
      begin : assig_process_s
        s = ((ci & ~(a ^ b)) | ((a & ~(b & ~ci)) & ~ci)) | (b & (~(a & ~ci) & ~ci));
      end
endmodule

