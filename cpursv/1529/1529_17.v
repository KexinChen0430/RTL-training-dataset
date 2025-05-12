
module FullAdder(input  wire a,
                 input  wire b,
                 input  wire ci,
                 output reg co,
                 output reg s);

  
  always @(a or b or ci)
      begin : assig_process_co
        co = (ci & b) | (((b | (ci & a)) | ci) & a);
      end
  
  always @(a or b or ci)
      begin : assig_process_s
        s = (((((~b & ((a & ~b) | b)) | ~a) & ~ci) | ~((a & ~b) | (b & ~a))) & (~((a & ~b) | (b & ~a)) | ((a & ~b) | b))) & (((((~b & ((a & ~b) | b)) | ~a) & ~ci) | ci) & (ci | ((a & ~b) | b)));
      end
endmodule

