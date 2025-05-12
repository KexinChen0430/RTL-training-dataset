
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
          disparity <= ((NDOS4 | PDOS4) & ~DISPARITY6) | ((~(NDOS4 | PDOS4) | ~DISPARITY6) & DISPARITY6);
          {a,b,c,d,e,i,f,g,h,j} <= {NAO ^ COMPLS6,(((~COMPLS6 & NBO) | ~NBO) & COMPLS6) | (~COMPLS6 & NBO),NCO ^ COMPLS6,NDO ^ COMPLS6,((~NEO & COMPLS6) | ~COMPLS6) & ((~NEO & COMPLS6) | NEO),(NIO & ~COMPLS6) | (COMPLS6 & (~NIO | ~COMPLS6)),(~NFO | ~COMPLS4) & ((COMPLS4 & ~NFO) | NFO),((COMPLS4 & ~NGO) | ~COMPLS4) & (COMPLS4 | (NGO & ~COMPLS4)),((COMPLS4 & ~NHO) | ~COMPLS4) & ((COMPLS4 & ~NHO) | NHO),COMPLS4 ^ NJO};
        end
  assign AeqB = (B & A) | (!A & !B);
  assign CeqD = (!C | (C & D)) & ((C & D) | !D);
  assign L40 = B & (D & (A & C));
  assign L04 = (!A & (!C & !B)) & !D;
  assign L13 = (!CeqD | (!C & (!AeqB & !D))) & ((!A & !B) | (!C & (!AeqB & !D)));
  assign L31 = ((!CeqD & B) | (D & (!AeqB & C))) & ((D & (!AeqB & C)) | A);
  assign L22 = (((((((B & A) & !D) & !C) | !CeqD) | (((((!A & D) & C) | ((B & A) & !D)) & (!C | ((!A & D) & C))) & !B)) & !AeqB) | (((B & A) & !D) & !C)) | (((((B & A) & !D) & !C) | !B) & ((!A & D) & C));
  assign PD_1S6 = ((!A | (!L22 & !E)) & ((D & ((!C & !B) & E)) | (!L22 & !E))) & (!L31 | (!A & (D & ((!C & !B) & E))));
  assign NDOS6 = PD_1S6;
  assign PDOS6 = K | ((K | (E & !L22)) & !L13);
  assign ND_1S6 = (K | ((K | (E & !L22)) & !L13)) | (!E & ((!D & C) & (B & A)));
  assign ND_1S4 = F & G;
  assign NDOS4 = !G & !F;
  assign PD_1S4 = ((F | (!G & !F)) & ((K & !G) | (!G & !F))) | ((K & G) & !F);
  assign PDOS4 = G & (F & H);
  assign illegalk = ((!E & ((((B | !C) & K) | (A & K)) | ((((K & ((!H | !E) | ((((!G & (F & K)) | !F) | !G) | !L31))) & !E) | (!D & K)) | ((!L31 & (((!D & K) | ((A | B) & K)) | (K & !C))) | (((K & ((!H | !E) | ((((!G & (F & K)) | !F) | !G) | !L31))) & !E) & !L31))))) | (((((B | !C) & K) | (A & K)) | ((((K & ((!H | !E) | ((((!G & (F & K)) | !F) | !G) | !L31))) & !E) | (!D & K)) | ((!L31 & (((!D & K) | ((A | B) & K)) | (K & !C))) | (((K & ((!H | !E) | ((((!G & (F & K)) | !F) | !G) | !L31))) & !E) & !L31)))) & !F)) | (((!G | !H) & ((((B | !C) & K) | (A & K)) | ((((K & ((!H | !E) | ((((!G & (F & K)) | !F) | !G) | !L31))) & !E) | (!D & K)) | ((!L31 & (((!D & K) | ((A | B) & K)) | (K & !C))) | (((K & ((!H | !E) | ((((!G & (F & K)) | !F) | !G) | !L31))) & !E) & !L31))))) | ((!L31 & (((!D & K) | ((A | B) & K)) | (K & !C))) | (((K & ((!H | !E) | ((((!G & (F & K)) | !F) | !G) | !L31))) & !E) & !L31)));
  assign DISPARITY6 = (((~(NDOS6 | PDOS6) & disparity) | PDOS6) | NDOS6) & (~(NDOS6 | PDOS6) | ~disparity);
  
  always @(posedge SBYTECLK or posedge reset)
      if (reset) 
        begin
          COMPLS4 <= 0;
          COMPLS6 <= 0;
        end
      else 
        begin
          COMPLS4 <= ((DISPARITY6 | PD_1S4) & (!DISPARITY6 | DISPARITY6)) & (ND_1S4 | (PD_1S4 & !DISPARITY6));
          COMPLS6 <= (disparity & (ND_1S6 | (PD_1S6 & !disparity))) | (PD_1S6 & !disparity);
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
          tNBOx <= B & !L40;
          tNBOy <= L04;
          tNCOx <= C | L04;
          tNCOy <= !A & (D & ((!C & !B) & E));
          tNDO <= D & !(B & (A & C));
          tNEOx <= L13 | E;
          tNEOy <= !(!A & (D & ((!C & !B) & E)));
          tNIOw <= (!E | (L40 & E)) & ((L40 & E) | L22);
          tNIOx <= ((!(B & A) & !C) & E) & !D;
          tNIOy <= (((E & (C & K)) & !A) & D) & !B;
          tNIOz <= (C & (E & !D)) & (!A & !B);
        end
  assign NAO = tNAO;
  assign NBO = tNBOy | tNBOx;
  assign NCO = tNCOx | tNCOy;
  assign NDO = tNDO;
  assign NEO = tNEOy & tNEOx;
  assign NIO = (tNIOw | tNIOx) | (tNIOy | tNIOz);
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
          alt7 <= (G & (H & ((disparity ? ((!E & L31) & D) : (E & (!D & L13))) | K))) & F;
          tNFO <= F;
          tNGO <= (((!G & !F) | (G & (K & (F & H)))) | G) & ((G | (~F & (!H & G))) | !H);
          tNHO <= H;
          tNJO <= (~F & (!H & G)) | ((F & ~G) & !H);
        end
  assign NFO = !alt7 & tNFO;
  assign NGO = tNGO;
  assign NHO = tNHO;
  assign NJO = alt7 | tNJO;
endmodule

