
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
          disparity <= (DISPARITY6 & ((~DISPARITY6 & PDOS4) | ((NDOS4 & ~DISPARITY6) | ~(PDOS4 | NDOS4)))) | (~DISPARITY6 & (PDOS4 | NDOS4));
          {a,b,c,d,e,i,f,g,h,j} <= {NAO ^ COMPLS6,NBO ^ COMPLS6,NCO ^ COMPLS6,(~NDO & COMPLS6) | (NDO & ~COMPLS6),((~COMPLS6 & NEO) | COMPLS6) & ((~COMPLS6 & NEO) | ~NEO),NIO ^ COMPLS6,(~COMPLS4 | (COMPLS4 & ~NFO)) & ((COMPLS4 & ~NFO) | NFO),(~COMPLS4 & NGO) | (~NGO & COMPLS4),COMPLS4 ^ NHO,((NJO & ~COMPLS4) | COMPLS4) & (~NJO | ~COMPLS4)};
        end
  assign AeqB = (A & B) | (!B & !A);
  assign CeqD = (!C & !D) | (C & D);
  assign L40 = ((C & A) & B) & D;
  assign L04 = (!B & (!A & !C)) & !D;
  assign L13 = (((!CeqD & !A) & !B) | (!C & !AeqB)) & (!D | ((!CeqD & !A) & !B));
  assign L31 = (D & (((A & B) & !CeqD) | (!AeqB & C))) | ((A & B) & !CeqD);
  assign L22 = (!D & (B & (!C & A))) | (((!A & (C & D)) & ((!B | (!C & !D)) & ((B | !B) & (!B | A)))) | (!CeqD & !AeqB));
  assign PD_1S6 = ((!E & !L22) & !L31) | ((D & (!C & E)) & (!B & !A));
  assign NDOS6 = PD_1S6;
  assign PDOS6 = (((K | !L13) & (E & !L22)) | (!G & (K & F))) | K;
  assign ND_1S6 = ((((!E & !D) & ((C & A) & B)) | ((K & B) | (K & (!C | A)))) | K) | ((K | !L13) & (E & !L22));
  assign ND_1S4 = F & G;
  assign NDOS4 = !F & !G;
  assign PD_1S4 = (G & (!F & K)) | (!G & ((!F & !G) | (K & F)));
  assign PDOS4 = F & (H & G);
  assign illegalk = ((((((K & B) | (K & (!C | A))) | (!D & K)) & !L31) | ((((((K & B) | (K & (!C | A))) | (!D & K)) | (K & !E)) & !E) | ((!F | !G) & ((((K & B) | (K & (!C | A))) | (!D & K)) | (K & !E))))) | (!H & ((((K & B) | (K & (!C | A))) | (!D & K)) | (K & !E)))) | ((K & !E) & !L31);
  assign DISPARITY6 = ((~(NDOS6 | PDOS6) & disparity) | (PDOS6 & ~disparity)) | (~disparity & NDOS6);
  
  always @(posedge SBYTECLK or posedge reset)
      if (reset) 
        begin
          COMPLS4 <= 0;
          COMPLS6 <= 0;
        end
      else 
        begin
          COMPLS4 <= (DISPARITY6 & ND_1S4) | ((PD_1S4 | (DISPARITY6 & ND_1S4)) & !DISPARITY6);
          COMPLS6 <= (ND_1S6 & disparity) | (((ND_1S6 & disparity) | !disparity) & PD_1S6);
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
          tNCOy <= (D & (!C & E)) & (!B & !A);
          tNDO <= !((C & A) & B) & D;
          tNEOx <= E | L13;
          tNEOy <= !((D & (!C & E)) & (!B & !A));
          tNIOw <= ((E & L40) | !E) & (L22 | (E & L40));
          tNIOx <= (!C & (E & !D)) & !(A & B);
          tNIOy <= (C & (E & ((D & K) & !B))) & !A;
          tNIOz <= !A & (!B & (C & (E & !D)));
        end
  assign NAO = tNAO;
  assign NBO = tNBOx | tNBOy;
  assign NCO = tNCOy | tNCOx;
  assign NDO = tNDO;
  assign NEO = tNEOx & tNEOy;
  assign NIO = (tNIOy | (tNIOx | tNIOw)) | tNIOz;
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
          alt7 <= (((K | (disparity ? ((!E & L31) & D) : ((L13 & E) & !D))) & H) & G) & F;
          tNFO <= F;
          tNGO <= (!H & (((!F | (G & (K & (H & F)))) | G) & (G | !G))) | G;
          tNHO <= H;
          tNJO <= !H & ((!H & (~F & G)) | (F & ~G));
        end
  assign NFO = tNFO & !alt7;
  assign NGO = tNGO;
  assign NHO = tNHO;
  assign NJO = tNJO | alt7;
endmodule

