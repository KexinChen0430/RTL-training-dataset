module sqrt64fp(
    clk,
    ce,
    rdy,
    a,
    result);
input clk;
input ce;
output rdy;
input[64 - 1:0] a;
output[64 - 1:0] result;
endmodule