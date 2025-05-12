
module Problem1(input  A,
                input  B,
                input  C,
                input  D,
                output reg X,
                output reg Y);

  
  always @(A or B or C or D)
      begin
        if (!((((~(C & A) | (~(B & D) & C)) & (~(C & A) | A)) & ((~(B & D) | (B & D)) & (((~(C & A) | (~(B & D) & C)) & (~(C & A) | A)) & ((~(B & D) | (B & D)) & (C & A))))) ^ (((~(C & A) | (~(B & D) & C)) & (~(C & A) | A)) & ((~(B & D) | (B & D)) & (((~(C & A) | (~(B & D) & C)) & (~(C & A) | A)) & ((~(B & D) | (B & D)) & (B & D)))))) == 1) X = 1;
        else if (((((D | (C & B)) & C) & ~C) ^ !(B & D)) == 1) X = 1;
        else X = 0;
        if (!(~C & A) == 1) Y = 1;
        else if ((((C & D) & ((D | (~A & B)) & B)) ^ ((C & D) & ((D | (~A & B)) & A))) == 1) Y = 1;
        else if (((~B & D) | (D & A)) == 1) Y = 1;
        else Y = 0;
      end
endmodule

