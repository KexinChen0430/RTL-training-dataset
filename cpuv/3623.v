module rc4(
    clk,             
    rst,             
    output_ready,    
    password_input,  
    K                
);
input clk; 
input rst; 
input [7:0] password_input; 
output output_ready; 
output [7:0] K; 
wire clk, rst;
wire [7:0] password_input;
reg output_ready;
reg [7:0] key[0:`KEY_SIZE-1]; 
reg [7:0] S[0:256]; 
reg [10:0] discardCount; 
`define KSS_KEYREAD    4'h0 
`define KSS_KEYSCHED1  4'h1 
`define KSS_KEYSCHED2  4'h2 
`define KSS_KEYSCHED3  4'h3 
`define KSS_CRYPTO     4'h4 
reg [3:0] KSState; 
reg [7:0] i; 
reg [7:0] j; 
reg [7:0] K; 
always @ (posedge clk or posedge rst) begin
    if (rst) begin
        i <= 8'h0;
        KSState <= `KSS_KEYREAD;
        output_ready <= 0;
        j <= 0;
    end else begin
        case (KSState)
            `KSS_KEYREAD: begin
                if (i == `KEY_SIZE) begin
                    KSState <= `KSS_KEYSCHED1;
                    i <= 8'h00;
                end else begin
                    i <= i + 1;
                    key[i] <= password_input;
                    $display ("rc4: key[%d] = %08X", i, password_input);
                end
            end
            `KSS_KEYSCHED1: begin
                S[i] <= i;
                if (i == 8'hFF) begin
                    KSState <= `KSS_KEYSCHED2;
                    i <= 8'h00;
                end else begin
                    i <= i + 1;
                end
            end
            `KSS_KEYSCHED2: begin
                j <= (j + S[i] + key[i % `KEY_SIZE]);
                KSState <= `KSS_KEYSCHED3;
            end
            `KSS_KEYSCHED3: begin
                S[i] <= S[j];
                S[j] <= S[i];
                if (i == 8'hFF) begin
                    KSState <= `KSS_CRYPTO;
                    i <= 8'h01;
                    j <= S[1];
                    discardCount <= 11'h0;
                    output_ready <= 0; 
                end else begin
                    i <= i + 1;
                    KSState <= `KSS_KEYSCHED2;
                end
            end
            `KSS_CRYPTO: begin
                S[i] <= S[j];
                S[j] <= S[i];
                K <= S[S[i] + S[j]];
                if (discardCount < 11'h600) begin
                    discardCount <= discardCount + 1;
                end else begin
                    output_ready <= 1; 
                end
                i <= i + 1;
                if (j == i + 1) begin
                    j <= (j + S[i]);
                end else begin
                    if (i == 255) begin
                        j <= (j + S[0]);
                    end else begin
                        j <= (j + S[i + 1]);
                    end
                end
            end
            default: begin
            end
        endcase
    end
end
endmodule