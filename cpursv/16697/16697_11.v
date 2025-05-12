
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
          {a,b,c,d,e,i,f,g,h,j} <= {COMPLS6 ^ NAO,(~NBO | ~COMPLS6) & (COMPLS6 | (~COMPLS6 & NBO)),((COMPLS6 & ~NCO) | NCO) & (~COMPLS6 | (COMPLS6 & ~NCO)),NDO ^ COMPLS6,((COMPLS6 & ~NEO) | ~COMPLS6) & (COMPLS6 | (~COMPLS6 & NEO)),(NIO | (COMPLS6 & ~NIO)) & (~COMPLS6 | (COMPLS6 & ~NIO)),(COMPLS4 | (NFO & ~COMPLS4)) & (~NFO | (NFO & ~COMPLS4)),COMPLS4 ^ NGO,NHO ^ COMPLS4,((NJO & ~COMPLS4) | COMPLS4) & (~COMPLS4 | ~NJO)};
        end
  assign AeqB = (B & A) | (!B & !A);
  assign CeqD = ((D | (!C & !D)) & C) | (!C & !D);
  assign L40 = (C & D) & (B & A);
  assign L04 = !C & ((!A & !D) & !B);
  assign L13 = ((!AeqB & (!C & !D)) | !CeqD) & ((!B & !A) | (!AeqB & (!C & !D)));
  assign L31 = (B & (((A & !CeqD) | !AeqB) & ((A & !CeqD) | (C & D)))) | (C & (!AeqB & D));
  assign L22 = ((!CeqD & ((((D & !A) & !B) & C) | (!AeqB | (!C & ((B & A) & !D))))) | (!C & ((B & A) & !D))) | (((D & !A) & !B) & C);
  assign PD_1S6 = (((!L31 | !B) & (!L31 | (!A & ((D & !C) & E)))) & (!E & !L22)) | (((D & !C) & E) & (!B & !A));
  assign NDOS6 = PD_1S6;
  assign PDOS6 = K | ((!L22 & E) & ((!L13 | ((((((!H | !E) | ((G & K) & !F)) | !F) | (!G | !L31)) & K) & !E)) | K));
  assign ND_1S6 = (A & ((C & B) & (!D & !E))) | (K | ((!L22 & E) & ((!L13 | ((((((!H | !E) | ((G & K) & !F)) | !F) | (!G | !L31)) & K) & !E)) | K)));
  assign ND_1S4 = F & G;
  assign NDOS4 = !F & !G;
  assign PD_1S4 = ((((!F & K) | ((!G & K) & F)) & (F & (((!F | !G) & (!F | F)) & !G))) | (!G | (((!F & K) | ((!G & K) & F)) & G))) & ((!F | (K & (G & ((!F | !G) & (!F | F))))) | ((!G & K) & F));
  assign PDOS4 = (G & H) & F;
  assign illegalk = ((((((((((!H | !E) | ((G & K) & !F)) | !F) | (!G | !L31)) & K) & !E) | ((!L31 & K) & ((!D | (B | A)) | (!E | !C)))) | ((((!L31 & K) & ((!D | (B | A)) | (!E | !C))) | (K & (B | A))) | (K & (!C | !D)))) & (!L31 | !E)) | ((!H | !F) & ((((((((!H | !E) | ((G & K) & !F)) | !F) | (!G | !L31)) & K) & !E) | ((!L31 & K) & ((!D | (B | A)) | (!E | !C)))) | ((((!L31 & K) & ((!D | (B | A)) | (!E | !C))) | (K & (B | A))) | (K & (!C | !D)))))) | (!G & ((((((((!H | !E) | ((G & K) & !F)) | !F) | (!G | !L31)) & K) & !E) | ((!L31 & K) & ((!D | (B | A)) | (!E | !C)))) | ((((!L31 & K) & ((!D | (B | A)) | (!E | !C))) | (K & (B | A))) | (K & (!C | !D)))));
  assign DISPARITY6 = disparity ^ (PDOS6 | NDOS6);
  
  always @(posedge SBYTECLK or posedge reset)
      if (reset) 
        begin
          COMPLS4 <= 0;
          COMPLS6 <= 0;
        end
      else 
        begin
          COMPLS4 <= (PD_1S4 & ((DISPARITY6 & ND_1S4) | !DISPARITY6)) | (DISPARITY6 & ND_1S4);
          COMPLS6 <= (!disparity | (ND_1S6 & disparity)) & (PD_1S6 | (ND_1S6 & disparity));
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
          tNCOy <= ((D & !C) & E) & (!B & !A);
          tNDO <= D & !(C & (B & A));
          tNEOx <= L13 | E;
          tNEOy <= !(((D & !C) & E) & (!B & !A));
          tNIOw <= (!E | (L40 & E)) & (L22 | (L40 & E));
          tNIOx <= (!D & (!(B & A) & !C)) & E;
          tNIOy <= (!B & !A) & (E & ((C & D) & K));
          tNIOz <= (E & !D) & (C & (!B & !A));
        end
  assign NAO = tNAO;
  assign NBO = tNBOy | tNBOx;
  assign NCO = tNCOy | tNCOx;
  assign NDO = tNDO;
  assign NEO = tNEOy & tNEOx;
  assign NIO = ((tNIOx | tNIOz) | tNIOw) | tNIOy;
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
          alt7 <= (((disparity ? (!E & (L31 & D)) : ((E & L13) & !D)) | ((((!C | A) & K) | (B & K)) | (K & !D))) | K) & ((G & H) & F);
          tNFO <= F;
          tNGO <= (((!H & !G) | (((G & H) & K) & F)) | G) & (G | !F);
          tNHO <= H;
          tNJO <= (G ^ F) & !H;
        end
  assign NFO = tNFO & !alt7;
  assign NGO = tNGO;
  assign NHO = tNHO;
  assign NJO = alt7 | tNJO;
endmodule

