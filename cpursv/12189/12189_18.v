
module Problem4(input  A,
                input  B,
                input  C,
                input  D,
                input  E,
                output X);

  assign X = ((((((E & ~D) & B) & (A & C)) | ((((E | ((~E & (~A & ~C)) & ~B)) & (E | D)) & (((~A & (E & ~D)) & (B & C)) | ((((~B & (E & (C & ~A))) | (((~D & B) & ~C) & ~A)) | ((~A & ~B) & (((~C & (E & D)) & (~A & ~B)) | (D & ~C)))) | ((E & D) & (~C & (B & ~A)))))) | (((A & ~B) & (D & C)) | (((~C & E) & A) & ~B)))) | (((E & D) & A) & (B & C))) & (E | ((E | ((~E & (~A & ~C)) & ~B)) & (E | D)))) & (E | (((~C & (B & ~A)) & ((((((((~A & ~D) & (C & ~B)) & E) | (((~A & ~B) & (((~C & (E & D)) & (~A & ~B)) | (D & ~C))) | (D & (~A & (C & ~B))))) | ((~D & ~C) & (E & (B & ~A)))) & (E | (((((~A & ~D) & (C & ~B)) & E) | (((~A & ~B) & (((~C & (E & D)) & (~A & ~B)) | (D & ~C))) | (D & (~A & (C & ~B))))) | ((~D & ~C) & (E & (B & ~A)))))) & (E | ((E | ((~E & (~A & ~C)) & ~B)) & (E | D)))) | D)) | (((((((~A & ~D) & (C & ~B)) & E) | (((~A & ~B) & (((~C & (E & D)) & (~A & ~B)) | (D & ~C))) | (D & (~A & (C & ~B))))) | ((~D & ~C) & (E & (B & ~A)))) & (E | (((((~A & ~D) & (C & ~B)) & E) | (((~A & ~B) & (((~C & (E & D)) & (~A & ~B)) | (D & ~C))) | (D & (~A & (C & ~B))))) | ((~D & ~C) & (E & (B & ~A)))))) & (E | ((E | ((~E & (~A & ~C)) & ~B)) & (E | D))))));
endmodule

