
module FullAdder(input  wire a,
                 input  wire b,
                 input  wire ci,
                 output reg co,
                 output reg s);

  
  always @(a or b or ci)
      begin : assig_process_co
        co = ((a & b) | (a & ci)) | (b & ci);
      end
  
  always @(a or b or ci)
      begin : assig_process_s
        s = (a ^ b) ^ ci;
      end
endmodule

