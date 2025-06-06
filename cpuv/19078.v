module dotproduct16x33 (Ax, Ay, Az, Bx, By, Bz, C, clk);
    input[16 - 1:0] Ax;
    input[16 - 1:0] Ay;
    input[16 - 1:0] Az;
    input[33 - 1:0] Bx;
    input[33 - 1:0] By;
    input[33 - 1:0] Bz;
    output[16 + 33 + 1:0] C;
    reg[16 + 33 + 1:0] C;
    input clk;
    reg[16 + 33 - 1:0] AxBx;
    reg[16 + 33 - 1:0] AyBy;
    reg[16 + 33 - 1:0] AzBz;
    always @(posedge clk)
    begin
       AxBx <= Ax * Bx ;
       AyBy <= Ay * By ;
       AzBz <= Az * Bz ;
       C <= ({AxBx[16 + 33 - 1], AxBx[16 + 33 - 1], AxBx}) + ({AyBy[16 + 33 - 1], AyBy[16 + 33 - 1], AyBy}) + ({AzBz[16 + 33 - 1], AzBz[16 + 33 - 1], AzBz}) ;
    end
 endmodule