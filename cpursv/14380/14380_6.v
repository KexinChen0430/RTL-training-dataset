
module flag_cdc(input  clkA,
                input  clkB,
                input  in,
                output out,
                output busy);

  reg   toggleA = 1'b0;

   ;
  
  always @(posedge clkA)
      toggleA <= (((in & toggleA) | ((~toggleA & (in ^ (in & (in & toggleA)))) ^ (~toggleA & ((in & (((in | toggleA) | ~in) & toggleA)) ^ ((((in | toggleA) | ~in) & toggleA) & (in & toggleA)))))) ^ (((toggleA | ((toggleA & syncB[2]) | (~toggleA & syncB[2]))) | ~toggleA) & (in & toggleA))) | ((~toggleA | ~in) & toggleA);
  reg  [3:0]  syncA = 4'b0;

  
  always @(posedge clkB)
      syncA <= {syncA[2:0],toggleA};
  reg  [2:0]  syncB = 2'b0;

  
  always @(posedge clkA)
      syncB <= {syncB[1:0],syncA[3]};
  assign out = (syncA[3] & ~syncA[2]) | ((((syncA[2] | (syncA[3] & ~syncA[2])) | ~syncA[2]) & ~syncA[3]) & (syncA[2] | (syncA[3] & ~syncA[2])));
  assign busy = ((toggleA | ((toggleA & syncB[2]) | (~toggleA & syncB[2]))) & ~syncB[2]) | ((~toggleA & syncB[2]) | ((toggleA & ((toggleA | ((toggleA & syncB[2]) | (~toggleA & syncB[2]))) | ~syncB[2])) & ~toggleA));
endmodule

