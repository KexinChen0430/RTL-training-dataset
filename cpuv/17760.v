module
    propagateFloatNaN_divSqrt#(parameter sigWidth = 3) (
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
    assign signNaN = isNaNA ? signA : isTrueNaNB ? signB : 1;
    assign fractNaN =
        {1'b1,
         isNaNA ? fractA[(sigWidth - 3):0]
             : isTrueNaNB ? fractB[(sigWidth - 3):0] : 1'b0};
endmodule