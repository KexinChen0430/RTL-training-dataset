
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
          disparity <= DISPARITY6 ^ (PDOS4 | NDOS4);
          {a,b,c,d,e,i,f,g,h,j} <= {(~NAO & COMPLS6) | (NAO & ~COMPLS6),(NBO & ~COMPLS6) | (COMPLS6 & ~NBO),NCO ^ COMPLS6,NDO ^ COMPLS6,COMPLS6 ^ NEO,COMPLS6 ^ NIO,(~COMPLS4 | ~NFO) & (NFO | (~NFO & COMPLS4)),COMPLS4 ^ NGO,(COMPLS4 | (NHO & ~COMPLS4)) & (~NHO | ~COMPLS4),(~COMPLS4 & NJO) | (COMPLS4 & ~NJO)};
        end
  assign AeqB = (B & A) | ((!B | (B & A)) & !A);
  assign CeqD = (C & D) | (!D & !C);
  assign L40 = (C & D) & (B & A);
  assign L04 = (!A & !B) & (!D & !C);
  assign L13 = ((((!D & !C) | !B) & (!B | !AeqB)) & (!A | (!D & (!C & !AeqB)))) & (!CeqD | (!D & (!C & !AeqB)));
  assign L31 = ((!AeqB & C) & (D | ((B & A) & !CeqD))) | ((B & A) & !CeqD);
  assign L22 = ((!CeqD & !AeqB) | ((C & (!A & !B)) & D)) | (((!C & (B & A)) | ((C & (!A & !B)) & D)) & !D);
  assign PD_1S6 = (((E & (!B & D)) & !C) & !A) | (!L31 & (!L22 & !E));
  assign NDOS6 = PD_1S6;
  assign PDOS6 = K | (!L13 & (!L22 & E));
  assign ND_1S6 = (((!L13 & (!L22 & E)) | (A & (K | ((!L13 & ((((!L22 | ((B | A) & K)) | K) & E) | K)) | (((B & C) & !E) & !D))))) | (((((((!E & K) | ((!C & K) | (K & (!D | (B | A))))) & !H) | (!E & ((!E & K) | ((!C & K) | (K & (!D | (B | A))))))) | (((!E & K) | ((!C & K) | (K & (!D | (B | A))))) & (!F | !G))) | (K & (!C | !D))) | ((B | A) & K))) | K;
  assign ND_1S4 = G & F;
  assign NDOS4 = !G & !F;
  assign PD_1S4 = ((!G & !F) | K) & (((!G & !F) | (!F & G)) | (!G & F));
  assign PDOS4 = (F & H) & G;
  assign illegalk = ((!G & ((!E & K) | ((!C & K) | (K & (!D | (B | A)))))) | (((((!C & K) | (K & (!D | (B | A)))) & !L31) | (!L31 & (!E & K))) | (!E & ((!E & K) | ((!C & K) | (K & (!D | (B | A)))))))) | (((!E & K) | ((!C & K) | (K & (!D | (B | A))))) & ((!H | (!G & !F)) | !F));
  assign DISPARITY6 = (PDOS6 | ((~(NDOS6 | PDOS6) & disparity) | NDOS6)) & ((~(NDOS6 | PDOS6) | (~disparity & NDOS6)) | ~disparity);
  
  always @(posedge SBYTECLK or posedge reset)
      if (reset) 
        begin
          COMPLS4 <= 0;
          COMPLS6 <= 0;
        end
      else 
        begin
          COMPLS4 <= (!DISPARITY6 & PD_1S4) | (ND_1S4 & ((!DISPARITY6 & PD_1S4) | DISPARITY6));
          COMPLS6 <= (((((PD_1S6 | ND_1S6) & (!disparity | ND_1S6)) & !disparity) & PD_1S6) | disparity) & ((PD_1S6 | ND_1S6) & (!disparity | ND_1S6));
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
          tNCOx <= C | L04;
          tNCOy <= ((E & (!B & D)) & !C) & !A;
          tNDO <= !((B & C) & A) & D;
          tNEOx <= E | L13;
          tNEOy <= !(((E & (!B & D)) & !C) & !A);
          tNIOw <= (L40 & (E | (!E & L22))) | (!E & L22);
          tNIOx <= (!C & !(B & A)) & (E & !D);
          tNIOy <= (C & (!A & !B)) & (D & (K & E));
          tNIOz <= (!A & !B) & ((!D & C) & E);
        end
  assign NAO = tNAO;
  assign NBO = tNBOy | tNBOx;
  assign NCO = tNCOx | tNCOy;
  assign NDO = tNDO;
  assign NEO = tNEOy & tNEOx;
  assign NIO = (tNIOx | tNIOy) | (tNIOz | tNIOw);
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
          alt7 <= (((disparity ? (D & (!E & L31)) : ((E & L13) & !D)) | (((((!E & K) | ((!C & K) | (K & (!D | (B | A))))) & !H) | (!E & ((!E & K) | ((!C & K) | (K & (!D | (B | A))))))) | (((!E & K) | ((!C & K) | (K & (!D | (B | A))))) & (!F | !G)))) | K) & ((F & H) & G);
          tNFO <= F;
          tNGO <= ((!H | G) & (!G & !F)) | G;
          tNHO <= H;
          tNJO <= ((F & !H) & ~(!H & G)) | (~(F & !H) & (!H & G));
        end
  assign NFO = tNFO & !alt7;
  assign NGO = tNGO;
  assign NHO = tNHO;
  assign NJO = alt7 | tNJO;
endmodule

