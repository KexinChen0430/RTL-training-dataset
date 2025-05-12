
module Problem1(input  A,
                input  B,
                input  C,
                input  D,
                output reg X,
                output reg Y);

  
  always @(A or B or C or D)
      begin
        if (!(((A & C) & (((C & ~(D & B)) | ~(A & C)) & (A | ~(A & C)))) | ((D & B) & ~(A & C))) == 1) X = 1;
        else if ((((!(D & B) & ~!(D & B)) | (!(D & B) & ~((((D | ~C) & B) | ((D | ~C) & D)) & (~C & C)))) ^ (((~!(D & B) | ~((((D | ~C) & B) | ((D | ~C) & D)) & (~C & C))) & (~C & C)) & ((B | ~C) & (B | D)))) == 1) X = 1;
        else X = 0;
        if (!(A & ~C) == 1) Y = 1;
        else if ((((C & D) & ((A | ~A) & ((~B | B) & B))) ^ ((C & D) & ((A | ~A) & ((~B | B) & A)))) == 1) Y = 1;
        else if (((D & ~B) | (D & A)) == 1) Y = 1;
        else Y = 0;
      end
endmodule

