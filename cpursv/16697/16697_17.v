
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
          disparity <= ((NDOS4 | (~(NDOS4 | PDOS4) & DISPARITY6)) | PDOS4) & (((PDOS4 & ~DISPARITY6) | ~(NDOS4 | PDOS4)) | (~DISPARITY6 & NDOS4));
          {a,b,c,d,e,i,f,g,h,j} <= {(~NAO | ~COMPLS6) & (COMPLS6 | (~COMPLS6 & NAO)),NBO ^ COMPLS6,COMPLS6 ^ NCO,(((NDO & ~COMPLS6) | ~NDO) & COMPLS6) | (NDO & ~COMPLS6),((NEO & ~COMPLS6) | COMPLS6) & ((NEO & ~COMPLS6) | ~NEO),(NIO & ~COMPLS6) | (~NIO & COMPLS6),(~COMPLS4 | ~NFO) & (COMPLS4 | (NFO & ~COMPLS4)),(NGO | (~NGO & COMPLS4)) & ((~NGO & COMPLS4) | ~COMPLS4),(~COMPLS4 & NHO) | (~NHO & COMPLS4),(~NJO | ~COMPLS4) & ((COMPLS4 & ~NJO) | NJO)};
        end
  assign AeqB = (A & B) | (!A & !B);
  assign CeqD = (!D & !C) | (C & D);
  assign L40 = D & ((A & B) & C);
  assign L04 = !A & (!D & (!B & !C));
  assign L13 = (((!AeqB & !D) | !B) & (!C | !B)) & ((!D & (!C & !AeqB)) | (!CeqD & !A));
  assign L31 = ((C & D) & !AeqB) | (B & (A & !CeqD));
  assign L22 = (((!CeqD & !AeqB) | (A & (!D & B))) & (!C | (!CeqD & !AeqB))) | ((((!A & (C & D)) | !D) & ((!C & (A & B)) | (!A & (C & D)))) & !B);
  assign PD_1S6 = ((!L31 & (!E & !L22)) | !B) & ((!C & (!A & (E & D))) | (!L31 & (!E & !L22)));
  assign NDOS6 = PD_1S6;
  assign PDOS6 = ((((E & (K | !L22)) | (K & !D)) | K) & !L13) | K;
  assign ND_1S6 = (((!D & ((B & C) & !E)) & ((A | K) | ((((E & (K | !L22)) | (K & !D)) | K) & !L13))) | K) | ((((E & (K | !L22)) | (K & !D)) | K) & !L13);
  assign ND_1S4 = F & G;
  assign NDOS4 = !F & !G;
  assign PD_1S4 = ((!F & !G) | ((F & K) & !G)) | (K & (G & (!F | (F & !G))));
  assign PDOS4 = (F & G) & H;
  assign illegalk = ((((K & !C) | ((K & (A | B)) | (K & (!E | !D)))) & !E) | ((((!G | !H) & ((K & !C) | ((K & (A | B)) | (K & (!E | !D))))) | ((K & !E) & !L31)) | (!L31 & (((K & !D) | (K & (A | !C))) | (K & B))))) | (((K & !C) | ((K & (A | B)) | (K & (!E | !D)))) & !F);
  assign DISPARITY6 = ((PDOS6 | NDOS6) & ((~(PDOS6 | NDOS6) & disparity) | ~disparity)) | (~(PDOS6 | NDOS6) & disparity);
  
  always @(posedge SBYTECLK or posedge reset)
      if (reset) 
        begin
          COMPLS4 <= 0;
          COMPLS6 <= 0;
        end
      else 
        begin
          COMPLS4 <= ((DISPARITY6 & ND_1S4) | PD_1S4) & ((DISPARITY6 & ND_1S4) | !DISPARITY6);
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
          tNBOx <= B & !L40;
          tNBOy <= L04;
          tNCOx <= C | L04;
          tNCOy <= D & ((!A & !B) & (!C & E));
          tNDO <= !((A & B) & C) & D;
          tNEOx <= E | L13;
          tNEOy <= !(D & ((!A & !B) & (!C & E)));
          tNIOw <= ((L22 & !E) | L40) & ((L22 & !E) | E);
          tNIOx <= !(A & B) & ((!D & E) & !C);
          tNIOy <= (!A & ((E & (D & K)) & !B)) & C;
          tNIOz <= !B & (C & (!A & (!D & E)));
        end
  assign NAO = tNAO;
  assign NBO = tNBOx | tNBOy;
  assign NCO = tNCOy | tNCOx;
  assign NDO = tNDO;
  assign NEO = tNEOy & tNEOx;
  assign NIO = (tNIOw | tNIOy) | (tNIOz | tNIOx);
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
          alt7 <= ((disparity ? ((D & !E) & L31) : (!D & (L13 & E))) | (H & ((F & G) & K))) & ((F & G) & H);
          tNFO <= F;
          tNGO <= G | ((!F & !G) & !H);
          tNHO <= H;
          tNJO <= (F & !H) ^ (G & !H);
        end
  assign NFO = !alt7 & tNFO;
  assign NGO = tNGO;
  assign NHO = tNHO;
  assign NJO = tNJO | alt7;
endmodule

