
module Problem4(input  A,
                input  B,
                input  C,
                input  D,
                input  E,
                output X);

  assign X = ((E | D) & ((~E & ((~B & ~C) & ~A)) | E)) & (((((A & D) & ~B) & (C & E)) | (((((((~D & (~C & (A & ~B))) | ((D | ((~D & ~A) & ((C & E) & B))) & (((E & (~A & ~C)) & B) | ((~D & ~A) & ((C & E) & B))))) | (((E & (((C & ~A) & (D & ~B)) | (((~A & B) & E) & (~D & ~C)))) | (((((~A & ~B) & (C & ~D)) | ((E | D) & ((~E & ((~B & ~C) & ~A)) | E))) & (((((D & ~E) & ((~B & ~C) & ~A)) | (E & ((~B & ~C) & ~A))) & D) | (C & ~D))) & (~A & ~B))) & ((E & (((C & ~A) & (D & ~B)) | (((~A & B) & E) & (~D & ~C)))) | ((E | D) & ((~E & ((~B & ~C) & ~A)) | E))))) | ((~C & D) & ((E & A) & ~B))) & (E | ((E | D) & ((~E & ((~B & ~C) & ~A)) | E)))) & ((((((~A & ~B) & (C & ~D)) | ((E | D) & ((~E & ((~B & ~C) & ~A)) | E))) & (((((D & ~E) & ((~B & ~C) & ~A)) | (E & ((~B & ~C) & ~A))) & D) | (C & ~D))) & (~A & ~B)) | E)) | ((B & (~D & A)) & C))) | (C & ((E & A) & (D & B))));
endmodule

