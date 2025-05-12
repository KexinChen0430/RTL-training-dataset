
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
          disparity <= (DISPARITY6 & (~(NDOS4 | PDOS4) | ~DISPARITY6)) | ((~DISPARITY6 & PDOS4) | (NDOS4 & ~DISPARITY6));
          {a,b,c,d,e,i,f,g,h,j} <= {(COMPLS6 | (~COMPLS6 & NAO)) & (~NAO | ~COMPLS6),((~COMPLS6 | ~NBO) & COMPLS6) | (~COMPLS6 & NBO),(~COMPLS6 & NCO) | (~NCO & COMPLS6),NDO ^ COMPLS6,((COMPLS6 & ~NEO) | NEO) & (~NEO | ~COMPLS6),(NIO & ~COMPLS6) | (COMPLS6 & (~COMPLS6 | ~NIO)),(NFO & ~COMPLS4) | (COMPLS4 & ((~NFO & COMPLS4) | ~COMPLS4)),(~COMPLS4 & NGO) | (~NGO & COMPLS4),((~NHO & COMPLS4) | ~COMPLS4) & ((~NHO & COMPLS4) | NHO),(NJO & ~COMPLS4) | (COMPLS4 & ~NJO)};
        end
  assign AeqB = ((B & A) | !A) & (!B | (B & A));
  assign CeqD = (D | (!C & !D)) & ((!C & !D) | C);
  assign L40 = ((B & C) & A) & D;
  assign L04 = !A & ((!C & !D) & !B);
  assign L13 = ((!AeqB & !C) | ((!B & !A) & !CeqD)) & (!D | ((!B & !A) & !CeqD));
  assign L31 = ((((!AeqB & C) & D) | A) & (!CeqD | ((!AeqB & C) & D))) & (((C & D) | B) & (!AeqB | B));
  assign L22 = (((!B & !A) | (!CeqD & !AeqB)) & ((!CeqD & !AeqB) | (C & D))) | (!D & ((!C & A) & B));
  assign PD_1S6 = ((!B & (((E & D) & !C) & !A)) | (!L31 & !E)) & ((!B & (((E & D) & !C) & !A)) | !L22);
  assign NDOS6 = PD_1S6;
  assign PDOS6 = (K | !L13) & (K | (!L22 & E));
  assign ND_1S6 = ((!E & (C & !D)) & (B & A)) | ((K | !L13) & (K | (!L22 & E)));
  assign ND_1S4 = F & G;
  assign NDOS4 = !F & !G;
  assign PD_1S4 = (((((K & G) & !F) | (((K & ((((!F & !G) | F) & !G) | !F)) & G) | ((K & ((((!F & !G) | F) & !G) | !F)) & ((((((!F & !G) | F) & !G) | !F) & F) & !G)))) | !F) & !G) | (((K & ((((!F & !G) | F) & !G) | !F)) & G) | ((K & ((((!F & !G) | F) & !G) | !F)) & ((((((!F & !G) | F) & !G) | !F) & F) & !G)));
  assign PDOS4 = (F & H) & G;
  assign illegalk = (!L31 & (((!D | B) | (!C | A)) & K)) | (((!H & ((((!D | B) | (!C | A)) & K) | ((!E & ((((!L31 | !E) | !H) | (!G | !F)) & K)) | ((!L31 & (!E & ((((!L31 | !E) | !H) | (!G | !F)) & K))) | (!L31 & (((!D | B) | (!C | A)) & K)))))) | (((((!D | B) | (!C | A)) & K) | ((!E & ((((!L31 | !E) | !H) | (!G | !F)) & K)) | ((!L31 & (!E & ((((!L31 | !E) | !H) | (!G | !F)) & K))) | (!L31 & (((!D | B) | (!C | A)) & K))))) & (!E | (!G | !F)))) | (!L31 & (!E & ((((!L31 | !E) | !H) | (!G | !F)) & K))));
  assign DISPARITY6 = (~disparity & (PDOS6 | NDOS6)) | (disparity & ~(PDOS6 | NDOS6));
  
  always @(posedge SBYTECLK or posedge reset)
      if (reset) 
        begin
          COMPLS4 <= 0;
          COMPLS6 <= 0;
        end
      else 
        begin
          COMPLS4 <= ((ND_1S4 | !DISPARITY6) & (PD_1S4 | ND_1S4)) & (DISPARITY6 | (!DISPARITY6 & PD_1S4));
          COMPLS6 <= (!disparity & PD_1S6) | (disparity & ((PD_1S6 | ND_1S6) & (!disparity | ND_1S6)));
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
          tNCOy <= !B & (((E & D) & !C) & !A);
          tNDO <= !((B & C) & A) & D;
          tNEOx <= L13 | E;
          tNEOy <= !(!B & (((E & D) & !C) & !A));
          tNIOw <= ((((!E | E) & (L22 | E)) & L22) & !E) | (E & L40);
          tNIOx <= (!D & (E & !(B & A))) & !C;
          tNIOy <= !B & ((!A & ((D & K) & E)) & C);
          tNIOz <= C & ((!D & (E & !B)) & !A);
        end
  assign NAO = tNAO;
  assign NBO = tNBOy | tNBOx;
  assign NCO = tNCOx | tNCOy;
  assign NDO = tNDO;
  assign NEO = tNEOy & tNEOx;
  assign NIO = (tNIOy | tNIOw) | (tNIOx | tNIOz);
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
          alt7 <= ((K & H) & (F & G)) | (F & ((H & G) & (disparity ? (L31 & (D & !E)) : (L13 & (!D & E)))));
          tNFO <= F;
          tNGO <= (G | !H) & (G | (!F & !G));
          tNHO <= H;
          tNJO <= (((G & ~F) & !H) | (~G & F)) & !H;
        end
  assign NFO = tNFO & !alt7;
  assign NGO = tNGO;
  assign NHO = tNHO;
  assign NJO = tNJO | alt7;
endmodule

