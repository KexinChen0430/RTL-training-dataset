
module Problem1(input  A,
                input  B,
                input  C,
                input  D,
                output reg X,
                output reg Y);

  
  always @(A or B or C or D)
      begin
        if (!(((C & A) & ~(B & D)) | ((B & ~(C & A)) & D)) == 1) X = 1;
        else if ((!(B & D) ^ (((C & B) & (~C & C)) | (C & ((D & ~C) & C)))) == 1) X = 1;
        else X = 0;
        if (!(~C & A) == 1) Y = 1;
        else if ((((B & (~B | (B & ~A))) & (C & D)) ^ ((C & D) & ((~B | (B & ~A)) & A))) == 1) Y = 1;
        else if (((((A | D) & A) | ((A | D) & ~B)) & D) == 1) Y = 1;
        else Y = 0;
      end
endmodule

