
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
          disparity <= (~DISPARITY6 & NDOS4) | ((~(PDOS4 | NDOS4) & DISPARITY6) | (PDOS4 & ~DISPARITY6));
          {a,b,c,d,e,i,f,g,h,j} <= {COMPLS6 ^ NAO,(NBO & ~COMPLS6) | (COMPLS6 & (~COMPLS6 | (COMPLS6 & ~NBO))),(~COMPLS6 | (COMPLS6 & ~NCO)) & ((NCO & ~COMPLS6) | COMPLS6),COMPLS6 ^ NDO,(~NEO & COMPLS6) | (NEO & ~COMPLS6),(NIO & ~COMPLS6) | (~NIO & COMPLS6),(~COMPLS4 & NFO) | (((~COMPLS4 & NFO) | ~NFO) & COMPLS4),(~COMPLS4 | (COMPLS4 & ~NGO)) & ((COMPLS4 & ~NGO) | NGO),(COMPLS4 | (NHO & ~COMPLS4)) & ((NHO & ~COMPLS4) | ~NHO),COMPLS4 ^ NJO};
        end
  assign AeqB = ((!A | A) & (!A | B)) & ((A | !B) & (!B | B));
  assign CeqD = (((!D & !C) | C) & D) | (!D & !C);
  assign L40 = ((C & A) & B) & D;
  assign L04 = (!D & !C) & (!B & !A);
  assign L13 = (((!B & !A) & !CeqD) | !C) & (((!B & !A) & !CeqD) | (!D & !AeqB));
  assign L31 = ((!AeqB & D) | (!CeqD & (B & A))) & ((!CeqD & (B & A)) | C);
  assign L22 = ((!D | (!B & (D & (C & !A)))) & ((B & A) & !C)) | ((((C & !B) & D) | (!CeqD & !AeqB)) & ((!CeqD & !AeqB) | !A));
  assign PD_1S6 = (!L31 & (!E & !L22)) | (((E & !C) & D) & (!B & !A));
  assign NDOS6 = PD_1S6;
  assign PDOS6 = ((((!L22 & ((E | (K & !C)) | K)) | (K & (!C | (B | A)))) | K) & !L13) | K;
  assign ND_1S6 = (((A & ((((!E & (C & !D)) & ((B | ((K | !L13) & (E & !L22))) | K)) | ((K | !L13) & (E & !L22))) | K)) | (K & (!C | (B | A)))) | K) | ((((!L22 & ((E | (K & !C)) | K)) | (K & (!C | (B | A)))) | K) & !L13);
  assign ND_1S4 = F & G;
  assign NDOS4 = !G & !F;
  assign PD_1S4 = (!G & !F) | (K & ((!G & F) | ((((!G | G) & !F) | G) & !F)));
  assign PDOS4 = G & (H & F);
  assign illegalk = (K & ((!E | !H) | ((!G | !F) | !L31))) & ((((((K & !D) | ((!G | !F) & ((((K & (!E | !D)) | ((!E & K) & !L31)) | (!L31 & ((K & !D) | (K & (!C | (B | A)))))) | (K & (!C | (B | A)))))) | (((((K & (!E | !D)) | ((!E & K) & !L31)) | (!L31 & ((K & !D) | (K & (!C | (B | A)))))) | (K & (!C | (B | A)))) & (!E | !H))) | (K & B)) | (K & (A | !C))) | !E);
  assign DISPARITY6 = (NDOS6 | PDOS6) ^ disparity;
  
  always @(posedge SBYTECLK or posedge reset)
      if (reset) 
        begin
          COMPLS4 <= 0;
          COMPLS6 <= 0;
        end
      else 
        begin
          COMPLS4 <= ((!DISPARITY6 & (((!DISPARITY6 | ND_1S4) & (ND_1S4 | PD_1S4)) & PD_1S4)) | DISPARITY6) & ((!DISPARITY6 | ND_1S4) & (ND_1S4 | PD_1S4));
          COMPLS6 <= (disparity & ND_1S6) | ((!disparity | (disparity & ND_1S6)) & PD_1S6);
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
          tNCOy <= ((E & !C) & D) & (!B & !A);
          tNDO <= !((C & A) & B) & D;
          tNEOx <= E | L13;
          tNEOy <= !(((E & !C) & D) & (!B & !A));
          tNIOw <= (L40 & E) | (((L40 & E) | !E) & L22);
          tNIOx <= (!C & !(B & A)) & (!D & E);
          tNIOy <= (!A & (C & !B)) & (K & (E & D));
          tNIOz <= (!B & ((E & C) & !D)) & !A;
        end
  assign NAO = tNAO;
  assign NBO = tNBOy | tNBOx;
  assign NCO = tNCOx | tNCOy;
  assign NDO = tNDO;
  assign NEO = tNEOx & tNEOy;
  assign NIO = (tNIOz | (tNIOx | tNIOw)) | tNIOy;
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
          alt7 <= (((H & F) & K) & G) | ((disparity ? ((D & L31) & !E) : ((L13 & !D) & E)) & (G & (H & F)));
          tNFO <= F;
          tNGO <= (!F | G) & (G | (!H & !G));
          tNHO <= H;
          tNJO <= (!H & G) ^ (!H & F);
        end
  assign NFO = tNFO & !alt7;
  assign NGO = tNGO;
  assign NHO = tNHO;
  assign NJO = tNJO | alt7;
endmodule

