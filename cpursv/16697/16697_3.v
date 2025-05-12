
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
          disparity <= (~(PDOS4 | NDOS4) | ~DISPARITY6) & ((PDOS4 | NDOS4) | (~(PDOS4 | NDOS4) & DISPARITY6));
          {a,b,c,d,e,i,f,g,h,j} <= {(NAO & ~COMPLS6) | (~NAO & COMPLS6),(~COMPLS6 | ~NBO) & (COMPLS6 | (NBO & ~COMPLS6)),(~NCO | ~COMPLS6) & (NCO | (~NCO & COMPLS6)),NDO ^ COMPLS6,NEO ^ COMPLS6,((COMPLS6 & ~NIO) | ~COMPLS6) & ((COMPLS6 & ~NIO) | NIO),COMPLS4 ^ NFO,(((~COMPLS4 & NGO) | ~NGO) & COMPLS4) | (~COMPLS4 & NGO),NHO ^ COMPLS4,NJO ^ COMPLS4};
        end
  assign AeqB = ((B & A) | !A) & ((A | !B) & (B | !B));
  assign CeqD = (((!C & !D) | D) & C) | (!C & !D);
  assign L40 = (B & A) & (C & D);
  assign L04 = (!B & !A) & (!C & !D);
  assign L13 = (((!C & !D) & !AeqB) | !B) & ((!CeqD | ((!C & !D) & !AeqB)) & (!A | ((!C & !D) & !AeqB)));
  assign L31 = ((A & !CeqD) & ((D | B) & (B | (C & !AeqB)))) | (!AeqB & (C & D));
  assign L22 = (((C & D) & !B) & !A) | ((!D & ((B & A) & !C)) | (!AeqB & !CeqD));
  assign PD_1S6 = ((!B & (((D & !C) & !A) & E)) | !L31) & ((!B & (((D & !C) & !A) & E)) | (((!B & (((D & !C) & !A) & E)) | !L22) & !E));
  assign NDOS6 = PD_1S6;
  assign PDOS6 = ((!L13 & !L22) & E) | K;
  assign ND_1S6 = (((!L13 & !L22) & E) | (((B & A) & (!E & C)) & !D)) | K;
  assign ND_1S4 = G & F;
  assign NDOS4 = !G & !F;
  assign PD_1S4 = ((!F & (G & K)) | (!G & !F)) | ((K & F) & !G);
  assign PDOS4 = (F & H) & G;
  assign illegalk = (!E & K) | ((((K & !D) | (K & B)) | ((!C | A) & K)) & (((!G | !L31) | !E) | ((!H | (!F & (G & K))) | !F)));
  assign DISPARITY6 = (~(PDOS6 | NDOS6) & disparity) | ((PDOS6 | NDOS6) & ((~(PDOS6 | NDOS6) | (~disparity & PDOS6)) | ~disparity));
  
  always @(posedge SBYTECLK or posedge reset)
      if (reset) 
        begin
          COMPLS4 <= 0;
          COMPLS6 <= 0;
        end
      else 
        begin
          COMPLS4 <= (ND_1S4 | (PD_1S4 & !DISPARITY6)) & ((PD_1S4 & !DISPARITY6) | DISPARITY6);
          COMPLS6 <= ((PD_1S6 & !disparity) | disparity) & ((PD_1S6 | ND_1S6) & (!disparity | ND_1S6));
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
          tNCOy <= !B & (((D & !C) & !A) & E);
          tNDO <= D & !(B & (C & A));
          tNEOx <= L13 | E;
          tNEOy <= !(!B & (((D & !C) & !A) & E));
          tNIOw <= (L40 & E) | (!E & ((L40 & E) | L22));
          tNIOx <= (!(B & A) & (!C & !D)) & E;
          tNIOy <= (((C & D) & !B) & !A) & (E & K);
          tNIOz <= ((!B & !A) & (E & C)) & !D;
        end
  assign NAO = tNAO;
  assign NBO = tNBOy | tNBOx;
  assign NCO = tNCOy | tNCOx;
  assign NDO = tNDO;
  assign NEO = tNEOx & tNEOy;
  assign NIO = ((tNIOz | tNIOx) | tNIOw) | tNIOy;
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
          alt7 <= H & ((G & F) & (((disparity ? (!E & (L31 & D)) : (E & (L13 & !D))) | ((B | A) & K)) | K));
          tNFO <= F;
          tNGO <= (!H & (!G & !F)) | G;
          tNHO <= H;
          tNJO <= ((!H & G) & ~(F & !H)) | (~(!H & G) & (F & !H));
        end
  assign NFO = !alt7 & tNFO;
  assign NGO = tNGO;
  assign NHO = tNHO;
  assign NJO = alt7 | tNJO;
endmodule

