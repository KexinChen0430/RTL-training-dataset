
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
          disparity <= ((PDOS4 | NDOS4) & ~DISPARITY6) | (DISPARITY6 & ~(PDOS4 | NDOS4));
          {a,b,c,d,e,i,f,g,h,j} <= {(NAO & ~COMPLS6) | (COMPLS6 & ~NAO),NBO ^ COMPLS6,((~NCO | ~COMPLS6) & COMPLS6) | (NCO & ~COMPLS6),((~NDO & COMPLS6) | NDO) & (~NDO | ~COMPLS6),COMPLS6 ^ NEO,(~COMPLS6 & NIO) | (~NIO & COMPLS6),(~COMPLS4 & NFO) | ((~COMPLS4 | ~NFO) & COMPLS4),COMPLS4 ^ NGO,COMPLS4 ^ NHO,COMPLS4 ^ NJO};
        end
  assign AeqB = (A & B) | (!A & ((A & B) | !B));
  assign CeqD = (D & C) | (!C & !D);
  assign L40 = (D & C) & (A & B);
  assign L04 = (!B & !A) & (!C & !D);
  assign L13 = ((!CeqD & !A) & !B) | ((!C & !AeqB) & !D);
  assign L31 = ((A & B) & !CeqD) | ((D & C) & !AeqB);
  assign L22 = ((!AeqB & !CeqD) | ((!D & (!C & B)) & A)) | ((!B & !A) & (D & C));
  assign PD_1S6 = (!L31 & (((D & (E & !C)) | (!E & !L22)) & ((!B & !A) | (!E & !L22)))) | (!C & (!A & (D & (!B & E))));
  assign NDOS6 = PD_1S6;
  assign PDOS6 = K | (!L13 & (!L22 & E));
  assign ND_1S6 = ((((!L13 & (!L22 & E)) | A) | (K & !D)) | K) & ((K | (!L13 & (!L22 & E))) | (B & (!D & (C & !E))));
  assign ND_1S4 = F & G;
  assign NDOS4 = !G & !F;
  assign PD_1S4 = (((!G & K) | (!G & !F)) & (F | (!G & !F))) | ((G & (!F | ((F | (!G & !F)) & !G))) & K);
  assign PDOS4 = G & (H & F);
  assign illegalk = ((!E | !F) | ((!H | !G) | !L31)) & (((K & !D) | ((((!E | !F) | ((!H | !G) | !L31)) & K) & !E)) | (K & ((A | B) | !C)));
  assign DISPARITY6 = ((~disparity & ((PDOS6 & ~disparity) | NDOS6)) | disparity) & ((~disparity & ((PDOS6 & ~disparity) | NDOS6)) | ~(NDOS6 | PDOS6));
  
  always @(posedge SBYTECLK or posedge reset)
      if (reset) 
        begin
          COMPLS4 <= 0;
          COMPLS6 <= 0;
        end
      else 
        begin
          COMPLS4 <= ((DISPARITY6 & ND_1S4) | PD_1S4) & (!DISPARITY6 | (DISPARITY6 & ND_1S4));
          COMPLS6 <= (ND_1S6 & ((!disparity & (((ND_1S6 | !disparity) & (PD_1S6 | ND_1S6)) & PD_1S6)) | disparity)) | (!disparity & (((ND_1S6 | !disparity) & (PD_1S6 | ND_1S6)) & PD_1S6));
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
          tNCOy <= !C & (!A & (D & (!B & E)));
          tNDO <= !(C & (A & B)) & D;
          tNEOx <= E | L13;
          tNEOy <= !(!C & (!A & (D & (!B & E))));
          tNIOw <= ((E | !E) & (E | L22)) & ((L22 | L40) & (L40 | !E));
          tNIOx <= !C & ((E & !(A & B)) & !D);
          tNIOy <= C & (((E & K) & D) & (!B & !A));
          tNIOz <= ((C & (!D & E)) & !B) & !A;
        end
  assign NAO = tNAO;
  assign NBO = tNBOx | tNBOy;
  assign NCO = tNCOy | tNCOx;
  assign NDO = tNDO;
  assign NEO = tNEOy & tNEOx;
  assign NIO = (tNIOx | tNIOw) | (tNIOz | tNIOy);
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
          alt7 <= F & (((((disparity ? (L31 & (!E & D)) : (L13 & (!D & E))) | ((K & ((A | B) | !C)) | (K & !D))) | K) & H) & G);
          tNFO <= F;
          tNGO <= ((G | !G) & (G | !H)) & (G | !F);
          tNHO <= H;
          tNJO <= ((G & ~F) | (~G & F)) & !H;
        end
  assign NFO = tNFO & !alt7;
  assign NGO = tNGO;
  assign NHO = tNHO;
  assign NJO = alt7 | tNJO;
endmodule

