
module Problem1(input  A,
                input  B,
                input  C,
                input  D,
                output reg X,
                output reg Y);

  
  always @(A or B or C or D)
      begin
        if (!((((A | ~(A & C)) & (C | ~(A & C))) & (((B & D) | ~(B & D)) & (((B & D) | ~(B & D)) & (((A | ~(A & C)) & (C | ~(A & C))) & (A & C))))) ^ (((A | ~(A & C)) & (C | ~(A & C))) & (((B & D) | ~(B & D)) & (((B & D) | ~(B & D)) & (((A | ~(A & C)) & (C | ~(A & C))) & (B & D)))))) == 1) X = 1;
        else if ((!(B & D) ^ (((D & C) & ~C) | ((C & (C & B)) & ~C))) == 1) X = 1;
        else X = 0;
        if (!(~C & A) == 1) Y = 1;
        else if (((C & (D & ((~A & B) | (B & ~B)))) | (((D & C) & A) & ~B)) == 1) Y = 1;
        else if ((D & ((D & ~B) | ((~B | D) & (~B | A)))) == 1) Y = 1;
        else Y = 0;
      end
endmodule

