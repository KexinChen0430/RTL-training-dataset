
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
          {a,b,c,d,e,i,f,g,h,j} <= {(~NAO | (~COMPLS6 & NAO)) & (COMPLS6 | (~COMPLS6 & NAO)),(NBO & ~COMPLS6) | (COMPLS6 & ~NBO),(COMPLS6 | (NCO & ~COMPLS6)) & (~NCO | ~COMPLS6),(~NDO & COMPLS6) | (~COMPLS6 & NDO),NEO ^ COMPLS6,(~NIO | ~COMPLS6) & (COMPLS6 | (~COMPLS6 & NIO)),(COMPLS4 & ~NFO) | (NFO & ~COMPLS4),NGO ^ COMPLS4,(NHO & ~COMPLS4) | (~NHO & COMPLS4),(~NJO & COMPLS4) | (NJO & ~COMPLS4)};
        end
  assign AeqB = (((!A & !B) | B) & A) | (!A & !B);
  assign CeqD = ((D | !C) & (!C | C)) & (!D | (D & C));
  assign L40 = ((B & A) & C) & D;
  assign L04 = (!A & (!D & !C)) & !B;
  assign L13 = ((!A & !B) & !CeqD) | ((!C & !AeqB) & !D);
  assign L31 = (D | (!CeqD & (B & A))) & ((!CeqD & (B & A)) | (C & !AeqB));
  assign L22 = ((A & ((!C & B) & !D)) | ((!B & (D & (!A & C))) | !AeqB)) & ((!CeqD | (A & ((!C & B) & !D))) | ((D & (!A & C)) & (!B | (A & ((!C & B) & !D)))));
  assign PD_1S6 = ((!E & !L22) & !L31) | (!C & ((D & E) & (!A & !B)));
  assign NDOS6 = PD_1S6;
  assign PDOS6 = ((!L22 & E) & !L13) | K;
  assign ND_1S6 = ((!E & (B & (C & !D))) & A) | (((!L22 & E) & !L13) | K);
  assign ND_1S4 = G & F;
  assign NDOS4 = !F & !G;
  assign PD_1S4 = (G & (K & !F)) | ((!F & !G) | ((F & K) & !G));
  assign PDOS4 = F & (G & H);
  assign illegalk = (((!E | (!D & K)) | (K & (B | !C))) | (A & K)) & (K & ((!H | !E) | ((!L31 | !F) | !G)));
  assign DISPARITY6 = ((~disparity & PDOS6) | (NDOS6 & ~disparity)) | (disparity & ~(PDOS6 | NDOS6));
  
  always @(posedge SBYTECLK or posedge reset)
      if (reset) 
        begin
          COMPLS4 <= 0;
          COMPLS6 <= 0;
        end
      else 
        begin
          COMPLS4 <= (DISPARITY6 & ND_1S4) | (!DISPARITY6 & (PD_1S4 | (DISPARITY6 & ND_1S4)));
          COMPLS6 <= ((disparity & ND_1S6) | !disparity) & (PD_1S6 | (disparity & ND_1S6));
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
          tNCOy <= !C & ((D & E) & (!A & !B));
          tNDO <= D & !((B & A) & C);
          tNEOx <= L13 | E;
          tNEOy <= !(!C & ((D & E) & (!A & !B)));
          tNIOw <= (L22 & !E) | (E & ((!E | L40) & (L22 | L40)));
          tNIOx <= !(B & A) & ((E & !C) & !D);
          tNIOy <= ((!A & !B) & (D & (E & K))) & C;
          tNIOz <= (E & (C & !D)) & (!A & !B);
        end
  assign NAO = tNAO;
  assign NBO = tNBOx | tNBOy;
  assign NCO = tNCOy | tNCOx;
  assign NDO = tNDO;
  assign NEO = tNEOx & tNEOy;
  assign NIO = (tNIOy | tNIOz) | (tNIOx | tNIOw);
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
          alt7 <= (F & (G & H)) & ((disparity ? ((D & L31) & !E) : (L13 & (!D & E))) | K);
          tNFO <= F;
          tNGO <= (((G | ((F & K) & !G)) | !G) & (!H | G)) & (G | !F);
          tNHO <= H;
          tNJO <= ((~G | (G & ~F)) & ((G & ~F) | F)) & !H;
        end
  assign NFO = tNFO & !alt7;
  assign NGO = tNGO;
  assign NHO = tNHO;
  assign NJO = tNJO | alt7;
endmodule

