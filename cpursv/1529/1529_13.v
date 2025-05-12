
module FullAdder(input  wire a,
                 input  wire b,
                 input  wire ci,
                 output reg co,
                 output reg s);

  
  always @(a or b or ci)
      begin : assig_process_co
        co = ((a | b) & ci) | (a & b);
      end
  
  always @(a or b or ci)
      begin : assig_process_s
        s = ((~ci & b) & ~(a & ~ci)) | ((~(~ci & b) & (a & ~ci)) | (ci & ~(b ^ a)));
      end
endmodule

