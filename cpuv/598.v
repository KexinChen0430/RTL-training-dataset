module sha_mix_part(
    input clk, 
    input [15:0] index, 
    input [31:0] words[0:15], 
    input [31:0] digest[0:7], 
    input [31:0] K, 
    output reg [31:0] wordsOut[0:15], 
    output reg [31:0] digestOut[0:7], 
    output reg [15:0] indexOut 
);
    wire [31:0] s0, s00, s01, s02;
    wire [31:0] s1, s10, s11, s12;
    wire [31:0] maj; 
    wire [31:0] ch; 
    wire [31:0] t2; 
    wire [31:0] t1; 
    always @(*) begin
        s00[31:30] = digest[0][1:0];
        s00[29:0] = digest[0][31:2];
        s01[31:19] = digest[0][12:0];
        s01[18:0] = digest[0][31:13];
        s02[31:10] = digest[0][21:0];
        s02[9:0] = digest[0][31:22];
        s10[31:26] = digest[4][5:0];
        s10[25:0] = digest[4][31:6];
        s11[31:21] = digest[4][10:0];
        s11[20:0] = digest[4][31:11];
        s12[31:7] = digest[4][24:0];
        s12[6:0] = digest[4][31:25];
        maj = (digest[0] & digest[1]) ^ (digest[0] & digest[2]) ^ (digest[1] & digest[2]);
        ch = (digest[4] & digest[5]) ^ (~digest[4] & digest[6]);
        s0 = s00 ^ s01 ^ s02;
        s1 = s10 ^ s11 ^ s12;
        t2 = s0 + maj;
        t1 = digest[7] + s1 + ch + K + words[0];
    end
    always @(posedge clk) begin
        digestOut[0] <= t1 + t2;
        digestOut[1] <= digest[0];
        digestOut[2] <= digest[1];
        digestOut[3] <= digest[2];
        digestOut[4] <= digest[3] + t1;
        digestOut[5] <= digest[4];
        digestOut[6] <= digest[5];
        digestOut[7] <= digest[6];
    end
    wire [31:0] w00, w01, w02;
    wire [31:0] w10, w11, w12;
    wire [31:0] newWord; 
    always @(*) begin
        w00[31:25] = words[1][6:0];
        w00[24:0] = words[1][31:7];
        w01[31:14] = words[1][17:0];
        w01[13:0] = words[1][31:18];
        w02 = words[1] >> 3;
        w10[31:15] = words[14][16:0];
        w10[14:0] = words[14][31:17];
        w11[31:13] = words[14][18:0];
        w11[12:0] = words[14][31:19];
        w12 = words[14] >> 10;
        newWord = words[0] + (w00 ^ w01 ^ w02) + words[9] + (w10 ^ w11 ^ w12);
    end
    always @(posedge clk) begin
        wordsOut[15] <= newWord;
        for (int i = 0; i < 15; i++) begin
            wordsOut[i] <= words[i + 1];
        end
        indexOut <= index + 1'h1;
    end
endmodule