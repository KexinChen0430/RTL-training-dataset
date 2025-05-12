module Music (
    input [7:0] ibeatNum, 
    input clk,            
    output reg [31:0] tone 
);
parameter C = 523;
parameter D = 587;
parameter E = 660;
parameter F = 698;
parameter Fs = 745;
parameter G = 784;
parameter A = 880;
parameter As = 932;
parameter B = 988;
parameter ss = 20000; 
always @(posedge clk) begin
    case(ibeatNum)
        0:tone<=ss;
        1:tone<=G;
        2:tone<=Fs;
        3:tone<=G;
        207:tone<=C<<1;
    endcase
end
endmodule