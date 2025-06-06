
module FullAdder(input  wire a,
                 input  wire b,
                 input  wire ci,
                 output reg co,
                 output reg s);

  
  always @(a or b or ci)
      begin : assig_process_co
        co = ((b | a) & (ci | b)) & (ci | a);
      end
  
  always @(a or b or ci)
      begin : assig_process_s
        s = ci ^ ((~a | ~b) & (a | (~a & b)));
      end
endmodule

