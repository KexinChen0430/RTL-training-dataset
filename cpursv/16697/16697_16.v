
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
          disparity <= ((NDOS4 | PDOS4) & ~DISPARITY6) | (~(NDOS4 | PDOS4) & DISPARITY6);
          {a,b,c,d,e,i,f,g,h,j} <= {(~COMPLS6 | ~NAO) & ((NAO & ~COMPLS6) | COMPLS6),(~NBO & COMPLS6) | (~COMPLS6 & NBO),NCO ^ COMPLS6,(~NDO | ~COMPLS6) & (COMPLS6 | (NDO & ~COMPLS6)),COMPLS6 ^ NEO,COMPLS6 ^ NIO,((NFO & ~COMPLS4) | COMPLS4) & (~COMPLS4 | ~NFO),NGO ^ COMPLS4,(~COMPLS4 & NHO) | (COMPLS4 & ~NHO),(COMPLS4 | (NJO & ~COMPLS4)) & (~NJO | ~COMPLS4)};
        end
  assign AeqB = (A | (!A & !B)) & (B | (!A & !B));
  assign CeqD = (C & D) | (!C & !D);
  assign L40 = D & ((B & A) & C);
  assign L04 = (!C & !D) & (!A & !B);
  assign L13 = ((!A & !B) | ((!AeqB & !D) & !C)) & (!CeqD | ((!AeqB & !D) & !C));
  assign L31 = ((A | (!AeqB & (C & D))) & ((C | B) & (B | (!AeqB & D)))) & ((!AeqB & (C & D)) | !CeqD);
  assign L22 = ((!D & ((D & (C & (!A & !B))) | ((A & !C) & B))) | (D & (C & (!A & !B)))) | (!CeqD & ((!AeqB | (!D & ((D & (C & (!A & !B))) | ((A & !C) & B)))) | (D & (C & (!A & !B)))));
  assign PD_1S6 = ((!C & (((!B & E) & D) & !A)) | !L22) & ((!E | (!C & (((!B & E) & D) & !A))) & (!L31 | (!C & (((!B & E) & D) & !A))));
  assign NDOS6 = PD_1S6;
  assign PDOS6 = K | (!L13 & (E & !L22));
  assign ND_1S6 = (((((A | ((E & !L22) & ((!L13 | (K & (B | A))) | K))) | (!C & K)) | K) & (!E & (B & (!D & C)))) | (!L13 & (E & !L22))) | K;
  assign ND_1S4 = F & G;
  assign NDOS4 = !F & !G;
  assign PD_1S4 = (((!F | ((((!F & !G) | (F & ((H & G) & K))) | F) & !G)) & G) & K) | ((!F & !G) | ((!G & F) & K));
  assign PDOS4 = (F & G) & H;
  assign illegalk = (!L31 & (!E & K)) | ((((((K & !D) | ((((((B | (!D | A)) & K) | (!C & K)) & !L31) | (!L31 & (!E & K))) | ((!E | ((B | A) | !C)) & K))) & !E) | (((K & !D) | ((((((B | (!D | A)) & K) | (!C & K)) & !L31) | (!L31 & (!E & K))) | ((!E | ((B | A) | !C)) & K))) & !H)) | (((K & !D) | ((((((B | (!D | A)) & K) | (!C & K)) & !L31) | (!L31 & (!E & K))) | ((!E | ((B | A) | !C)) & K))) & (!F | !G))) | ((((B | (!D | A)) & K) | (!C & K)) & !L31));
  assign DISPARITY6 = (~(NDOS6 | PDOS6) & disparity) | ((NDOS6 | PDOS6) & ~disparity);
  
  always @(posedge SBYTECLK or posedge reset)
      if (reset) 
        begin
          COMPLS4 <= 0;
          COMPLS6 <= 0;
        end
      else 
        begin
          COMPLS4 <= (ND_1S4 & DISPARITY6) | (((ND_1S4 & DISPARITY6) | !DISPARITY6) & PD_1S4);
          COMPLS6 <= (disparity & ((ND_1S6 | PD_1S6) & (ND_1S6 | !disparity))) | (PD_1S6 & !disparity);
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
          tNCOx <= L04 | C;
          tNCOy <= !C & (((!B & E) & D) & !A);
          tNDO <= !((B & A) & C) & D;
          tNEOx <= L13 | E;
          tNEOy <= !(!C & (((!B & E) & D) & !A));
          tNIOw <= (L40 | (L22 & !E)) & ((E | !E) & (E | L22));
          tNIOx <= !D & ((!C & !(B & A)) & E);
          tNIOy <= (E & (K & D)) & (!A & (C & !B));
          tNIOz <= (E & !D) & (!A & (C & !B));
        end
  assign NAO = tNAO;
  assign NBO = tNBOy | tNBOx;
  assign NCO = tNCOx | tNCOy;
  assign NDO = tNDO;
  assign NEO = tNEOy & tNEOx;
  assign NIO = (tNIOx | tNIOz) | (tNIOw | tNIOy);
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
          alt7 <= ((F & G) & H) & (((((F & G) & (disparity ? ((!E & L31) & D) : ((!D & L13) & E))) & H) | (((((K & !D) | (((K & !D) | ((((((B | (!D | A)) & K) | (!C & K)) & !L31) | (!L31 & (!E & K))) | ((!E | ((B | A) | !C)) & K))) & ((!F | !G) | !E))) | (((K & !D) | ((((((B | (!D | A)) & K) | (!C & K)) & !L31) | (!L31 & (!E & K))) | ((!E | ((B | A) | !C)) & K))) & !H)) | (K & (B | A))) | (!C & K))) | K);
          tNFO <= F;
          tNGO <= (G | !H) & (((!F & !G) | (F & ((H & G) & K))) | G);
          tNHO <= H;
          tNJO <= !H & ((G & (!H & ~F)) | (F & ~G));
        end
  assign NFO = !alt7 & tNFO;
  assign NGO = tNGO;
  assign NHO = tNHO;
  assign NJO = alt7 | tNJO;
endmodule

