
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
          disparity <= (PDOS4 | NDOS4) ^ DISPARITY6;
          {a,b,c,d,e,i,f,g,h,j} <= {COMPLS6 ^ NAO,(~COMPLS6 & NBO) | (~NBO & COMPLS6),(~COMPLS6 | (COMPLS6 & ~NCO)) & ((NCO & ~COMPLS6) | COMPLS6),(~NDO & COMPLS6) | (~COMPLS6 & NDO),NEO ^ COMPLS6,(~COMPLS6 & NIO) | (COMPLS6 & (~COMPLS6 | ~NIO)),(~COMPLS4 | (COMPLS4 & ~NFO)) & ((COMPLS4 & ~NFO) | NFO),(NGO & ~COMPLS4) | (COMPLS4 & (~NGO | ~COMPLS4)),NHO ^ COMPLS4,(~COMPLS4 & NJO) | (COMPLS4 & ~NJO)};
        end
  assign AeqB = ((B | !A) & (!A | A)) & ((A & B) | !B);
  assign CeqD = (C & (D | (!D & !C))) | (!D & !C);
  assign L40 = (D & C) & (A & B);
  assign L04 = (!A & !B) & (!D & !C);
  assign L13 = ((!CeqD | ((!D & !C) & !AeqB)) & ((!D | !B) & ((!AeqB & !C) | !B))) & (((!D & !C) & !AeqB) | !A);
  assign L31 = ((C & !AeqB) & (D | ((A & B) & !CeqD))) | ((A & B) & !CeqD);
  assign L22 = (!AeqB & !CeqD) | ((((C & !A) & D) & !B) | (!D & ((((C & !A) & D) & !B) | (A & (B & !C)))));
  assign PD_1S6 = (((D & (!C & E)) & (!A & !B)) | (!E & !L31)) & (!L22 | ((D & (!C & E)) & (!A & !B)));
  assign NDOS6 = PD_1S6;
  assign PDOS6 = ((((!L13 | (!D & K)) | K) & (!L22 & E)) | (!E & K)) | K;
  assign ND_1S6 = (((((!L13 | (!D & K)) | K) & (!L22 & E)) | (!E & K)) | K) | (!E & ((A & B) & (!D & C)));
  assign ND_1S4 = G & F;
  assign NDOS4 = !F & !G;
  assign PD_1S4 = (!F & !G) | ((K & (G & !F)) | ((!G & K) & F));
  assign PDOS4 = (F & H) & G;
  assign illegalk = (((((((!E & K) | (!D & K)) | ((B | A) & K)) | (!C & K)) & (!G | !F)) | (((((!E & K) | (!D & K)) | ((B | A) & K)) | (!C & K)) & !E)) | (((((!E & K) | (!D & K)) | ((B | A) & K)) | (!C & K)) & !H)) | ((K & !L31) & (((((((((!E & K) | (!D & K)) | ((B | A) & K)) | (!C & K)) & (!G | !F)) | (((((!E & K) | (!D & K)) | ((B | A) & K)) | (!C & K)) & !E)) | (((((!E & K) | (!D & K)) | ((B | A) & K)) | (!C & K)) & !H)) | !E) | (((!D & K) | (!C & K)) | ((B | A) & K))));
  assign DISPARITY6 = disparity ^ (NDOS6 | PDOS6);
  
  always @(posedge SBYTECLK or posedge reset)
      if (reset) 
        begin
          COMPLS4 <= 0;
          COMPLS6 <= 0;
        end
      else 
        begin
          COMPLS4 <= ((DISPARITY6 | PD_1S4) & (!DISPARITY6 | DISPARITY6)) & ((!DISPARITY6 | ND_1S4) & (PD_1S4 | ND_1S4));
          COMPLS6 <= ((PD_1S6 | disparity) & (disparity | !disparity)) & ((ND_1S6 | !disparity) & (PD_1S6 | ND_1S6));
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
          tNCOy <= (D & (!C & E)) & (!A & !B);
          tNDO <= D & !(C & (A & B));
          tNEOx <= E | L13;
          tNEOy <= !((D & (!C & E)) & (!A & !B));
          tNIOw <= (L22 | (L40 & E)) & ((L40 & E) | !E);
          tNIOx <= (E & (!(A & B) & !C)) & !D;
          tNIOy <= (!A & !B) & (((E & D) & K) & C);
          tNIOz <= (((C & !B) & E) & !D) & !A;
        end
  assign NAO = tNAO;
  assign NBO = tNBOx | tNBOy;
  assign NCO = tNCOx | tNCOy;
  assign NDO = tNDO;
  assign NEO = tNEOx & tNEOy;
  assign NIO = tNIOw | ((tNIOx | tNIOy) | tNIOz);
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
          alt7 <= (G & F) & ((((disparity ? (L31 & (!E & D)) : ((L13 & E) & !D)) | ((K & (!C | B)) | (A & K))) | K) & H);
          tNFO <= F;
          tNGO <= (((!H | ((G & F) & (K & H))) | G) & (G | !F)) & (!G | G);
          tNHO <= H;
          tNJO <= (!H & (F & ~G)) | (!H & (~F & G));
        end
  assign NFO = tNFO & !alt7;
  assign NGO = tNGO;
  assign NHO = tNHO;
  assign NJO = tNJO | alt7;
endmodule

