module quadrature_clocked(
    clk,
    quadA,
    quadB,
    count
);
    input clk, quadA, quadB;
    output [7:0] count;