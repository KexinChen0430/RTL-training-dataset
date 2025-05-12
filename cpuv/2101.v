module mux_4_to_1_5(
    input [4:0] A, 
    input [4:0] B, 
    input [4:0] C, 
    input [4:0] D, 
    input [1:0] enable, 
    output reg[4:0] O 
);
    always @* begin
        case (enable)
            2'b00 : begin 
                O <= A;
            end
            2'b01 : begin 
                O <= B;
            end
            2'b10 : begin 
                O <= C;
            end
            2'b11 : begin 
                O <= D;
            end
        endcase 
    end 
endmodule 