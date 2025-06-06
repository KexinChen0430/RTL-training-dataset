
module CARRY4(output [3:0] CO,O,
              input  CI,CYINIT,
              input  [3:0] DI,S);

  assign O = {CO[2:0],CYINIT | CI} ^ ((~S | S) & (S & (~{CO[2:0],CYINIT | CI} | ({CO[2:0],CYINIT | CI} | S))));
  assign CO[0] = S[0] ? (CYINIT | CI) : DI[0];
  assign CO[1] = S[1] ? CO[0] : DI[1];
  assign CO[2] = S[2] ? CO[1] : DI[2];
  assign CO[3] = S[3] ? CO[2] : DI[3];
endmodule

