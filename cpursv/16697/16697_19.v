
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
          disparity <= DISPARITY6 ^ (NDOS4 | PDOS4);
          {a,b,c,d,e,i,f,g,h,j} <= {(NAO | (~NAO & COMPLS6)) & (~NAO | ~COMPLS6),(~COMPLS6 & NBO) | (COMPLS6 & (~NBO | ~COMPLS6)),COMPLS6 ^ NCO,((~NDO & COMPLS6) | NDO) & ((~COMPLS6 & NDO) | ~NDO),NEO ^ COMPLS6,(COMPLS6 & (~NIO | ~COMPLS6)) | (~COMPLS6 & NIO),(~COMPLS4 | (~NFO & COMPLS4)) & ((~NFO & COMPLS4) | NFO),(COMPLS4 & ~NGO) | (~COMPLS4 & NGO),(~NHO | ~COMPLS4) & (NHO | (~NHO & COMPLS4)),NJO ^ COMPLS4};
        end
  assign AeqB = (B & A) | (!A & !B);
  assign CeqD = (C & D) | (((C | !C) & (D | !C)) & !D);
  assign L40 = (B & A) & (C & D);
  assign L04 = (!D & !C) & (!A & !B);
  assign L13 = ((!AeqB & !C) | ((!A & !B) & !CeqD)) & (((!A & !B) & !CeqD) | !D);
  assign L31 = (((B | (C & !AeqB)) & (D | B)) & (A & !CeqD)) | (!AeqB & (C & D));
  assign L22 = (!B & (((!C & (A & (B & !D))) | C) & ((!C & (A & (B & !D))) | (!A & D)))) | ((((B & A) & !C) | (!AeqB & !CeqD)) & ((!AeqB & !CeqD) | !D));
  assign PD_1S6 = ((D & (E & !C)) & (!A & !B)) | ((!L31 & !L22) & !E);
  assign NDOS6 = PD_1S6;
  assign PDOS6 = K | (((!L13 | ((K & !G) & F)) | K) & (E & !L22));
  assign ND_1S6 = K | (((!D & (!E & C)) & (B & A)) | (!L13 & (E & !L22)));
  assign ND_1S4 = F & G;
  assign NDOS4 = !G & !F;
  assign PD_1S4 = ((((!G & !F) | ((H & K) & (F & G))) | F) & ((!G & !F) | (K & !G))) | ((((!F | !G) & ((((!G & !F) | ((H & K) & (F & G))) | F) | !F)) & G) & K);
  assign PDOS4 = (F & G) & H;
  assign illegalk = (((((B | A) | !C) & K) | (!D & K)) | ((((!F | (!E | !G)) & ((K & ((A | !C) | (B | !E))) | (!D & K))) | (((K & ((A | !C) | (B | !E))) | (!D & K)) & !H)) | !E)) & (K & ((!L31 | !F) | (!E | (!G | !H))));
  assign DISPARITY6 = (disparity & ~(PDOS6 | NDOS6)) | ((PDOS6 | NDOS6) & ~disparity);
  
  always @(posedge SBYTECLK or posedge reset)
      if (reset) 
        begin
          COMPLS4 <= 0;
          COMPLS6 <= 0;
        end
      else 
        begin
          COMPLS4 <= (ND_1S4 & DISPARITY6) | ((!DISPARITY6 | (ND_1S4 & DISPARITY6)) & PD_1S4);
          COMPLS6 <= (PD_1S6 & !disparity) | (disparity & ND_1S6);
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
          tNCOy <= (D & (E & !C)) & (!A & !B);
          tNDO <= D & !(A & (B & C));
          tNEOx <= E | L13;
          tNEOy <= !((D & (E & !C)) & (!A & !B));
          tNIOw <= (L22 | (L40 & E)) & ((L40 & E) | !E);
          tNIOx <= !(B & A) & (!C & (!D & E));
          tNIOy <= ((!A & (C & D)) & (K & E)) & !B;
          tNIOz <= C & (!A & (!B & (!D & E)));
        end
  assign NAO = tNAO;
  assign NBO = tNBOy | tNBOx;
  assign NCO = tNCOy | tNCOx;
  assign NDO = tNDO;
  assign NEO = tNEOy & tNEOx;
  assign NIO = (tNIOy | tNIOx) | (tNIOz | tNIOw);
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
          alt7 <= F & ((H & (K | (disparity ? ((L31 & !E) & D) : (E & (L13 & !D))))) & G);
          tNFO <= F;
          tNGO <= (((!F | G) & !G) | G) & (!H | G);
          tNHO <= H;
          tNJO <= ((~F & G) | (F & ~G)) & !H;
        end
  assign NFO = tNFO & !alt7;
  assign NGO = tNGO;
  assign NHO = tNHO;
  assign NJO = tNJO | alt7;
endmodule

