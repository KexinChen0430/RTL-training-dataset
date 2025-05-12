
module encoder_8b10b(input  reset,
                     input  SBYTECLK,
                     input  K,
                     input  [7:0] ebi,
                     output [9:0] tbi,
                     output reg disparity);

  wire L40,L04,L13,L31,L22,AeqB,CeqD;
  wire PD_1S6,NDOS6,PDOS6,ND_1S6;
  wire ND_1S4,PD_1S4,NDOS4,PDOS4;
  wire illegalk,DISPARITY6;
  reg  COMPLS6,COMPLS4;
  wire NAO,NBO,NCO,NDO,NEO,NIO;
  wire NFO,NGO,NHO,NJO;
  wire A,B,C,D,E,F,G,H;

  assign {H,G,F,E,D,C,B,A} = ebi[7:0];
  reg  a,b,c,d,e,i,f,g,h,j;

  assign tbi[9:0] = {a,b,c,d,e,i,f,g,h,j};
  wire [9:0] tst;

  assign tst[9:0] = {NAO,NBO,NCO,NDO,NEO,NIO,NFO,NGO,NHO,NJO};
  
  always @(posedge SBYTECLK or posedge reset)
      if (reset) 
        begin
          disparity <= 1'b0;
          {a,b,c,d,e,i,f,g,h,j} <= 10'b0;
        end
      else 
        begin
          disparity <= (NDOS4 | PDOS4) ^ DISPARITY6;
          {a,b,c,d,e,i,f,g,h,j} <= {NAO ^ COMPLS6,((~COMPLS6 | ~NBO) & COMPLS6) | (~COMPLS6 & NBO),(COMPLS6 | (NCO & ~COMPLS6)) & (~COMPLS6 | ~NCO),NDO ^ COMPLS6,(~COMPLS6 & NEO) | (COMPLS6 & ((~COMPLS6 & NEO) | ~NEO)),COMPLS6 ^ NIO,(~NFO & COMPLS4) | (NFO & ~COMPLS4),(NGO & ~COMPLS4) | (COMPLS4 & ~NGO),(~COMPLS4 | (~NHO & COMPLS4)) & ((~COMPLS4 & NHO) | COMPLS4),(~COMPLS4 | ~NJO) & (COMPLS4 | (~COMPLS4 & NJO))};
        end
  assign AeqB = (B | (!B & !A)) & (A | (!B & !A));
  assign CeqD = (!D | (D & C)) & ((!C | C) & (!C | D));
  assign L40 = B & (A & (D & C));
  assign L04 = (!B & !A) & (!D & !C);
  assign L13 = (((!CeqD & !A) | (!D & !AeqB)) & (!C | (!CeqD & !A))) & ((!C & (!D & !AeqB)) | !B);
  assign L31 = ((C & !AeqB) & D) | ((((C & !AeqB) & D) | ((!CeqD | ((C & !AeqB) & D)) & A)) & B);
  assign L22 = (((!D & !C) & (B & A)) | (((((!D & !C) & (B & A)) | (!B | !AeqB)) & ((!AeqB | ((D & !A) & C)) | ((!D & !C) & (B & A)))) & !CeqD)) | ((((!D & !C) & (B & A)) | (!A & ((D & C) | ((!D & !C) & (B & A))))) & !B);
  assign PD_1S6 = (((!E & !L22) & !L31) | !B) & (((!E & !L22) & !L31) | (E & ((D & !C) & !A)));
  assign NDOS6 = PD_1S6;
  assign PDOS6 = ((!L13 & (((((!L22 | ((((K & (A | B)) | (K & (!D | !C))) | ((((K & (A | B)) | (K & (!D | !C))) | (((K & !E) | (!L31 & (K & !E))) | (!L31 & ((K & (A | B)) | (K & (!D | !C)))))) & !F)) | ((!E & (((K & (A | B)) | (K & (!D | !C))) | (((K & !E) | (!L31 & (K & !E))) | (!L31 & ((K & (A | B)) | (K & (!D | !C))))))) | ((((K & (A | B)) | (K & (!D | !C))) | (((K & !E) | (!L31 & (K & !E))) | (!L31 & ((K & (A | B)) | (K & (!D | !C)))))) & (!H | !G))))) | K) & E) | (((((!E | !G) | (~F & (!H & G))) | !H) | !F) & (((K & (A | B)) | (K & (!D | !C))) | (((K & !E) | (!L31 & (K & !E))) | (!L31 & ((K & (A | B)) | (K & (!D | !C)))))))) | K)) | (K & !C)) | K;
  assign ND_1S6 = (((!L13 & (((((!L22 | ((((K & (A | B)) | (K & (!D | !C))) | ((((K & (A | B)) | (K & (!D | !C))) | (((K & !E) | (!L31 & (K & !E))) | (!L31 & ((K & (A | B)) | (K & (!D | !C)))))) & !F)) | ((!E & (((K & (A | B)) | (K & (!D | !C))) | (((K & !E) | (!L31 & (K & !E))) | (!L31 & ((K & (A | B)) | (K & (!D | !C))))))) | ((((K & (A | B)) | (K & (!D | !C))) | (((K & !E) | (!L31 & (K & !E))) | (!L31 & ((K & (A | B)) | (K & (!D | !C)))))) & (!H | !G))))) | K) & E) | (((((!E | !G) | (~F & (!H & G))) | !H) | !F) & (((K & (A | B)) | (K & (!D | !C))) | (((K & !E) | (!L31 & (K & !E))) | (!L31 & ((K & (A | B)) | (K & (!D | !C)))))))) | K)) | (K & !C)) | K) | ((((((!E & (!D & C)) & B) | ((B | (A | !D)) & K)) | K) | (!L13 & (((((!L22 | ((((K & (A | B)) | (K & (!D | !C))) | ((((K & (A | B)) | (K & (!D | !C))) | (((K & !E) | (!L31 & (K & !E))) | (!L31 & ((K & (A | B)) | (K & (!D | !C)))))) & !F)) | ((!E & (((K & (A | B)) | (K & (!D | !C))) | (((K & !E) | (!L31 & (K & !E))) | (!L31 & ((K & (A | B)) | (K & (!D | !C))))))) | ((((K & (A | B)) | (K & (!D | !C))) | (((K & !E) | (!L31 & (K & !E))) | (!L31 & ((K & (A | B)) | (K & (!D | !C)))))) & (!H | !G))))) | K) & E) | (((((!E | !G) | (~F & (!H & G))) | !H) | !F) & (((K & (A | B)) | (K & (!D | !C))) | (((K & !E) | (!L31 & (K & !E))) | (!L31 & ((K & (A | B)) | (K & (!D | !C)))))))) | K))) & A);
  assign ND_1S4 = F & G;
  assign NDOS4 = !G & !F;
  assign PD_1S4 = (((K & ((((!G | !F) & (F | !F)) & F) & !G)) | (!G & !F)) | (!F & G)) & (((!G & !F) | ((K & (A | B)) | (K & !C))) | K);
  assign PDOS4 = (G & H) & F;
  assign illegalk = (((K & (A | B)) | (K & (!D | !C))) | (((K & !E) | (!L31 & (K & !E))) | (!L31 & ((K & (A | B)) | (K & (!D | !C)))))) & (((!F | (~F & (!H & G))) | !H) | ((!E | !L31) | !G));
  assign DISPARITY6 = (NDOS6 | PDOS6) ^ disparity;
  
  always @(posedge SBYTECLK or posedge reset)
      if (reset) 
        begin
          COMPLS4 <= 0;
          COMPLS6 <= 0;
        end
      else 
        begin
          COMPLS4 <= ((ND_1S4 & DISPARITY6) | PD_1S4) & (!DISPARITY6 | (ND_1S4 & DISPARITY6));
          COMPLS6 <= (ND_1S6 & disparity) | (!disparity & PD_1S6);
        end
  reg  
      tNAO ,
      tNBOx,
      tNBOy,
      tNCOx,
      tNCOy,
      tNDO ,
      tNEOx,
      tNEOy,
      tNIOw,
      tNIOx,
      tNIOy,
      tNIOz;

  
  always @(posedge SBYTECLK or posedge reset)
      if (reset) 
        begin
          tNAO <= 0;
          tNBOx <= 0;
          tNBOy <= 0;
          tNCOx <= 0;
          tNCOy <= 0;
          tNDO <= 0;
          tNEOx <= 0;
          tNEOy <= 0;
          tNIOw <= 0;
          tNIOx <= 0;
          tNIOy <= 0;
          tNIOz <= 0;
        end
      else 
        begin
          tNAO <= A;
          tNBOx <= !L40 & B;
          tNBOy <= L04;
          tNCOx <= L04 | C;
          tNCOy <= (!B & !A) & ((E & !C) & D);
          tNDO <= D & !(C & (B & A));
          tNEOx <= E | L13;
          tNEOy <= !((!B & !A) & ((E & !C) & D));
          tNIOw <= (!E & ((L40 & E) | L22)) | (L40 & E);
          tNIOx <= (!D & (!C & !(B & A))) & E;
          tNIOy <= ((E & K) & D) & ((!B & !A) & C);
          tNIOz <= ((!B & C) & !A) & (E & !D);
        end
  assign NAO = tNAO;
  assign NBO = tNBOy | tNBOx;
  assign NCO = tNCOy | tNCOx;
  assign NDO = tNDO;
  assign NEO = tNEOx & tNEOy;
  assign NIO = (tNIOy | tNIOz) | (tNIOx | tNIOw);
  reg  alt7,tNFO,tNGO,tNHO,tNJO;

  
  always @(posedge SBYTECLK or posedge reset)
      if (reset) 
        begin
          alt7 <= 0;
          tNFO <= 0;
          tNGO <= 0;
          tNHO <= 0;
          tNJO <= 0;
        end
      else 
        begin
          alt7 <= (G & ((disparity ? (!E & (L31 & D)) : ((L13 & !D) & E)) & (F & H))) | (((F & H) & K) & G);
          tNFO <= F;
          tNGO <= G | ((G | (!G & !F)) & !H);
          tNHO <= H;
          tNJO <= ((~F & G) | (F & ~G)) & !H;
        end
  assign NFO = tNFO & !alt7;
  assign NGO = tNGO;
  assign NHO = tNHO;
  assign NJO = tNJO | alt7;
endmodule

