
module InnerBlend(input  [8:0] Op,
                  input  [4:0] A,
                  input  [4:0] B,
                  input  [4:0] C,
                  output [4:0] O);

  wire  OpOnes = Op[4];
  wire [7:0]  Amul = A*Op[7:5];
  wire [6:0]  Bmul = Op[3:2]*B;
  wire [6:0]  Cmul = C*Op[1:0];
  wire [7:0]  At = Amul;
  wire [7:0]  Bt = (OpOnes == 0) ? {Bmul,1'b0} : {3'b0,B};
  wire [7:0]  Ct = (OpOnes == 0) ? {Cmul,1'b0} : {3'b0,C};
  wire [8:0]  Res = (Ct+{At,1'b0})+Bt;

  assign O = Op[8] ? A : Res[8:4];
endmodule

