module
propagateFloatNaN_mulAdd#(parameter sigWidth = 3) ( 
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
wire notNaNAOrB_propagateC = !invalidProd && isNaNC; 
assign signNaN =
    isNaNA ? signA : isNaNB ? signB : notNaNAOrB_propagateC ? signC : 1; 
assign fractNaN =
    {1'b1,
     isNaNA ? fractA[(sigWidth - 3):0]
         : isNaNB ? fractB[(sigWidth - 3):0]
               : notNaNAOrB_propagateC ? fractC[(sigWidth - 3):0] : 1'b0}; 
endmodule 