
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
          disparity <= (PDOS4 | NDOS4) ^ DISPARITY6;
          {a,b,c,d,e,i,f,g,h,j} <= {(COMPLS6 & ~NAO) | (~COMPLS6 & NAO),((~COMPLS6 | (~NBO & COMPLS6)) & COMPLS6) | (~COMPLS6 & NBO),(~NCO & COMPLS6) | (~COMPLS6 & NCO),(NDO & ~COMPLS6) | (~NDO & COMPLS6),(~NEO | ~COMPLS6) & ((COMPLS6 & ~NEO) | NEO),(NIO & ~COMPLS6) | (COMPLS6 & ~NIO),(COMPLS4 & ~NFO) | (NFO & ~COMPLS4),((COMPLS4 & ~NGO) | NGO) & (~COMPLS4 | ~NGO),(~COMPLS4 | ~NHO) & (COMPLS4 | (NHO & ~COMPLS4)),(NJO & ~COMPLS4) | (COMPLS4 & ~NJO)};
        end
  assign AeqB = ((A | !A) & (B | !A)) & (!B | (A & B));
  assign CeqD = ((!C & !D) | D) & ((!C & !D) | C);
  assign L40 = A & (D & (B & C));
  assign L04 = (!A & (!C & !D)) & !B;
  assign L13 = (!B & (!CeqD & !A)) | (((!B & (!CeqD & !A)) | (!C & !AeqB)) & !D);
  assign L31 = (!CeqD | (!AeqB & (D & C))) & ((B | (!AeqB & (D & C))) & (A | (!AeqB & (D & C))));
  assign L22 = ((((((!A & C) & D) & !B) | (((B & (!C & !D)) & A) | !CeqD)) & !AeqB) | ((B & (!C & !D)) & A)) | (((!A & C) & D) & !B);
  assign PD_1S6 = (!A & ((((!E & !L22) & !L31) | (D & (E & !B))) & (!C | ((!E & !L22) & !L31)))) | ((!E & !L22) & !L31);
  assign NDOS6 = PD_1S6;
  assign PDOS6 = K | (!L22 & (E & !L13));
  assign ND_1S6 = ((((!L22 & (E | K)) | K) & !L13) | (A | K)) & (((!L22 & E) & ((!L13 | (((((K & A) | (K & (B | !C))) | (!D & K)) | (((((B | A) & K) | (!D & K)) | ((K & !C) | (!E & K))) & (!E | !H))) | ((!F | !G) & ((((B | A) & K) | (!D & K)) | ((K & !C) | (!E & K)))))) | K)) | (((((C & !E) & B) & !D) | (K & (G & !F))) | K));
  assign ND_1S4 = F & G;
  assign NDOS4 = !G & !F;
  assign PD_1S4 = (((F & (((!F | F) & (!F | !G)) & !G)) & K) | (!G & !F)) | (K & (G & !F));
  assign PDOS4 = (F & G) & H;
  assign illegalk = ((((!F | !G) | !H) | (!E | !L31)) & K) & ((!E | !D) | (B | (!C | A)));
  assign DISPARITY6 = (NDOS6 | PDOS6) ^ disparity;
  
  always @(posedge SBYTECLK or posedge reset)
      if (reset) 
        begin
          COMPLS4 <= 0;
          COMPLS6 <= 0;
        end
      else 
        begin
          COMPLS4 <= ((((ND_1S4 | PD_1S4) & (ND_1S4 | !DISPARITY6)) & PD_1S4) & !DISPARITY6) | (DISPARITY6 & ND_1S4);
          COMPLS6 <= ((!disparity | ND_1S6) & (ND_1S6 | PD_1S6)) & ((disparity | !disparity) & (PD_1S6 | disparity));
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
          tNCOy <= !C & ((D & (E & !B)) & !A);
          tNDO <= D & !(C & (A & B));
          tNEOx <= L13 | E;
          tNEOy <= !(!C & ((D & (E & !B)) & !A));
          tNIOw <= (L22 | (L40 & E)) & ((L40 & E) | !E);
          tNIOx <= ((!D & E) & !C) & !(A & B);
          tNIOy <= D & (((C & K) & E) & (!A & !B));
          tNIOz <= (C & (!D & E)) & (!A & !B);
        end
  assign NAO = tNAO;
  assign NBO = tNBOy | tNBOx;
  assign NCO = tNCOx | tNCOy;
  assign NDO = tNDO;
  assign NEO = tNEOx & tNEOy;
  assign NIO = ((tNIOw | tNIOx) | tNIOy) | tNIOz;
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
          alt7 <= ((F & G) & H) & (K | (disparity ? ((!E & D) & L31) : ((E & L13) & !D)));
          tNFO <= F;
          tNGO <= ((!H & ((G | !F) & (!G | G))) | ((H & K) & (F & G))) | G;
          tNHO <= H;
          tNJO <= (!H & F) ^ (!H & G);
        end
  assign NFO = !alt7 & tNFO;
  assign NGO = tNGO;
  assign NHO = tNHO;
  assign NJO = alt7 | tNJO;
endmodule

