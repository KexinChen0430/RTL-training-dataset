
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
          disparity <= (DISPARITY6 & ~(NDOS4 | PDOS4)) | (~DISPARITY6 & (NDOS4 | PDOS4));
          {a,b,c,d,e,i,f,g,h,j} <= {COMPLS6 ^ NAO,(~COMPLS6 | (COMPLS6 & ~NBO)) & (COMPLS6 | (~COMPLS6 & NBO)),(~COMPLS6 & NCO) | (~NCO & COMPLS6),((~NDO & COMPLS6) | NDO) & (~COMPLS6 | (~NDO & COMPLS6)),(NEO | (COMPLS6 & ~NEO)) & (~COMPLS6 | ~NEO),(~NIO | ~COMPLS6) & (NIO | (~NIO & COMPLS6)),((~COMPLS4 & NFO) | ~NFO) & (COMPLS4 | (~COMPLS4 & NFO)),(~NGO & COMPLS4) | (~COMPLS4 & NGO),(~COMPLS4 & NHO) | (COMPLS4 & ~NHO),(NJO & ~COMPLS4) | (COMPLS4 & ~NJO)};
        end
  assign AeqB = ((B & A) | !B) & ((!A | A) & (B | !A));
  assign CeqD = (D & C) | (!C & !D);
  assign L40 = A & ((B & C) & D);
  assign L04 = (!C & (!B & !A)) & !D;
  assign L13 = (((!B & !A) & !CeqD) | (!C & !AeqB)) & (((!B & !A) & !CeqD) | !D);
  assign L31 = ((((B & A) & !CeqD) | C) & (!AeqB | ((B & A) & !CeqD))) & (D | ((B & A) & !CeqD));
  assign L22 = ((!AeqB & ((!B & (((D & (!A & C)) | ((B & !D) & A)) & (!C | (D & (!A & C))))) | (!CeqD | (((!C & A) & !D) & B)))) | (((!C & A) & !D) & B)) | ((C & (!B & !A)) & D);
  assign PD_1S6 = ((!B & !A) & ((E & !C) & D)) | ((((!B & !A) & ((E & !C) & D)) | !L31) & (!E & !L22));
  assign NDOS6 = PD_1S6;
  assign PDOS6 = K | ((K | ((!L22 | K) & E)) & !L13);
  assign ND_1S6 = (((A & ((!E & !D) & C)) | K) | ((K | ((!L22 | K) & E)) & !L13)) & ((((((!L13 | (K & !C)) | K) & (!L22 & E)) | B) | (((((!E | (!G & !F)) | !F) | !G) & ((!E & K) | (((!C | !D) & K) | (K & (B | A))))) | (!H & ((!E & K) | (((!C | !D) & K) | (K & (B | A))))))) | K);
  assign ND_1S4 = G & F;
  assign NDOS4 = !G & !F;
  assign PD_1S4 = (((F & !G) & (((F & !G) & K) | (K & !F))) | (!G & !F)) | ((((F & !G) & K) | (K & !F)) & G);
  assign PDOS4 = H & (G & F);
  assign illegalk = (!E & ((!E & K) | (((!C | !D) & K) | (K & (B | A))))) | (((((!F | ((~F & G) & !H)) | !H) & ((!E & K) | (((!C | !D) & K) | (K & (B | A))))) | (!G & ((!E & K) | (((!C | !D) & K) | (K & (B | A)))))) | ((!L31 & (!E & K)) | (!L31 & (((!C | !D) & K) | (K & (B | A))))));
  assign DISPARITY6 = (~(NDOS6 | PDOS6) & disparity) | ((PDOS6 & ~disparity) | (NDOS6 & ~disparity));
  
  always @(posedge SBYTECLK or posedge reset)
      if (reset) 
        begin
          COMPLS4 <= 0;
          COMPLS6 <= 0;
        end
      else 
        begin
          COMPLS4 <= ((((!DISPARITY6 | ND_1S4) & (ND_1S4 | PD_1S4)) & PD_1S4) & !DISPARITY6) | ((DISPARITY6 | ((((!DISPARITY6 | ND_1S4) & (ND_1S4 | PD_1S4)) & PD_1S4) & !DISPARITY6)) & ND_1S4);
          COMPLS6 <= (ND_1S6 & disparity) | ((!disparity | (ND_1S6 & disparity)) & PD_1S6);
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
          tNCOy <= (!B & !A) & ((E & !C) & D);
          tNDO <= D & !((B & A) & C);
          tNEOx <= E | L13;
          tNEOy <= !((!B & !A) & ((E & !C) & D));
          tNIOw <= ((E & L40) | !E) & (L22 | (E & L40));
          tNIOx <= ((E & !C) & !(B & A)) & !D;
          tNIOy <= D & ((C & (E & K)) & (!B & !A));
          tNIOz <= C & ((!D & E) & (!B & !A));
        end
  assign NAO = tNAO;
  assign NBO = tNBOy | tNBOx;
  assign NCO = tNCOy | tNCOx;
  assign NDO = tNDO;
  assign NEO = tNEOx & tNEOy;
  assign NIO = tNIOx | (tNIOz | (tNIOw | tNIOy));
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
          alt7 <= ((((disparity ? ((!E & L31) & D) : ((!D & E) & L13)) & (H & (G & F))) | (((!C | !D) & K) | (K & (B | A)))) | K) & (H & (G & F));
          tNFO <= F;
          tNGO <= (G | ((G | !G) & !F)) & (G | !H);
          tNHO <= H;
          tNJO <= (((~F & G) | (H & ((G & F) & K))) | F) & ((~G | ~F) & !H);
        end
  assign NFO = tNFO & !alt7;
  assign NGO = tNGO;
  assign NHO = tNHO;
  assign NJO = alt7 | tNJO;
endmodule

