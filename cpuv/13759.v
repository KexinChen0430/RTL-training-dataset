module hex2seg(
    input [3:0] hex, 
    output reg [6:0] seg 
);
    always @ (hex) begin
        case (hex)
            4'h0 : seg <= `SSEG_0; 
            4'h1 : seg <= `SSEG_1; 
            4'h2 : seg <= `SSEG_2; 
            4'h3 : seg <= `SSEG_3; 
            4'h4 : seg <= `SSEG_4; 
            4'h5 : seg <= `SSEG_5; 
            4'h6 : seg <= `SSEG_6; 
            4'h7 : seg <= `SSEG_7; 
            4'h8 : seg <= `SSEG_8; 
            4'h9 : seg <= `SSEG_9; 
            4'ha : seg <= `SSEG_A; 
            4'hb : seg <= `SSEG_B; 
            4'hc : seg <= `SSEG_C; 
            4'hd : seg <= `SSEG_D; 
            4'he : seg <= `SSEG_E; 
            4'hf : seg <= `SSEG_F; 
        endcase
    end
endmodule