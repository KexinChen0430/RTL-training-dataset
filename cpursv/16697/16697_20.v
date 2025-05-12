
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
          disparity <= ((~DISPARITY6 & NDOS4) | (PDOS4 & ~DISPARITY6)) | (DISPARITY6 & ~(NDOS4 | PDOS4));
          {a,b,c,d,e,i,f,g,h,j} <= {NAO ^ COMPLS6,COMPLS6 ^ NBO,(~NCO | ~COMPLS6) & (COMPLS6 | (NCO & ~COMPLS6)),(~NDO | ~COMPLS6) & (NDO | (COMPLS6 & ~NDO)),(~COMPLS6 & NEO) | ((~NEO | ~COMPLS6) & COMPLS6),COMPLS6 ^ NIO,(~NFO | ~COMPLS4) & ((~COMPLS4 & NFO) | COMPLS4),(NGO & ~COMPLS4) | (~NGO & COMPLS4),(~NHO | ~COMPLS4) & ((~NHO & COMPLS4) | NHO),COMPLS4 ^ NJO};
        end
  assign AeqB = (!B & !A) | (A & B);
  assign CeqD = ((!D | C) & (D | !D)) & ((C | !C) & (!C | D));
  assign L40 = (A & (B & C)) & D;
  assign L04 = (!B & !A) & (!D & !C);
  assign L13 = (((!B & !A) & !CeqD) | (!D & !AeqB)) & (!C | ((!B & !A) & !CeqD));
  assign L31 = (!CeqD & (A & B)) | (!AeqB & (D & C));
  assign L22 = ((((A & B) & (!D & !C)) | (!AeqB | (D & ((!B & !A) & C)))) & !CeqD) | ((D & ((!B & !A) & C)) | (((D & ((!B & !A) & C)) | !D) & (A & (!C & B))));
  assign PD_1S6 = (((E & D) | ((!E & !L22) & !L31)) & ((!B & !C) | ((!E & !L22) & !L31))) & (((!E & !L22) & !L31) | !A);
  assign NDOS6 = PD_1S6;
  assign PDOS6 = ((K | !L13) & (E & !L22)) | K;
  assign ND_1S6 = K | (((E & !L22) | (((!E & !D) & C) & (A & B))) & ((((!E & !D) & C) & (A & B)) | !L13));
  assign ND_1S4 = F & G;
  assign NDOS4 = !G & !F;
  assign PD_1S4 = (((F & !G) | (!G & !F)) | G) & ((!F | ((F & !G) | (!G & !F))) & ((!G & !F) | K));
  assign PDOS4 = (H & G) & F;
  assign illegalk = (K & !E) | (((((!F | !G) | (~F & (!H & G))) | !H) | (!E | !L31)) & (K & (!D | (K & ((!C | A) | B)))));
  assign DISPARITY6 = disparity ^ (PDOS6 | NDOS6);
  
  always @(posedge SBYTECLK or posedge reset)
      if (reset) 
        begin
          COMPLS4 <= 0;
          COMPLS6 <= 0;
        end
      else 
        begin
          COMPLS4 <= (PD_1S4 | (ND_1S4 & DISPARITY6)) & (!DISPARITY6 | (ND_1S4 & DISPARITY6));
          COMPLS6 <= (PD_1S6 | (disparity & ND_1S6)) & ((disparity & ND_1S6) | !disparity);
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
          tNCOy <= !A & ((E & D) & (!B & !C));
          tNDO <= !(A & (B & C)) & D;
          tNEOx <= L13 | E;
          tNEOy <= !(!A & ((E & D) & (!B & !C)));
          tNIOw <= (!E | (L40 & E)) & (L22 | (L40 & E));
          tNIOx <= ((!D & !C) & E) & !(A & B);
          tNIOy <= ((!B & !A) & ((E & K) & C)) & D;
          tNIOz <= C & (!A & (E & (!D & !B)));
        end
  assign NAO = tNAO;
  assign NBO = tNBOx | tNBOy;
  assign NCO = tNCOx | tNCOy;
  assign NDO = tNDO;
  assign NEO = tNEOx & tNEOy;
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
          alt7 <= ((H & G) & F) & (K | (disparity ? ((!E & D) & L31) : (E & (L13 & !D))));
          tNFO <= F;
          tNGO <= (((G | (~F & (!H & G))) | !H) & (!G | G)) & (G | !F);
          tNHO <= H;
          tNJO <= ((~F | ~G) & !H) & (F | (~F & G));
        end
  assign NFO = !alt7 & tNFO;
  assign NGO = tNGO;
  assign NHO = tNHO;
  assign NJO = alt7 | tNJO;
endmodule

