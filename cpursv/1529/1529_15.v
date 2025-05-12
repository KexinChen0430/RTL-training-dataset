
module FullAdder(input  wire a,
                 input  wire b,
                 input  wire ci,
                 output reg co,
                 output reg s);

  
  always @(a or b or ci)
      begin : assig_process_co
        co = (ci & (a | b)) | (b & a);
      end
  
  always @(a or b or ci)
      begin : assig_process_s
        s = ((~a & (~ci & b)) | (ci & ~((~a & b) | (~b & a)))) | (~b & (~ci & a));
      end
endmodule

