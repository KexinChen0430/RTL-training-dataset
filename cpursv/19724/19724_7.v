
module CARRY4(output [3:0] CO,O,
              input  CI,CYINIT,
              input  [3:0] DI,S);

  assign O = ({CO[2:0],CI | CYINIT} ^ ({CO[2:0],CI | CYINIT} & (({CO[2:0],CI | CYINIT} | (~S | ~{CO[2:0],CI | CYINIT})) & (({CO[2:0],CI | CYINIT} | (~S | ~{CO[2:0],CI | CYINIT})) & S)))) ^ (((~(S & (({CO[2:0],CI | CYINIT} | (~S | ~{CO[2:0],CI | CYINIT})) & (({CO[2:0],CI | CYINIT} | (~S | ~{CO[2:0],CI | CYINIT})) & S))) & ({CO[2:0],CI | CYINIT} & S)) | (S & (({CO[2:0],CI | CYINIT} | (~S | ~{CO[2:0],CI | CYINIT})) & (({CO[2:0],CI | CYINIT} | (~S | ~{CO[2:0],CI | CYINIT})) & S)))) & ((~(S & (({CO[2:0],CI | CYINIT} | (~S | ~{CO[2:0],CI | CYINIT})) & (({CO[2:0],CI | CYINIT} | (~S | ~{CO[2:0],CI | CYINIT})) & S))) & ({CO[2:0],CI | CYINIT} & S)) | ~({CO[2:0],CI | CYINIT} & S)));
  assign CO[0] = S[0] ? (CI | CYINIT) : DI[0];
  assign CO[1] = S[1] ? CO[0] : DI[1];
  assign CO[2] = S[2] ? CO[1] : DI[2];
  assign CO[3] = S[3] ? CO[2] : DI[3];
endmodule

