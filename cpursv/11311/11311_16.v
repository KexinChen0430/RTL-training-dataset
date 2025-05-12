
module Problem1(input  A,
                input  B,
                input  C,
                input  D,
                output reg X,
                output reg Y);

  
  always @(A or B or C or D)
      begin
        if (!((((~B | D) | ~(D & B)) & (((~B | D) | ~(D & B)) & ((C & A) & (~(C & A) | ~(D & B))))) ^ (((~B | D) | ~(D & B)) & (((~B | D) | ~(D & B)) & ((B & (~(C & A) | ~(D & B))) & D)))) == 1) X = 1;
        else if ((((((((((C & (D & C)) | (C & B)) & ~!(D & B)) & (D | ~C)) | ~((((B | (~B & D)) | D) & ~C) & C)) & (~((((B | (~B & D)) | D) & ~C) & C) | ~C)) & ~((((B | (~B & D)) | D) & ~C) & C)) & !(D & B)) | ((((((((C & (D & C)) | (C & B)) & ~!(D & B)) & (D | ~C)) | ~((((B | (~B & D)) | D) & ~C) & C)) & (~((((B | (~B & D)) | D) & ~C) & C) | ~C)) & (C & ~C)) & (B | ((D & ~C) & C)))) == 1) X = 1;
        else X = 0;
        if (!(A & ~C) == 1) Y = 1;
        else if ((((D & C) & ((~A | A) & A)) ^ ((D & C) & ((~A | A) & B))) == 1) Y = 1;
        else if ((D & ((D & A) | ~B)) == 1) Y = 1;
        else Y = 0;
      end
endmodule

