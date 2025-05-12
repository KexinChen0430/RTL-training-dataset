module  testmux(); 
   # (parameter WIDTH = 32) 
   (
    input wire [2:0]        sel, 
    input wire [WIDTH-1:0] a, 
    output reg [WIDTH-1:0] out 
    );
endmodule 