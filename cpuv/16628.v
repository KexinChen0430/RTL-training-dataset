module propagateFloatNaN_mulAdd#(parameter sigWidth = 3) (
    input [(`floatControlWidth - 1):0] control, 
    input [1:0] op,                             
    input isNaNA,                               
    input signA,                                
    input [(sigWidth - 2):0] fractA,            
    input isNaNB,                               
    input signB,                                
    input [(sigWidth - 2):0] fractB,            
    input invalidProd,                          
    input isNaNC,                               
    input signC,                                
    input [(sigWidth - 2):0] fractC,            
    output signNaN,                             
    output [(sigWidth - 2):0] fractNaN          
);
wire isSigNaNC = isNaNC && !fractC[sigWidth - 2];
wire selectA =
    isNaNA && !isSigNaNC
        && (!isNaNB || !fractA[sigWidth - 2] || fractB[sigWidth - 2]);
wire selectB =
    isNaNB && !isSigNaNC
        && (!isNaNA || (!fractB[sigWidth - 2] && fractA[sigWidth - 2]));
wire isNaNProd = isNaNA || isNaNB || invalidProd;
wire selectC = isNaNC && (!isNaNProd || !fractC[sigWidth - 2]);
assign signNaN =
    (selectA && signA) || (selectB && signB) || (selectC && signC);
assign fractNaN =
    {1'b1,
       (selectA ? fractA[(sigWidth - 3):0] : 1'b0)
     | (selectB ? fractB[(sigWidth - 3):0] : 1'b0)
     | (selectC ? fractC[(sigWidth - 3):0] : 1'b0)};
endmodule 