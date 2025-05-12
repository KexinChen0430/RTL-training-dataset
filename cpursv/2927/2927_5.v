
module FULL_ADDER(input  wire wA,
                  input  wire wB,
                  input  wire wCi,
                  output wire wR,
                  output wire wCo);

  assign {wCo,wR} = (wCi+wA)+wB;
endmodule

