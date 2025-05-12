
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
          disparity <= ((~DISPARITY6 & PDOS4) | (~DISPARITY6 & NDOS4)) | ((~DISPARITY6 | (DISPARITY6 & ~(PDOS4 | NDOS4))) & DISPARITY6);
          {a,b,c,d,e,i,f,g,h,j} <= {NAO ^ COMPLS6,(~NBO | (NBO & ~COMPLS6)) & (COMPLS6 | (NBO & ~COMPLS6)),(~COMPLS6 & NCO) | (~NCO & COMPLS6),NDO ^ COMPLS6,(~NEO & COMPLS6) | (NEO & ~COMPLS6),(COMPLS6 | (~COMPLS6 & NIO)) & ((COMPLS6 & ~NIO) | ~COMPLS6),COMPLS4 ^ NFO,COMPLS4 ^ NGO,(NHO & ~COMPLS4) | (~NHO & COMPLS4),(~NJO | ~COMPLS4) & (COMPLS4 | (NJO & ~COMPLS4))};
        end
  assign AeqB = ((!B & !A) | B) & (A | (!B & !A));
  assign CeqD = (!D & !C) | (C & D);
  assign L40 = (C & D) & (A & B);
  assign L04 = (!D & !C) & (!B & !A);
  assign L13 = ((!D & !AeqB) & !C) | (((!A & !CeqD) | ((!D & !AeqB) & !C)) & !B);
  assign L31 = (((C & D) & !AeqB) | A) & ((!CeqD | ((C & D) & !AeqB)) & ((!AeqB | B) & (B | (C & D))));
  assign L22 = ((!AeqB & ((((A & B) & (!D & !C)) | !CeqD) | (D & ((!B & !A) & C)))) | ((A & B) & (!D & !C))) | (D & ((!B & !A) & C));
  assign PD_1S6 = (!C & ((!B & !A) & (E & D))) | ((((D & (!C & E)) | !L31) & (!L31 | (!B & !A))) & (!L22 & !E));
  assign NDOS6 = PD_1S6;
  assign PDOS6 = ((!L13 | ((!D | (A | B)) & K)) | K) & (K | (!L22 & E));
  assign ND_1S6 = (A & ((((!L13 | ((!D | (A | B)) & K)) | K) & (K | (!L22 & E))) | (!E & ((C & B) & !D)))) | (((!L13 | ((!D | (A | B)) & K)) | K) & (K | (!L22 & E)));
  assign ND_1S4 = G & F;
  assign NDOS4 = !F & !G;
  assign PD_1S4 = ((((((!F & !G) | ((!F & G) | (!F & !G))) | !G) & F) | (!F & !G)) | (!F & G)) & ((((!G & F) & K) | ((!F & !G) | ((!G & F) & K))) | K);
  assign PDOS4 = (G & F) & H;
  assign illegalk = ((!F & (((K & (A | (!C | B))) | ((!L31 & ((K & ((!H | !L31) | ((!E | !F) | !G))) & !E)) | (((K & (A | B)) | ((K & !C) | (K & !D))) & !L31))) | (K & (!E | !D)))) | ((((K & (A | (!C | B))) | ((!L31 & ((K & ((!H | !L31) | ((!E | !F) | !G))) & !E)) | (((K & (A | B)) | ((K & !C) | (K & !D))) & !L31))) | (K & (!E | !D))) & ((!G | ((!H & G) & ~F)) | !H))) | ((!L31 | !E) & (((K & (A | (!C | B))) | ((!L31 & ((K & ((!H | !L31) | ((!E | !F) | !G))) & !E)) | (((K & (A | B)) | ((K & !C) | (K & !D))) & !L31))) | (K & (!E | !D))));
  assign DISPARITY6 = (((~disparity & NDOS6) | (PDOS6 & ~disparity)) | ~(NDOS6 | PDOS6)) & ((disparity & ~(NDOS6 | PDOS6)) | (NDOS6 | PDOS6));
  
  always @(posedge SBYTECLK or posedge reset)
      if (reset) 
        begin
          COMPLS4 <= 0;
          COMPLS6 <= 0;
        end
      else 
        begin
          COMPLS4 <= (DISPARITY6 & ND_1S4) | (!DISPARITY6 & ((DISPARITY6 & ND_1S4) | PD_1S4));
          COMPLS6 <= (disparity & ND_1S6) | ((!disparity | (disparity & ND_1S6)) & PD_1S6);
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
          tNCOx <= C | L04;
          tNCOy <= !C & ((!B & !A) & (E & D));
          tNDO <= !(C & (A & B)) & D;
          tNEOx <= E | L13;
          tNEOy <= !(!C & ((!B & !A) & (E & D)));
          tNIOw <= (((E & L40) | L22) & !E) | (E & L40);
          tNIOx <= E & ((!(A & B) & !C) & !D);
          tNIOy <= ((!B & !A) & C) & (K & (E & D));
          tNIOz <= (!A & ((E & !B) & !D)) & C;
        end
  assign NAO = tNAO;
  assign NBO = tNBOx | tNBOy;
  assign NCO = tNCOy | tNCOx;
  assign NDO = tNDO;
  assign NEO = tNEOx & tNEOy;
  assign NIO = (tNIOx | tNIOz) | (tNIOw | tNIOy);
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
          alt7 <= ((G & F) & H) & (((disparity ? ((D & L31) & !E) : ((!D & L13) & E)) | (K & !D)) | K);
          tNFO <= F;
          tNGO <= G | ((!F & !G) & !H);
          tNHO <= H;
          tNJO <= (!H & G) ^ (!H & F);
        end
  assign NFO = tNFO & !alt7;
  assign NGO = tNGO;
  assign NHO = tNHO;
  assign NJO = tNJO | alt7;
endmodule

