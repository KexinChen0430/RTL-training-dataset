
module Problem4(input  A,
                input  B,
                input  C,
                input  D,
                input  E,
                output X);

  assign X = ((B & ((D & E) & (C & A))) | ((((((((E | (D & ~E)) & ((~C & (~B & ~A)) | E)) & (((~C & D) & ((~A & B) & E)) | ((((D & C) & (~B & ~A)) | (((~D | (~C & (~B & ~A))) & (C | (D & (~C & (~B & ~A))))) & (~B & ~A))) & (((D & C) & (~B & ~A)) | ((E | (D & ~E)) & ((~C & (~B & ~A)) | E)))))) | ((~C & ~D) & (~A & B))) | (~D & ((E & B) & (~A & C)))) & ((E | (D & ~E)) & ((~C & (~B & ~A)) | E))) | (((D & ~B) & (C & A)) | (((A & ~C) & E) & ~B))) | ((~D & B) & ((C & E) & A)))) & ((E | (D & ~E)) & ((~C & (~B & ~A)) | E));
endmodule

