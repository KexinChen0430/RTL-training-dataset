
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
          disparity <= (NDOS4 | PDOS4) ^ DISPARITY6;
          {a,b,c,d,e,i,f,g,h,j} <= {(~NAO | ~COMPLS6) & (COMPLS6 | (NAO & ~COMPLS6)),COMPLS6 ^ NBO,((~NCO & COMPLS6) | NCO) & (~NCO | (~COMPLS6 & NCO)),(~NDO | ~COMPLS6) & (COMPLS6 | (NDO & ~COMPLS6)),COMPLS6 ^ NEO,NIO ^ COMPLS6,(COMPLS4 & (~COMPLS4 | ~NFO)) | (NFO & ~COMPLS4),((~COMPLS4 & NGO) | ~NGO) & ((~NGO & COMPLS4) | NGO),COMPLS4 ^ NHO,NJO ^ COMPLS4};
        end
  assign AeqB = (!B & !A) | (A & B);
  assign CeqD = (C & (D | (!D & !C))) | (!D & !C);
  assign L40 = ((C & B) & A) & D;
  assign L04 = (!B & !A) & (!D & !C);
  assign L13 = (((!B | (!D & !AeqB)) & (!C | !B)) & (!A | ((!C & !AeqB) & !D))) & (!CeqD | ((!C & !AeqB) & !D));
  assign L31 = ((A & !CeqD) & (((C & !AeqB) | B) & (B | D))) | ((C & D) & !AeqB);
  assign L22 = ((D & (C & !A)) & !B) | ((((A & B) & !C) | (!CeqD & !AeqB)) & (!D | (!CeqD & !AeqB)));
  assign PD_1S6 = ((!L22 & (!L31 & !E)) | (!B & ((!C & E) & D))) & (!A | (!L22 & (!L31 & !E)));
  assign NDOS6 = PD_1S6;
  assign PDOS6 = ((E & !L22) & (K | !L13)) | K;
  assign ND_1S6 = ((((((E & !L22) & (K | !L13)) | (!E & (B & (C & !D)))) | K) & A) | K) | (((E & !L22) | K) & !L13);
  assign ND_1S4 = G & F;
  assign NDOS4 = !G & !F;
  assign PD_1S4 = (F & (K & !G)) | ((!F & (K & G)) | (!G & !F));
  assign PDOS4 = (G & F) & H;
  assign illegalk = ((((K & !L31) & ((!E | A) | (!C | (!D | B)))) | (K & !D)) | (((!E | ((B | !C) | A)) & K) | ((K & !L31) & ((!E | A) | (!C | (!D | B)))))) & ((!G | (!F | !L31)) | (!H | !E));
  assign DISPARITY6 = (PDOS6 | NDOS6) ^ disparity;
  
  always @(posedge SBYTECLK or posedge reset)
      if (reset) 
        begin
          COMPLS4 <= 0;
          COMPLS6 <= 0;
        end
      else 
        begin
          COMPLS4 <= (PD_1S4 & (!DISPARITY6 | (ND_1S4 & DISPARITY6))) | (ND_1S4 & DISPARITY6);
          COMPLS6 <= (ND_1S6 & ((disparity | !disparity) & (PD_1S6 | disparity))) | (PD_1S6 & !disparity);
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
          tNCOy <= !A & ((!B & ((!C & E) & D)) & (((!E & !L22) | (!B & !A)) & ((!E & !L22) | ((!C & E) & D))));
          tNDO <= D & !((C & B) & A);
          tNEOx <= L13 | E;
          tNEOy <= !(!A & ((!B & ((!C & E) & D)) & (((!E & !L22) | (!B & !A)) & ((!E & !L22) | ((!C & E) & D)))));
          tNIOw <= ((!E | E) & (L22 | E)) & ((!E & L22) | L40);
          tNIOx <= ((E & !D) & !C) & !(A & B);
          tNIOy <= ((!B & !A) & (D & (K & E))) & C;
          tNIOz <= ((!B & !A) & C) & (E & !D);
        end
  assign NAO = tNAO;
  assign NBO = tNBOx | tNBOy;
  assign NCO = tNCOx | tNCOy;
  assign NDO = tNDO;
  assign NEO = tNEOy & tNEOx;
  assign NIO = (tNIOx | tNIOw) | (tNIOy | tNIOz);
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
          alt7 <= ((H & F) & ((disparity ? ((!E & D) & L31) : (L13 & (E & !D))) | K)) & G;
          tNFO <= F;
          tNGO <= G | ((!G & !F) & (!H | G));
          tNHO <= H;
          tNJO <= (F | (~F & G)) & (!H & ((~G & F) | ~F));
        end
  assign NFO = !alt7 & tNFO;
  assign NGO = tNGO;
  assign NHO = tNHO;
  assign NJO = tNJO | alt7;
endmodule

