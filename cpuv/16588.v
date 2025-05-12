module propagateFloatNaN_divSqrt#(parameter sigWidth = 3) (
    input [(`floatControlWidth - 1):0] control,
    input sqrtOp, 
    input isNaNA, 
    input signA, 
    input [(sigWidth - 2):0] fractA, 
    input isNaNB, 
    input signB, 
    input [(sigWidth - 2):0] fractB, 
    output signNaN,
    output [(sigWidth - 2):0] fractNaN
);
wire isTrueNaNB = !sqrtOp && isNaNB;
wire selectA =
    isNaNA
        && (!isTrueNaNB || !fractA[sigWidth - 2] || fractB[sigWidth - 2]);
wire selectB =
    isTrueNaNB
        && (!isNaNA || (!fractB[sigWidth - 2] && fractA[sigWidth - 2]));
assign signNaN = (selectA && signA) || (selectB && signB);
assign fractNaN =
    {1'b1, 
       (selectA ? fractA[(sigWidth - 3):0] : 1'b0) 
     | (selectB ? fractB[(sigWidth - 3):0] : 1'b0)}; 
endmodule