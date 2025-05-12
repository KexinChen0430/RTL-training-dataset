
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
          disparity <= ((~DISPARITY6 & PDOS4) | (NDOS4 & ~DISPARITY6)) | (DISPARITY6 & ~(NDOS4 | PDOS4));
          {a,b,c,d,e,i,f,g,h,j} <= {(NAO & ~COMPLS6) | ((~COMPLS6 | ~NAO) & COMPLS6),(COMPLS6 & ((NBO & ~COMPLS6) | ~NBO)) | (NBO & ~COMPLS6),COMPLS6 ^ NCO,(~NDO & COMPLS6) | (~COMPLS6 & NDO),(~NEO & COMPLS6) | (~COMPLS6 & NEO),COMPLS6 ^ NIO,(~COMPLS4 & NFO) | ((~COMPLS4 | ~NFO) & COMPLS4),NGO ^ COMPLS4,NHO ^ COMPLS4,COMPLS4 ^ NJO};
        end
  assign AeqB = (A & (B | (!A & !B))) | (!A & !B);
  assign CeqD = (C & D) | (((D | !D) & (C | !D)) & !C);
  assign L40 = D & (C & (A & (B & ((!A | B) & (A | !A)))));
  assign L04 = (!B & (!D & !A)) & !C;
  assign L13 = ((!A | (!AeqB & (!C & !D))) & ((!B | (!AeqB & !D)) & (!C | !B))) & ((!AeqB & (!C & !D)) | !CeqD);
  assign L31 = ((((C & D) | (A & !CeqD)) & (!AeqB | (A & !CeqD))) & B) | ((!AeqB & C) & D);
  assign L22 = ((!D | (C & (D & (!A & !B)))) & ((A & (B & ((!A | B) & (A | !A)))) & !C)) | ((C & (D & (!A & !B))) | (!CeqD & !AeqB));
  assign PD_1S6 = ((!L31 & (!L22 & !E)) | !B) & ((!L31 & (!L22 & !E)) | (((E & D) & !C) & !A));
  assign NDOS6 = PD_1S6;
  assign PDOS6 = K | (((!L13 | ((A | B) & K)) | K) & (!L22 & E));
  assign ND_1S6 = (K | (((!L13 | ((A | B) & K)) | K) & (!L22 & E))) | ((K | (((((((!L22 | (((B | !C) | A) & K)) | K) & E) | (K & ((!C | !D) | (A | B)))) | K) & !L13) | A)) & ((!E & (B & C)) & !D));
  assign ND_1S4 = G & F;
  assign NDOS4 = !F & !G;
  assign PD_1S4 = ((!F & !G) | (K & ((((!F & !G) | (!G & F)) | !F) & G))) | ((!G & F) & K);
  assign PDOS4 = (F & H) & G;
  assign illegalk = (K & ((!H | !F) | ((!E | !G) | !L31))) & ((B | (A | !E)) | (!C | !D));
  assign DISPARITY6 = ((~disparity & NDOS6) | (disparity & ~(PDOS6 | NDOS6))) | (PDOS6 & ~disparity);
  
  always @(posedge SBYTECLK or posedge reset)
      if (reset) 
        begin
          COMPLS4 <= 0;
          COMPLS6 <= 0;
        end
      else 
        begin
          COMPLS4 <= ((DISPARITY6 & ND_1S4) | PD_1S4) & ((DISPARITY6 & ND_1S4) | !DISPARITY6);
          COMPLS6 <= ((PD_1S6 | ND_1S6) & (ND_1S6 | !disparity)) & ((!disparity & PD_1S6) | disparity);
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
          tNCOy <= (((E & D) & !C) & !A) & !B;
          tNDO <= D & !(C & (A & (B & ((!A | B) & (A | !A)))));
          tNEOx <= E | L13;
          tNEOy <= !((((E & D) & !C) & !A) & !B);
          tNIOw <= (L22 & !E) | (((L22 & !E) | E) & L40);
          tNIOx <= (!D & E) & (!(A & (B & ((!A | B) & (A | !A)))) & !C);
          tNIOy <= ((K & E) & (D & (!B & C))) & !A;
          tNIOz <= (!D & E) & ((!A & !B) & C);
        end
  assign NAO = tNAO;
  assign NBO = tNBOx | tNBOy;
  assign NCO = tNCOy | tNCOx;
  assign NDO = tNDO;
  assign NEO = tNEOy & tNEOx;
  assign NIO = tNIOx | (tNIOw | (tNIOy | tNIOz));
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
          alt7 <= (G & ((disparity ? ((!E & D) & L31) : ((!D & L13) & E)) & (F & H))) | ((K & (F & H)) & G);
          tNFO <= F;
          tNGO <= ((G | (!H & (G & ~F))) | !H) & ((!F & (!G | G)) | G);
          tNHO <= H;
          tNJO <= (!H & (F & ~G)) | (!H & (G & ~F));
        end
  assign NFO = tNFO & !alt7;
  assign NGO = tNGO;
  assign NHO = tNHO;
  assign NJO = alt7 | tNJO;
endmodule

