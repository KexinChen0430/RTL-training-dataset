module charComp(
    input [6:0] char,   
    input enter,        
    output reg cEnter,  
    output reg cEne,    
    output reg cVirgul, 
    output reg cDelete, 
    output reg cNum     
);
always @(char or enter) begin
    if(enter == 0) begin
        case (char)
            7'b0000100: begin
                cEnter = 1;
                cEne = 0;
                cVirgul = 0;
                cDelete = 0;
                cNum = 0;
            end
            7'b1101110,
            7'b1001110: begin
                cEnter = 0;
                cEne = 1;
                cVirgul = 0;
                cDelete = 0;
                cNum = 0;
            end
            7'b1111110: begin
                cEnter = 0;
                cEne = 0;
                cVirgul = 1;
                cDelete = 0;
                cNum = 0;
            end
            7'b0001000: begin
                cEnter = 0;
                cEne = 0;
                cVirgul = 0;
                cDelete = 1;
                cNum = 0;
            end
            default: begin
                cEnter = 0;
                cEne = 0;
                cVirgul = 0;
                cDelete = 0;
                cNum = 0;
            end
        endcase
    end
    if(enter == 1) begin
        case (char)
            7'b0110000, 
            7'b0110001, 
            7'b0110010, 
            7'b0110011, 
            7'b0110100, 
            7'b0110101, 
            7'b0110110, 
            7'b0110111, 
            7'b0111000, 
            7'b0111001: 
            begin
                cEnter = 0;
                cEne = 0;
                cVirgul = 0;
                cDelete = 0;
                cNum = 1;
            end
            default: begin
                cEnter = 0;
                cEne = 0;
                cVirgul = 0;
                cDelete = 0;
                cNum = 0;
            end
        endcase
    end
end
endmodule